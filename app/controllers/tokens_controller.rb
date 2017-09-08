class TokensController < ApplicationController

  def index
  	b1 = Account.where(platform: "box", account: "box0@b-fox.cn").first
  	b2 = Account.where(platform: "box", account: "box1@b-fox.cn").first
  	b3 = Account.where(platform: "box", account: "box2@b-fox.cn").first
  	b4 = Account.where(platform: "box", account: "box3@b-fox.cn").first
  	b5 = Account.where(platform: "box", account: "box4@b-fox.cn").first
  	d1 = Account.where(platform: "dropbox", account: "box0@b-fox.cn").first


    # box_accounts = Account.where(platform: "box", account: /box*/)
    box_accounts = [b1, b2, b3, b4, d1]
    # box_accounts = [a1, a2, a3, a4, a5]
    access_tokens = box_accounts.map { |e| e.access_token } .select { |e| e.present? }
    render text: access_tokens.join(',') and return
  end
end
