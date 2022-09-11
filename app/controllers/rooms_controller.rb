class RoomsController < ApplicationController
  def show
    # DM
    @user = User.find(params[:id])
    @current_entry = Entry.where(user_id: current_user.id)
    @partner_entry = Entry.where(user_id: @user.id)

    unless @user.id == current_user.id
      @current_entry.each do |current|
        @partner_entry.each do |partner|
          if current.room_id == partner.room_id
            @room_id = current.room_id
          else
             @room = Room.create
             @entry = Entry.create
          end
        end
      end
    end

  end
end
