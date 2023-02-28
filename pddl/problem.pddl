(define (problem moving_problem)
  (:domain moving_company)
  
  ; Define the objects in the problem
  (:objects
    couch - furniture
    ; kitchen - furniture
    truck - truck
  )

  ; Define the initial state of the problem
  (:init
    ; Furniture is assembled
    (assembled couch)
    ;(assembled kitchen)
  )

  ; Define the goal state of the problem
  (:goal
    ; All furniture is moved to a new location and assembled
    (and
      (assembled couch)
      (moved couch)
      ; (assembled kitchen)
      ; (moved kitchen)
    )
  )
)