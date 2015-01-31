module ApplicationHelper
  
  def font_awesome_link_tag
    '<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" />'.html_safe
  end
  
  def google_font_link_tag
    '<link href="http://fonts.googleapis.com/css?family=PT+Serif:700italic" rel="stylesheet" type="text/css" />'.html_safe
  end
  
end
