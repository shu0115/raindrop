class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate           # ログイン認証
  before_filter :reset_session_expires  # セッション有効期限延長

  private

  # Markdown変換表示
  def show_markdown(text)
    html_render = HtmlWithPygments.new(hard_wrap: true, filter_html: true)
    markdown    = Redcarpet::Markdown.new(html_render, autolink: true, fenced_code_blocks: true, space_after_headers: true)

    return markdown.render(text.to_s) rescue text
  end
  helper_method :show_markdown

  # ログイン認証
  def authenticate
    unless signed_in?
      # リクエストURL保管
      session[:request_url] = request.url

      # ルートヘリダイレクト
      redirect_to :root and return
    end
  end

  # セッション期限延長
  def reset_session_expires
    request.session_options[:expire_after] = 2.weeks
  end

  # ログインユーザ
  def current_user
    @current_user ||= User.where( id: session[:user_id] ).first
  end
  helper_method :current_user

  # ユーザ登録チェック
  def signed_in?
    User.where( id: session[:user_id] ).exists?
  end
  helper_method :signed_in?
end
