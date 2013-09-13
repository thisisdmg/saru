module Saru
  class AccessDenied < StandardError
    DEFAULT_MESSAGE = 'You are not authorized to %s %s.'
    attr_reader :action, :subject

    def initialize(action, subject, message = nil)
      @action = action
      @subject = subject
      @message = message
    end

    def to_s
      @message || DEFAULT_MESSAGE % [@action, @subject]
    end
  end
end
