# frozen_string_literal: true

# Application root controller.
class HomeController < ApplicationController
  before_action :current_user

  def index; end
end
