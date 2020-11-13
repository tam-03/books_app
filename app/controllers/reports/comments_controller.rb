class Reports::CommentsController < ApplicationController
  before_action :set_report
  before_action :set_report_comment, only: [:show, :edit, :update, :destroy]
  before_action :validates_user, only: [:show, :edit, :update, :destroy]

  def index
    @comments = @report.comments.all.page params[:page]
  end

  def show; end

  def new
    @comment = @report.comments.new
  end

  def edit
    @comment = @report_comment
  end

  def create
    @comment = @report.comments.new(comment_params)
    @comment.user_id = current_user.id

    respond_to do |format|
      if @comment.save
        format.html { redirect_to report_comments_path, notice: t('notice_create_comment') }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @report_comment.update(comment_params)
        format.html { redirect_to report_comments_path, notice: t('notice_update_comment') }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @report_comment.destroy
    respond_to do |format|
      format.html { redirect_to report_comments_path, notice: t('notice_destroy_comment') }
      format.json { head :no_content }
    end
  end

  private

  def set_report
    @report = Report.find(params[:report_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_report_comment
    @report_comment = @report.comments.find_by(id: params[:id], user_id: current_user.id)
  end

  def validates_user
    redirect_to report_comments_path(@report, @comment), alert: t('validates_user_alert') if @report_comment.user_id != current_user.id
  end
end
