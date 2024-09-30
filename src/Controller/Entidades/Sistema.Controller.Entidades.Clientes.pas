unit Sistema.Controller.Entidades.Clientes;

interface

uses
  Sistema.Crontroller.Interfaces, Sistema.Model.Interfaces,
  System.Classes;

type
  TControlerEntidadeClientes = class(TInterfacedObject, IControllerEntidade<IDadosClientes>)
  private
    FEntidade: IModelEntidade<IDadosClientes>;
    constructor create;
  public
    class function new: IControllerEntidade<IDadosClientes>;
    function Listar: TComponent;
    procedure Editar;
    procedure Deletar;
    procedure Finalizar;
    procedure Inserir;
    procedure Cancelar;
    function Dados: IDadosClientes;
  end;

implementation

{ TControlerEntidadeClientes }

uses
  Sistema.Model.Entidades.Factory;

procedure TControlerEntidadeClientes.Cancelar;
begin
  FEntidade.Cancelar;
end;

constructor TControlerEntidadeClientes.create;
begin
  FEntidade := TModelEntityFactory.new.getModelEntidadesClientes;
end;

function TControlerEntidadeClientes.Dados: IDadosClientes;
begin
  Result := FEntidade.Dados;
end;

procedure TControlerEntidadeClientes.Deletar;
begin
  FEntidade.Deletar;
end;

procedure TControlerEntidadeClientes.Editar;
begin
  FEntidade.Editar;
end;

procedure TControlerEntidadeClientes.Inserir;
begin
  FEntidade.Inserir;
end;

function TControlerEntidadeClientes.Listar: TComponent;
begin
  Result := FEntidade.Listar;
end;

class function TControlerEntidadeClientes.new: IControllerEntidade<IDadosClientes>;
begin
  Result := Self.create;
end;

procedure TControlerEntidadeClientes.Finalizar;
begin
  FEntidade.Finalizar;
end;

end.
