def binary_search_iterative(array, item)
  low = 0
  high = array.length - 1
  mid = array.length / 2
  while low <= high
    return "#{item} found at index #{mid}" if array[mid] == item
    if array[mid] > item
      high = mid - 1
    else
      low = mid + 1
    end
    mid = (low + high) / 2
  end
  "#{item} not found."
end
