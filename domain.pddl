(define (domain healthcare)
  (:requirements :strips)
  
  ; Define the objects used in the domain
  (:types
    patient - object
    doctor - object
    medicine - object
    hospital - object
  )

  ; Define the predicates used in the domain
  (:predicates
    (has_symptom ?patient - patient ?symptom - symptom)
    (treats ?medicine - medicine ?symptom - symptom)
    (treated_by ?patient - patient ?doctor - doctor)
    (treated_with ?patient - patient ?medicine - medicine)
    (admitted_to ?patient - patient ?hospital - hospital)
    (prescription ?patient - patient ?medicine - medicine)
  )

  ; Define the actions that can be taken in the domain
  (:action admit
    :parameters (?patient - patient ?hospital - hospital)
    :precondition (not (admitted_to ?patient ?hospital))
    :effect (admitted_to ?patient ?hospital)
  )

  (:action assign_doctor
    :parameters (?patient - patient ?doctor - doctor)
    :precondition (not (treated_by ?patient ?doctor))
    :effect (treated_by ?patient ?doctor)
  )

  (:action diagnose_symptom
    :parameters (?patient - patient ?symptom - symptom ?doctor - doctor)
    :precondition (and
      (treated_by ?patient ?doctor)
    )
    :effect (has_symptom ?patient ?symptom)
  )

  (:action prescribe_medicine
    :parameters (?patient - patient ?medicine - medicine ?doctor - doctor)
    :precondition (and
      (treated_by ?patient ?doctor)
      (has_symptom ?patient ?symptom)
      (treat ?medicine ?symptom)
    )
    :effect (prescription ?patient ?medicine)
  )

  (:action treat
    :parameters (?patient - patient ?medicine - medicine ?doctor - doctor)
    :precondition (and
      (prescription ?patient ?medicine)
      (treated_by ?patient ?doctor)
    )
    :effect (treated_with ?patient ?medicine)
  )

  (:action change_medicine
    :parameters (?patient - patient ?medicine - medicine ?new_medicine - medicine)
    :precondition (and
      (treated_with ?patient ?medicine)
      (prescription ?patient ?new_medicine)
    )
    :effect (and
      (not (treated_with ?patient ?medicine))
      (treated_with ?patient ?new_medicine)
      (not (prescription ?patient ?medicine))
    )
  )

  (:action discharge
    :parameters (?patient - patient)
    :precondition (admitted_to ?patient ?hospital)
    :effect (not (admitted_to ?patient ?hospital))
  )

  (:action cancel_treatment
    :parameters (?patient - patient ?medicine - medicine)
    :precondition (treated_with ?patient ?medicine)
    :effect (not (treated_with ?patient ?medicine))
  )
)

