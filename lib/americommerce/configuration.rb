module AmericommerceApi
  # Configures Plugin.
  def self.configure(configuration = AmericommerceApi::Configuration.new)
    yield configuration if block_given?
    @@configuration = configuration
  end

  def self.configuration
    @@configuration ||= AmericommerceApi::Configuration.new
  end

  class Configuration
  end

end