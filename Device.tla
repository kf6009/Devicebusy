------------------------------- MODULE Device -------------------------------
CONSTANT Data
VARIABLE register

TypeInv == 
    register \in [ busy:{0,1}, data:Data ]

Init == 
    register = [busy|->0, data|-> CHOOSE x \in Data :TRUE ]

Send(d) ==
    /\ register.busy = 0
    /\ register' = [busy|->1, data|->d]

Read == 
    /\ register.busy = 1
    /\ register' = [register EXCEPT !.busy=0 ]

Next == 
    \/ \E d \in Data : Send(d)
    \/ Read 

Device == Init /\ [][Next]_register /\ WF_register(Next)
=============================================================================
\* Modification History
\* Last modified Tue Feb 16 10:24:14 GMT 2021 by alunm
\* Created Sat Feb 13 14:51:38 GMT 2021 by alunm
