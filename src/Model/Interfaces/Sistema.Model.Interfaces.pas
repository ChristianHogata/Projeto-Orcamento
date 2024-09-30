unit Sistema.Model.Interfaces;

interface

uses
  System.Classes, Data.DB, System.Generics.Collections;

type
  IModelConexaoParametros = interface;
  IDadosPedidosItens = interface;
  IModelEntidade<T> = Interface;

  IDadosPedidosItens = interface
    ['{1577D90D-F12B-42B7-9BE0-208B525A1AB9}']
    function DefinirIdProduto(id_produto: integer): IDadosPedidosItens;
    function DefinirIdPedido(id_pedido: integer): IDadosPedidosItens;
    function DefinirQuantidade(quantidade: extended): IDadosPedidosItens;
    function DefinirValorTotalItem(valor_total_item: Double): IDadosPedidosItens;
    function ObterIdProduto: Integer;
    function ObterIdPedido: Integer;
    function ObterQuantidade: extended;
    function ObterValorTotalItem: Double;
    function FimDoPreenchimento: IModelEntidade<IDadosPedidosItens>;
  end;

  IDadosPedidos = interface
    ['{DEA749AE-6225-43E2-8BE3-069C3E367130}']
    function DefinirValorTotalPedido(ValorTotalPedido: Double): IDadosPedidos;
    function DefinirValorPagoPedido(ValorPagoPedido: Double): IDadosPedidos;
    function DefinirValorTrocoPedido(ValorTrocoPedido: Double): IDadosPedidos;
    function DefinirIdClientePedido(IdCliente: integer): IDadosPedidos;
    function ObterValorTotalPedido: Double;
    function ObterValorPagoPedido: Double;
    function ObterValorTrocoPedido: Double;
    function ObterIdClientePedido: Integer;
    function FimDoPreenchimento: IModelEntidade<IDadosPedidos>;
  end;

  IDadosClientes = interface
    ['{DABE497D-4F65-48B1-9AAB-CD222FC84526}']
    //Não implementado pois não há cadastro de clientes no projeto.
  end;

  IDadosProdutos = interface
    ['{F7FCCC58-0FC2-44EB-8243-15CFCBE6703B}']
    //Não implementado pois não há cadastro de produtos no projeto.
  end;

  IDadosFornecedores = interface
    ['{F7B279CC-ACA1-4092-902F-228E60D5AAEF}']
    //Não implementado pois não há cadastro de fornecedores no projeto.
  end;

  IDadosEndereco = interface
    ['{DDAD0E06-C50A-4D3D-A2F8-AFBC5229ADA3}']
    //Não implementado pois não há cadastro de endereços no projeto.
  end;

  IModelConexao = interface
    ['{0A8E84E8-116D-4A7F-AA43-D2EE36F1BED4}']
    function setParametros: IModelConexaoParametros;
    function Get: TComponent;
  end;

  IModelConexaoFactory = interface
    ['{83F0B33A-0E62-49F3-A6DA-E5FC3C7AD61D}']
    function getConexao: IModelConexao;
  end;

  IModelConexaoParametros = interface
    ['{4DE9BFF8-D143-4AB6-BD11-561389FA910F}']
    function Name(value: UTF8String) : IModelConexaoParametros;
    function DriverName(value: UTF8String) : IModelConexaoParametros;
    function DataBase(value: UTF8String) : IModelConexaoParametros;
    function UserName(value: UTF8String) : IModelConexaoParametros;
    function Password(value: UTF8String) : IModelConexaoParametros;
    function Server(value: UTF8String) : IModelConexaoParametros;
    function Port(value: UTF8String) : IModelConexaoParametros;
    function DriverId(value: UTF8String) : IModelConexaoParametros;
    function VendorHome(value: string) : IModelConexaoParametros;
    function &end: IModelConexao;
  end;

 IModelDataSet = interface
    ['{519B4DB9-F9F5-457F-99D9-1677F1CAF46A}']
    function open(aTable: String): TComponent;
    function get: TComponent;
    procedure ExecutarQuery(pQuery: string);
  end;

  IModelDataSetFactory = interface
    ['{519B4DB9-F9F5-457F-99D9-1677F1CAF46A}']
    function dataSet: IModelDataSet;
  end;

  IModelEntidade<T> = interface
    ['{47B7EB43-A877-4A39-9BC6-1C070EBFE6AB}']
    function Listar: TComponent;
    procedure Editar;
    procedure Deletar;
    procedure Inserir;
    function Dados: T;
  end;

  IModelEntidadeFactory = interface
    ['{47B7EB43-A877-4A39-9BC6-1C070EBFE6AB}']
    function GetModelEntidadesClientes: IModelEntidade<IDadosClientes>;
    function GetModelEntidadesProdutos: IModelEntidade<IDadosProdutos>;
    function GetModelEntidadesPedidos: IModelEntidade<IDadosPedidos>;
    function GetModelEntidadesEnderecos: IModelEntidade<IDadosEndereco>;
    function GetModelEntidadesPedidosItens: IModelEntidade<IDadosPedidosItens>;
  end;

implementation

end.
