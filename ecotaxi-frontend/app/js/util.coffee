_.subHash = (obj, props, context) ->
  result = {}
  if obj? and _.isArray props
    _.each props, (key) ->
      result[key] = obj[key]
  result
