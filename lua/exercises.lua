function change(amount)
  if math.type(amount) ~= "integer" then
    error("Amount must be an integer")
  end
  if amount < 0 then
    error("Amount cannot be negative")
  end
  local counts, remaining = {}, amount
  for _, denomination in ipairs({25, 10, 5, 1}) do
    counts[denomination] = remaining // denomination
    remaining = remaining % denomination
  end
  return counts
end

-- Write your first then lower case function here
function first_then_lower_case(sequence, predicate)
  for _, value in ipairs(sequence) do
    if predicate(value) then return value:lower() end
  end
  return nil
 end

-- Write your powers generator here
function powers_generator(base, limit)
  return coroutine.create(function ()
    local value = 1
    while (value < limit) do
      coroutine.yield(value)
      value = value * base
    end
  end)
end

-- Write your say function here
function say(word)
  if word == nil then
    return ""
  end
  return function (next) return ((next == nil) and word or say(word .. " " .. next)) end
 end

-- Write your line count function here
function meaningful_line_count(filename)
  local line_number = 0
  local file = io.open(filename, 'r')
  if file == nil then
    error("No such file")
  end
  for line in file:lines() do
    local strippedline = string.gsub(line, " ", "")
    strippedline = string.gsub(strippedline, "\n", "")
    strippedline = string.gsub(strippedline, "\013", "")
    strippedline = string.gsub(strippedline, "\009", "")
    if ((strippedline ~= "") and (strippedline ~= nil) and (strippedline:sub(1,1) ~= '#')) then
      line_number = line_number + 1
    end
  end
  file:close()
  return line_number
 end
-- Write your Quaternion table here
Quaternion = {}
function Quaternion.new(a, b, c, d)
  local new_quat = {a=a, b=b, c=c, d=d}
  setmetatable(new_quat, Quaternion)
  Quaternion.__index = Quaternion
  return new_quat
end

function Quaternion:coefficients()
  return {self.a, self.b, self.c, self.d}
end

function Quaternion:conjugate()
  return Quaternion.new(self.a, -self.b, -self.c, -self.d)
end

function Quaternion:eq(other)
  return self.a == other.a and self.b == other.b and self.c == other.c and self.d == other.d
end

function Quaternion:add(other)
  return Quaternion.new(self.a + other.a, self.b + other.b, self.c + other.c, self.d + other.d)
end

function Quaternion:mul(other)
  local mul_a = self.a * other.a - self.b * other.b - self.c * other.c - self.d * other.d
  local mul_b = self.a * other.b + self.b * other.a + self.c * other.d - self.d * other.c
  local mul_c = self.a * other.c - self.b * other.d + self.c * other.a + self.d * other.b
  local mul_d = self.a * other.d + self.b * other.c - self.c * other.b + self.d * other.a
  return Quaternion.new(mul_a, mul_b, mul_c, mul_d)
end

function Quaternion:tostring(other)
  local function coeftostring(coef, comp)
    return ((coef >= 0) and "+" or "-") 
    .. ((math.abs(coef) ~= 1 or comp == "") and tostring(math.abs(coef)) or "") 
    .. comp
  end

  local components = {"", "i", "j", "k"}
  local stringified = ""
  for i, c in ipairs(self:coefficients()) do
    if c ~= 0 then
      stringified = stringified .. coeftostring(c, components[i])
    end
  end
  if (stringified == "") then
    return "0"
  end
  -- This is how you access individual characters in lua
  -- I dont make the rules
  if (string.sub(stringified, 1, 1) == "+") then
    stringified = string.sub(stringified, 2)
  end
  return stringified
end

Quaternion.__eq = Quaternion.eq
Quaternion.__add = Quaternion.add
Quaternion.__mul = Quaternion.mul
Quaternion.__tostring = Quaternion.tostring