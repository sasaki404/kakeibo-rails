class BooksController < ApplicationController
    def index
        @books=Book.all
        @books=@books.where(year:params[:year]) if params[:year].present?
        @books=@books.where(month:params[:month]) if params[:month].present?
    end

    def show
        @book=Book.find(params[:id])
    end 

    def new
        @book=Book.new
    end
    
    def create
        book_params=params.require(:book).permit(:year,:month,:inout,:category,:amount)
        @book=Book.new(book_params)
        if @book.save
            flash[:notice]="家計簿にデータを１件登録しました"
            redirect_to books_path
        else   
            flash.now[:alert]="登録に失敗しました"
            render:new
        end

    end
    
    def edit
        @book=Book.find(params[:id])
    end

    def update
        @book=Book.find(params[:id])
        book_params=params.require(:book).permit(:year,:month,:inout,:category,:amount)
        if @book.update(book_params)
            redirect_to books_path
        else
            redirect_to book_path(@book)
        end
    end

    def destroy
        @book=Book.find(params[:id])
        @book.destroy
        redirect_to books_path
    end
end