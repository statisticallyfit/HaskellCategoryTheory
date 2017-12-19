module StateMonad where

newtype State s a = State { runState :: s -> (a, s) }

runWithNoState :: Int -> (String, Int)
runWithNoState c | c `mod` 5 == 0 = ("fooWOS",c+1)
                 | otherwise = ("barWOS",c+1)

-- look at our counter and return "foo" or "bar"
-- along with the incremented counter:
fromStoAandS :: Int -> (String,Int)
fromStoAandS c | c `mod` 5 == 0 = ("foo",c+1)
               | otherwise = ("bar",c+1)

stateIntString :: State Int String
stateIntString = State fromStoAandS




instance Functor (State s) where
    -- equals: sas is afunction s -> (a,s) and needs to be applied to \s arg then
    -- f is applied on the result (a) and we return resulting state (s').
    -- fmap :: (a -> b) -> State s a -> State s b
    fmap f (State sas) = State $ \s -> let (a, s') = sas s
                                       in (f a, s')




instance Applicative (State s) where
    -- pure :: a -> State s a
    pure a = State $ \s -> (a, s)
    -- (<*>) :: (s -> (a -> b, s)) -> (s -> (a,s)) -> (s -> (b,s))
    -- (<*>) :: State s (a -> b)   -> State s a    -> State s b
    (State sabs) <*> (State sas) = State $ \s -> let (ab, s') = sabs s
                                                     (a, s'') = sas s'
                                                 in (ab a, s'')




instance Monad (State s) where
    -- note m ~ State s
    -- return :: (Monad m) => a ->     m     a
    -- return :: (Monad m) => a -> (State s) a
    return a = State $ \s -> (a, s)
    -- (>>=) :: State s a        -> (a -> State s b)    -> State s b
    -- (>>=) :: (s -> (a,s))     -> (a -> s -> (b,s))   -> (s -> (b,s))
    {-m >>= k = State $ \s -> let (a, s') = runState m s
                             in runState (k a) s'
    -}

    -- (>>=) :: State s a        -> (a -> State s b)    -> State s b
    -- (>>=) :: (s -> (a,s))     -> (a -> s -> (b,s))   -> (s -> (b,s))
    (State sa) >>= aSb = State $ \s -> let (a, s') = sa s
                                       in runState (aSb a) s
                                           -- help why do we return (s)
                                           -- here when we return s'' last before?


-- a -> (b -> (c -> (e -> f)))
-- (a -> b) -> c -> e -> f

main = do
    print $ (runState stateIntString) 1
    print $ runState stateIntString 10
    print $ runWithNoState 10
    print $ runState (return "hi") 1
