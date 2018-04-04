class MessagesController < ApplicationController
  include SessionsHelper
  before_action :set_message, only: [:update, :destroy]

  def create
    @message=@device.messages.build(message_params)
    device=Device.find_by_id(params[:deviceid])
    redirect_to chats_path, flash: {:warning => '此聊天不存在'} and return if device.nil?
    @message.device = device
    @message.from_whom = 0
    @message.whom_id = @device_status.user_id
    if @message.save
      sync_new @message, scope: device
    else
      redirect_to root_path(divice), flash: {:warning => '消息发送失败'} and return
    end
    redirect_to root_path(device)
  end

  def destroy
    @message = Message.find(params[:id])
    chat=Chat.find_by_id(params[:chat_room])
    @message.destroy
    sync_destroy @message
    redirect_to chat_path(chat)
  end

  def destroyall
    chat=Chat.find_by_id(params[:chat_room])
    chat.messages.delete_all
    redirect_to chat_path(chat), flash: {info: '聊天记录已清空'}
  end

  private
  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:body)
  end
end

# def update
#   respond_to do |format|
#     if @message.update(message_params)
#       format.html { redirect_to @message, notice: 'Message was successfully updated.' }
#       format.json { render :show, status: :ok, location: @message }
#     else
#       format.html { render :edit }
#       format.json { render json: @message.errors, status: :unprocessable_entity }
#     end
#   end
# end
