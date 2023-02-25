(define (domain moving_company)
  (:requirements :strips :typing :negative-preconditions)
  ; Define the types of objects in the domain
  (:types truck furniture - object)

  ; Define the predicates for the domain
  (:predicates
    (assembled ?f - furniture)
    (packed ?f - furniture)
    (loaded ?f - furniture ?b - truck)
    (moved ?f - furniture)
  )

  ; Define the actions for the domain
  (:action assemble_furniture
    :parameters (?f - furniture ?t - truck)
    :precondition (and
      (not (assembled ?f))
      (not (packed ?f))
      (not (loaded ?f ?t))
      (moved ?f)
    )
    :effect (assembled ?f)
  )
  
  (:action disassemble_furniture
    :parameters (?f - furniture ?t - truck)
    :precondition (and
      (assembled ?f)
      (not (packed ?f))
      (not (loaded ?f ?t))
    )
    :effect (and (not (assembled ?f)) (not(moved ?f)))
  )
  
  (:action pack
    :parameters (?f - furniture ?t - truck)
    :precondition (and
      (not (packed ?f))
      (not (assembled ?f))
      (not (loaded ?f ?t))
      (not (moved ?f))
    )
    :effect (packed ?f)
  )

  (:action unpack
    :parameters (?f - furniture ?t - truck)
    :precondition (and
      (packed ?f)
      (not (assembled ?f))
      (not (loaded ?f ?t))
      (moved ?f)
    )
    :effect (not (packed ?f))
  )

  (:action load_truck
    :parameters (?f - furniture ?t - truck)
    :precondition (and
      (packed ?f)
      (not (assembled ?f))
      (not (loaded ?f ?t))
      (not (moved ?f))
    )
    :effect (loaded ?f ?t)
  )
  
  (:action unload_truck
    :parameters (?f - furniture ?t - truck)
    :precondition (and
      (packed ?f)
      (not (assembled ?f))
      (loaded ?f ?t)
      (moved ?f)
    )
    :effect (not (loaded ?f ?t))
  )
  
  (:action move
    :parameters (?f - furniture ?t - truck)
    :precondition (and
      (packed ?f)
      (not (assembled ?f))
      (loaded ?f ?t)
      (not (moved ?f))
    )
    :effect (moved ?f)
  )
)