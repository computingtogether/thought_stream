require "rails_helper"

RSpec.describe EntriesHelper, :type => :helper do
  describe "#get_red" do
    let!(:entry1){FactoryBot.create(:entry, thoughts: 'taxes, walk, study')}
    let!(:entry2){FactoryBot.create(:entry, thoughts: 'taxes, walk')}
    let!(:entry3){FactoryBot.create(:entry, thoughts: 'taxes')}
    let(:entries){Entry.all}

    it "returns 20 times the number of prior occurences of the string passed in" do
      # binding.pry
      expect(helper.get_red(entries, "taxes", entry3.created_at.to_i)).to eq(60)
    end
  end

describe "#create_prior_word_count_hash" do
  subject{helper.create_prior_word_count_hash(entries_array,time)}
    context "when the time is equal to or after" do
      let(:time){DateTime.new(2022,1,5,0,0,0).to_i}

      context "with one entry" do
        let(:entry1){FactoryBot.create(:entry, thoughts: thought1)}
        let(:entries_array){[entry1]}
        context "with one word in the thought" do
          let!(:thought1){'eat'}
          it "returns expected hash" do
            expect(subject).to eq({"eat"=>1})
          end
        end

        context "with two words in the thought" do
          let!(:thought1){'eat, dishes'}
          it "returns expected hash" do
            expect(subject).to eq({"eat"=>1, "dishes"=>1})
          end
        end
      end

      context "with two entries" do
        let(:entries_array){[entry1,entry2]}
        let(:entry1){FactoryBot.create(:entry, thoughts: thought1)}
        let(:entry2){FactoryBot.create(:entry, thoughts: thought2)}
        context "with one word in each thought" do
          let(:thought1){'swim'}
          let(:thought2){'swim'}

          it "returns expected hash" do
            # binding.pry
            expect(subject).to eq({"swim"=>2})
          end
        end
      end
    end
    context "when the time is before" do
      let(:time){DateTime.new(2000,1,5,0,0,0).to_i}
      context "with one entry" do
        let(:entry1){FactoryBot.create(:entry, thoughts: thought1)}
        let(:entries_array){[entry1]}
        context "with one word in the thought" do
          let!(:thought1){'eat'}
          it "returns expected hash" do
            expect(subject).to eq({})
          end
        end

        context "with two words in the thought" do
          let!(:thought1){'eat, dishes'}
          it "returns expected hash" do
            expect(subject).to eq({})
          end
        end
      end
    end
  end
end

# make a new context with multiple words in thought
# make a new context with two entries, consider where to put all of the lets
# test edge cased in get red