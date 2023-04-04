require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  test "获取文章列表" do
    article_one = Article.create!(title: "Article One", content: "content")
    article_two = Article.create!(title: "Article Two", content: "content")

    get articles_url, as: :json
    assert_response :success
    assert_equal([
      { 'id' => article_one.id, 'title' => "Article One" },
      { 'id' => article_two.id, 'title' => "Article Two" }
    ], JSON.parse(response.body)['articles'])
  end

  test "创建文章" do
    assert_difference("Article.count") do
      post articles_url, params: { article: { content: 'content', title: 'New Article' } }, as: :json
      assert_response :created, response.body
    end

    assert_equal 'content', JSON.parse(response.body)['article']['content']
    assert_equal 'New Article', JSON.parse(response.body)['article']['title']
  end

  test "查看文章" do
    article = Article.create!(title: "The Article", content: "content")
    get article_url(article), as: :json
    assert_response :success
    assert_equal(
      { 'id' => article.id, 'title' => "The Article", 'content' => "content" },
      JSON.parse(response.body)['article']
    )
  end

  test "更新文章" do
    article = Article.create!(title: "The Article", content: "content")
    patch article_url(article), params: { article: { content: 'New content', title: 'New Title' } }, as: :json
    assert_response :success
    assert_equal(
      { 'id' => article.id, 'title' => "New Title", 'content' => "New content" },
      JSON.parse(response.body)['article']
    )
  end

  test "should destroy article" do
    article = Article.create!(title: "The Article", content: "content")
    assert_difference("Article.count", -1) do
      delete article_url(article), as: :json
    end

    assert_response :no_content
  end
end
