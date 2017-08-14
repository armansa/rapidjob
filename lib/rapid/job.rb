module Rapid
  module Job
    def self.included(base)
      base.send(:extend, ClassMethods)
    end

    module ClassMethods

      def rapid attr={}
        job = Rapid::Task.new self.to_s, nil, attr
        methods = self.public_methods - self.superclass.methods
        methods.each do |method_name|
          job.metaclass.send(:define_method, method_name) do |*args|
            self.method_name= method_name
            self.args= args
            self.enqueue
            self
          end
        end
        job
      end

    end

    def rapid attr={}
      job = Rapid::Task.new self.class.to_s, self.to_json, attr
      methods = self.public_methods - self.class.superclass.instance_methods
      methods.each do |method_name|
        job.metaclass.send(:define_method, method_name) do |*args|
          self.method_name= method_name
          self.args= args
          self.enqueue
          self
        end
      end
      job
    end

  end
end
