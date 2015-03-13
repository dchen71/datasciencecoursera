##Sets and returns the original matrix
makeCacheMatrix <- function(x = matrix()) {   
    ##Returns the original matrix
    get = function() 
        x    
    
    m <<- NULL
    set = function()
        m <<- solve(x)
    
    list(set = set, get = get)
}


##Computes cache if necessary
cacheSolve <- function(x, ...) {    
    if(!is.null(m)){
        print("getting cached data")
        return(m)
    }
    else
        m <<- x$set()
}

