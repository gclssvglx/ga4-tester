RSpec.describe "Tester" do
  context "Test" do
    before :all do
      @interactions = YAML.load_file("interactions.yml")
    end

    context "tabs" do
      it "correctly creates the dataLayer event from the data attributes" do
        @interactions["tabs"]["urls"].each do |url|
          visit url

          tag = @interactions['tabs']['tag']
          klass = @interactions['tabs']['class']

          find_all(:xpath, "//#{tag}[@class='#{klass}']").each do |link|
            event_name = link["data-gtm-event-name"]
            data_attributes = JSON.parse(link["data-gtm-attributes"])

            link.click

            events = page.evaluate_script("dataLayer")
            unless events.nil?
              event = build_event(event_name, events.length, data_attributes, data_attributes["state"])
              expect(event).to eq(events.last)
            end
          end
        end
      end
    end

    context "accordions" do
      it "correctly creates the dataLayer event from the data attributes" do
        @interactions["accordions"]["urls"].each do |url|
          visit url

          tag = @interactions['accordions']['tag']
          klass = @interactions['accordions']['class']

          find_all(:xpath, "//#{tag}[@class='#{klass}']").each do |link|
            event_name = link["data-gtm-event-name"]
            data_attributes = JSON.parse(link["data-gtm-attributes"])

            %w[opened closed].each do |state|
              link.click

              events = page.evaluate_script("dataLayer")
              unless events.nil?
                event = build_event(event_name, events.length, data_attributes, state)
                expect(event).to eq(events.last)
              end
            end
          end
        end
      end
    end
  end
end
