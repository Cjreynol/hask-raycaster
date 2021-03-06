{-|
Module      : Direction
Description : Datatype for 2-D directions
Copyright   : (c) Chad Reynolds, 2018
License     : MIT
-}

module Direction (
      Direction(..)
    , getDirVector
    ) where

import SDL.Vect     (V2(V2))

import Settings     (moveSpeed)


-- | Enumeration for the possible movement directions from key presses.
data Direction = DirUp | DirRight | DirDown | DirLeft
    deriving Eq

-- | Convert from a direction to a vector to apply to velocity.
getDirVector :: Maybe Direction -> V2 Double
getDirVector (Just dir)
    | dir == DirUp = V2 0 (-moveSpeed)
    | dir == DirRight = V2 moveSpeed 0
    | dir == DirDown = V2 0 moveSpeed
    | dir == DirLeft = V2 (-moveSpeed) 0
    | otherwise = error "Impossible direction case"
getDirVector (Nothing) = V2 0 0

