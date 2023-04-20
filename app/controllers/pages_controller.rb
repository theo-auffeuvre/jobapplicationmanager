class PagesController < ApplicationController
  before_action :authenticate_user!

  def home
    @statuses = Status.all
    @icons = ["fas fa-star", "fas fa-file", "fas fa-handshake", "fas fa-check", "fas fa-face-frown"]
  end
end
