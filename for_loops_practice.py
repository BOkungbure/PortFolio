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
