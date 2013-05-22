module Conversion
  def str_to_coord(str) # "d6"
    col_map = ("a".."g").to_a
    str_col, str_row = str.chars.to_a
    coord_col = col_map.index(str_col)
    coord_row = (str_row.to_i - 1)
    [coord_col, coord_row] # [3, 5]
  end

  def coord_to_str(coord_array)
    col_map = ("a".."g").to_a
    row, col= coord_array
    col_string = col_map[col].to_s
    row_string = (row + 1).to_s
    col_string + row_string
  end
end