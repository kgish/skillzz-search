class Customer::SearchController < ApplicationController
  # TODO: For the time-being checks disabled for authorized and policy.
  skip_after_action :verify_authorized, :verify_policy_scoped

  def show
    @user = User.find(params[:id])
    # TODO
    # Authorize (current_user MUST equal user)
  end

end
