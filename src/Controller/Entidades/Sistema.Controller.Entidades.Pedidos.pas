unit Sistema.Controller.Entidades.Pedidos;

interface

uses
  Sistema.Crontroller.Interfaces, Sistema.Model.Interfaces,
  System.Classes;

type
  TControlerEntidadePedidos = class(TInterfacedObject, IControllerEntidade<IDadosPedidos>)
  private
    FEntidade: IModelEntidade<IDadosPedidos>;

    constructor create;
  public
    class function new: IControllerEntidade<IDadosPedidos>;
    function Listar: TComponent;
    procedure Editar;
    procedure Deletar;
    procedure Finalizar;
    procedure Inserir;
    procedure Cancelar;
    function Dados: IDadosPedidos;
  end;

implementation

{ TControlerEntidadePedidos }

uses
  Sistema.Model.Entidades.Factory;

procedure TControlerEntidadePedidos.Cancelar;
begin
  FEntidade.Cancelar;
end;

constructor TControlerEntidadePedidos.create;
begin
  FEntidade := TModelEntityFactory.new.getModelEntidadesPedidos;
end;

function TControlerEntidadePedidos.Dados: IDadosPedidos;
begin
  Result := FEntidade.Dados;
end;

procedure TControlerEntidadePedidos.Deletar;
begin
  FEntidade.Deletar;
end;

procedure TControlerEntidadePedidos.Editar;
begin
  FEntidade.Editar;
end;

procedure TControlerEntidadePedidos.Inserir;
begin
  FEntidade.Inserir;
end;

function TControlerEntidadePedidos.Listar: TComponent;
begin
  Result := FEntidade.Listar;
end;

class function TControlerEntidadePedidos.new: IControllerEntidade<IDadosPedidos>;
begin
  Result := Self.create;
end;

procedure TControlerEntidadePedidos.Finalizar;
begin
  FEntidade.Finalizar;
end;

end.
