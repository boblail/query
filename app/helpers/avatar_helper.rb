module AvatarHelper
  
  def avatar_for(user, options={})
    return "" unless user
    
    size = options.fetch(:size, 24)
    "<img class=\"avatar user-#{user.id}\" src=\"#{gravatar_url(user.email, size: size * 2)}\" width=\"#{size}\" height=\"#{size}\" alt=\"#{user.name}\" />".html_safe
  end
  
  # http://en.gravatar.com/site/implement/ruby
  # http://en.gravatar.com/site/implement/url
  def gravatar_url(email, options={})
    url = "http://www.gravatar.com/avatar/#{Digest::MD5::hexdigest(email)}?r=g&d=retro"
    url << "&s=#{options[:size]}" if options.key?(:size)
    url
  end
  
end
