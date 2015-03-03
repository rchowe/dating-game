
file 'index.html' => 'index.haml' do
	sh 'haml index.haml > index.html'
end

file 'main.js' => 'main.coffee' do
	sh 'coffee -c main.coffee'
end

task :default => [:'index.html', :'main.js']
