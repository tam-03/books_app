class Books::CommentsController < ApplicationController
  before_action :set_book
  before_action :set_book_comment, only: [:show, :edit, :update, :destroy]
  before_action :validates_user, { only: [:show, :edit, :update, :destroy] }

  # GET /Comments
  # GET /Comments.json
  def index
    @comments = @book.comments.all
  end

  # GET /Comments/1
  # GET /Comments/1.json
  def show; end

  # GET /Comments/new
  def new
    @comment = @book.comments.new
  end

  # GET /Comments/1/edit
  def edit
    @comment = @book_comment
  end

  # POST /Comments
  # POST /Comments.json
  def create
    @comment = @book.comments.new(comment_params)
    @comment.user_id = current_user.id

    respond_to do |format|
      if @comment.save
        format.html { redirect_to book_comments_path, notice: 'Comment was successfully created.' }
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
      if @book_comment.update(comment_params)
        format.html { redirect_to book_comments_path, notice: 'Comment was successfully updated.' }
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
    @book_comment.destroy
    respond_to do |format|
      format.html { redirect_to book_comments_path, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_book
    @book = Book.find(params[:book_id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_book_comment
    @book_comment = @book.comments.find_by(id: params[:id], user_id: current_user.id)
  end

  def validates_user
    redirect_to book_comments_path(@book, @comment), alert: '自分のコメントではありません。' if @book_comment.user_id != current_user.id
  end
end
