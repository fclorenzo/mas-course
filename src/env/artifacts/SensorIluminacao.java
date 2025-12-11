// CArtAgO artifact code for project aula10

package artifacts;

import java.awt.event.ActionEvent;

import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;

import cartago.INTERNAL_OPERATION;
import cartago.LINK;
import cartago.tools.GUIArtifact;

public class SensorIluminacao extends GUIArtifact {
	
	private InterfaceSensorIluminacao frame;
	private SensorModel sensor_model = new SensorModel(0);
	private int valor_cortina = 0;
	private int valor_luz = 0;
	
	
    void setup(int nivel) {
    	sensor_model.setNivel_iluminacao(nivel);
		defineObsProperty("nivel_iluminacao", sensor_model.getNivel_iluminacao());
		create_frame();
	}
    
    public void setup() {
    	defineObsProperty("nivel_iluminacao", sensor_model.getNivel_iluminacao());
		create_frame();
	}
	
    void create_frame() {
    	frame = new InterfaceSensorIluminacao();
		linkActionEventToOp(frame.okButton,"ok");
		frame.setVisible(true);
    }
    
    @LINK
    void ajustar_iluminacao_cortina(int value){
    	this.valor_cortina = value;
		sensor_model.setNivel_iluminacao(Math.max(100, this.valor_luz + this.valor_cortina));
		getObsProperty("nivel_iluminacao").updateValue(sensor_model.getNivel_iluminacao());
	}
    
    @LINK
    void ajustar_iluminacao_luz(int value){
    	this.valor_luz = value;
		sensor_model.setNivel_iluminacao(Math.max(100, this.valor_luz + this.valor_cortina));
		getObsProperty("nivel_iluminacao").updateValue(sensor_model.getNivel_iluminacao());
	}

	@INTERNAL_OPERATION 
	void ok(ActionEvent ev){
		sensor_model.setNivel_iluminacao(frame.getnivel_iluminacao());
		getObsProperty("nivel_iluminacao").updateValue(sensor_model.getNivel_iluminacao());
		signal("ajuste_nivel");
	}
	
	class SensorModel{
		// 0 = escuro, 100 = iluminado
		int nivel_iluminacao = 50;
	
		public SensorModel(int nivel_iluminacao) {
			this.nivel_iluminacao = nivel_iluminacao;
		}
	
		public int getNivel_iluminacao() {
			return nivel_iluminacao;
		}
	
		public void setNivel_iluminacao(int nivel_iluminacao) {
			this.nivel_iluminacao = nivel_iluminacao;
		}
		
	}
	
	class InterfaceSensorIluminacao extends JFrame {	
		
		private JButton okButton;
		private JTextField nivel_iluminacao;
		
		public InterfaceSensorIluminacao(){
			setTitle(" Camera ");
			setSize(200,300);
						
			JPanel panel = new JPanel();
			JLabel nivelL = new JLabel();
			nivelL.setText("Nivel de abertura:    ");
			setContentPane(panel);
			
			okButton = new JButton("ok");
			okButton.setSize(80,50);
			
			nivel_iluminacao = new JTextField(10);
			nivel_iluminacao.setText("0");
			nivel_iluminacao.setEditable(true);
			
			panel.setLayout(new BoxLayout(panel, BoxLayout.Y_AXIS));
			panel.add(nivelL);
			panel.add(nivel_iluminacao);
			panel.add(okButton);
			
		}
		
		public int getnivel_iluminacao(){
			return Integer.parseInt(nivel_iluminacao.getText());
		}
	}
	
}


