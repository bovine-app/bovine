# frozen_string_literal: true

# Application root controller.
class HomeController < ApplicationController
  include SessionAuthentication

  before_action :current_user

  def index; end
end
