module ApplicationHelper

  def format_price(price)
    number_to_currency(price)
  end

  def format_date_time1(date_time)
    date_time.httpdate
  end

  def format_status(status)
    case status
    when "canceled"
      "Đã Hủy"
    when "pending"
      "Đang Chờ Xử Lí"
    else
      "Thành Công"
    end
  end

  def format_alert(type)
    # pp "type" + type
    case type
    when "success"
      { :header_color => "bg-success text-white", :header_msg => "Thành Công" }
    when "error"
      { :header_color => "bg-danger text-white", :header_msg => "Lỗi" }
    else
      { :header_color => "bg-info text-dark", :header_msg => "Chú Ý" }
    end

  end

end
