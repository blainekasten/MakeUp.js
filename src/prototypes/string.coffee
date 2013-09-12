String::toArray = ->
  indices = []
  for i in @split(/,/)
    split = i.split(/-/)
    min = Number split[0]
    max = Number split[1]
    for j in [min..max]
      indices.push j
  indices
