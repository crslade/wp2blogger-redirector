require 'rack/rewrite' 

use Rack::Static, :urls => ['/index.html', '/favicon.ico'], :root => 'public'

if ENV['RACK_ENV'] == 'development'
  use Rack::ShowExceptions
end

root = 'http://www.christopherslade.com'

use Rack::Rewrite do
  #Redirect the index page
  r301 %r{index.php}, root
  #Redirect the author page
  r301 %r{\A/authors/crslade}, root+'/p/about_21.html'
  #Redirect the feed page
  r301 %r{^/feed}, root+'/feeds/posts/default'
  #Redirect all old urls
  r301 %r{\A/([0-9]{4})/([0-9]{2})/([A-Za-z\-]*)/?\z}, "#{root}/$1/$2/$3.html"
end

run Proc.new { |env|
    [200, {'Content-Type' => 'text/plain'}, ['Nothing Here']]
}

