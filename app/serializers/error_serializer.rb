class ErrorSerializer
  def initialize(error_object)
    @error_object = error_object
  end

  def serialize_json
    {
      error: @error_object.message,
      status: @error_object.status
    }
  end
end