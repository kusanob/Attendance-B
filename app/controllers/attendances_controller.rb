class AttendancesController < ApplicationController
  before_action :set_user, only: [:edit_one_month, :update_one_month]
  before_action :logged_in_user, only: [:update, :edit_one_week]
  before_action :admin_or_correct_user, only: [:update, :edit_one_month, :update_one_month]
  before_action :set_one_month, only: :edit_one_month
  
  UPDATE_ERROR_MSG = "勤怠登録に失敗しました。やり直してください。"
  
  def update
    @user = User.find(params[:user_id])
    @attendance = Attendance.find(params[:id])
    if @attendance.started_at.nil?
      if @attendance.update_attributes(started_at: Time.current.floor_to(15.minutes))
        flash[:info] = "おはようございます！本日も一日頑張りましょう！"
      else
        flash[:danger] = UPDATE_ERROR_MSG
      end
    elsif @attendance.finished_at.nil?
      if @attendance.update_attributes(finished_at: Time.current.floor_to(15.minutes))
        flash[:info] = "本日も一日お疲れさまでした！"
      else
        flash[:danger] = UPDATE_ERROR_MSG
      end
    end
    redirect_to @user
  end
  
  def edit_one_month
  end
  
  def update_one_month
    ActiveRecord::Base.transaction do
      attendances_params.each do |id, item|
        attendance = Attendance.find(id)
        if item[:started_at].present? && item[:finished_at].present?
          attendance.update_attributes!(item)
          flash[:success] = "1ヶ月分の勤怠情報を更新しました。"
          redirect_to user_url(date: params[:date])
        else
          flash[:danger] = "退勤も更新してください"
          redirect_to attendances_edit_one_month_user_url(date: params[:date])and return
        end
      end
    end
  rescue ActiveRecord::RecordInvalid
      flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
      redirect_to attendances_edit_one_month_user_url(date: params[:date])
  end

  private
  
    def attendances_params
      params.require(:user).permit(attendances: [:started_at, :finished_at, :note])[:attendances]
    end
    
    def admin_or_correct_user
      @user = User.find(params[:user_id]) if @user.blank?
      unless current_user?(@user) || current_user.admin?
        flash[:danger] = "編集権限がありません。"
        redirect_to(root_url)
      end  
    end
end

# @attendance.started_at.present? && @attendance.finished_at.present?
# @attendance.update_attributes(started_at: Time.current, finished_at: Time.current)
# flash[:danger] = "退勤も更新してください"
      # redirect_to attendances_edit_one_month_user_url(date: params[:date])and return
# @attendance = Attendance.find(params[:id])
    # if @attendance.started_at.present? && @attendance.finished_at.blank?
      # flash[:danger] = "退勤も更新してください"
      # redirect_to attendances_edit_one_month_user_url(date: params[:date])and return
    # end