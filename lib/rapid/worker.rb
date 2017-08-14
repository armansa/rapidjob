require "bunny"
namespace :rapid do
  desc "Start a rapid worker."
  task :worker => :environment do
    conn = Bunny.new
    conn.start
    ch = conn.create_channel
    q  = ch.queue("rapid_"+ENV['QUEUE'], durable: true)
    delivery_info, metadata, payload = q.pop
    puts payload
		task = JSON.parse payload
		klass = task['klass'].constantize
		obj = task['content'] ? klass.new : klass
		obj.send(task['method_name'], *task['args'])
    conn.stop
  end
end
