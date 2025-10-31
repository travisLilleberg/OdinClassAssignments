# O(n^2) I believe
def stock_picker(stocks)
  best_dates = [0,0]
  i = 0
  while(i < stocks.length - 1) do
    j = i + 1
    while (j < stocks.length) do
      best_dates = [i,j] if stocks[j] - stocks[i] > stocks[best_dates[1]] - stocks[best_dates[0]]
      j += 1
    end
    i += 1
  end

  best_dates
end

# 0(n)
def stock_picker_2(stocks)
  best = nil
  last = nil
  first = nil
  i = stocks.length
  while(i > 0)
    i -= 1

    if(last == nil)
      last = i
      next
    end

    if(first == nil)
      if(stocks[i] > stocks[last])
        last = i
      else
        first = i
        # Now that we have a last and first, we can save them, if best is still nil.
        best ||= [first,last]
      end
      next
    end

    if(stocks[i] < stocks[first])
      first = i;
      next;
    end

    if(stocks[i] > stocks[last])
      # When resetting last, save [first,last] if its better than best.
      if(stocks[last] - stocks[first] > stocks[best[1]] - stocks[best[0]])
        best = [first,last]
      end

      last = i
      first = nil
      next
    end
  end
  
  # One final check to see if the current first,last is better than best.
  if(first != nil) 
    best = [first,last] if stocks[last] - stocks[first] > stocks[best[1]] - stocks[best[0]]
  end

  best
end

p stock_picker_2([17,3,6,9,15,8,6,1,10])
#[1,4]  # for a profit of $15 - $3 == $12