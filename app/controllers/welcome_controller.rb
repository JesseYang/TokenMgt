class WelcomeController < ApplicationController
  def index
    box_accounts = Account.where(platform: "box")
    @box_accounts = auto_paginate(box_accounts)

    onedrive_accounts = Account.where(platform: "onedrive")
    @onedrive_accounts = auto_paginate(onedrive_accounts)

    googledrive_accounts = Account.where(platform: "googledrive")
    @googledrive_accounts = auto_paginate(googledrive_accounts)

    @platform = params[:platform].blank? ? "box" : params[:platform]
  end
end
