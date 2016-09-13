class AccountsController < ApplicationController

  def create
  	Account.create_account(params[:platform], params[:account], params[:password])
  	redirect_to "/?platform=#{params[:platform]}" and return
  end
end
