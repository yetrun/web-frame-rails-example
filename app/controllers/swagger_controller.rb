class SwaggerController < ApplicationController
  def index
    Rails.application.eager_load! # 需要提前加载所有控制器常量
    doc = Meta::Rails::Plugin.generate_swagger_doc(ApplicationController,
      info: {
        title: 'Web API 示例项目',
        version: 'current'
      },
      servers: [
        { url: 'http://localhost:9292', description: 'Web API 示例项目' }
      ]
    )
    render json: doc
  end
end
