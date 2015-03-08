class FeedsController < ApplicationController
  before_action :authenticate
  before_action :set_feed, only: [:show, :update, :destroy]

  # GET /feeds
  # GET /feeds.json
  def index
    @feeds = Feed.order("created_at DESC").limit(10)
    render json: @feeds.to_json(:methods => [:attachment_url], :except=>[:attachment_file_name])
  end

  # GET /feeds/1
  # GET /feeds/1.json
  def show
    render json: @feed.to_json(:methods => [:attachment_url], :except=>[:attachment_file_name])
  end

  # POST /feeds
  # POST /feeds.json
  def create
    @feed = Feed.new(feed_params)

    if @feed.save
      render json: @feed.to_json(:methods => [:attachment_url], :except=>[:attachment_file_name]), status: :created, location: @feed
    else
      render json: {:error => "Invalid Request"}.to_json, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /feeds/1
  # PATCH/PUT /feeds/1.json
  def update
    @feed = Feed.find(params[:id])

    if @feed.user_id != @login_user.id
      render json: {:error => "You are not authorized to update this feed"}.to_json, status: :unauthorized
    else 
      if @feed.update(feed_params)
        head :no_content
      else
        render json: {:error => "Invalid Request"}.to_json, status: :unprocessable_entity
      end
    end
  end

  # DELETE /feeds/1
  # DELETE /feeds/1.json
  def destroy
    @feed.destroy

    head :no_content
  end

  private

    def set_feed
      @feed = Feed.find(params[:id])
    end

    def feed_params
      params.require(:feed).permit(:content, :user_id, :attachment)
    end
end
