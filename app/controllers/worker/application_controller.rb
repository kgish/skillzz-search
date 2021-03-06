class Worker::ApplicationController < ApplicationController
  # TODO: For the time-being checks disabled for authorized and policy.
  skip_after_action :verify_authorized, :verify_policy_scoped
  before_action :set_user
  before_action :authorize_worker!

  def index
  end

  private

    def set_user
      @user = current_user
    end

    def authorize_worker!
      authenticate_user!
      unless @user.worker?
        redirect_to root_path, alert: "You must be a worker to do that."
      end
    end

end
