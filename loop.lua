-- while
a = 10
while (a < 20) do
    print("a:", a)
    a = a + 1
end

-- for range
function f(x)
    print("f evaluated")
    return x*2
end
for i=1, f(5) do -- f will be only evaluated at the first time
    print("i", i)
end

-- for iter
a = {"one", "two", "three"}
for i, v in ipairs(a) do
    print("i", i, "v", v)
end

--[[
repeat until always executed at least once
because the condition test is done after the body
]]
a = 10
repeat
    print("a:", a)
    a = a + 1
until (a > 15)

-- embed loop
j = 2
for i = 2, 10 do
    for j = 2, (i/j), 2 do
        if(not(i%j)) then
            break -- break
        end
        if (j > (i/j)) then
            print("i", i)
        end
    end
end

-- goto
local a = 1
::label:: print("--- goto label ---")

a = a + 1
if a < 3 then
    goto label
end

for i = 1, 3 do
    if i <= 2 then
        print(i, "yes continue")
        goto continue
    end
    print(i, " no continue")
    ::continue::
    print([[i'm end]])
end

i = 0
::s1:: do
    print(i)
    i = i + 1
end
if i > 3 then
    os.exit()
end

goto s1