use Rack::Auth::Digest::MD5, "auth", '' do |username|
  "password"
end

run proc { [200, {'Content-Type' => 'text/html'}, ['hoge']] }
