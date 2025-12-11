package artifacts;

import java.awt.event.ActionEvent;
import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;

import cartago.*;
import cartago.tools.GUIArtifact;

public class Cortina extends GUIArtifact {
    
    private InterfaceCortina frame;
    private int avanco = 10; 
    private CortinaModel cortina_model = new CortinaModel(0);
    
    void setup(int nivel) {
        cortina_model.setNivel_abertura(nivel);
        defineObsProperty("nivel_abertura", cortina_model.getNivel_abertura());
        create_frame();
    }
    
    public void setup() {
        defineObsProperty("nivel_abertura", cortina_model.getNivel_abertura());
        create_frame();
    }
    
    void create_frame() {
        frame = new InterfaceCortina();
        linkActionEventToOp(frame.okButton,"ok");
        frame.setVisible(true);
    }
    
    @OPERATION
    void aumentar_nivel() {
        int nivel = cortina_model.getNivel_abertura() + avanco;
        if (nivel > 100) nivel = 100;
        
        System.out.println("Cortina movendo para: " + nivel);
        cortina_model.setNivel_abertura(nivel);
        
        // Atualiza a GUI
        if (frame != null) frame.setNivel(nivel);
        getObsProperty("nivel_abertura").updateValue(nivel);
    }
    
    @OPERATION
    void diminuir_nivel() {
        int nivel = cortina_model.getNivel_abertura() - avanco;
        if (nivel < 0) nivel = 0;

        System.out.println("Cortina movendo para: " + nivel);
        cortina_model.setNivel_abertura(nivel);
        
        // Atualiza a GUI
        if (frame != null) frame.setNivel(nivel);
        getObsProperty("nivel_abertura").updateValue(nivel);
    }

    @OPERATION
    void fechar() {
        System.out.println("Fechando cortina totalmente...");
        cortina_model.setNivel_abertura(0); 
        
        // Atualiza a GUI
        if (frame != null) frame.setNivel(0);
        getObsProperty("nivel_abertura").updateValue(0);
    }
    
    @OPERATION
    void abrir()  {
        System.out.println("Abrindo cortina totalmente...");
        cortina_model.setNivel_abertura(100); 
        
        // Atualiza a GUI
        if (frame != null) frame.setNivel(100);
        getObsProperty("nivel_abertura").updateValue(100);
    }
    
    @INTERNAL_OPERATION 
    void ok(ActionEvent ev){
        try {
            int novoNivel = frame.getnivel();
            cortina_model.setNivel_abertura(novoNivel);
            getObsProperty("nivel_abertura").updateValue(novoNivel);
            signal("ajuste_cortina");
        } catch (Exception e) {
            System.out.println("Erro ao ler nível: " + e.getMessage());
        }
    }

    class CortinaModel{
        int nivel_abertura = 0;

        public CortinaModel(int nivel_abertura) {
            this.nivel_abertura = nivel_abertura;
        }

        public int getNivel_abertura() {
            return nivel_abertura;
        }

        public void setNivel_abertura(int nivel_abertura) {
            this.nivel_abertura = nivel_abertura;
        }
    }

    class InterfaceCortina extends JFrame {  
        
        private JButton okButton;
        private JTextField nivel;
        
        public InterfaceCortina(){
            setTitle(" Cortina ");
            setSize(200,300);
                        
            JPanel panel = new JPanel();
            JLabel nivelL = new JLabel();
            nivelL.setText("Nivel de abertura:    ");
            setContentPane(panel);
            
            okButton = new JButton("ok");
            okButton.setSize(80,50);
            
            nivel = new JTextField(10);
            nivel.setText("0");
            nivel.setEditable(true);
            
            panel.setLayout(new BoxLayout(panel, BoxLayout.Y_AXIS));
            panel.add(nivelL);
            panel.add(nivel);
            panel.add(okButton);
        }
        
        public int getnivel(){
            return Integer.parseInt(nivel.getText());
        }

        // Método Setter para atualizar a GUI
        public void setNivel(int n) {
            if (nivel != null) {
                nivel.setText(String.valueOf(n));
            }
        }
    }
}