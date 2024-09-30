unit Sistema.Controller.Entidades.PedidosItens;

interface

uses
  Sistema.Crontroller.Interfaces, Sistema.Model.Interfaces,
  System.Classes;

type
  TControlerEntidadePedidosItens = class(TInterfacedObject, IControllerEntidade<IDadosPedidosItens>)
  private
    FEntidade: IModelEntidade<IDadosPedidosItens>;

    constructor create;
  public
    class function new: IControllerEntidade<IDadosPedidosItens>;
    function Listar: TComponent;
    procedure Editar;
    procedure Deletar;
    procedure Finalizar;
    procedure Inserir;
    procedure Cancelar;
    function Dados: IDadosPedidosItens;
  end;

implementation

{ TControlerEntidadePedidosItens }

uses
  Sistema.Model.Entidades.Factory, Sistema.Model.Entidades.PedidosItens;

procedure TControlerEntidadePedidosItens.Cancelar;
begin
  FEntidade.Cancelar;
end;

constructor TControlerEntidadePedidosItens.create;
begin
  FEntidade := TModelEntityFactory.new.GetModelEntidadesPedidosItens;
end;

function TControlerEntidadePedidosItens.Dados: IDadosPedidosItens;
begin
  Result := FEntidade.Dados;
end;

procedure TControlerEntidadePedidosItens.Deletar;
begin
  FEntidade.Deletar;
end;

procedure TControlerEntidadePedidosItens.Editar;
begin
  FEntidade.Editar;
end;

procedure TControlerEntidadePedidosItens.Inserir;
begin
  FEntidade.Inserir;
end;

function TControlerEntidadePedidosItens.Listar: TComponent;
begin
  Result := FEntidade.Listar;
end;

class function TControlerEntidadePedidosItens.new: IControllerEntidade<IDadosPedidosItens>;
begin
  Result := Self.create;
end;

procedure TControlerEntidadePedidosItens.Finalizar;
begin
  FEntidade.Finalizar;
end;

end.
