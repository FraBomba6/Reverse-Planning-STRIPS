(define (domain spacecraft-maneuvering)
  (:requirements :strips :typing :negative-preconditions)

  ; Define the objects used in the domain
  (:types
    spacecraft - object
    satellite - object
    cargo - object
    orbit - object
  )

  ; Define the predicates used in the domain
  (:predicates
    (re-entry-orbit ?o - orbit)
    (in-manuever ?s - spacecraft)
    (target-orbit ?o - orbit)
    (is_in_target_orbit ?sat - satellite ?o - orbit)
    (stable-orbit ?s - spacecraft ?o - orbit)
    (attached-to ?sat - satellite ?s - spacecraft)
    (docked ?s - spacecraft)
    (docked-with ?s1 - spacecraft ?s2 - spacecraft)
    (has-cargo ?s - spacecraft ?c - cargo)
    (has-satellite ?s - spacecraft ?sat - satellite)
    (orientation ?s - spacecraft ?o - orbit)
    (at_orientation ?s - spacecraft)
    (altitude ?s - spacecraft ?o - orbit)
    (at_altitude ?s - spacecraft)
    (inclination ?s - spacecraft ?o - orbit)
    (at_inclination ?s - spacecraft)
    (velocity ?s - spacecraft ?o - orbit)
    (at_velocity ?s - spacecraft)
    (same-orbit ?s1 - spacecraft ?s2 - spacecraft)
    (same-orientation ?s1 - spacecraft ?s2 - spacecraft)
    (same-altitude ?s1 - spacecraft ?s2 - spacecraft)
    (same-inclination ?s1 - spacecraft ?s2 - spacecraft)
    (same-velocity ?s1 - spacecraft ?s2 - spacecraft)
    (able-to-dock ?s1 - spacecraft ?s2 - spacecraft)
    (sat-deployed ?s - spacecraft)
  )

  ; Define the actions that can be taken in the domain  
  (:action reach-orientation
    :parameters (?s - spacecraft ?o - orbit)
    :precondition (and
      (in-manuever ?s)
      (not (at_orientation ?s))
      (not (docked ?s))
    )
    :effect (and
      (orientation ?s ?o)
      (at_orientation ?s)
    )
  )
  
  (:action reach-altitude
    :parameters (?s - spacecraft ?o - orbit)
    :precondition (and
      (in-manuever ?s)
      (not (at_altitude ?s))
      (not (docked ?s))
    )
    :effect (and
      (altitude ?s ?o)
      (at_altitude ?s)
    )
  )
  
  (:action reach-inclination
    :parameters (?s - spacecraft ?o - orbit)
    :precondition (and
      (in-manuever ?s)
      (not (at_inclination ?s))
      (not (docked ?s))
    )
    :effect (and
      (inclination ?s ?o)
      (at_inclination ?s)
    )
  )
  
  (:action reach-velocity
    :parameters (?s - spacecraft ?o - orbit)
    :precondition (and
      (in-manuever ?s)
      (not (at_velocity ?s))
      (not (docked ?s))
    )
    :effect (and
      (velocity ?s ?o)
      (at_velocity ?s)
    )
  )
  
  (:action check_stable_orbit
    :parameters (?s - spacecraft ?o - orbit)
    :precondition (and
      (orientation ?s ?o)
      (altitude ?s ?o)
      (inclination ?s ?o)
      (velocity ?s ?o)
    )
    :effect (and
      (stable-orbit ?s ?o)
      (not (in-manuever ?s))
      (not (at_orientation ?s))
      (not (at_altitude ?s))
      (not (at_inclination ?s))
      (not (at_velocity ?s))
    )
  )

  (:action prepare-for-manuever
      :parameters (?s - spacecraft ?o - orbit)
      :precondition (stable-orbit ?s ?o)
      :effect (and
        (in-manuever ?s)
        (not (stable-orbit ?s ?o))
      )
  )

  (:action match-altitude
    :parameters (?s1 - spacecraft ?s2 - spacecraft ?o - orbit)
    :precondition (and
      (in-manuever ?s1)
      (not (docked ?s1))
      (stable-orbit ?s2 ?o)
      (not (same-orbit ?s1 ?s2))
      (not (same-altitude ?s1 ?s2))
    )
    :effect (and
      (same-altitude ?s1 ?s2)
      (same-altitude ?s2 ?s1)
    )
  )
  
  (:action match-inclination
    :parameters (?s1 - spacecraft ?s2 - spacecraft ?o - orbit)
    :precondition (and
      (in-manuever ?s1)
      (not (docked ?s1))
      (stable-orbit ?s2 ?o)
      (not (same-orbit ?s1 ?s2))
      (not (same-inclination ?s1 ?s2))
    )
    :effect (and
      (same-inclination ?s1 ?s2)
      (same-inclination ?s2 ?s1)
    )
  )
  
  (:action match-velocity
    :parameters (?s1 - spacecraft ?s2 - spacecraft ?o - orbit)
    :precondition (and
      (in-manuever ?s1)
      (not (docked ?s1))
      (stable-orbit ?s2 ?o)
      (not (same-orbit ?s1 ?s2))
      (not (same-velocity ?s1 ?s2))
    )
    :effect (and
      (same-velocity ?s1 ?s2)
      (same-velocity ?s2 ?s1)
    )
  )

  (:action check-same-orbit
    :parameters (?s1 - spacecraft ?s2 - spacecraft)
    :precondition (and
      (same-altitude ?s1 ?s2)
      (same-inclination ?s1 ?s2)
      (same-velocity ?s1 ?s2)
    )
    :effect (and
      (not (in-manuever ?s1))
      (same-orbit ?s1 ?s2)
      (same-orbit ?s2 ?s1)
    )
  )

  (:action deploy-satellite
    :parameters (?s - spacecraft ?sat - satellite ?o - orbit)
    :precondition (and
      (target-orbit ?o)
      (stable-orbit ?s ?o)
      (has-satellite ?s ?sat)
    )
    :effect (and
      (not (has-satellite ?s ?sat))
      (sat-deployed ?s)
      (is_in_target_orbit ?sat ?o)
    )
  )

  (:action connect-spacecrafts
    :parameters (?s1 - spacecraft ?s2 - spacecraft)
    :precondition (and
      (same-orbit ?s1 ?s2)
      (not (docked-with ?s1 ?s2))
      (not (docked-with ?s2 ?s1))
      (able-to-dock ?s1 ?s2)
    )
    :effect (and
      (docked ?s1)
      (docked ?s2)
      (docked-with ?s1 ?s2)
      (docked-with ?s2 ?s1)
    )
  )

  (:action transfer-cargo
    :parameters (?s1 - spacecraft ?s2 - spacecraft ?c - cargo)
    :precondition (and
      (docked-with ?s1 ?s2)
      (has-cargo ?s1 ?c)
    )
    :effect (and 
      (not (has-cargo ?s1 ?c))
      (has-cargo ?s2 ?c)
    )
  )
  
  (:action disconnect-spacecrafts
    :parameters (?s1 - spacecraft ?s2 - spacecraft)
    :precondition (and
      (docked-with ?s1 ?s2)
      (docked-with ?s2 ?s1)
    )
    :effect (and
      (not (docked ?s1))
      (not (docked ?s2))
      (not (docked-with ?s1 ?s2))
      (not (docked-with ?s2 ?s1))
    )
  )
)