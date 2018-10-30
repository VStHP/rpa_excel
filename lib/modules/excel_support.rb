module ExcelSupport
  include ApplicationHelper
  CELL_ADDRESS_PERMIT = /^\$?[A-Z]{1,3}\d{1,4}$/
  SPECIAL_CHARS = /([\s+*)(\/<>=:!-])/

  def export_data_xlsx(file_template, model)
    # Open file by RubyXL to work
    workbook = RubyXL::Parser.parse(file_template)
    # Select first sheet of workbook
    sheet = workbook[0]
    # Get last row of sheet (Follow format, it must be row template data)
    temp_data = sheet[-1]
    # Get index row of row temp_data
    temp_row = temp_data.cells[0].row
    model.classify.constantize.all.each_with_index do |obj, idx|
      # Set index of row will add data is below the last row has data
      row_index = sheet.sheet_data.rows.length
      0.upto(temp_data.cells.length-1) do |col_idx|
        if temp_data[col_idx].value == 'auto_increment'
          # Set data auto increment with index of object
          sheet.add_cell(row_index, col_idx, idx + 1)
        else
          # set value sheet by value attr of object or '' base on template data
          value = obj.attribute_names.include?(temp_data[col_idx].value) ? obj.send(temp_data[col_idx].value) : ''
          sheet.add_cell(row_index, col_idx, value)
        end
        # Set number format for working-cell by template
        sheet[row_index][col_idx].set_number_format(temp_data[col_idx].number_format&.format_code)
        # Set full-style for working-cell by template
        sheet[row_index][col_idx].style_index = temp_data[col_idx].style_index
        # Rewrite value of working-cell by new format if value is datetime
        # It's necessary for cell require format type datetime
        if is_datetime?(value)
          sheet[row_index][col_idx].change_contents(remove_timezone(value))
        end
        # Rewrite value of working-cell if this cell has formula
        if temp_data[col_idx]&.formula&.expression
          sheet[row_index][col_idx].change_contents(
            '',
            match_formula(temp_data[col_idx]&.formula&.expression, temp_row, row_index)
          )
        end
      end
    end
    # Delete row containt template data
    sheet.delete_row(temp_row)
    workbook.stream.string
  end

  def export_data_xls(file_template, model)
    Spreadsheet.client_encoding = 'UTF-8'
    workbook = Spreadsheet.open(file_template)
    sheet = workbook.worksheet(0)
    temp_data = sheet.row(-1)
    temp_row = temp_data.idx
    model.classify.constantize.all.each_with_index do |obj, idx|
      row_index = sheet.rows.length
      0.upto(temp_data.length-1) do |col_idx|
        if temp_data[col_idx] == 'auto_increment'
          sheet.row(row_index).push(idx + 1)
        else
          value = obj.attribute_names.include?(temp_data[col_idx]) ? obj.send(temp_data[col_idx]) : temp_data[col_idx].value
          sheet.row(row_index).push(value)
        end
        sheet.row(row_index).set_format(col_idx, sheet.row(temp_row).format(col_idx))
      end
    end
    sheet.delete_row(temp_row)
    file_contents = StringIO.new
    workbook.write file_contents
    file_contents.string
  end

  # Description: Rewrite the formula based on the current row
  # Params:
  #   - formula: String (formula of template data)
  #   - temp_row: Integer (row index of template data)
  #   - current_row: Integer (index of row will write data)
  # Results:
  #   Positive:
  #     - New formula base on template: String
  #   Negative:
  #     - return when params formula is nil
  def match_formula(formula, temp_row, current_row)
    return unless formula
    array = formula.split(SPECIAL_CHARS)
    array.each_with_index do |item, idx|
      next if item.blank? || is_integer?(item)

      if CELL_ADDRESS_PERMIT === item
        # từ ô công thức + thêm khoảng cách giữa row được thêm và header
        new_row = item.gsub(/\D/, '').to_i + (current_row - (temp_row + 1))
        array[idx] = item.gsub(/\d/, new_row.to_s)
      end
    end
    array.join
  end

  def write_and_download(file, model)
    file_ext = File.extname(file.path)
    unless Constant::PERMIT_EXT.include?(file_ext)
      @message_danger = "Can't read file with ext #{file_ext}"
      return
    end
    filename = "report_#{model}_#{Time.zone.now.strftime('%Y%m%d%H%M%S')}"
    if Constant::RUBYXL_PERMIT_EXT.include?(file_ext)
      filename += '.xlsx'
      send_data(export_data_xlsx(file.path, model.capitalize), filename: filename)
    else
      filename += '.xls'
      send_data(export_data_xls(file.path, model.capitalize), filename: filename)
    end
  end

  # def mkdir_excels
  #   Dir.mkdir('/tmp/excels') unless Dir.exist?('/tmp/excels')
  # end

  # def remove_zip_files_by_date(model)
  #   `rm -f /tmp/excels/report_#{model}_#{Time.zone.now.strftime('%Y%m%d')}*`
  # end
end
