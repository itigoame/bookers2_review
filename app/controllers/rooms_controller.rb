class RoomsController < ApplicationController

  def create
    @room          = Room.create
    @current_entry = Entry.create(room_id: @room.id, user_id: current_user.id)
    @partner_entry = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id))
    redirect_to room_path(@room.id)
  end

  def show
    @room = Room.find(params[:id])

    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages
      @message  = Message.new
      @entries  = @room.entries
      @partner = @entries.where.not(user_id: current_user.id).first
    else
      redirect_back
    end

  end

end
