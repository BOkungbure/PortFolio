from optparse import Values
from turtle import right


sentence = ["the", "quick", "brown", "fox", "jumped", "over", "the", "lazy", "dog"]

for word in sentence:
    print(word)

for i in range(5,31,5):
    print(i)

names = ["Joey Tribbiani", "Monica Geller", "Chandler Bing", "Phoebe Buffay"]
user_names = []

for i in range(len(names)):
    names[i] = names[i].lower().replace(' ','_')
print(names)

for name in names:
    user_names.append(name.lower().replace(' ','_'))
    print(user_names)


tokens = ['<greeting>', 'Hello World!', '</greeting>']
count = 0
tokens[-1]

# write your for loop here
for token in tokens:
    if token[0] == '<' and token[-1] == '>':
        count += 1

print(count)


items = ['first string', 'second string']
html_str = '<ul>\n'

for i in items:
    html_str += '<li>{}</li>\n'.format(i)

print(html_str)

book_title =  ['great', 'expectations','the', 'adventures', 'of', 'sherlock','holmes','the','great','gasby','hamlet','adventures','of','huckleberry','fin']
word_counter = {}

for word in book_title:
    word_counter[word] = word_counter.get(word, 0) + 1

for word in book_title:
    if word in word_counter:
        word_counter[word] += 1
    else:
        word_counter[word] = 1

print(word_counter)


cast = {
           "Jerry Seinfeld": "Jerry Seinfeld",
           "Julia Louis-Dreyfus": "Elaine Benes",
           "Jason Alexander": "George Costanza",
           "Michael Richards": "Cosmo Kramer"
       }

for key, value in cast.items():
    print('{}:  {}'.format(key, value))


# You would like to count the number of fruits in your basket. 
# In order to do this, you have the following dictionary and list of
# fruits.  Use the dictionary and list to count the total number
# of fruits, but you do not want to count the other items in your basket.

result = 0
basket_items = {'lettuce': 2, 'kites': 3, 'sandwiches': 8, 'pears': 4, 'bears': 10}
fruits = ['apples', 'oranges', 'pears', 'peaches', 'grapes', 'bananas']

#Iterate through the dictionary
for fruit,quantity in basket_items.items():
#if the key is in the list of fruits, add the value (number of fruits) to result
    if fruit in fruits:
        result += quantity

print('There are {} fruits in the basket'.format(result))


fruit_count, not_fruit_count = 0, 0
basket_items = {'apples': 4, 'oranges': 19, 'kites': 3, 'sandwiches': 8}
fruits = ['apples', 'oranges', 'pears', 'peaches', 'grapes', 'bananas']

#Iterate through the dictionary
for thing,quantity in basket_items.items():
#if the key is in the list of fruits, add to fruit_count.
    if thing in fruits:
        fruit_count += quantity
#if the key is not in the list, then add to the not_fruit_count
    elif thing not in fruits:
        not_fruit_count += quantity

print(fruit_count, not_fruit_count)