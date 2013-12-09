module ApplicationHelper
  
  # ページタイトル
  def page_title
    title = "Morning Glory"
    title = @page_title + " - " + title if @page_title
    title
  end

  # ヘッダーのメニューバーを生成
  # 現在のページの場合はリンクを生成せずspanでテキストを囲む
  def menu_link_to(text, path)
    link_to_unless_current(text, path) { content_tag(:span, text)}
  end
end
