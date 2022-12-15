require 'rails_helper'

RSpec.describe Beer, type: :model do
  describe "with brewery that exists" do
    let(:test_brewery) { Brewery.new name: "test", year: 2000 }

    it "is added when it receives name, style and brewery" do
      style = Style.create name: 'IPA', description: 'Placeholder'
      beer = Beer.create name: "testbeer", style: style, brewery: test_brewery

      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end

    it "is not added without name" do
      style = Style.create name: 'IPA', description: 'Placeholder'
      beer = Beer.create style: style, brewery: test_brewery

      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end

    it "is not added without style" do
      beer = Beer.create name: "testbeer", brewery: test_brewery

      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end

  end
end
