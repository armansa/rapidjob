RapidJob
=========

RapidJob is a RabbitMQ-backed Ruby library for processing background jobs.

It's not complete yet!

Any class can include Rapid::Job.
<pre>
class MyJob
  include Rapid::Job

  retry_count 5

  retry_delays [10, 20, 30, 40, 50]

  def self.fail
    puts 
  end

  def to_json
    '{}'
  end

  def self.from_json json_message
    new
  end

  def f s
    puts "hey hey hey, f is called: #{s}"
  end

  def self.g
    puts 'hey hey hey, g is called'
  end

  def self.h a, b
    puts "h is called with a: #{a}, b: #{b}"
  end
end
</pre>

Then it's functions can be called in background:
<pre>
mg = MyJob.new
mg.rapid.f "Salaam"

MyJob.rapid.g

MyJob.rapid.mission(g: nil, h: [1, 2])
</pre>

To pop messages from MQ and run:
<pre>
rake rapid:worker QUEUE=my_job
</pre>
