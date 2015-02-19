require 'spec_helper'

describe "Nsume::VERSION" do
  describe "reference" do
    it "returns #{Nsume::VERSION} version" do
      expect(Nsume::VERSION).to eq(Nsume::VERSION)
    end
  end
end
