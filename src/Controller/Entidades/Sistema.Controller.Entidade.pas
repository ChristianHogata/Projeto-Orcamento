unit Sistema.Controller.Entidade;

interface

uses
  Sistema.Crontroller.Interfaces, Sistema.Model.Interfaces;

type
  TControllerEntidade = class(TInterfacedObject, IControllerEntidade)
  private
    FEntidadeCliente: IModelEntidade<IDadosClientes>;
    FEntidadeEndereco: IModelEntidade<IDadosEndereco>;
    FEntidadePedido: IModelEntidade<IDadosPedidos>;
    FEntidadePedidosItens: IModelEntidade<IDadosPedidosItens>;
    FEntidadeProdutos: IModelEntidade<IDadosProdutos>;
  public
    class function new: IControllerEntidade;
    function Clientes: IModelEntidade<IDadosClientes>;
    function Produtos: IModelEntidade<IDadosProdutos>;
    function Pedidos: IModelEntidade<IDadosPedidos>;
    function Enderecos: IModelEntidade<IDadosEndereco>;
    function PedidosItens: IModelEntidade<IDadosPedidosItens>;
  end;

implementation

uses
  Sistema.Controller.Entidades.Factory;

{ TControllerEntidade }

function TControllerEntidade.Clientes: IModelEntidade<IDadosClientes>;
begin
  if not assigned(FEntidadeCliente) then
    FEntidadeCliente := TControlerEntityFactory.new.ObterEntidadeClientes;

  Result := FEntidadeCliente;
end;

function TControllerEntidade.Enderecos: IModelEntidade<IDadosEndereco>;
begin
  if not assigned(FEntidadeEndereco) then
    FEntidadeEndereco := TControlerEntityFactory.new.ObterEntidadeEnderecos;

  Result := FEntidadeEndereco;
end;

function TControllerEntidade.Pedidos: IModelEntidade<IDadosPedidos>;
begin
  if not assigned(FEntidadePedido) then
    FEntidadePedido := TControlerEntityFactory.new.ObterEntidadePedidos;

  Result := FEntidadePedido;
end;

function TControllerEntidade.PedidosItens: IModelEntidade<IDadosPedidosItens>;
begin
  if not assigned(FEntidadePedidosItens) then
    FEntidadePedidosItens := TControlerEntityFactory.new.ObterEntidadePedidosItens;

  Result := FEntidadePedidosItens;
end;

function TControllerEntidade.Produtos: IModelEntidade<IDadosProdutos>;
begin
  if not assigned(FEntidadeProdutos) then
    FEntidadeProdutos := TControlerEntityFactory.new.ObterEntidadeProdutos;

  Result := FEntidadeProdutos;
end;

class function TControllerEntidade.new: IControllerEntidade;
begin
  Result := Self.Create;
end;

end.
