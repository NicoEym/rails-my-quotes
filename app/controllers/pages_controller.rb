require 'date'


class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @asset_types = AssetType.all
    @assets = Asset.all
    @date = Date.today
  end
end
