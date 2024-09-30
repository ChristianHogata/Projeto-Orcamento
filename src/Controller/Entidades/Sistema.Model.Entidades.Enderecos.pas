unit Sistema.Model.Entidades.Enderecos;

interface

uses
  Sistema.Crontroller.Interfaces, Data.DB, Sistema.Model.Interfaces,
  System.Classes;

type
  TControlerEntidadeEnderecos = class(TInterfacedObject, IControlerEntity)
  private
    FEntity: IModelEntity;
  public
    class function new: IControlerEntity;
    constructor create; overload;
    function Listar: TComponent;
    procedure editar;
    procedure delete;
    procedure post;
    procedure insert;
    procedure cancelar;
  end;

implementation

{ TControlerEntidadeEnderecos }

uses
  Sistema.Model.Entidades.Factory;

procedure TControlerEntidadeEnderecos.cancelar;
begin
  FEntity.cancelar;
end;

constructor TControlerEntidadeEnderecos.create;
begin
  FEntity := TModelEntityFactory.new.CadEnderecos;
end;

procedure TControlerEntidadeEnderecos.delete;
begin
  FEntity.delete;
end;

procedure TControlerEntidadeEnderecos.editar;
begin
  FEntity.editar;
end;

procedure TControlerEntidadeEnderecos.insert;
begin
  FEntity.insert;
end;

function TControlerEntidadeEnderecos.Listar: TComponent;
begin
  Result := FEntity.Listar;
end;

class function TControlerEntidadeEnderecos.new: IControlerEntity;
begin
  Result := Self.create;
end;

procedure TControlerEntidadeEnderecos.post;
begin
  FEntity.post;
end;

end.
