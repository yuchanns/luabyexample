-- default global variable
a = 5
-- local variable
local b = 5

function joke()
    c = 5 -- global
    local d =6 -- local
end

joke()
print("global c:", c, "local d:", d)

do
    local a = 6
    b = 6
    print("local a:", a, "local b:", b)
end

print("a:", a, "b:", b)

-- batch assign variables
e, f = 10, 11
print("e:", e, "f:", f)

-- default nil if not assign value
a, b, c = 1, 2
print("a", a, "b", b, "c", c)

-- extra values will be ignore
a, b = 4, 5, 6
print("a", a, "b", b)

-- index of table
user = {}
user["name"] = "yuchanns"
print("user[\"name\"]:", user["name"])
print("user.name:", user.name)