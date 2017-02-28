class TokensController < ApplicationController

  def index
  	a1 = Account.where(platform: "box", account: "box0@b-fox.cn").first
  	a2 = Account.where(platform: "box", account: "box1@b-fox.cn").first
  	a3 = Account.where(platform: "box", account: "box2@b-fox.cn").first
  	a4 = Account.where(platform: "box", account: "box3@b-fox.cn").first
  	a5 = Account.where(platform: "dropbox", account: "box0@b-fox.cn").first


    # box_accounts = Account.where(platform: "box", account: /box*/)
    box_accounts = [a1, a2, a3, a4, a5]
    access_tokens = box_accounts.map { |e| e.access_token } .select { |e| e.present? }
    render text: access_tokens.join(',') and return
  end
end
