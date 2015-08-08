# Description:
#   Simple calculator script respecting PEMDAS preference
#
# Commands:
#   calc <expr> - calculate mathematical expression
#
# Author:
#   miretz
#
evaluate = (operator, num1, num2) ->
  num1 = parseInt(num1)
  num2 = parseInt(num2)
  result = switch
    when operator == '+' then num1 + num2
    when operator == '-' then num1 - num2
    when operator == '*' then num1 * num2
    when operator == '/' then num1 / num2
    else num1 + num2

  #console.log("calculate: " + num1 + operator + num2 + "=" + result)
  
  return result

reduceList = (list, operators) ->
  result_list = []
  for element, i in list
    if element in operators
      result_list.push evaluate(element, result_list[result_list.length - 1], list[i+1])
      result_list.splice(result_list.length - 2, 1)
      list.splice(i+1, 1)
    else
      result_list.push element

  result_list = (item for item in result_list when item != undefined) 
  
  #console.log result_list
  
  return result_list

calculate = (res) ->
  input = res.match[1]
  inputs = input.split(' ')

  for element in inputs
    if element not in ['+','-','*','/'] and isNaN(element)
        res.send "Invalid expression!"
        return

  inputs = reduceList(inputs, ['*'])
  inputs = reduceList(inputs, ['/'])
  inputs = reduceList(inputs, ['+','-'])

  res.send "#{input} = #{inputs[0]}"

module.exports = (robot) ->
  robot.hear /^calc (.*)$/i, (res) ->
    calculate(res)
