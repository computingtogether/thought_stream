require "rails_helper"

RSpec.describe EntriesController, :type => :controller do
  describe "create" do
    subject{post :create, :params => {:entry => {:thoughts => thoughts}}}
    let(:thoughts){"PIZZA"}

    it "assigns the variable" do
      subject
      entry = Entry.all.last
      expect(assigns(:entry)).to eq(entry)

      expect(entry).to have_attributes(:thoughts => thoughts)
    end
  end
end