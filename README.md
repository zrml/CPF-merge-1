# CPF Merge File example

## Intro
This project shows how to configure an InterSystems IRIS  
- instance parameters and  
- a mirror-pair 
via the CPF (Configuration Parameter File) file and specifically how to do it in an automated way with the new **CPF merge file**.

The CPF merge facility allows to inject configuration parameters as we start the instance in accordance to the [12-factor](https://12factor.net/) app and in order to render the whole process much more intuitive and easily automatable.
The CPF merge facility appeared in InterSystems IRIS 2019.4 and is continually improved.

## Details
The docker-compose runs 3 services:  
- 2 x IRIS instances and  
- 1 x Arbiter  

The 2 InterSystems IRIS instances will configure themselves as a mirror-pair, respectively one as the Primary and the other as the Backup member while the Arbiter is the 3rd node mirror coordinator.
Please review the files  
- *mirrorPrimary.conf* and  
- *mirrorBackup.conf*  
and see how the **ShardRole** and **ShardMirrorMember** keys are defined. It should be selfexplantory, otherwise see InterSystems documentatopm
- [main CPF merge doc page](https://docs.intersystems.com/irislatest/csp/docbook/Doc.View.cls?KEY=ADOCK#ADOCK_iris_customizing)  
- [SharddRole](https://docs.intersystems.com/irislatest/csp/docbook/Doc.View.cls?KEY=RACS_ShardRole)  
- [ShardMirrorMember](https://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?KEY=RACS_ShardMirrorMember)  
- [ArbiterURL](https://docs.intersystems.com/irislatest/csp/docbook/Doc.View.cls?KEY=RACS_ArbiterURL)   


The CPF extensions for configuring a mirror are new & initally focused on shard-based clusters. More flexible options will appear in future releases.
While this demo is based on docker-compose, the feature is usable even with traditional tarballs deployments.

InterSystems IRIS [durable %SYS](https://docs.intersystems.com/irislatest/csp/docbook/Doc.View.cls?KEY=ADOCK#ADOCK_iris_durable) directories will be created in  
./iris.sys.d1  
./iris.sys.d2


A container-network is created with a range of ip addresses to  
- pin services to a fixed IP and  
- to avoid conflict with local subnets


## Requirements and Notes
- You will need a non CE version of InterSystems IRIS 2020.1
- You will need an adequate key supporting InterSystems mirroring and shard technologies
- In order to reset the environment and remove the durable %SYS directories there is the deleteDurableSYS.sh script
- and 2xConvenience scripts to start and stop the composition


---
