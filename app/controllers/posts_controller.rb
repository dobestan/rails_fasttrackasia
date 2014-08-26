class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  # NEW -> CREATE
  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.save

    # post_path(post), 즉 새로 생성된 post의 show action으로 이동한다.
    redirect_to post_path(post)
  end

  # EDIT -> UPDATE
  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to post_path(post)
  end

  private
    def post_params
      # post라는 이름의 form 에 대해서 ( form_for @post / form_for :post )
      # title, content라는 항목에 대해서만 parameter로 받는다
      params.require(:post).permit(:title, :content)
    end
end
