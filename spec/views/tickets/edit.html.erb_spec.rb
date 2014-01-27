require 'spec_helper'

describe "tickets/edit" do
  before(:each) do
    @ticket = assign(:ticket, stub_model(Ticket))
  end

  it "renders the edit ticket form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", ticket_path(@ticket), "post" do
    end
  end
end
