unit Sistema.Model.Entidades.Enderecos;

interface

uses
  Sistema.Model.Interfaces, Data.DB, System.Classes, Datasnap.DBClient;

type
  TDadosEndereco = class(TInterfacedObject, IDadosEndereco)
      endereco: string;
      numero: string;
      bairro: string;
      uf: string;
      cidade: string;
      cep: string;
      referencia: string;
      class function new: IDadosEndereco;
    end;

  TModelEntidadeEnderecos = class(TInterfacedObject, IModelEntidade<IDadosEndereco>)
  private
    FDataSet: IModelDataSet;
    FClientDataSet: TClientDataSet;
    FDadosEndereco: IDadosEndereco;
    procedure CriarClientDataSet;
    constructor Create;
  public
    destructor Destroy; override;
    class function new: IModelEntidade<IDadosEndereco>;
    function Listar: TComponent;
    procedure Editar;
    procedure Deletar;
    procedure Finalizar;
    procedure Inserir;
    procedure Cancelar;
    function Dados: IDadosEndereco;
  end;

implementation

uses
  System.SysUtils, Sistema.Model.DataSetFactory;

Const
  FQUERY = 'SELECT * FROM enderecos';

{ TModelEntidadeEnderecos }

procedure TModelEntidadeEnderecos.Cancelar;
begin
  FClientDataSet.Cancel;
end;

constructor TModelEntidadeEnderecos.create;
begin
  FDataSet := TModelDataSetFactory.new.dataSet;
  FClientDataSet := TClientDataSet.Create(nil);
  FDadosEndereco := TDadosEndereco.new;

  CriarClientDataSet();
end;

procedure TModelEntidadeEnderecos.CriarClientDataSet;
begin
  FClientDataSet.FieldDefs.Add('codigo', ftInteger, 0);
  FClientDataSet.FieldDefs.Add('endereco', ftstring, 255);
  FClientDataSet.FieldDefs.Add('numero', ftstring, 11);
  FClientDataSet.FieldDefs.Add('bairro', ftstring, 255);
  FClientDataSet.FieldDefs.Add('uf', ftstring, 2);
  FClientDataSet.FieldDefs.Add('cidade', ftstring, 255);
  FClientDataSet.FieldDefs.Add('cep', ftstring, 14);
  FClientDataSet.FieldDefs.Add('referencia', ftstring, 255);
  FClientDataSet.FieldDefs.Add('id_cliente', ftInteger, 0);

  FClientDataSet.SetProvider(FDataSet.open(FQUERY));
  FClientDataSet.Open;

  FClientDataSet.FieldByName('codigo').DisplayWidth := 10;
  FClientDataSet.FieldByName('endereco').DisplayWidth := 40;
  FClientDataSet.FieldByName('numero').DisplayWidth := 40;
  FClientDataSet.FieldByName('bairro').DisplayWidth := 22;
  FClientDataSet.FieldByName('uf').DisplayWidth := 22;
  FClientDataSet.FieldByName('cidade').DisplayWidth := 10;
  FClientDataSet.FieldByName('cep').DisplayWidth := 20;
  FClientDataSet.FieldByName('referencia').DisplayWidth := 30;
  FClientDataSet.FieldByName('id_cliente').DisplayWidth := 10;

  FClientDataSet.AddIndex('IdxIdCliente', 'id_cliente', [ixUnique]);
  FClientDataSet.IndexName := 'IdxIdCliente';
end;

function TModelEntidadeEnderecos.Dados: IDadosEndereco;
begin
  Result := FDadosEndereco;
end;

procedure TModelEntidadeEnderecos.Deletar;
begin
  FClientDataSet.delete;
  FClientDataSet.ApplyUpdates(0);
end;

destructor TModelEntidadeEnderecos.destroy;
begin
  FClientDataSet.Free;
  inherited;
end;

procedure TModelEntidadeEnderecos.Editar;
begin
  FClientDataSet.Edit;
  FClientDataSet.ApplyUpdates(0);
end;

procedure TModelEntidadeEnderecos.Inserir;
begin
  FClientDataSet.Append;
end;

function TModelEntidadeEnderecos.Listar: TComponent;
begin
  Result := FClientDataSet;
end;

class function TModelEntidadeEnderecos.new: IModelEntidade<IDadosEndereco>;
begin
  Result := Self.create;
end;

procedure TModelEntidadeEnderecos.Finalizar;
begin
   FClientDataSet.post;
   FClientDataSet.ApplyUpdates(0);
   FClientDataSet.Refresh;
end;

{ TDadosEndereco }

class function TDadosEndereco.new: IDadosEndereco;
begin
  Result := Self.Create;
end;

end.
