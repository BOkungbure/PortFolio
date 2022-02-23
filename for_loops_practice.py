sentence = ["the", "quick", "brown", "fox", "jumped", "over", "the", "lazy", "dog"]

for word in sentence:
    print(word)

for i in range(5,31,5):
    print(i)

names = ["Joey Tribbiani", "Monica Geller", "Chandler Bing", "Phoebe Buffay"]
user_names = []

for name in names:
    user_names.append(name.lower().replace(' ','_'))
    print(user_names)