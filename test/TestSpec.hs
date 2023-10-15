module TestSpec (spec) where

import MyLib
    ( dfs,
      bfs,
      fibs,
      myZipWith,
      insertionSort,
      insert,
      quicksort,
      take'',
      take',
      last',
      head',
      map',
      filter',
      reverse',
      maximum',
      length',
      or',
      Tree(Node) )

import Test.Hspec
  (
    Spec
  , it
  , shouldBe
  , describe
  )


  spec :: Spec
  spec = do
    describe "Eq instance for ChurchNumber" $ do
        it "Equality of two Zeros" $ do
          Zero == Zero `shouldBe` True

        it "Equality of two Succ values" $ do
          (Succ (Succ Zero)) == (Succ (Succ Zero)) `shouldBe` True

        it "Inequality" $ do
          Zero == (Succ Zero) `shouldBe` False

      describe "Ord instance for ChurchNumber" $ do
        it "Comparison of two Zeros" $ do
          compare Zero Zero `shouldBe` EQ

        it "Comparison of Zero and Succ" $ do
          compare Zero (Succ Zero) `shouldBe` LT

        it "Comparison of Succ and Zero" $ do
          compare (Succ Zero) Zero `shouldBe` GT

      describe "Num instance for ChurchNumber" $ do
        it "Addition of Zero and Succ" $ do
          (Zero + Succ (Succ Zero)) `shouldBe` (Succ (Succ Zero))
          
        it "Subtraction of Succ and Zero" $ do
          ((Succ (Succ Zero)) - Zero) `shouldBe` (Succ (Succ Zero))

        it "Multiplication of Succ values" $ do
          (Succ (Succ Zero) * Succ (Succ Zero)) `shouldBe` Succ (Succ (Succ (Succ (Zero))))

      describe "Ix instance for ChurchNumber" $ do
        it "Range from Zero to Zero" $ do
          range (Zero, Zero) `shouldBe` [Zero]

        it "Range from Zero to Succ" $ do
          range (Zero, Succ (Succ Zero)) `shouldBe` [Zero, Succ Zero, Succ (Succ Zero)]

        it "Index Zero in the range" $ do
          index (Zero, Succ (Succ Zero)) Zero `shouldBe` 0

        it "Index Succ in the range" $ do
          index (Zero, Succ (Succ Zero)) (Succ Zero) `shouldBe` 1

        it "In range Zero" $ do
          inRange (Zero, Succ (Succ Zero)) Zero `shouldBe` True

        it "Not in range Succ" $ do
          inRange (Zero, Succ Zero) (Succ (Succ Zero)) `shouldBe` False

      describe "InOrder instance for Tree" $ do
        it "In-Order traversal of a single node tree" $ do
            let tree = In (Node 12345 [])
            show tree `shouldBe` "12345"
    
        it "In-Order traversal of a tree with multiple nodes" $ do
            let tree = In (Node 1 [Node 2 [], Node 3 [Node 4 [], Node 5 []]])
            show tree `shouldBe` "2453514535"
    
      describe "PreOrder instance for Tree" $ do
        it "Pre-Order traversal of a single-node tree" $ do
            let tree = Pre (Node 12345 [])
            show tree `shouldBe` "12345"
    
        it "Pre-Order traversal of a tree with multiple nodes" $ do
            let tree = Pre (Node 1 [Node 2 [], Node 3 [Node 4 [], Node 5 []]])
            show tree `shouldBe` "12345"
    
      describe "PostOrder instance for Tree" $ do
        it "Post-Order traversal of a single-node tree" $ do
            let tree = Post (Node 12345 [])
            show tree `shouldBe` "12345"
    
        it "Post-Order traversal of a tree with multiple nodes" $ do
            let tree = Post (Node 1 [Node 2 [], Node 3 [Node 4 [], Node 5 []]])
            show tree `shouldBe` "24531"

      describe "nextDay" $ do
        it "Monday -> Tuesday" $ do
            nextDay Monday `shouldBe` Tuesday
    
        it "Saturday -> Sunday" $ do
            nextDay Saturday `shouldBe` Sunday
        
      describe "dayBefore" $ do
        it "Monday <- Tuesday" $ do
            dayBefore Tuesday `shouldBe` Monday
    
        it "Saturday <- Sunday" $ do
            dayBefore Sunday `shouldBe` Saturday
        
      describe "daysBeforeWeekend" $ do
        it "Whole working week OMG why so long i want to rest" $ do
            daysBeforeWeekend Monday `shouldBe` 5
    
        it "ITS WEEKENDS!!!" $ do
            daysBeforeWeekend Saturday `shouldBe` 0

      describe "Functor instance for List" $ do
        it "Functor save structure" $ do
            fmap id (Cons 1 (Cons 2 Nil)) `shouldBe` (Cons 1 (Cons 2 Nil))

        it "Functor applies function" $ do
            fmap (*10) (Cons 1 (Cons 2 Nil)) `shouldBe` (Cons 10 (Cons 20 Nil))

      describe "Functor instance for Tree" $ do
        it "Functor save structure" $ do
            let tree = Node 1 [Node 2 [], Node 3 [Node 4 []]]
            fmap id tree `shouldBe` tree

        it "Functor applies function" $ do
            let tree = Node 1 [Node 2 [], Node 3 [Node 4 []]]
            let expectedTree = Node 10 [Node 20 [], Node 30 [Node 40 []]]
            fmap (*10) tree `shouldBe` expectedTree

      describe "Functor instance for Pair" $ do
        it "Functor applies function to the second element" $ do
            fmap length (Pair 1 "RickAndMorty") `shouldBe` (Pair 1 12)

      describe "biFunctor instance for Pair" $ do
        it "biFunctor applies function to both elements" $ do
            bimap length (Pair "ha" "haha") `ShouldBe` (Pair 2 4)

      describe "VibeCheck instance" $ do
        it "Интроверт чек" $ do
            (/\__/\) Интроверт `shouldBe` "100% попадание!"