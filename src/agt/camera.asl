// src/agt/camera.asl

!inicializar_camera.

+!inicializar_camera
  <- 	makeArtifact("camera_quarto","artifacts.Camera",[],D);
         focus(D).

+movimento 
  <-  !!verificar_pessoa.

// --- LÓGICA DOS CENÁRIOS ---

// CENÁRIO 1: Proprietário Chegando (Jonas na "frente")
+!verificar_pessoa : pessoa_presente("jonas") & local("frente")
   <-  .print("PROPRIETÁRIO CHEGANDO: Iniciando protocolo de boas-vindas.");
        
        // Comandar a porta
        .send(fechadura, achieve, destrancar_e_abrir);
        
        // Adequar ambiente
        .send(ar_condicionado, achieve, preparar_ambiente);
        .send(cortina, achieve, abrir_totalmente);
        .send(lampada, achieve, acender_luzes).

// CENÁRIO 2: Proprietário Saindo (Jonas na "saida")
// Nota: Como o artefato é simples, convencionamos que digitar "saida" no local simula a saída
+!verificar_pessoa : pessoa_presente("jonas") & local("saida")
   <-  .print("PROPRIETÁRIO SAINDO: Iniciando protocolo de encerramento.");
        
        // Trancar a casa
        .send(fechadura, achieve, fechar_e_trancar);
        
        // Desligar aparelhos
        .send(ar_condicionado, achieve, desligar_sistema);
        .send(cortina, achieve, fechar_totalmente);
        .send(lampada, achieve, apagar_luzes).

// CENÁRIO 3: Intruso (Qualquer pessoa que não seja 'jonas' nem 'ninguem')
+!verificar_pessoa : pessoa_presente(P) & P \== "jonas" & P \== "ninguem"
    <-  .print("ALERTA DE SEGURANÇA! Intruso detectado: ", P);
        
        // Usamos broadcast para avisar TODOS os agentes de uma vez para entrarem em modo pânico
        .broadcast(achieve, modo_seguranca).

// Caso padrão (ninguém ou situação irrelevante)
+!verificar_pessoa
    <- .print("Nenhuma ação necessária no momento.").