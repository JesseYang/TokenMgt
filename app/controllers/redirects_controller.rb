class RedirectsController < ApplicationController

  def box
    account = Account.where(id: params[:state]).first
    retval = account.get_token(params[:code])
    redirect_to "/" and return
  end
end
