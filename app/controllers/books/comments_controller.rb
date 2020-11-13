class Books::CommentsController < ApplicationController
  before_action :set_book
  before_action :set_book_comment, only: [:show, :edit, :update, :destroy]
  before_action :validates_user, only: [:show, :edit, :update, :destroy]

  def index
    @comments = @book.comments.all.page params[:page]
  end

  def show; end

  def new
    @comment = @book.comments.new
  end

  def edit
    @comment
  end

  def create
    @comment = @book.comments.new(comment_params)
    @comment.user_id = current_user.id

    respond_to do |format|
      if @comment.save
        format.html { redirect_to book_comments_path, notice: t('notice_create_comment') }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to book_comments_path, notice: t('notice_update_comment') }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to book_comments_path, notice: t('notice_destroy_comment') }
    end
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_book_comment
    @comment = @book.comments.find_by(id: params[:id], user_id: current_user.id)
  end

  def validates_user
    redirect_to book_comments_path(@book, @comment), alert: t('validates_user_alert') if @comment.user_id != current_user.id
  end
end
