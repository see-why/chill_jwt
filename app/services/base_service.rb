class BaseService
  Response = Struct.new(:data, :error) do
    def success?
      error.nil?
    end
  end

  def self.call(...)
    new(...).call
  end
end
