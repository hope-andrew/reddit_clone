class SubsController < ApplicationController
  before_action :check_for_mod, only: [:edit]
  before_action :check_logged_in, only: [:create]

  def new
    render :new
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def create
    # @sub = current_user.subs.new(sub_params)
    @sub = Sub.new(sub_params.merge({moderator: current_user.id}))
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def update
    @sub = Sub.find(params[:id])

    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def index
  end
  private

    def sub_params
      params.require(:sub).permit(:title, :description)
    end

    def check_for_mod
      if current_user.id != Sub.find(params[:id]).moderator_id
        flash.now[:errors] = ["Must be moderator to edit sub"]
        redirect_to subs_url
      end
    end

    def check_logged_in
      if !logged_in?
        flash[:errors] = ["You must be logged in."]
        redirect_to new_session_url
      end
    end

end
