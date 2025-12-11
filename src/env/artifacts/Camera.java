// CArtAgO artifact code for project aula10

package artifacts;

import java.awt.event.ActionEvent;
import java.awt.event.WindowEvent;
import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;

import cartago.*;
import cartago.tools.GUIArtifact;

public class Camera extends GUIArtifact {
	
	private InterfaceAC frame;
	private CameraLocal camera_model = new CameraLocal(true,"frente", "ninguem");
    
    public void setup(String local, String pessoa) {
    	camera_model.setLocal(local);
    	camera_model.setPessoa(pessoa);
		defineObsProperty("ligada", camera_model.isOn());
        defineObsProperty("local", camera_model.getLocal());	
        defineObsProperty("pessoa_presente", camera_model.getPessoa());	
        create_frame();
	}
    
    public void setup() {
		defineObsProperty("ligada", camera_model.isOn());
        defineObsProperty("local", camera_model.getLocal());	
        defineObsProperty("pessoa_presente", camera_model.getPessoa());	
        create_frame();
	}
    
    void create_frame() {
    	frame = new InterfaceAC();
		linkActionEventToOp(frame.okButton,"ok");
		linkWindowClosingEventToOp(frame, "closed");
		frame.setVisible(true);
    }
    

	@OPERATION
	void ligar() {
		camera_model.setOn(true);
		getObsProperty("ligada").updateValue(camera_model.isOn());
	}

	@OPERATION
	void desligar() {
		camera_model.setOn(false);
		getObsProperty("ligada").updateValue(camera_model.isOn());
	}
	
	@INTERNAL_OPERATION 
	void ok(ActionEvent ev){
		camera_model.setLocal(frame.getLocal());
		camera_model.setPessoa(frame.getPessoa());
		getObsProperty("local").updateValue(camera_model.getLocal());
		getObsProperty("pessoa_presente").updateValue(camera_model.getPessoa());
		signal("movimento");
	}
	
	@INTERNAL_OPERATION void closed(WindowEvent ev){
		signal("closed");
	}
	
// se necessário simular alguma coisa, usando uma thread JAVA, 
//	pode-se chamar atualizar_artefato() e colocar as mudanças  em update()	
//	@OPERATION void update(){
//	
//	}
//	void atualiza_artefato(){
//		execInternalOp("update");
//	}
//	
	class CameraLocal {
		
		private boolean isOn = false;
		private String local = "unknown";
		private String pessoa = "noone";
		
		public CameraLocal(boolean isOn, String local, String p) {
			super();
			this.isOn = isOn;
			this.local = local;
			this.pessoa = p;
		}

		public boolean isOn() {
			return isOn;
		}

		public void setOn(boolean isOn) {
			this.isOn = isOn;
		}

		public String getLocal() {
			return local;
		}

		public void setLocal(String local) {
			this.local = local;
		}

		public String getPessoa() {
			return pessoa;
		}

		public void setPessoa(String pessoa) {
			this.pessoa = pessoa;
		}

	}
	
class InterfaceAC extends JFrame {	
		
		private JButton okButton;
		private JTextField pessoa;
		private JTextField local;
		
		public InterfaceAC(){
			setTitle(" Camera ");
			setSize(200,300);
						
			JPanel panel = new JPanel();
			JLabel pessoaL = new JLabel();
			pessoaL.setText("Nome da pessoa:    ");
			JLabel localL = new JLabel();
			localL.setText("Local atual: ");
			setContentPane(panel);
			
			okButton = new JButton("ok");
			okButton.setSize(80,50);
			
			pessoa = new JTextField(10);
			pessoa.setText("Jonas");
			pessoa.setEditable(true);
			
			local = new JTextField(10);
			local.setText("frente");
			local.setEditable(true);
			
			panel.setLayout(new BoxLayout(panel, BoxLayout.Y_AXIS));
			panel.add(pessoaL);
			panel.add(pessoa);
			panel.add(localL);
			panel.add(local);
			panel.add(okButton);
			
		}
		
		public String getPessoa(){
			return pessoa.getText();
		}
		
		public String getLocal(){
			return local.getText();
		}
	}
	
}

	

    

