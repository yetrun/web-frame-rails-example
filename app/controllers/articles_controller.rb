class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show update destroy ]

  route '/articles', :get do
    title '获取文章列表'
    tags ['Article']
    status 200 do
      expose :articles, type: 'array', ref: ArticleEntity
    end
  end
  def index
    @articles = Article.all
    render json_on_schema: { 'articles' => @articles }
  end

  route '/articles/:id', :get do
    title '查看文章'
    tags ['Article']
    status 200 do
      expose :article, ref: ArticleEntity.locked(scope: 'full')
    end
  end
  def show
    render json_on_schema: { 'article' => @article }
  end

  route '/articles', :post do
    title '创建文章'
    tags ['Article']
    params do
      param :article, required: true, ref: ArticleEntity.locked(scope: 'full')
    end
    status 201 do
      expose :article, ref: ArticleEntity.locked(scope: 'full')
    end
  end
  def create
    @article = Article.new(params_on_schema[:article])
    if @article.save
      render json_on_schema: { 'article' => @article }, status: :created, location: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  route '/articles/:id', :patch do
    title '更新文章'
    tags ['Article']
    params do
      param :article, required: true, ref: ArticleEntity.locked(scope: 'full', discard_missing: true)
    end
    status 200 do
      expose :article, ref: ArticleEntity.locked(scope: 'full')
    end
  end
  def update
    if @article.update(params_on_schema[:article])
      render json_on_schema: { 'article' => @article }
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  route '/articles/:id', :delete do
    title '删除文章'
    tags ['Article']
    status 204
  end
  def destroy
    @article.destroy
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end
end
