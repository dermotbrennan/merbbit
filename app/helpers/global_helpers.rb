module Merb
  module GlobalHelpers
    # helpers defined here available to all views.  
    def logged_in_content(&block)
      if session.user
        yield
      end
    end
  end
end
