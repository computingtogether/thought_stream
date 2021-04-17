require "rails_helper"

RSpec.describe Entry, :type => :model do
  describe "validations" do
    subject{FactoryBot.build(:entry, thoughts: thought)}
    context "when thoughts are present" do
      let(:thought){'za'}
      it "is expected to be valid" do
        expect(subject).to be_valid
      end
    end

    context "when thoughts are nil" do
      let(:thought){nil}
      it{is_expected.to be_invalid}
    end
    
    context "when thoughts are an empty string" do
      let(:thought){""}
      it{is_expected.to be_invalid}
    end
  end
end