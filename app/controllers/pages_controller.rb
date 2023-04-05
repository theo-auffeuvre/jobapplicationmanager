class PagesController < ApplicationController
  before_action :authenticate_user!

  def home
    @statuses = current_user.statuses
  end
end
