module ApplicationHelper
  def is_integer?(string)
    /\A[-+]?\d+\z/ === string
  end

  def is_datetime?(arg)
    arg.methods.include? :strftime
  end

  def format_datetime_standard(datetime)
    datetime.strftime('%Y-%m-%d %H:%M:%S')
  end

  def remove_timezone(datetime)
    datetime_format = '%Y/%m/%d %H:%M:%S'
    DateTime.strptime(datetime.strftime(datetime_format), datetime_format)
  end
end
