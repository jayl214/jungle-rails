module ApplicationHelper

  def homepageLink
    content_tag(:a, "Your cart is empty!" , class: 'btn btn-primary', href: '/')
  end

end
