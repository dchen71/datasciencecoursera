Coursera Data Science Capstone
========================================================
author: dchen71
date: 01/20/2016

About Natural Language Processing
========================================================

Natural language processing(NLP) is a field dedicated to understanding the interactions between computers and natural languages. NLP has it's roots in trying to help model the characteristics that we take for granted in speech and text, and to be able to parse and created meaning for the compiler. 

Some of the practical uses include the following:
* Summarization
* Machne Translation
* Text prediction


The model
========================================================

The goals of the model is to be able to accurately predict the text that is being typed. The model is similar to a more primitive version of the backoff models in which it is highly dependent on the text preceding what is being predicted.

## Preprocessing
Datasets from twitter, blogs and news are used. They are processed to remove extra spaces, swears, and punctuation. The text is then further processed to 1grams, 2grams, and 3grams.

## Model
The model is dependent on the number of words input. For single word predictions, it relies on indexing based on the first character input and then on the highest frequent word. The phrases with two words, the model does two things. If the first word was seen before, it will return the highest seen phrase containing that word. If it has not, then it will return the highest occuring word from the single word list. Phrases with 3 words follows the same example and will predict based on the last two words of the phrase if possible.

Model Performance
========================================================



The model in action
========================================================

![Shiny App](model_pres-figure/img.png "Shinyapp Picture")
