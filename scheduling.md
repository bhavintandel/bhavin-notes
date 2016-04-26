### Fair Scheduler
 
 #### Basics
  * Groups jobs into _"pools"_
  * Assign each pool a gauranteed minimum shares
  * Divide excess capacity evenly between pools

 #### Pools
  * Determined from a configurable job property
    Default in 0.20: username(one pool per user)
  * Pool properties:
    Minimum Mapper
    Minimum Reducer
    Limit on number of running jobs

 #### Scheduling Algorithm
  * Split each pool's min share among its jobs
  * Split each pool's total share among its jobs
  * When slot need to be assign:
    __If__ job is below min share, schedule it
    __Else__ schedule the job that we have been most unfair to
