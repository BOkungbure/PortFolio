new_message = print((17*6) - (9*7)+(5*7))
X = 2
Y = X
print(Y)
age,sex,race = 30,'Male','Black' # You can do mass variable declarations this way
print(age,sex,race)

age+=1
print(age)

# The current volume of a water reservoir (in cubic metres)
reservoir_volume = 4.445e8
# The amount of rainfall from a storm (in cubic metres)
rainfall = 5e6

# decrease the rainfall variable by 10% to account for runoff
rainfall *= 0.9

# add the rainfall variable to the reservoir_volume variable
reservoir_volume += rainfall

# increase reservoir_volume by 5% to account for stormwater that flows
# into the reservoir in the days following the storm
reservoir_volume *= 1.05

# decrease reservoir_volume by 5% to account for evaporation
reservoir_volume *= 0.95

# subtract 2.5e5 cubic metres from reservoir_volume to account for water
# that's piped to arid regions.
reservoir_volume -= 2.5e5

# print the new value of the reservoir_volume variable
print(reservoir_volume)


carrots = 24
rabbits = 8
crs_per_rab = carrots/rabbits
rabbits = 12
print(crs_per_rab)# In python, unless you've declared changes to a variable before running an operation, the value in the variable sa
# stays same, when declared after an operation.

print(type(rabbits))# This gets the type of the variable

