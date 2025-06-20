# TASK 1

In this task we need to put the correct pointers to our elements in the list
to be in an ascending order. We will take every node in the array and find
the minimum node that is greater than the node we are trying to process.
And in the final all the nodes will be connected to form an ascending order
linked list.

And to determine the node we should return. We just determine the minimum node
in our array and return that.

# TASK 2

## SUBTASK 1

We will traverse the string until N words are put in our vector of strings.
When we want to determine a word we will position our string on the first letter
of the word and then we will iterate until we find ',', 0, or 10. Then we will put 
NULL at the end of the word and store the address in our vector of strings.

## SUBTASK 2

We need to create a compare function to call qsort. The antet of the compare
function is:

```c
int compare(char *s1, char *s2)
```

At first it will call `strlen` for both `s1` and `s2` and determine the length of each word.
And if they don't match it will return the appropriate comparison value.  
But if it is equal it will call `strcmp` and it will return the returned value of `strcmp`.

And in the function `sort` it will just call `qsort` with the appropriate arguments.

# TASK 3

In this task we need to implement a recursive function that does the KFIB and
returns the N-th element of the KFIB.

The breaking part of our recursive function is when the `N` is lower than `K`
then it will return 0. And when `N` is equal to `K` then it will return `K`.

In the implementation, it uses a `for` that calls:

```c
KFIB(N - i, K)
```

where `i` is from 1 to `K`.

# TASK 4

## SUBTASK 1

In this first subtask we need to determine if the word is palindrome.  
We will check the first with the last, the second with the before-the-last and so on.  
If a pair doesn't match it will return 0, and if all match it will return 1.

## SUBTASK 2

In this task we need to generate the longest word and to be minimum lexicographically
composed from the given words in the array of vectors.  

We generate this word by doing a recursive backtracking.

The function of the backtracking has the signature:

```c
void back_tracking(int arr, char **vector, int len, int k, char *out)
```

And in the array of the backtracking we will store the position of the strings.

When we will verify the word we need to construct the string using the position in the `arr`.
This is done in the function `check` with the signature:

```c
void check(int arr, char **vector, int len, char *out)
```

In this function we will take each number in the `arr` vector and put
its aferent string in the `aux` string with `strcat`.

At the end we should have the word generated by the backtracking function,  
and then we will check if it is palindrome by calling the function check_palindrome.
