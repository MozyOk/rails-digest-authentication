# frozen_string_literal: true

require 'digest/md5'

class ApplicationController < ActionController::Base
  before_action :authenticate

  REALM = 'SecretZone'
  USERS = { 'user1' => Digest::MD5.hexdigest(['user1', REALM, 'password'].join(':')) }.freeze

  def index
    render plain: 'ログイン後に表示されるよ!'
  end

  private

  def authenticate
    authenticate_or_request_with_http_digest(REALM) do |username|
      USERS[username]
    end
  end
end
