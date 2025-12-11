
!inicializar_lampada.

+!inicializar_lampada
  <- 	makeArtifact("lampada_quarto","artifacts.Lampada",[],D);
             focus(D);
             !ligar_lampada.
             
+interuptor 
  <-  !!verificar_lampada.
      
+closed  <-  .print("Close event from GUIInterface").
   
 +!verificar_lampada: ligada(false)  
     <-  .print("Alguém DESLIGOU a Lâmpada").
     
 +!verificar_lampada: ligada(true)  
     <-  .print("Alguém LIGOU a Lâmpada").
     
 +!ligar_lampada
     <-  ligar;
         .print("Liguei a Lâmpada!").

// Cenário 1: Chegada
+!acender_luzes
    <-  ligar;
        .print("Luzes acesas.").

// Cenário 2: Saída
+!apagar_luzes
    <-  desligar;
        .print("Luzes apagadas.").

// Cenário 3: Intruso (Apagar luzes para dificultar)
+!modo_seguranca
    <-  desligar;
        .print("MODO SEGURANÇA: Luzes apagadas!").