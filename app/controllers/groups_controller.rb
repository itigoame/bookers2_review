class GroupsController < ApplicationController
  before_action :ensure_correct_user, { only: [:edit, :update, :destroy] }

  def ensure_correct_user
    @group = Group.find_by(id: params[:id])
    return unless @group.owner_id != current_user.id

    redirect_to groups_path
  end

  def new
    @group = Group.new
  end

  def create
    group = Group.new(group_params)
    group.owner_id = current_user.id
    if group.save
      redirect_to groups_path, notice: "グループを作成しました。"
    else
      @group = Group.new
      render :new, alert: "グループ作成に失敗しました。もう一度お試しください。"
    end
  end

  def show
    @group = Group.find(params[:id])
  end

  def index
    @groups = Group.all
    @group_joining = GroupUser.where(user_id: current_user.id)
    @group_not_join ="参加しているチャットグループがありません"
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if  @group.update(group_params)
      redirect_to groups_path, notice: "編集に成功しました。"
    else
      render :edit, alert: "編集に失敗しました。もう一度お試しください。"
    end
  end

  def destroy
    group = Group.find(params[:id])
    if group.destroy
      redirect_to groups_path, notice: "グループを削除しました。"
    end
  end

  private
    def group_params
      params.require(:group).permit(:name, :body, :group_image, :owner_id)
    end
end