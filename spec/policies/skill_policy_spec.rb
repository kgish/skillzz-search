require "rails_helper"

RSpec.describe SkillPolicy do
  context "permissions" do
    subject { SkillPolicy.new(user, skill) }

    let(:user) { FactoryGirl.create(:user) }
    let(:category) { FactoryGirl.create(:category) }
    let(:skill) { FactoryGirl.create(:skill, category: category) }

    context "for anonymous users" do
      let(:user) { nil }

      it { should_not permit_action :show }
      it { should_not permit_action :update }
      it { should_not permit_action :destroy }
      it { should_not permit_action :tag }
    end

    context "for viewers of the category" do
      before { assign_role!(user, :viewer, category) }

      it { should permit_action :show }
      it { should_not permit_action :update }
      it { should_not permit_action :destroy }
      it { should_not permit_action :tag }
    end

    context "for editors of the category" do
      before { assign_role!(user, :editor, category) }

      it { should permit_action :show }
      it { should_not permit_action :update }
      it { should_not permit_action :destroy }
      it { should_not permit_action :tag }

      context "when the editor created the skill" do
        before { skill.author = user }

        it { should permit_action :update }
      end
    end

    context "for managers of the category" do
      before { assign_role!(user, :manager, category) }

      it { should permit_action :show }
      it { should permit_action :update }
      it { should permit_action :destroy }
      it { should permit_action :tag }
    end

    context "for managers of other categories" do
      before do
        assign_role!(user, :manager, FactoryGirl.create(:category, name: "Truly Amazing Stuff"))
      end

      it { should_not permit_action :show }
      it { should_not permit_action :update }
      it { should_not permit_action :destroy }
      it { should_not permit_action :tag }
    end

    context "for administrators" do
      let(:user) { FactoryGirl.create :user, :admin }

      it { should permit_action :show }
      it { should permit_action :update }
      it { should permit_action :destroy }
      it { should permit_action :tag }
    end
  end
end