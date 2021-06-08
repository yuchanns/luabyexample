print("nil type:", type(nil))
print("10.4*3 type:", type(10.4*3))
print("print type:", type(print))
print("true type:", type(true))
print("string type:", type("hello world"))

tab1 = { key1 = "val1", key2 = "val2", "val3" }
print("tab1 type:", type(tab1))
for k, v in pairs(tab1) do
    print(k .. " - " .. v)
end

print("type(nil) == \"nil\"", type(nil) == "nil")
print("type(nil) == nil", type(nil) == nil)

if false and nil then
    print("false and nil are false")
end
if 0 and true then
    print("0 is also true")
end

multiline = [[
here is
multiline string
]]
print(multiline)
print("len of multiline:", #multiline)
print("concat \"hello\" with \"world\" using ..:", "hello" .. "world")

tab2 = {"apple"}
tab2["hello"] = "world"
tab2[10] = 11
for k, v in pairs(tab2) do
    if k == 1 then
        print("table index start from 1")
    end
    print("key", k)
end
print("tab2[11] is", tab2[11])

function fibIter(a, b, p, q, count)
    if count == 0 then
        return b
    elseif count % 2 == 0 then
        return fibIter(a, b, ((q*q)+(p*p)), ((q*q)+(2*q*p)), count / 2)
    else
        return fibIter((b*q)+(a*q)+(a*p), (b*q)+(a*q), p, q, count - 1)
    end
end

function fib(n)
    if n == 0 then
        return 1
    else
        return n * fib(n - 1)
    end
end

-- function can be passed as an arg
function testFunc(tbl, func)
    print("test func:")
    for k, v in pairs(tbl) do
        print(k, func(v))
    end
end

testFunc({1, 2, 3, 4, 5}, fib)
testFunc({1, 2, 3, 4, 5}, -- anonymous function
        function(n)
    print("anonymous function")
    return n
end)