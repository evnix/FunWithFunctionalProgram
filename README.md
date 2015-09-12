# FunWithFunctionalProgram
doing some code for fun during my spare time :)

Note: The program would be coded & solved much faster in imperative languages like Java or C

This program uses a client server concept. this means, 

we could have 1000 of processes running on multiple servers working in union to solve the problem.
A **little** sacrifice in speed for scalability.


## To Run [Install Erlang-18]

````
erlc *.erl

erl -run mainp start

````


## Files

````
two_dim.erl  [Erlang doesnt support 2 Dim arrays, so implemented it]
fhandle.erl  [load contents of file into an array]
iterator.erl [function which actually recurses through data]
consumer.erl [server for consuming and discarding resultsets from clients]
mainp.erl    [acts as the client and initiates all above modules]

````
