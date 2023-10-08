class BooksController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
  end

  def index
    @books = Book.all
    # @book = Book.new

    # Qiitaからコピペ
    # 変数.to定義(現在日時23:59)
    to = Time.current.at_end_of_day
    # 変数.from定義(7日後)
    from = (to - 6.day).at_beginning_of_day

    # いいねを持っているユーザーがいる本一覧を取得
    # sort_byにていいね数順に並び替え、reverseにて昇順に切替
    @books = Book.all.sort {|a,b|
        a.favorites.where(created_at: from...to).size <=>
        b.favorites.where(created_at: from...to).size
       }.reverse

      # sort_by {|x|
        # x.favorited_users.includes(:favorites).where(created_at: from...to).size
      # }.reverse
      # ここまで

      # ブックインスタンスを生成
      @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render "index"
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book)
    else
      render "edit"
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end



  def book_params
    params.require(:book).permit(:title, :body)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end
end

