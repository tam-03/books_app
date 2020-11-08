class Reports::CommentsController < ApplicationController
    before_action :set_report
    before_action :set_report_comment, only: [:show, :edit, :update, :destroy]
    before_action :validates_user, { only: [:show, :edit, :update, :destroy] }

  # GET /Comments
  # GET /Comments.json
  def index
    @comments = @report.comments.all
  end

  # GET /Comments/1
  # GET /Comments/1.json
  def show
  end

  # GET /Comments/new
  def new
    @comment = @report.comments.new
  end

  # GET /Comments/1/edit
  def edit
    @comment = @report_comment
  end

  # POST /Comments
  # POST /Comments.json
  def create
    @comment = @report.comments.new(comment_params)
    @comment.user_id = current_user.id

    respond_to do |format|
      if @comment.save
        format.html { redirect_to report_comments_path, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /Comments/1
  # PATCH/PUT /Comments/1.json
  def update
    respond_to do |format|
      if @report_comment.update(comment_params)
        format.html { redirect_to report_comments_path, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /Comments/1
  # DELETE /Comments/1.json
  def destroy
    @report_comment.destroy
    respond_to do |format|
      format.html { redirect_to report_comments_path, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:report_id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:body)
    end

    def set_report_comment
      @report_comment = @report.comments.find_by(id: params[:id], user_id: current_user.id)
    end

    def validates_user
        redirect_to report_comments_path(@report, @comment), alert: '自分のコメントではありません。' if @report_comment.user_id != current_user.id
    end
end
