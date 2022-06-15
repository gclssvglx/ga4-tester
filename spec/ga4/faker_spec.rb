RSpec.describe "Faker" do
  context "Generate" do
    before :all do
      @interactions = YAML.load_file("interactions.yml")
    end

    context "tabs" do
      it "correctly creates fake tab data" do
        fake(@interactions["tabs"])
      end
    end

    context "accordions" do
      it "correctly creates fake accordion data" do
        fake(@interactions["accordions"])
      end
    end

    context "mystuff" do
      it "correctly creates fake mystuff data" do
        fake(@interactions["mystuff"])
      end
    end
  end
end
