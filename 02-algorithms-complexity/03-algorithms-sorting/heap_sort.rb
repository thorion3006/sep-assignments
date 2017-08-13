def heap_sort(collection)
  heap_size = collection.length
  heap = [nil] + collection
  (heap_size / 2).downto(1) do |i|
    down_heap(heap, i, heap_size)
  end
  while heap_size > 1
    heap[1], heap[heap_size] = heap[heap_size], heap[1]
    heap_size -= 1
    down_heap(heap, 1, heap_size)
  end
  heap.drop(1)
end

def down_heap(heap, parent, limit)
  root = heap[parent]
  while (child = parent * 2) <= limit
    child += 1 if child < limit && heap[child] < heap[child + 1]
    break if root >= heap[child]
    heap[parent] = heap[child]
    parent = child
  end
  heap[parent] = root
end
