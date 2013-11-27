require "./App"

describe "#debrackafy" do
	it "should remove brackets from a given word" do
		expect(debrackafy("[Genre]")).to eq("Genre")
	end
end