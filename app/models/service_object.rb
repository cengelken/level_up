class ServiceObject
  attr_reader :context

  def initialize(params = {})
    @context = OpenStruct.new
    params.each do |k, v|
      @context.send("#{k}=", v)
    end
    setup if respond_to? :setup
  end

  def errors
    @errors ||= []
  end

  def message
    errors.join("\n")
  end

  def fail!(message = '')
    errors << message
  end

  def failure?
    errors.any?
  end

  def success?
    !failure?
  end

  def run
    fail NotImplementedError, "Please implement 'run' to perform the work."
  end

  def call
    run unless failure?
    self
  end

  def self.call(context = {})
    new(context).call
  end
end
