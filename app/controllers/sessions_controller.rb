class SessionsController < ApplicationController

  def new
    redirect_to "/auth/github"
  end

  def create
    auth = request.env["omniauth.auth"]
    user = User.where(provider: auth["provider"], uid: auth["uid"].to_s).first ||
           User.create_with_omniauth(auth)
    
    # Is the user a member of the required organization?
    github_token = env["omniauth.auth"].credentials.token
    client = Octokit::Client.new access_token: github_token
    organizations = client.organizations.map(&:login)
    unless organizations.include? Rails.application.secrets.github_organization
      redirect_to root_url, notice: "Unable to sign in"
      return
    end

    reset_session
    session[:user_id] = user.id
    redirect_to root_url, notice: "Signed in!"
  end

  def destroy
    reset_session
    redirect_to root_url, notice: "Signed out!"
  end

  def failure
    redirect_to root_url, alert: "Authentication error: #{params[:message].humanize}"
  end

end
