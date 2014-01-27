require 'spec_helper'

describe "tickets/index" do
  before(:each) do
    assign(:tickets, [
      stub_model(Ticket),
      stub_model(Ticket)
    ])
  end

  it "renders a list of tickets" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
