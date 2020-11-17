class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :validates_user, only: [:edit, :update, :destroy]

  def index
    @books = Book.all.page params[:page]
  end

  def show
  end

  def new
    @book = Book.new
  end

  def edit
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id

    if @book.save
      redirect_to @book, notice: t('notice_create')
    else
      render :new
    end
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: t('notice_update')
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_url, notice: t('notice_destroy')
  end

  private
    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :memo, :author, :picture)
    end

    def validates_user
      redirect_to root_path, alert: t('validates_user_alert') if @book.user_id != current_user.id
    end
end
