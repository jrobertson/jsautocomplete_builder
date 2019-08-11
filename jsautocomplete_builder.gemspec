Gem::Specification.new do |s|
  s.name = 'jsautocomplete_builder'
  s.version = '0.1.0'
  s.summary = 'Makes it trivial to build an autocomplete search feature into a web page.'
  s.authors = ['James Robertson']
  s.files = Dir['lib/jsautocomplete_builder.rb']
  s.add_runtime_dependency('rexle', '~> 1.5', '>=1.5.2')  
  s.signing_key = '../privatekeys/jsautocomplete_builder.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@jamesrobertson.eu'
  s.homepage = 'https://github.com/jrobertson/jsautocomplete_builder'
end
