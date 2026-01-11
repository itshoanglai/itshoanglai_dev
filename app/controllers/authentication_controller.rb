# frozen_string_literal: true

class AuthenticationController < ApplicationController
  include AuthenticationHelper

  before_action :set_common_data

  def set_common_data
    gon.controller_name = controller_name
    gon.action_name = action_name
  end

  def new_session
  end

  def create_session
  end

  def new_registration
  end

  def create_registration
  end

  def destroy_session
  end
end
