require 'rack/rewrite' 

use Rack::Static, :urls => ['/index.html', '/favicon.ico'], :root => 'public'

if ENV['RACK_ENV'] == 'development'
  use Rack::ShowExceptions
end

#change to your domain
root = 'http://www.christopherslade.com'

use Rack::Rewrite do
  #Customize this section for your blog
  #Redirect the author page
  r301 %r{\A/authors/crslade}, root+'/p/about_21.html'
  #Add other URLS that might have changed here
  #for example blogger removes words like 'the', 'a' and 'with' from the url.
  r301 %r{\A/2011/09/rails-editors-and-the-command-line/?\z}, "#{root}/2011/09/rails-editors-and-command-line.html"
  r301 %r{\A/2009/03/outliers-by-malcolm-gladwell/?\z}, "#{root}/2009/03/outliers-story-of-success-by-malcolm.html"
  r301 %r{\A/2010/10/migrating-to-a-new-host/?\z},"#{root}/2010/10/migrating-to-new-host.html"
  r301 %r{\A/2011/01/amacraigbay-with-google-products/?\z}, "#{root}/2011/01/amacraigbay-now-with-google-products.html"
  
  #Leave the following rules alone.
  #Redirect the index page
  r301 %r{index.php}, root
  #Redirect the feed page
  r301 %r{^/feed}, "#{root}/feeds/posts/default"
  #Redirect the archive pages
  r301 %r{\A/([0-9]{4})/([0-9]{2})/?\z}, "#{root}/$1_$2_01_archive.html"
  #Redirect all old urls
  r301 %r{\A/([0-9]{4})/([0-9]{2})/([A-Za-z\-]*)/?\z}, "#{root}/$1/$2/$3.html"
  #Redirect categories and tags to labels
  r301 %r{\A/tag/([A-Za-z\-]*)/?}, "#{root}/search/label/$1"
  r301 %r{\A/category/([A-Za-z\-]*)/?}, "#{root}/search/label/$1"
end

run Proc.new { |env|
    [200, {'Content-Type' => 'text/plain'}, ['Nothing Here']]
}

