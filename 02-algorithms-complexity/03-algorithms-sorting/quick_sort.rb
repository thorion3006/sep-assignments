def quick_sort(collection, left = 0, right = collection.length - 1)
  if left < right
    pivot = partition(collection, left, right)
    quick_sort(collection, left, pivot - 1)
    quick_sort(collection, pivot + 1, right)
  end
  collection
end

def partition(array, left, right)
  pivot = left
  unsorted = left
  (unsorted...right).each do |i|
    if array[i] <= array[right]
      swap(array, pivot, i)
      pivot += 1
    end
  end
  swap(array, pivot, right)
  pivot
end

def swap(array, first_element, second_element)
  temp = array[first_element]
  array[first_element] = array[second_element]
  array[second_element] = temp
end
