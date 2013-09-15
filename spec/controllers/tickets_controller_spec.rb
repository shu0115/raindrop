require 'spec_helper'

describe TicketsController do
  # This should return the minimal set of attributes required to create a valid
  # Ticket. As you add validations to Ticket, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { "user_id" => "1" }
  end

  describe 'GET index' do
    before do
      @ticket = Ticket.create! valid_attributes
      controller.index
    end
    describe 'assigns all tickets as @tickets' do
      subject { controller.instance_variable_get('@tickets') }
      it { should eq([@ticket]) }
    end
  end

  describe 'GET show' do
    before do
      @ticket = Ticket.create! valid_attributes
      controller.show(@ticket.to_param)
    end
    describe 'assigns the requested ticket as @ticket' do
      subject { controller.instance_variable_get('@ticket') }
      it { should eq(@ticket) }
    end
  end

  describe 'GET new' do
    before do
      controller.new
    end
    describe 'assigns a new ticket as @ticket' do
      subject { controller.instance_variable_get('@ticket') }
      it { should be_a_new(Ticket) }
    end
  end

  describe 'GET edit' do
    before do
      @ticket = Ticket.create! valid_attributes
      controller.edit(@ticket.to_param)
    end
    describe 'assigns the requested ticket as @ticket' do
      subject { controller.instance_variable_get('@ticket') }
      it { should eq(@ticket) }
    end
  end

  describe 'POST create' do
    context 'with valid params' do
      before do
        controller.should_receive(:redirect_to) {|u| u.should eq(Ticket.last) }
      end
      describe 'creates a new Ticket' do
        it { expect {
          controller.create(valid_attributes)
        }.to change(Ticket, :count).by(1) }
      end

      describe 'assigns a newly created ticket as @ticket and redirects to the created ticket' do
        before do
          controller.create(valid_attributes)
        end
        subject { controller.instance_variable_get('@ticket') }
        it { should be_a(Ticket) }
        it { should be_persisted }
      end
    end

    context 'with invalid params' do
      describe "assigns a newly created but unsaved ticket as @ticket, and re-renders the 'new' template" do
        before do
          Ticket.any_instance.stub(:save) { false }
          controller.should_receive(:render).with(:action => 'new')
          controller.create({ "user_id" => "invalid value" })
        end
        subject { controller.instance_variable_get('@ticket') }
        it { should be_a_new(Ticket) }
      end
    end
  end

  describe 'PUT update' do
    context 'with valid params' do
      describe 'updates the requested ticket, assigns the requested ticket as @ticket, and redirects to the ticket' do
        before do
          @ticket = Ticket.create! valid_attributes
          controller.should_receive(:redirect_to).with(@ticket, anything)
          controller.update(@ticket.to_param, valid_attributes)
        end
        subject { controller.instance_variable_get('@ticket') }
        it { should eq(@ticket) }
      end
    end

    context 'with invalid params' do
      describe "assigns the ticket as @ticket, and re-renders the 'edit' template" do
        before do
          @ticket = Ticket.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Ticket.any_instance.stub(:save) { false }
          controller.should_receive(:render).with(:action => 'edit')
          controller.update(@ticket.to_param, { "user_id" => "invalid value" })
        end
        subject { controller.instance_variable_get('@ticket') }
        it { should eq(@ticket) }
      end
    end
  end

  describe 'DELETE destroy' do
    before do
      @ticket = Ticket.create! valid_attributes
      controller.stub(:tickets_url) { '/tickets' }
      controller.should_receive(:redirect_to).with('/tickets')
    end
    it 'destroys the requested ticket, and redirects to the tickets list' do
      expect {
        controller.destroy(@ticket.to_param)
      }.to change(Ticket, :count).by(-1)
    end
  end
end
