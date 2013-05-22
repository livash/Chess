module Conversion
  def str_to_coord(str) # "d6"
    col_map = ("a".."h").to_a
    str_col, str_row = str.chars.to_a
    coord_col = col_map.index(str_col)
    coord_row = 8 - str_row.to_i #- 1 # 0..7
    # coord_row = (str_row.to_i - 1)
    [coord_col, coord_row] # [3, 5]
  end

  def coord_to_str(coord_array)
    col_map = ("a".."h").to_a
    row, col= coord_array
    col_string = col_map[col].to_s
    row_string = (8 - row).to_s       # 0 => 8
    "#{col_string}#{row_string}"
  end
end