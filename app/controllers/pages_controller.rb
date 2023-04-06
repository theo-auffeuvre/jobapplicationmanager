class PagesController < ApplicationController
  before_action :authenticate_user!

  def home
    @statuses = Status.all
  end
end
