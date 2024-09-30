unit Sistema.Controller.Entidades.Enderecos;

interface

uses
  Sistema.Crontroller.Interfaces, Sistema.Model.Interfaces,
  System.Classes;

type
  TControlerEntidadeEnderecos = class(TInterfacedObject, IControllerEntidade<IDadosEndereco>)
  private
    FEntidade: IModelEntidade<IDadosEndereco>;

    constructor create;
  public
    class function new: IControllerEntidade<IDadosEndereco>;
    function Listar: TComponent;
    procedure Editar;
    procedure Deletar;
    procedure Finalizar;
    procedure Inserir;
    procedure Cancelar;
    function Dados: IDadosEndereco;
  end;

implementation

{ TControlerEntidadeEnderecos }

uses
  Sistema.Model.Entidades.Factory;

procedure TControlerEntidadeEnderecos.Cancelar;
begin
  FEntidade.Cancelar;
end;

constructor TControlerEntidadeEnderecos.create;
begin
  FEntidade := TModelEntityFactory.new.getModelEntidadesEnderecos;
end;

function TControlerEntidadeEnderecos.Dados: IDadosEndereco;
begin
  Result := FEntidade.Dados;
end;

procedure TControlerEntidadeEnderecos.Deletar;
begin
  FEntidade.Deletar;
end;

procedure TControlerEntidadeEnderecos.Editar;
begin
  FEntidade.Editar;
end;

procedure TControlerEntidadeEnderecos.Inserir;
begin
  FEntidade.Inserir;
end;

function TControlerEntidadeEnderecos.Listar: TComponent;
begin
  Result := FEntidade.Listar;
end;

class function TControlerEntidadeEnderecos.new: IControllerEntidade<IDadosEndereco>;
begin
  Result := Self.create;
end;

procedure TControlerEntidadeEnderecos.Finalizar;
begin
  FEntidade.Finalizar;
end;

end.
