class RedirectsController < ApplicationController

  def box
    account = Account.where(id: params[:state]).first
    retval = account.get_tokens(params[:code])
    redirect_to "/" and return
  end

  def onedrive
  	# account = Account.where(id: params[:state]).first
    # retval = account.get_tokens
    redirect_to "/" and return
  end
end
