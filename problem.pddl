(define (problem moving_problem)
  (:domain moving_company)
  
  ; Define the objects in the problem
  (:objects
    couch1 lamp1 desk1 - furniture
    truck1 - truck
    home office destination warehouse - location
  )

  ; Define the initial state of the problem
  (:init
    ; Furniture is at its initial location
    (at-location home couch1)
    (at-location home lamp1)
    (at-location office desk1)

    ; Furniture is assembled
    (assembled couch1)
    (assembled lamp1)
    (assembled desk1)

    ; Truck is at the warehouse
    (truck-location warehouse truck1)
  )

  ; Define the goal state of the problem
  (:goal
    ; All furniture is loaded onto the truck and is at the new location
    (and 
      (at-location destination couch1)
      (at-location destination lamp1)
      (at-location destination desk1)
      (assembled couch1)
      (assembled lamp1)
      (assembled desk1)
    )
  )
)