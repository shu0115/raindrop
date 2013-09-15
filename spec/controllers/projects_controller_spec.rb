require 'spec_helper'

describe ProjectsController do
  # This should return the minimal set of attributes required to create a valid
  # Project. As you add validations to Project, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { "user_id" => "1" }
  end

  describe 'GET index' do
    before do
      @project = Project.create! valid_attributes
      controller.index
    end
    describe 'assigns all projects as @projects' do
      subject { controller.instance_variable_get('@projects') }
      it { should eq([@project]) }
    end
  end

  describe 'GET show' do
    before do
      @project = Project.create! valid_attributes
      controller.show(@project.to_param)
    end
    describe 'assigns the requested project as @project' do
      subject { controller.instance_variable_get('@project') }
      it { should eq(@project) }
    end
  end

  describe 'GET new' do
    before do
      controller.new
    end
    describe 'assigns a new project as @project' do
      subject { controller.instance_variable_get('@project') }
      it { should be_a_new(Project) }
    end
  end

  describe 'GET edit' do
    before do
      @project = Project.create! valid_attributes
      controller.edit(@project.to_param)
    end
    describe 'assigns the requested project as @project' do
      subject { controller.instance_variable_get('@project') }
      it { should eq(@project) }
    end
  end

  describe 'POST create' do
    context 'with valid params' do
      before do
        controller.should_receive(:redirect_to) {|u| u.should eq(Project.last) }
      end
      describe 'creates a new Project' do
        it { expect {
          controller.create(valid_attributes)
        }.to change(Project, :count).by(1) }
      end

      describe 'assigns a newly created project as @project and redirects to the created project' do
        before do
          controller.create(valid_attributes)
        end
        subject { controller.instance_variable_get('@project') }
        it { should be_a(Project) }
        it { should be_persisted }
      end
    end

    context 'with invalid params' do
      describe "assigns a newly created but unsaved project as @project, and re-renders the 'new' template" do
        before do
          Project.any_instance.stub(:save) { false }
          controller.should_receive(:render).with(:action => 'new')
          controller.create({ "user_id" => "invalid value" })
        end
        subject { controller.instance_variable_get('@project') }
        it { should be_a_new(Project) }
      end
    end
  end

  describe 'PUT update' do
    context 'with valid params' do
      describe 'updates the requested project, assigns the requested project as @project, and redirects to the project' do
        before do
          @project = Project.create! valid_attributes
          controller.should_receive(:redirect_to).with(@project, anything)
          controller.update(@project.to_param, valid_attributes)
        end
        subject { controller.instance_variable_get('@project') }
        it { should eq(@project) }
      end
    end

    context 'with invalid params' do
      describe "assigns the project as @project, and re-renders the 'edit' template" do
        before do
          @project = Project.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Project.any_instance.stub(:save) { false }
          controller.should_receive(:render).with(:action => 'edit')
          controller.update(@project.to_param, { "user_id" => "invalid value" })
        end
        subject { controller.instance_variable_get('@project') }
        it { should eq(@project) }
      end
    end
  end

  describe 'DELETE destroy' do
    before do
      @project = Project.create! valid_attributes
      controller.stub(:projects_url) { '/projects' }
      controller.should_receive(:redirect_to).with('/projects')
    end
    it 'destroys the requested project, and redirects to the projects list' do
      expect {
        controller.destroy(@project.to_param)
      }.to change(Project, :count).by(-1)
    end
  end
end
