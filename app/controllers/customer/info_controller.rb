class Customer::InfoController < ApplicationController
  # TODO: For the time-being checks disabled for authorized and policy.
  skip_after_action :verify_authorized, :verify_policy_scoped

  def show
    @worker = User.find(params[:id])
    # TODO
    # Authorize
  end

end
