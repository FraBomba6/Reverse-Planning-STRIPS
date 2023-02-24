(define (problem spacecraft-maneuvering)
  (:domain spacecraft-maneuvering)
  
  ; Define the objects used in the problem
  (:objects
    spacecraft1 spacecraft2 spacecraft3 spacecraft4 - spacecraft
    satellite1 satellite2 - satellite
    cargo1 cargo2 cargo3 - cargo
    transition_orbit - orbit
    stationary_orbit - orbit
    sat_orbit1 sat_orbit2 - orbit
  )

  ; Define the initial state of the problem
  (:init
    ; spacecrafts 1, 2 and 3 are in transition orbit
    (stable-orbit spacecraft1 transition_orbit)

    (stable-orbit spacecraft2 transition_orbit)

    (stable-orbit spacecraft3 transition_orbit)

    ; spacecraft4 is already in stationary orbit
    (stable-orbit spacecraft4 stationary_orbit)
    (has-cargo spacecraft4 cargo1)

    ; spacecraft1 has cargo2 and cargo3 and is able to dock with spacecraft4
    (has-cargo spacecraft1 cargo2)
    (has-cargo spacecraft1 cargo3)
    (able-to-dock spacecraft1 spacecraft4)

    ; spacecraft2 has satellite1
    (has-satellite spacecraft2 satellite1)

    ; spacecraft3 has satellite2
    (has-satellite spacecraft3 satellite2)

    ; target_orbits for satellites
    (target-orbit sat_orbit1)
    (target-orbit sat_orbit2)

    (re-entry-orbit transition_orbit)
  )

  ; Define the goal state of the problem
  (:goal (and
      (sat-deployed spacecraft2)
      (sat-deployed spacecraft3)
      (is_in_target_orbit satellite1 sat_orbit1)
      (is_in_target_orbit satellite2 sat_orbit2)
      (has-cargo spacecraft4 cargo2)
      (has-cargo spacecraft4 cargo3)
      (has-cargo spacecraft1 cargo1)
      (stable-orbit spacecraft4 stationary_orbit)
      (stable-orbit spacecraft1 transition_orbit)
      (stable-orbit spacecraft2 transition_orbit)
      (stable-orbit spacecraft3 transition_orbit)
    )
  )
)