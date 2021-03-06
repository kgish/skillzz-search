require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

  it "handles a missing category correctly" do
    get :show, id: "not-here"
    expect(response).to redirect_to(categories_path)
    message = "The category you were looking for could not be found."
    expect(flash[:alert]).to eq message
  end

  it "handles permission errors by redirecting to a safe place" do
    allow(controller).to receive(:current_user)
    category = FactoryGirl.create(:category)
    get :show, id: category
    expect(response).to redirect_to(root_path)
    message = "Sorry, but you are not allowed to do that."
    expect(flash[:alert]).to eq message
  end
end
