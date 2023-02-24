(define (domain moving_company)
  (:requirements :strips :typing :negative-preconditions)
  ; Define the types of objects in the domain
  (:types truck furniture location customer - object)

  ; Define the predicates for the domain
  (:predicates
    (assembled ?f - furniture)
    (packed ?f - furniture)
    (at-location ?l - location ?f - furniture)
    (truck-location ?l - location ?b - truck)
    (loaded ?f - furniture ?b - truck)
  )

  ; Define the actions for the domain
  (:action assemble_furniture
    :parameters (?f - furniture ?l - location ?t - truck)
    :precondition (and
      (not (assembled ?f))
      (not (packed ?f))
      (at-location ?l ?f)
      (truck-location ?l ?t)
      (not (loaded ?f ?t))  
    )
    :effect (assembled ?f)
  )
  
  (:action disassemble_furniture
    :parameters (?f - furniture ?l - location ?t - truck)
    :precondition (and
      (assembled ?f)
      (not (packed ?f))
      (at-location ?l ?f)
      (truck-location ?l ?t)
      (not (loaded ?f ?t))
    )
    :effect (not (assembled ?f))
  )
  
  (:action pack
    :parameters (?f - furniture ?l - location ?t - truck)
    :precondition (and
      (not (packed ?f))
      (not (assembled ?f))
      (at-location ?l ?f)
      (truck-location ?l ?t)
      (not (loaded ?f ?t))
    )
    :effect (packed ?f)
  )

  (:action unpack
    :parameters (?f - furniture ?l - location ?t - truck)
    :precondition (and
      (packed ?f)
      (not (assembled ?f))
      (at-location ?l ?f)
      (truck-location ?l ?t)
      (not (loaded ?f ?t))
    )
    :effect (not (packed ?f))
  )

  (:action load_truck
    :parameters (?f - furniture ?t - truck ?l - location)
    :precondition (and
      (packed ?f)
      (not (assembled ?f))
      (truck-location ?l ?t)
      (at-location ?l ?f)
      (not (loaded ?f ?t))
    )
    :effect (and (loaded ?f ?t) (not (at-location ?l ?f)))
  )
  
  (:action unload_truck
    :parameters (?f - furniture ?t - truck ?l - location)
    :precondition (and
      (packed ?f)
      (not (assembled ?f))
      (truck-location ?l ?t)
      (not (at-location ?l ?f))
      (loaded ?f ?t)
    )
    :effect (and (at-location ?l ?f) (not (loaded ?f ?t)))
  )
  
  (:action travel
    :parameters (?t - truck ?l1 - location ?l2 - location)
    :precondition (and
      (not (truck-location ?l2 ?t))
      (truck-location ?l1 ?t)
    )
    :effect (and (truck-location ?l2 ?t) (not (truck-location ?l1 ?t)))
  )
)