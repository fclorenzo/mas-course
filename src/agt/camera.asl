// src/agt/camera.asl

!inicializar_camera.

+!inicializar_camera
  <- 	makeArtifact("camera_quarto","artifacts.Camera",[],D);
         focus(D).

+movimento 
  <-  !!verificar_pessoa.

// CENÁRIO 1: Chegada
// Note o "Jonas" com J maiúsculo para casar com o padrão da interface Java
+!verificar_pessoa : pessoa_presente("Jonas") & local("frente")
   <-  .print("PROPRIETÁRIO CHEGANDO: Iniciando protocolo de boas-vindas.");
        .send(fechadura, achieve, destrancar_e_abrir);
        .send(ar_condicionado, achieve, preparar_ambiente);
        .send(cortina, achieve, abrir_totalmente);
        .send(lampada, achieve, acender_luzes).

// CENÁRIO 2: Saída
+!verificar_pessoa : pessoa_presente("Jonas") & local("saida")
   <-  .print("PROPRIETÁRIO SAINDO: Iniciando protocolo de encerramento.");
        .send(fechadura, achieve, fechar_e_trancar);
        .send(ar_condicionado, achieve, desligar_sistema);
        .send(cortina, achieve, fechar_totalmente);
        .send(lampada, achieve, apagar_luzes).

// CENÁRIO 3: Intruso
// O intruso é qualquer um que NÃO seja "Jonas" (e nem "ninguem")
+!verificar_pessoa : pessoa_presente(P) & P \== "Jonas" & P \== "ninguem"
    <-  .print("ALERTA DE SEGURANÇA! Intruso detectado: ", P);
        .broadcast(achieve, modo_seguranca).

// Caso padrão (ninguém ou input vazio)
+!verificar_pessoa
    <- .print("Nenhuma ação necessária.").