"-------------------------------------------------------"
Magic sub: #Num has: 'n mu m2 sd lo hi txt w'

! Num methods !
init
    self n: 0;
         mu: 0;
         m2: 0;
         sd: 0;
         lo: 100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
         hi: -100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
         txt: 'txt';
         w: 1 !

numInc: x
    | d |
    (x == nil)
      ifTrue: [^x].
    n := n + 1.
    d := x - mu.
    mu := mu + (d/n asFloat).
    m2 := m2 + (d*(x - mu ) asFloat).
    (x > hi)
      ifTrue: [hi := x].
    (x < lo)
      ifTrue: [lo := x].
    (n >= 2)
      ifTrue: [sd := (m2/(n - 1 + (10 raisedTo: -32) asFloat) ) raisedTo: 0.5].
    ^x !

numDec: x
    | d |
    (x == nil)
      ifTrue: [^x].
    (x == 1)
      ifTrue: [^x].
    n := n - 1.
    d := x - mu.
    mu := mu - (d/n asFloat).
    m2 := m2 - (d*(x - mu ) asFloat).
    (x > hi)
      ifTrue: [hi := x].
    (x < lo)
      ifTrue: [lo := x].
    (n >= 2)
      ifTrue: [sd := (m2/(n - 1 + (10 raisedTo: -32) asFloat) ) raisedTo: 0.5].
    ^x !

nextPutAll: aCollection
    aCollection do:[:a | self numInc: a]. !

nextRemoveAll: aCollection
    aCollection do:[:a | self numDec: a]. !

!!

"-------------------------------------------------------"
! Collection methods !
b4Now: aBlock
    | current previous |
    (self size >= 2)
        ifTrue: [
            current := 0.
            previous := 0.
            self do: [ :element |
                (current >= 1)
                    ifTrue: [ 
                        previous := current.
                        current := element.
                        (aBlock value: previous value: current). 
                    ]
                    ifFalse: [current := element]
            ]. 
        ].!

eject: aBlock 
  ^self select: [:element | (aBlock value: element) not]
!

visit: aBlock
    self do: [:i | i visit: aBlock] !
!!

"-------------------------------------------------------"
! Object methods !

visit: aBlock
    aBlock value:self !
!!

"-------------------------------------------------------"
! String methods !
visit: aBlock
    aBlock value: self !
!!
