class TopController < ApplicationController
  skip_before_filter :authenticate

  # トップ
  def index
    redirect_to projects_path and return if current_user.present?
  end
end
