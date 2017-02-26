class ArticlesController < ApplicationController
  # index, show, new, edit, create, update and destroy
  # caution!!! - before_action are proccesed in order they are listed
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end
  
  def show
  end
  
  def new
    @article = Article.new
  end
  
  def edit
  end
  
  def create
    # render plain: params[:article].inspect
    # debugger
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = "Article was created successfully."
      redirect_to article_path(@article)
    else
      render 'new' # or render :new
    end
  end
  
  def update
    if @article.update(article_params)
      flash[:success] = "Article was updated successfully."
      redirect_to article_path(@article)
    else
      render 'edit' # render the edit page again
    end
  end
  
  def destroy
    @article.destroy
    flash[:danger] = "Article was deleted successfully."
    redirect_to articles_path
  end
  
  private
    def set_article
      @article = Article.find(params[:id])
    end
    
    def article_params
      params.require(:article).permit(:title, :description)
    end
    
    def require_same_user
      if  current_user != @article.user
        flash[:danger] = "You can only edit or delete your own articles"
        redirect_to root_path
      end
    end
  
end