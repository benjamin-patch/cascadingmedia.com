set :url_root, 'https://cascadingmedia.com'

activate :search_engine_sitemap

###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# no layout
page "/sitemap.xml", :layout => false
page "/insites/feed.xml", :layout => false
page "404.html", :layout => false

page "insites.html", :layout => :insite_layout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

set :partials_dir, 'partials'

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

# Methods defined in the helpers block are available in templates
helpers do

  def page_title
    if current_page.data.title.present?
      current_page.data.title + " | " + data.site_info.site_name
    else
      data.site_info.site_name
    end
  end

  def subtitle
    current_page.data.subtitle
  end

  def meta_description
    if current_page.data.description.present?
      current_page.data.description
    else
      data.site_info.site_description
    end
  end

  def is_page_active(page)
    current_page.url == page ? 'current-location' : 'nav-button'
  end

  def current_month_year
    t = Time.now
    t.strftime("%B %Y")
  end

  def article_date
    article_date = current_page.data.date
    article_date.strftime("%B %e, %Y")
  end
end

set :css_dir, 'assets/styles'

set :fonts_dir, 'assets/fonts'

set :js_dir, 'assets/scripts'

set :images_dir, 'assets/images'

ready do
  sprockets.import_asset 'vendor/modernizr-2.8.3.min.js'
  sprockets.import_asset 'vendor/jquery-2.1.1.min.js'
end

# Clean URLs
activate :directory_indexes
page "404.html", :directory_index => false

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable gzip
  activate :gzip

  # Enable cache buster
  activate :asset_hash

  # Use relative URLs
  activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"

  activate :minify_html do |html|
    html.remove_multi_spaces        = true   # Remove multiple spaces
    html.remove_comments            = true   # Remove comments
    html.remove_intertag_spaces     = false  # Remove inter-tag spaces
    html.remove_quotes              = true   # Remove quotes
    html.simple_doctype             = false  # Use simple doctype
    html.remove_script_attributes   = true   # Remove script attributes
    html.remove_style_attributes    = true   # Remove style attributes
    html.remove_link_attributes     = true   # Remove link attributes
    html.remove_form_attributes     = false  # Remove form attributes
    html.remove_input_attributes    = false  # Remove input attributes
    html.remove_javascript_protocol = true   # Remove JS protocol
    html.remove_http_protocol       = false  # Remove HTTP protocol
    html.remove_https_protocol      = false  # Remove HTTPS protocol
    html.preserve_line_breaks       = false  # Preserve line breaks
    html.simple_boolean_attributes  = true   # Use simple boolean attributes
    # html.preserve_patterns          = nil    # Patterns to preserve
  end
end

activate :blog do |blog|
  blog.prefix = "insites"
  blog.permalink = "{year}/{month}/{title}"
  blog.layout = "article_layout"

  # Matcher for blog source files
  blog.sources = "{year}/{month}/{title}"
  # blog.taglink = "tags/{tag}.html"

  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  # blog.year_link = "{year}.html"
  # blog.month_link = "{year}/{month}.html"
  # blog.day_link = "{year}/{month}/{day}.html"
  # blog.default_extension = ".markdown"

  # blog.tag_template = "tag.html"
  # blog.calendar_template = "calendar.html"

  # Enable pagination
  # blog.paginate = true
  # blog.per_page = 10
  # blog.page_link = "page/{num}"
end

activate :deploy do |deploy|
  deploy.method = :rsync
  deploy.host   = '45.55.82.64'
  deploy.path   = '/var/www/cascadingmedia.com/public'
  # Optional Settings
  deploy.user  = 'alpha' # no default
  deploy.port  = 1776 # ssh port, default: 22
  deploy.clean = true # remove orphaned files on remote host, default: false
  # deploy.flags = '-rltgoDvzO --no-p --del' # add custom flags, default: -avz
end
