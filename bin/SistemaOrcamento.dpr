program SistemaOrcamento;

uses
  Vcl.Forms,
  Sistema.Model.Interfaces in '..\src\Model\Interfaces\Sistema.Model.Interfaces.pas',
  Sistema.Model.Conexao in '..\src\Model\Conexao\Sistema.Model.Conexao.pas',
  Sistema.Model.ConexaoFactory in '..\src\Model\Conexao\Sistema.Model.ConexaoFactory.pas',
  Sistema.Model.DataSet in '..\src\Model\Conexao\Sistema.Model.DataSet.pas',
  Sistema.Model.DataSetFactory in '..\src\Model\Conexao\Sistema.Model.DataSetFactory.pas',
  Sistema.Crontroller.Interfaces in '..\src\Controller\interfaces\Sistema.Crontroller.Interfaces.pas',
  Sistema.Model.Entidades.Clientes in '..\src\Model\Entidades\Sistema.Model.Entidades.Clientes.pas',
  Sistema.Model.Entidades.Factory in '..\src\Model\Entidades\Sistema.Model.Entidades.Factory.pas',
  Sistema.Controller.Entidades.Factory in '..\src\Controller\Entidades\Sistema.Controller.Entidades.Factory.pas',
  Sistema.View.Pedidos in '..\src\View\Sistema.View.Pedidos.pas' {frm_consulta_pedidos},
  Sistema.Model.Entidades.Produtos in '..\src\Model\Entidades\Sistema.Model.Entidades.Produtos.pas',
  Sistema.Model.Entidades.Pedidos in '..\src\Model\Entidades\Sistema.Model.Entidades.Pedidos.pas',
  Sistema.Controller.TelaPesquisaFactory in '..\src\Controller\Sistema.Controller.TelaPesquisaFactory.pas',
  Sistema.Controller.TelaPesquisa in '..\src\Controller\Sistema.Controller.TelaPesquisa.pas',
  Sistema.Model.Entidades.PedidosItens in '..\src\Model\Entidades\Sistema.Model.Entidades.PedidosItens.pas',
  Sistema.Model.Entidades.Enderecos in '..\src\Model\Entidades\Sistema.Model.Entidades.Enderecos.pas',
  Sistema.Controller.Entidade in '..\src\Controller\Entidades\Sistema.Controller.Entidade.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  Application.CreateForm(Tfrm_consulta_pedidos, frm_consulta_pedidos);
  Application.Run;
end.
