
!inicializar_cortina.

+!inicializar_cortina
  <- 	makeArtifact("cortina_quarto","artifacts.Cortina",[],D);
             focus(D);
             !abrir_cortina.
             
+ajuste_cortina 
  <-  !!verificar_ajuste.
      
+closed  <-  .print("Close event from GUIInterface").
   
 +!verificar_ajuste: nivel_abertura(N) 
     <-  .print("Nivel de abertura da cortina: ", N).
     
 +!abrir_cortina: nivel_abertura(N) 
     <-  .print("Nivel de abertura ANTES: ", N);
         abrir;
         ?nivel_abertura(ND);
         .print("Nivel de abertura DEPOIS: ", ND).

// Cenário 1: Chegada (Cortina aberta)
+!abrir_totalmente
    <-  abrir;
        .print("Cortinas abertas.").

// Cenário 2 e 3: Saída e Intruso (Fechar cortina)
+!fechar_totalmente
    <-  fechar;
        .print("Cortinas fechadas.").

+!modo_seguranca
    <-  !fechar_totalmente.