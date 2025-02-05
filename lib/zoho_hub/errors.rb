# frozen_string_literal: true

module ZohoHub
  class RecordNotFound < StandardError
  end

  class RecordInvalid < StandardError
  end

  class InvalidTokenError < StandardError
  end

  class InvalidQuery < StandardError
  end

  class InternalError < StandardError
  end

  class InvalidModule < StandardError
  end

  class NoPermission < StandardError
  end

  class MandatoryNotFound < StandardError
  end

  class RecordInBlueprint < StandardError
  end

  class ZohoAPIError < StandardError
  end

  class SyntaxError < StandardError
  end
end
