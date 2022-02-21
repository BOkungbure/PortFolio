import string


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

# You can also convert the data type by enclosing it in a datatype e.g.
int_test = int(4+5)
print(int_test)

float_test = float(4+5)
print(float_test)

print(.1+.1+.1)# just an example of float addition in python

print(24/0)
print(5 < 3) #boolean

sf_population, sf_area = 864816, 231.89
rio_population, rio_area = 6453682, 486.5

san_francisco_pop_density = sf_population/sf_area
rio_de_janeiro_pop_density = rio_population/rio_area

# Write code that prints True if San Francisco is denser than Rio, and False otherwise
comparison = san_francisco_pop_density > rio_de_janeiro_pop_density
print(comparison)

print('test & "tests" & test\'s') #string tests
print('test & "tests" & test\'s'*5) #string tests

first_name = 'Babatunde'
middle_name = 'Oluwayomi'
last_name = 'Okungbure'
full_name = (first_name+' '+middle_name+' '+last_name)
print(full_name)# adding strings together
print(first_name[7])# printing a character of a particular postion in a string

no_of_characters = len(full_name)
print(no_of_characters)


username = "Kinari"
timestamp = "04:50"
url = "http://petshop.com/pets/mammals/cats"

# TODO: print a log message using the variables above.
# The message should have the same format as this one:
# "Yogesh accessed the site http://petshop.com/pets/reptiles/pythons at 16:20."

print(username+' accessed the site '+url+' at '+timestamp)

given_name = "William"
middle_names = "Bradley"
family_name = "Pitt"

name_length = len(given_name+' '+middle_names+' '+family_name)
print(name_length)

# Now we check to make sure that the name fits within the driving license character limit
# Nothing you need to do here
driving_license_character_limit = 28
print(name_length <= driving_license_character_limit)

mon_sales = "121"
tues_sales = "105"
wed_sales = "110"
thurs_sales = "98"
fri_sales = "95"

#TODO: Print a string with this format: This week's total sales: xxx
# You will probably need to write some lines of code before the print statement.

week_sales = int(mon_sales)+int(tues_sales)+int(wed_sales)+int(thurs_sales)+int(fri_sales)
week_sales_str = str(week_sales)
print("This week's total sales: "+week_sales_str)

#.format string function
# Write two lines of code below, each assigning a value to a variable
var1 = 12
var2 = 13
# Now write a print statement using .format() to print out a sentence and the 
#   values of both of the variables
print('The numbers are {} and {}'.format(var1,var2))

#.split string function
new_str = "The cow jumped over the moon."
new_str.split()
new_str.split(sep=' ', maxsplit=50)


verse = "If you can keep your head when all about you\n  Are losing theirs and blaming it on you,\nIf you can trust yourself when all men doubt you,\n  But make allowance for their doubting too;\nIf you can wait and not be tired by waiting,\n  Or being lied about, don’t deal in lies,\nOr being hated, don’t give way to hating,\n  And yet don’t look too good, nor talk too wise:"
print(verse)

# What is the length of the string variable verse?
str_length = len(verse)

# What is the index of the first occurrence of the word 'and' in verse?
substr_index1 = verse.find('and')

# What is the index of the last occurrence of the word 'you' in verse?
substr_index2 = verse.rfind('you')

# What is the count of occurrences of the word 'you' in the verse?
substr_count = verse.count('you')

print('\n\nThe total number of characters in the poem is {},\nWhile the first index of the word "you" is {},\n and last index of that same word is {}.\nIn total "You" appears {} time(s)'.format(str_length,substr_index1,substr_index2,substr_count))


#Practising Lists
months = [
    'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']

print(len(months))
list_callout1 = months[len(months)-1] #calling the last item in a list
list_callout2 = months[-1] #There's an easier way to accomplish this buy just wrapping -1 in square brackets
list_callout1 == list_callout2 #By running a check statement you see that the callouts are identical despite using different formulas

#slicing lists
q1 = months[0:3]
q2 = months[3:6]
q3 = months[6:9]
q4 = months[9:12]
print('\nThe 1st quarter consists of:\n{}\nThe 2nd quarter consists of:\n{}\nThe 3rd quarter consists of:\n{}\nThe 4th quarter consists of:\n{}'.format(q1,q2,q3,q4))


first_half = months[:6] #the value on the right side of the square bracket is exclusive
second_half = months[6:] #the value on the left side of the square bracket is inclusive
print(first_half)
print(second_half)

print('monday' in first_half, 'monday' not in second_half)

#List Mutability
list_of_names = ['Babatunde','Oluwayom','Okungbure']
list_of_names[1] = 'Oluwayomi'
print(list_of_names)

month = 8
days_in_month = [31,28,31,30,31,30,31,31,30,31,30,31]

# use list indexing to determine the number of days in month
num_days = days_in_month[7]

print(len(days_in_month))
print(max(days_in_month))
print(min(days_in_month))
print(sorted(days_in_month))
print(sum(days_in_month))




sentence1 = "I wish to register a complaint."
sentence2 = ["I", "wish", "to", "register", "a", "complaint", "."]
sentence3 = "\n".join(sentence2)
print(sentence3)
sentence3.append#check append function
print(sentence3)
a = [1, 5, 8]
b = [2, 6, 9, 10]
c = [100, 200]

print(max([len(a), len(b), len(c)]))
print(min([len(a), len(b), len(c)]))

# Tuple Practice
height, age = 170, 31
print(height, age)


# Practising Sets. Sets are unordered lists without duplicates
# Sets are can have values added to them with the .add function
# Values can be removed from sets using the .pop function
# Sets are unordered they have no last value

numbers = [1, 2, 6, 3, 1, 1, 6]
set_numbers = set(numbers)
print(set_numbers)

set_numbers.add(100)
print(set_numbers)

print(100 in set_numbers)
print(1000 in set_numbers)

set_numbers.add(1000)
print(set_numbers)

set_numbers.pop()
print(set_numbers)

set_numbers.remove(1000)
print(set_numbers)


# Dictionaries are data containers that house and map unique keys to their values
# Dictionaries are mutable
# Dictionaries can house any number of data types
# Lists start are denoted by [] while dictionaries use {}
elements = {"hydrogen": 1,
            "helium": 2,
            "carbon": 6}

print(elements["helium"])

# Changing the data value of a unique key
elements["lithium"] = 3

# Looking up values in a dictionary
print("carbon" in elements)

print(elements.get("dilithium"))

n = elements.get("dilithium")
print( n is None)
print( n is not None)

population = {
    'Shanghai': 17.8,
    'Istanbul': 13.3,
    'Karachi': 13.0,
    'Mumbai': 12.5}

print(population)

print('Lagos' in population)
print(population.get('Lagos'))
print(population.get('Lagos','\nThe value entered is invalid'))


# Advanced Dictionaries

animals = {
'dogs': [20, 10, 15, 8, 32, 15],
'cats': [3,4,2,8,2,4],
'rabbits': [2, 3, 3],
'fish': [0.3, 0.5, 0.8, 0.3, 1]
}

animals['dogs'][3]
#animals[3]
animals['fish']

# Compound Dictionaries
family_members = {
    'Babatunde':{
        'Age(yrs)': 30,
        'Height(cm)': 170,
        'Weight(kg)': 75},
    'Segun':{
        'Age(yrs)': 40,
        'Height(cm)': 176,
        'Weight(kg)': 80}
}

print(family_members.get('Babatunde'))
family_members['Babatunde']['Age(yrs)']


Wunmi = {'Age(yrs)': 40, 'Height(cm)': 170, 'Weight(kg)': 70}
family_members['Wunmi'] = Wunmi

print('Family Members are=', family_members)


verse2 = "if you can keep your head when all about you are losing theirs and blaming it on you   if you can trust yourself when all men doubt you     but make allowance for their doubting too   if you can wait and not be tired by waiting      or being lied about  don’t deal in lies   or being hated  don’t give way to hating      and yet don’t look too good  nor talk too wise"

split_verse = verse2.split()
print(split_verse)

verse_set = set(split_verse)
print(verse_set)

unique_words = len(verse_set)
print(len(verse_set))


verse_dict =  {'if': 3, 'you': 6, 'can': 3, 'keep': 1, 'your': 1, 'head': 1, 'when': 2, 'all': 2, 'about': 2, 'are': 1, 'losing': 1, 'theirs': 1, 'and': 3, 'blaming': 1, 'it': 1, 'on': 1, 'trust': 1, 'yourself': 1, 'men': 1, 'doubt': 1, 'but': 1, 'make': 1, 'allowance': 1, 'for': 1, 'their': 1, 'doubting': 1, 'too': 3, 'wait': 1, 'not': 1, 'be': 1, 'tired': 1, 'by': 1, 'waiting': 1, 'or': 2, 'being': 2, 'lied': 1, 'don\'t': 3, 'deal': 1, 'in': 1, 'lies': 1, 'hated': 1, 'give': 1, 'way': 1, 'to': 1, 'hating': 1, 'yet': 1, 'look': 1, 'good': 1, 'nor': 1, 'talk': 1, 'wise': 1}
print(verse_dict, '\n')

# find number of unique keys in the dictionary
num_keys = len(verse_dict)
print(num_keys)

# find whether 'breathe' is a key in the dictionary
contains_breathe = 'breathe' in verse_dict
print(contains_breathe)

# create and sort a list of the dictionary's keys
sorted_keys = sorted(verse_dict.keys())
print(sorted_keys)

# get the first element in the sorted list of keys
print(sorted_keys[0])

# find the element with the highest value in the list of keys
print(sorted_keys[-1])

points = 1000

if points <= 50:
    result = print("Wooden Rabbit")
elif points <=150:
    result = print("no prize")
elif points <= 180:
    result = print("wafer-thin mint")
else:
    result = print("penguin")
print(result)


altitude = 10000
speed = 250
propulsion = "Propeller"
altitude < 1000 and speed > 100
(propulsion == "Jet" or propulsion == "Turboprop") and speed < 300 and altitude > 20000

not (speed > 400 and propulsion == "Propeller")

(altitude > 500 and speed > 100) or not propulsion == "Propeller"

cities = ['new york city', 'mountain view', 'chicago', 'los angeles']
for city in cities:
    print(city.upper())
print("Done!")

cities = ['new york city', 'mountain view', 'chicago', 'los angeles']
capitalized_cities = []

for city in cities:
    capitalized_cities.append(city.title())
print(capitalized_cities)