class RedirectsController < ApplicationController

  def box
    Rails.logger.info "AAAAAAAAAAAAAAAAAAAAA"
    Rails.logger.info params.inspect
    Rails.logger.info "AAAAAAAAAAAAAAAAAAAAA"

    render text: params.inspect
  end

end
