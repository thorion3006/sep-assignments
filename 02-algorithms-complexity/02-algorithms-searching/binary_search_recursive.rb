def binary_search_recursive(array, item, low = 0, high = array.length)
  mid = low + high / 2
  return "#{item} found at index #{mid}" if array[mid] == item
  return "#{item} not found." if low > high
  if array[mid] > item
    high = mid - 1
  else
    low = mid + 1
  end
  binary_search_recursive(array, item, low, high)
end
