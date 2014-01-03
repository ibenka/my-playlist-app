class BootstrapLinkRenderer < WillPaginate::ActionView::LinkRenderer
  def html_container(html)
    tag :div, tag(:b, html), container_attributes
  end

  def page_number(page)
    tag :b, 
      link(page, page, rel: rel_value(page)), 
      class: ('active' if page == current_page)
  end

  def gap
    tag :b, '...', class: 'disabled'
  end

  def previous_or_next_page(page, text, classname)
    tag :b, link(text, page || '#')
  end

  def previous_page
    num = @collection.current_page > 1 && @collection.current_page - 1
    previous_or_next_page(num, '&laquo;', 'previous_page')
  end

  def next_page
    num = @collection.current_page < total_pages && @collection.current_page + 1
    previous_or_next_page(num, '&raquo;', 'next_page')
  end
end