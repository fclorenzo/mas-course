// Agent gui in project aula10

/* Initial beliefs and rules */

temperatura_de_preferencia(jonas,25).

/* Initial goals */

!inicializar_AC.

+!inicializar_AC
  <- 	makeArtifact("ac_quarto","artifacts.ArCondicionado",[],D);
             focus(D);
             !definir_temperatura;
             !!climatizar.

+alterado : temperatura_ambiente(TA) & temperatura_ac(TAC)
  <-  .drop_intention(climatizar);
        .print("Houve interação com o ar condicionado!");
        .print("Temperatura Ambiente: ", TA);
       .print("Temperatura Desejada: ", TAC);
        !!climatizar.
      
+closed  <-  .print("Close event from GUIInterface").
   
 +!definir_temperatura: temperatura_ambiente(TA) & temperatura_ac(TAC) 
             & temperatura_de_preferencia(User,TP) & TP \== TD & ligado(false)
     <-  definir_temperatura(TP);
         .print("Definindo temperatura baseado na preferência do usuário ", User);
         .print("Temperatura: ", TP).
     
 +!definir_temperatura: temperatura_ambiente(TA) & temperatura_ac(TAC) & ligado(false)
     <-  .print("Usando última temperatura");
         .print("Temperatura: ", TAC).
         
         
 +!climatizar: temperatura_ambiente(TA) & temperatura_ac(TAC) & TA \== TAC & ligado(false)
     <-   ligar;
         .print("Ligando ar condicionado...");
         .print("Temperatura Ambiente: ", TA);
         .print("Temperatura Desejada: ", TAC);
         .wait(1000);
         !!climatizar.
         
 +!climatizar: temperatura_ambiente(TA) & temperatura_ac(TAC) & TA \== TAC & ligado(true) 
     <-  .print("Aguardando regular a temperatura de ", TA, " para ", TAC, "...");
         .wait(4000);
         !!climatizar.
              
  +!climatizar: temperatura_ambiente(TA) & temperatura_ac(TAC) & TA == TAC & ligado(true) 
     <-   desligar;
         .print("Desligando ar condicionado...");
         .print("Temperatura Ambiente: ", TA);
         .print("Temperatura Desejada: ", TAC).

 +!climatizar 
     <- 	.print("Não foram implementadas outras opções.");
         .print("Temperatura regulada.").


// --- NOVOS PLANOS ---

// Cenário 1: Preparar ambiente (Chegada)
+!preparar_ambiente
    : temperatura_de_preferencia(Dono, Temp)
    <-  .print("Preparando ambiente para ", Dono);
        !definir_temperatura(Temp); // Usa o plano já existente para setar valor
        ligar.

// Cenário 2: Desligar tudo (Saída)
+!desligar_sistema
    <-  desligar;
        .print("Ar condicionado desligado.").

// Cenário 3: Modo Pânico (Intruso)
+!modo_seguranca
    <-  ligar;
        definir_temperatura(10); // Congelar o intruso!
        .print("MODO SEGURANÇA: Temperatura ajustada para 10 graus!").