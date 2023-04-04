# meta-api: Rails 插件示例

这是一个 Rails 插件示例项目。

1. 查看 `app/controllers/articles_controller.rb` 和 `test/controllers/articles_controller_test.rb` 了解如何定义接口规格和实现的效果。
2. 查看 `app/controllers/swagger_controller.rb` 了解如何生成 Swagger 文档。

## 执行测试用例

```bash
$ bundle install
$ rails db:setup
$ rails test
```

## 查看 Swagger 文档

```bash
$ rails server
```

然后访问 `http://localhost:3000/swagger_doc`.
