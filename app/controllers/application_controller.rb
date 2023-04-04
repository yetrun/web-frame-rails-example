class ApplicationController < ActionController::API
  # 引入宏命令
  include Meta::Rails::Plugin

  # 处理参数验证错误，以下仅是个示例，请根据实际需要编写
  rescue_from Meta::Errors::ParameterInvalid do |e|
    render json: e.errors, status: :bad_request
  end
end
