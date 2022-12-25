module Top
  def top(count)
    all.sort_by{ |b| -(b.average_rating || 0) }.first(count)
  end
end
