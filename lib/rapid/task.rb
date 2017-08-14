module Rapid
  class Task
    def metaclass
      class << self; self; end
    end

    def initialize klass, content, attr
      @klass = klass
      @content = content
      @message_ttl = attr[:message_ttl]
      @routing_key = attr[:routing_key] 
      @max_attempts = attr[:max_attempts] || 1
      @attempt_counter = 0
    end

    def args= args
      @args = args
    end

    def method_name= method_name
      @method_name = method_name
    end

    def to_json
      {
        klass: @klass,
        content: @content,
        message_ttl: @message_ttl,
        routing_key: @routing_key,
        max_attempts: @max_attempts,
        attempt_counter: @attempt_counter,
        method_name: @method_name,
        args: @args,
      }.to_json
    end

    def underscore(camel_cased_word)
      camel_cased_word.to_s.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr('-', '_').
      downcase
    end

    def enqueue
      q = Rapid::get_channel.queue(underscore('rapid_'+@klass.to_s), durable: true)
      q.publish(to_json, persisted: true)# TODO: message_ttl, routing_key
    end
  end
end
