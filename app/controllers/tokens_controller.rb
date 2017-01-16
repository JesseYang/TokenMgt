class TokensController < ApplicationController

  def index
    box_accounts = Account.where(platform: "box")
    box_accounts.each do |e|
      e.refresh_tokens
    end
    access_tokens = box_accounts.map { |e| e.access_token } .select { |e| e.present? }
    render text: "AAA,BBB,CCC,DDD,EEE" and return
    # render text: access_tokens.join(',') and return
  end
end
