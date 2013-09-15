require 'spec_helper'

describe "tickets/edit" do
  before(:each) do
    @ticket = assign(:ticket, stub_model(Ticket,
      :user_id => 1,
      :title => "MyString",
      :content => "MyText",
      :status => "MyString"
    ))
  end

  it "renders the edit ticket form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", ticket_path(@ticket), "post" do
      assert_select "input#ticket_user_id[name=?]", "ticket[user_id]"
      assert_select "input#ticket_title[name=?]", "ticket[title]"
      assert_select "textarea#ticket_content[name=?]", "ticket[content]"
      assert_select "input#ticket_status[name=?]", "ticket[status]"
    end
  end
end
