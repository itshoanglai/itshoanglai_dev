# frozen_string_literal: true

require 'digest'
require 'bcrypt'

class AuthenticationController < ApplicationController
  include AuthenticationHelper

  before_action :set_common_data

  def set_common_data
    gon.controller_name = controller_name
    gon.action_name = action_name
    gon.create_registration = register_path
  end

  def new_session; end

  def create_session; end

  def new_registration
    @default_date_of_birth = (Time.zone.today - 18.years).strftime('%Y-%m-%d')
  end

  def create_registration
    email    = params[:email].to_s.strip.downcase
    password = params[:password]
    fullname = params[:full_name]
    dob      = params[:date_of_birth]
    gender   = params[:gender]

    salt = ENV.fetch('HASHID_SALT', nil)
    return render json: { success: false, error: 'Server misconfigured' }, status: :internal_server_error if salt.blank?

    email_name = email.split('@').first
    hashid     = Digest::SHA256.hexdigest("#{email_name}#{salt}")

    user = User.new(
      email: email,
      encrypted_password: password,
      hashid: hashid
    )

    unless user.valid?
      return render json: {
        success: false,
        error: user.errors.full_messages.first
      }, status: :unprocessable_content
    end

    ActiveRecord::Base.transaction do
      user.save!

      Patient.create!(
        user_id: user.id,
        fullname: fullname,
        dob: dob,
        gender: gender,
        private_email: email,
        hashid: Digest::SHA256.hexdigest("#{hashid}patient#{salt}")
      )
    end

    render json: { success: true }
  rescue ActiveRecord::RecordInvalid => e
    render json: {
      success: false,
      error: e.record.errors.full_messages.first
    }, status: :unprocessable_content
  end

  def destroy_session; end
end
