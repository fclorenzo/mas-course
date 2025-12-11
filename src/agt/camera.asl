
!inicializar_camera.

+!inicializar_camera
  <- 	makeArtifact("camera_quarto","artifacts.Camera",[],D);
  	   	focus(D).
  	   	
+movimento 
  <-  !!verificar_pessoa.
      
+closed  <-  .print("Close event from GUIInterface").
   
 +!verificar_pessoa: pessoa_presente(P) & local(L)
 	<-  .print("Pessoa: ", P, " reconhecida no local ", L, " da casa.").