$: << File.join(RAILS_ROOT,'lib/runners') unless $:.include?(File.join(RAILS_ROOT,'lib/runners'))
require 'sweetcron'
require 'crawlerstarttask'
