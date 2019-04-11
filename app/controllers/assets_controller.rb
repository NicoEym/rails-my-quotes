class AssetsController < ApplicationController

  def new
    asset = Asset.new
  end

  def create
    asset = Asset.new(params[:asset])
    asset.save
  end

  private

  def asset_params
    params.require(:asset).permit(:asset_name, :last_price, :daily_variation)
  end

end
