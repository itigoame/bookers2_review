class GroupChatsController < ApplicationController

  def create
    @group = Group.find(params[:group_id])
    @group_chat = current_user.group_chats.new(group_chat_params)
    @group_chat.group_id = @group.id
    # if
      @group_chat.save
      @group_chats = @group.group_chats
      redirect_to group_path(@group.id)
    # else
    #   @group_chats = GroupChat.new
    #   render group_path(group.id), alert: "投稿に失敗しました。もう一度お試しください。"
    # end
  end

  def destroy

  end
  private

  def group_chat_params
    params.require(:group_chat).permit(:body)
  end

end
