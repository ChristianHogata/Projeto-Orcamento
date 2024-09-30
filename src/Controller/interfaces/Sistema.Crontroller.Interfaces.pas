unit Sistema.Crontroller.Interfaces;

interface

uses
  System.Classes, Data.DB, Sistema.Model.Interfaces, Datasnap.DBClient;

type
  TTipoTela = (tpClientes, tpEndereco, tpProdutos);

  Tprocedures = reference to procedure;

  ITela = interface;

  IControllerEntidade = interface
    ['{C682791E-C47B-4019-A633-4906233B5FCE}']
    function Clientes: IModelEntidade<IDadosClientes>;
    function Produtos: IModelEntidade<IDadosProdutos>;
    function Pedidos: IModelEntidade<IDadosPedidos>;
    function Enderecos: IModelEntidade<IDadosEndereco>;
    function PedidosItens: IModelEntidade<IDadosPedidosItens>;
  end;

  IControllerEntidadeFactory = interface
    ['{7919FD30-6CC0-4D41-B748-8665EF017CAF}']
    function ObterEntidadeClientes: IModelEntidade<IDadosClientes>;
    function ObterEntidadeProdutos: IModelEntidade<IDadosProdutos>;
    function ObterEntidadePedidos: IModelEntidade<IDadosPedidos>;
    function ObterEntidadeEnderecos: IModelEntidade<IDadosEndereco>;
    function ObterEntidadePedidosItens: IModelEntidade<IDadosPedidosItens>;
  end;

  ITelaParametros = interface
    ['{5CEF7A78-C8B4-48AD-B155-3E231E87DD65}']
    function SetTipoDeTela(pTipoTela: TTipoTela): ITelaParametros;
    function SetClientDataSet(pClientDataSet: TClientDataSet): ITelaParametros;
    function &End: ITela;
  end;

  ITela = interface
    ['{CFF3627C-E91D-40E9-829C-04427026B72E}']
    function SetTelaParametros: ITelaParametros;
    function Get: TComponent;
  end;

  ITelaPesquisaFactory = interface
    ['{BEE1FA0C-4E4A-451C-B295-04DFEF1240C4}']
    function GetTela: ITela;
  end;

implementation

end.
