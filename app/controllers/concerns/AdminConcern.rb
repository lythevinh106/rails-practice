module AdminConcern
  extend ActiveSupport::Concern


  # included do
  #   around_action :wrap_in_transaction  # caái này có thể handle error , rôlback and logging
  #
  #   def wrap_in_transaction
  #     ActiveRecord::Base.transaction do
  #       begin
  #         yield
  #       ensure
  #         raise ActiveRecord::Rollback
  #       end
  #     end
  #
  #   end
  #
  #
  #
  #
  # end
  #
  # class_methods do
  #   # def handler_error_generic(path)
  #   #   begin
  #   #     yield   # yeild are these above method in controller
  #   #   rescue StandardError => e
  #   #     logger.error(e.message)
  #   #     flash[:error] = "Có lỗi xảy ra. Vui lòng thử lại sau."
  #   #     if path
  #   #       redirect_to path
  #   #     end
  #   #   end
  #   # end
  #
  #
  # end



  prepended do
    puts "trigger foi Controller"
  end











end