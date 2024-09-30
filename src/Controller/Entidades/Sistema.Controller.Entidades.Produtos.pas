unit Sistema.Controller.Entidades.Produtos;

interface

uses
  Sistema.Crontroller.Interfaces, Sistema.Model.Interfaces,
  System.Classes;

type
  TControlerEntidadeProdutos = class(TInterfacedObject, IControllerEntidade<IDadosProdutos>)
  private
    FEntidade: IModelEntidade<IDadosProdutos>;

    constructor create;
  public
    class function new: IControllerEntidade<IDadosProdutos>;
    function Listar: TComponent;
    procedure Editar;
    procedure Deletar;
    procedure Finalizar;
    procedure Inserir;
    procedure Cancelar;
    function Dados: IDadosProdutos;
  end;

implementation

{ TControlerEntidadeProdutos }

uses
  Sistema.Model.Entidades.Factory;

procedure TControlerEntidadeProdutos.Cancelar;
begin
  FEntidade.Cancelar;
end;

constructor TControlerEntidadeProdutos.create;
begin
  FEntidade := TModelEntityFactory.new.getModelEntidadesProdutos;
end;

function TControlerEntidadeProdutos.Dados: IDadosProdutos;
begin
  Result := FEntidade.Dados;
end;

procedure TControlerEntidadeProdutos.Deletar;
begin
  FEntidade.Deletar;
end;

procedure TControlerEntidadeProdutos.Editar;
begin
  FEntidade.Editar;
end;

procedure TControlerEntidadeProdutos.Inserir;
begin
  FEntidade.Inserir;
end;

function TControlerEntidadeProdutos.Listar: TComponent;
begin
  Result := FEntidade.Listar;
end;

class function TControlerEntidadeProdutos.new: IControllerEntidade<IDadosProdutos>;
begin
  Result := Self.create;
end;

procedure TControlerEntidadeProdutos.Finalizar;
begin
  FEntidade.Finalizar;
end;

end.
