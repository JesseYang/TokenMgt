class AccountsController < ApplicationController

  def create
    Account.create_account(params[:platform], params[:account], params[:password])
    redirect_to "/?platform=#{params[:platform]}" and return
  end

  def index
    box_accounts = Account.where(platform: "box")
    box_accounts.each do |e|
      e.refresh_tokens
    end
    access_tokens = box_accounts.map { |e| e.access_token }
    render text: access_tokens.join(',') and return
  end

  def update
    @account = Account.where(id: params[:id]).first
    @account.update_attributes({
      account: params[:account],
      password: params[:password]
    })
    redirect_to "/?platform=#{params[:platform]}" and return
  end
end
