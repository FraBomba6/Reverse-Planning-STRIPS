(define (problem healthcare-problem)
  (:domain healthcare)
  
  ; Define the objects used in the problem
  (:objects
    patient1 patient2 patient3 patient4 - patient
    doctor1 doctor2 - doctor
    medicine1 medicine2 medicine3 - medicine
    hospital1 - hospital
    symptom1 symptom2 symptom3 symptom4 symptom5 symptom6 - symptom
  )

  ; Define the initial state of the problem
  (:init
    ; Define which medicine treats which symptom
    (treats medicine1 symptom1)
    (treats medicine1 symptom2)
    (treats medicine2 symptom3)
    (treats medicine2 symptom4)
    (treats medicine3 symptom5)
    (treats medicine3 symptom6)
    
    ; Define which patient has which symptom
    (has_symptom patient1 symptom1)
    (has_symptom patient1 symptom2)
    (has_symptom patient2 symptom3)
    (has_symptom patient2 symptom4)
    (has_symptom patient3 symptom5)
    (has_symptom patient3 symptom6)
    (has_symptom patient4 symptom1)
    (has_symptom patient4 symptom5)
  )

  ; Define the goal state of the problem
  (:goal
    ; All patients are cured of their symptoms
    (and
        (cured patient1)
        (cured patient2)
        (cured patient3)
        (cured patient4)
    )
  )
)