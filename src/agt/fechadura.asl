
!inicializar_fechadura.

+!inicializar_fechadura
  <- 	makeArtifact("fechadura_quarto","artifacts.Fechadura",[],D);
             focus(D);
             !fechar_porta.
             
+movimento_macaneta <- !verificar_fechada.

+!verificar_fechada: trancada(true) 
  <-  .print("Alguem mexeu na MACANETA, porem a porta está trancada!").
+!verificar_fechada: fechada(true)
  <-  .print("Alguem mexeu na MACANETA e FECHOU a porta!").
+!verificar_fechada: fechada(false)
  <-  .print("Alguem mexeu na MACANETA e ABRIU a porta!").
  
+movimento_fechadura <- !verificar_trancada.

+!verificar_trancada: trancada(true)
  <-  .print("Alguem mexeu na FECHADURA e TRANCOU a porta!").
+!verificar_trancada: trancada(false)
  <-  .print("Alguem mexeu na FECHADURA e DESTRANCOU a porta!").
      
+closed  <-  .print("Close event from GUIInterface").
   
+!fechar_porta: fechada(true)
     <-  .print("Porta Fechada!");
         !trancar_porta.
     
+!fechar_porta: fechada(false)
     <-  fechar;
         .print("FECHEI a porta");
         !fechar_porta.
         
+!trancar_porta: trancada(true)
     <- .print("Porta Trancada!").
     
+!trancar_porta: trancada(false)
     <- 	trancar;
         .print("TRANQUEI a porta!");
         !trancar_porta.

// Cenário 1: Destrancar e Abrir
+!destrancar_e_abrir
    <-  destrancar;
        abrir;
        .print("Porta destrancada e aberta.").

// Cenário 2 e 3: Fechar e Trancar
+!fechar_e_trancar
    <-  fechar;
        trancar;
        .print("Porta fechada e trancada.").

+!modo_seguranca
    <-  !fechar_e_trancar.