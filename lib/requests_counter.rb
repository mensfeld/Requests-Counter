class RequestsCounter < ActiveRecord::Base

  after_initialize :check_defaults

  before_save :init_available_attempts

  class << self
    attr_accessor :available_attempts
    attr_accessor :wait_time
  end

  class AvailableAttemptsNotInitialized < StandardError; end
  class WaitTimeNotInitialized          < StandardError; end

  validates :token, :presence => true

  # Searches for instance element with provided token and resource
  # and if it does not find one - will create new and return it to us
  def self.with_token(token, resource = nil, params = {})
    unless el = self.where(:token => token, :resource => resource).first
      el = self.create({
          :token => token,
          :resource => resource
        }.merge(params))
    end
    el
  end

  def self.permitted?(token, resource = nil, params = {})
    self.with_token(token, resource, params).permitted?
  end

  def permitted?
    if attempts < available_attempts
      true
    else
      if time_permitted?
        reset!
        true
      else
        false
      end
    end
  end

  def self.permit?(token, resource = nil, params = {})
    self.with_token(token, resource, params).permit?
  end

  def permit?
    perm = permitted?
    incr!
    perm
  end

  def reset!
    self.update_attributes(:attempts => 0)
  end

  def self.remaining(token, resource = nil, params = {})
    self.with_token(token, resource, params).remaining
  end

  def remaining
    r = available_attempts - attempts
    r = 0 if r < 0
    r
  end

  private

  def init_available_attempts
    if self.available_attempts.nil? || self.available_attempts < 1
      self.available_attempts = self.class.available_attempts
    end
  end

  def time_permitted?
    time = case self.wait_time
      when /^(\d+)m$/ then Time.now - $1.to_i.minute
      when /^(\d+)h$/ then Time.now - $1.to_i.hour
      when /^(\d+)d$/ then Time.now - $1.to_i.day
      else Time.now - 1.hour
    end
    self.last_logged < time
  end

  # Refreshes our internal timestamp
  def refresh!
    self.update_attributes(:last_logged => Time.now)
  end

  # Increments our internatl attempts counter
  def incr!
    self.update_attributes(:attempts => self.attempts+1, :last_logged => Time.now)
  end

  # Default values should be initialized
  def check_defaults
    raise AvailableAttemptsNotInitialized unless self.class.available_attempts
    raise WaitTimeNotInitialized          unless self.class.wait_time
  end

end
