class RedirectsController < ApplicationController

  def box
    Rails.logger.info "AAAAAAAAAAAAAAAAAAAAA"
    Rails.logger.info params.inspect
    Rails.logger.info "AAAAAAAAAAAAAAAAAAAAA"

    account = Account.where(id: params[:state]).first
    retval = account.get_access_token(params[:code])

    render text: retval.inspect
  end
end
