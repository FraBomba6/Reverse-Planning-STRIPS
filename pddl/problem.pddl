(define (problem moving_problem)
  (:domain moving_company)
  
  ; Define the objects in the problem
  (:objects
    couch - furniture 
    ; lamp desk1
     - furniture
    truck - truck
  )

  ; Define the initial state of the problem
  (:init
    ; Furniture is assembled
    (assembled couch)
    ; (assembled lamp)
    ; (assembled desk)
  )

  ; Define the goal state of the problem
  (:goal
    ; All furniture is loaded onto the truck and is at the new location
    (and
      (assembled couch)
      ; (assembled lamp)
      ; (assembled desk)
      (moved couch)
      ; (moved lamp)
      ; (moved desk)
    )
  )
)