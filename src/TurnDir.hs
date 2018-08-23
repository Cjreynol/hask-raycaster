{-|
Module      : TurnDir
Description : Datatype for 2-D turning directions
Copyright   : (c) Chad Reynolds, 2018
License     : MIT
-}

module TurnDir (
      TurnDir(..)
    , getTurnDirMatrix
    , multVector
    ) where

import Data.Matrix      (Matrix, rowVector, getMatrixAsVector, identity, 
                            matrix)
import Data.Vector      (fromList, toList)
import SDL.Vect         (V2(..))


data TurnDir = TLeft | TRight
    deriving Eq

getTurnDirMatrix :: Maybe TurnDir -> Matrix Double
getTurnDirMatrix (Just tdir)
    | tdir == TLeft = matrix 2 2 $ rotMatrixBuilder (-turnSpeed)
    | tdir == TRight = matrix 2 2 $ rotMatrixBuilder turnSpeed
    | otherwise = error "Impossible turn direction case"
getTurnDirMatrix (Nothing) = identity 2 

rotMatrixBuilder :: Double -> (Int, Int) -> Double
rotMatrixBuilder sp (1, 1) = cos sp
rotMatrixBuilder sp (2, 1) = -(sin sp)
rotMatrixBuilder sp (1, 2) = sin sp
rotMatrixBuilder sp (2, 2) = cos sp
rotMatrixBuilder _ p = error $ "Unexpected size, should only be 2 x 2 - " ++ (show p)

turnSpeed :: Double     -- radians
turnSpeed = pi / 8

multVector :: V2 Double -> Matrix Double -> V2 Double
multVector (V2 x y) m = case v'' of 
                            (x':y':[]) -> V2 x' y'
                            _ -> error "Vector should not have changed size"
    where
        v' = fromList [x, y]
        v'' = toList $ getMatrixAsVector $ (rowVector $ v') * m
