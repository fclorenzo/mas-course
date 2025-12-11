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
        .print("Houve interacao com o ar condicionado!");
        .print("Temperatura Ambiente: ", TA);
       .print("Temperatura Desejada: ", TAC);
        !!climatizar.
      
+closed  <-  .print("Close event from GUIInterface").
   
/* Planos para definir temperatura */

// Plano para quando recebemos uma temperatura específica (ex: !definir_temperatura(25))
+!definir_temperatura(Temp)
    <-  definir_temperatura(Temp); // Chama a operação do Java
        .print("Temperatura do AC ajustada para ", Temp).

// Plano de fallback caso chamem sem argumentos (usa a preferência)
+!definir_temperatura
    :   temperatura_de_preferencia(User, TP) 
    <-  !definir_temperatura(TP). // Redireciona para o plano acima         
         
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
     <- 	.print("Nao foram implementadas outras opcoes.");
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
        .print("MODO SEGURANCA: Temperatura ajustada para 10 graus!").