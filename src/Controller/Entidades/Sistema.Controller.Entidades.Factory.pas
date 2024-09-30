unit Sistema.Controller.Entidades.Factory;

interface

uses
  Sistema.Crontroller.Interfaces, Sistema.Model.Interfaces;

type
  TControlerEntityFactory = class(TInterfacedObject, IControllerEntidadeFactory)
  public
    class function new: IControllerEntidadeFactory;
    function ObterEntidadeClientes: IModelEntidade<IDadosClientes>;
    function ObterEntidadeProdutos: IModelEntidade<IDadosProdutos>;
    function ObterEntidadePedidos: IModelEntidade<IDadosPedidos>;
    function ObterEntidadeEnderecos: IModelEntidade<IDadosEndereco>;
    function ObterEntidadePedidosItens: IModelEntidade<IDadosPedidosItens>;
  end;

implementation

uses
  Sistema.Model.Entidades.Produtos,
  Sistema.Model.Entidades.PedidosItens, Sistema.Model.Entidades.Pedidos,
  Sistema.Model.Entidades.Enderecos, Sistema.Model.Entidades.Clientes;

{ TControlerEntityFactory }

function TControlerEntityFactory.ObterEntidadeClientes: IModelEntidade<IDadosClientes>;
begin
  Result := TModelEntidadeClientes.new;
end;

function TControlerEntityFactory.ObterEntidadeEnderecos: IModelEntidade<IDadosEndereco>;
begin
  Result := TModelEntidadeEnderecos.new;
end;

function TControlerEntityFactory.ObterEntidadePedidos: IModelEntidade<IDadosPedidos>;
begin
  Result := TModelEntidadePedidos.new;
end;

function TControlerEntityFactory.ObterEntidadePedidosItens: IModelEntidade<IDadosPedidosItens>;
begin
  Result := TModelEntidadePedidosItens.new;
end;

function TControlerEntityFactory.ObterEntidadeProdutos: IModelEntidade<IDadosProdutos>;
begin
  Result := TModelEntidadeProdutos.new;
end;

class function TControlerEntityFactory.new: IControllerEntidadeFactory;
begin
  Result := Self.Create;
end;

end.
