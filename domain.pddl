(define (domain healthcare)
  (:requirements :strips :typing :negative-preconditions :existential-preconditions)
  
  ; Define the objects used in the domain
  (:types
    patient - object
    doctor - object
    medicine - object
    symptom - object
  )

  ; Define the predicates used in the domain
  (:predicates
    (has_symptom ?patient - patient ?symptom - symptom)
    (treats ?medicine - medicine ?symptom - symptom)
    (treated_by ?patient - patient ?doctor - doctor)
    (treated_with ?patient - patient ?medicine - medicine)
    (prescription ?patient - patient ?medicine - medicine ?doctor - doctor)
    (cured ?patient - patient)
    (allergic ?patient - patient ?medicine - medicine)
    (specialist ?doctor - doctor ?symptom - symptom)
  )

  ; Define the actions that can be taken in the domain
  (:action assign_doctor
    :parameters (?patient - patient ?doctor - doctor)
    :precondition (not (treated_by ?patient ?doctor))
    :effect (treated_by ?patient ?doctor)
  )

  (:action remove_doctor
      :parameters (?patient - patient ?doctor - doctor)
      :precondition (treated_by ?patient ?doctor)
      :effect (not (treated_by ?patient ?doctor))
  )

  (:action prescribe_medicine
    :parameters (?patient - patient ?symptom - symptom ?medicine - medicine ?doctor - doctor)
    :precondition (and
      (specialist ?doctor ?symptom)
      (treated_by ?patient ?doctor)
      (has_symptom ?patient ?symptom)
      (treats ?medicine ?symptom)
      (not (exists (?old_medicine - medicine ?doctor2 - doctor) (prescription ?patient ?old_medicine ?doctor2)))
    )
    :effect (prescription ?patient ?medicine ?doctor)
  )

  (:action remove_prescription
    :parameters (?patient - patient ?medicine - medicine ?doctor - doctor)
    :precondition (and
      (prescription ?patient ?medicine ?doctor)
      (not (treated_with ?patient ?medicine))
      (treated_by ?patient ?doctor)
    )
    :effect (not (prescription ?patient ?medicine ?doctor))
  )

  (:action treat
    :parameters (?patient - patient ?medicine - medicine ?doctor - doctor)
    :precondition (and
      (prescription ?patient ?medicine ?doctor)
      (treated_by ?patient ?doctor)
    )
    :effect (treated_with ?patient ?medicine)
  )

  (:action remove_treatment
      :parameters (?patient - patient ?medicine - medicine ?doctor - doctor)
      :precondition (and 
        (treated_with ?patient ?medicine)
        (treated_by ?patient ?doctor)  
      )
      :effect (not (treated_with ?patient ?medicine))
  )

  (:action cure
      :parameters (?patient - patient ?medicine - medicine ?symptom - symptom)
      :precondition (and
        (treated_with ?patient ?medicine)
        (treats ?medicine ?symptom)
        (not (allergic ?patient ?medicine))
      )
      :effect (not (has_symptom ?patient ?symptom))
  )

  (:action check_health
      :parameters (?patient - patient ?doctor - doctor)
      :precondition (and
        (not (exists (?symptom - symptom) (has_symptom ?patient ?symptom)))
        (treated_by ?patient ?doctor)
      )
      :effect (cured ?patient)
  )

  (:action discharge
    :parameters (?patient - patient ?doctor - doctor)
    :precondition (cured ?patient)
    :effect (not (treated_by ?patient ?doctor))
  )
)