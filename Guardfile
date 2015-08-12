#notification :gntp, :host => '127.0.0.1'
#notification :off
notification :terminal_notifier

guard 'rake', :task => 'test' do
  watch(%r{^manifests\/(.+)\.pp$})
  watch(%r{^spec\/**\/(.+)\.rb$})
end
