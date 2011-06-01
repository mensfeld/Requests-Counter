require 'spec_helper'

ROOT = File.expand_path(File.dirname(__FILE__))


RequestsCounter.wait_time = "10m"
RequestsCounter.available_attempts = 10

describe RequestsCounter do
  subject { RequestsCounter }
  after(:each){ RequestsCounter.destroy_all }

  context "when we want to have subject instance" do
    context "but we don't have any with corresponding ip" do
      it "should create one and return it to use" do
        subject.count.should == 0
        subject.with_token('127.0.0.1').should_not == nil
        subject.count.should == 1
      end
    end

    context "and we have one already" do
      it "should fetch it and return to us" do
        subject.count.should == 0
        subject.with_token('127.0.0.1')
        subject.count.should == 1
        subject.with_token('127.0.0.1')
        subject.with_token('127.0.0.1')
        subject.count.should == 1
      end
    end

    context "with additional key" do
      context "but we don't have any with corresponding ip" do
        it "should create one and return it to use" do
          subject.count.should == 0
          subject.with_token('127.0.0.1', :test).should_not == nil
          subject.count.should == 1
        end
      end

      context "and we have one but with different key" do
        it "should fetch a new one and return to us" do
          subject.count.should == 0
          subject.with_token('127.0.0.1')
          subject.with_token('127.0.0.1', :test).should_not == nil
          subject.count.should == 2
        end
      end
    
      context "and we have one with good key" do
        it "should return it to us" do
          subject.count.should == 0
          subject.with_token('127.0.0.1', :test).should_not == nil
          subject.count.should == 1
        end
      end

    end

    context "and we want one with different available_attempts" do
      it "should create it for us" do
        el = subject.with_token('127.0.0.1', :resource, {:available_attempts => 12})
        el.available_attempts.should == 12
      end
    end

    context "and we want one with different wait_time" do
      it "should create it for us" do
        el = subject.with_token('127.0.0.1', :resource, {:wait_time => '4h'})
        el.wait_time.should == '4h'
      end
    end

  end

  context "when we check if new ip is permitted" do
    context "when we use class interface" do
      it "should return true and should not count attempts" do
        subject.permitted?('127.0.0.1').should == true
        subject.permitted?('127.0.0.1', :resource).should == true
        subject.with_token('127.0.0.1', :resource).attempts.should == 0
      end
    end

    context "when we use instance interface" do
      it "should return true and should not count attempts" do
        el = subject.with_token('127.0.0.1', :resource)
        el.permitted?.should == true
        el.reload
        el.attempts.should == 0
      end
    end
  end

  context "when we check if we can permit resource" do
    context "when we use class interface" do
      it "should return true and should count attempts" do
        subject.permit?('127.0.0.1').should == true
        subject.permit?('127.0.0.1', :resource).should == true
        subject.with_token('127.0.0.1', :resource).attempts.should == 1
      end
    end

    context "when we use instance interface" do
      it "should return true and should count attempts" do
        el = subject.with_token('127.0.0.1', :resource)
        el.permit?.should == true
        el.permit?.should == true
        el.reload
        el.attempts.should == 2
      end
    end
  end

  context "when we request smthng 2 many times" do
    it "should ban us" do
      10.times { subject.permit?('127.0.0.1').should == true }
      subject.permit?('127.0.0.1').should == false
      subject.with_token('127.0.0.1').permit?.should == false
    end

    context "but time has passed ..." do
      it "should unban us" do
        10.times { subject.permit?('127.0.0.1').should == true }
        subject.permit?('127.0.0.1').should == false
        subject.with_token('127.0.0.1').update_attributes(:last_logged => 2.hours.ago)
        subject.permit?('127.0.0.1').should == true
        subject.with_token('127.0.0.1').attempts.should == 1
      end
    end

  end

  context "when we make first request" do
    it "should return us 9 remaining requests left" do
      subject.permit?('127.0.0.1')
      subject.with_token('127.0.0.1').remaining.should == 9
    end
  end

  context "when we request something a lot of times" do
    it "should not left us any remaining requests" do
      20.times { subject.permit?('127.0.0.1') }
      subject.with_token('127.0.0.1').remaining.should == 0
      subject.remaining('127.0.0.1').should == 0
    end
  end

end
