library(tm)
library(wordcloud)
library(memoise)

# Place data in the same directory


# The list of valid letters
letters <- list("Joseph Addison" = "addison",
               "Jane Austen" = "austen",
               "Daniel Defoe" = "defoe",
               "George III" = "george3",
               "Elizabeth Carter" = "ecarter")

# Using "memoise" to automatically cache the results
getTermMatrix <- memoise(function(letter) {
    # Careful not to let just any name slip in here; a
    # malicious user could manipulate this value.
    if (!(letter %in% letters))
        stop("Unknown letter")
    
    text <- readLines(sprintf("./%s.txt", letter),
                      encoding="UTF-8")
    
    my_corpus = Corpus(VectorSource(text))
    my_corpus = tm_map(my_corpus, content_transformer(tolower))
    my_corpus = tm_map(my_corpus, removePunctuation)
    my_corpus = tm_map(my_corpus, removeNumbers)
    my_corpus = tm_map(my_corpus, removeWords,
                      c(stopwords("SMART"), "thy", "thou", "thee", "the", "and", "but"))
    
    myDTM = TermDocumentMatrix(my_corpus,
                               control = list(minWordLength = 1))
    
    m = as.matrix(myDTM)
    
    sort(rowSums(m), decreasing = TRUE)
})