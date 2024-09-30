unit Sistema.Model.Entidades.Produtos;

interface

uses
  Sistema.Model.Interfaces, Data.DB, System.Classes, Datasnap.DBClient;

type

  TDadosProduto = class(TInterfacedObject, IDadosProdutos)
  public
    descricao: string;
    preco_venda: Double;
    class function new: IDadosProdutos;
  end;

  TModelEntidadeProdutos = class(TInterfacedObject, IModelEntidade<IDadosProdutos>)
  private
    FDataSet: IModelDataSet;
    FClientDataSet: TClientDataSet;
    FDadosProduto: IDadosProdutos;
    procedure CriarClientDataSet;
    constructor Create;
  public
    destructor Destroy; override;
    class function new: IModelEntidade<IDadosProdutos>;
    function Listar: TComponent;
    procedure Editar;
    procedure Deletar;
    procedure Finalizar;
    procedure Inserir;
    procedure Cancelar;
    function Dados: IDadosProdutos;
  end;

implementation

uses
  System.SysUtils, Sistema.Model.DataSetFactory;

Const
  FQUERY = 'SELECT * FROM produtos';

{ TModelEntidadeProdutos }

procedure TModelEntidadeProdutos.Cancelar;
begin
  FClientDataSet.Cancel;
end;

constructor TModelEntidadeProdutos.create;
begin
  FDataSet := TModelDataSetFactory.new.dataSet;
  FClientDataSet := TClientDataSet.Create(nil);
  FDadosProduto := TDadosProduto.new;

  CriarClientDataSet();
end;

procedure TModelEntidadeProdutos.CriarClientDataSet;
begin
  FClientDataSet.FieldDefs.Add('codigo', ftInteger, 0);
  FClientDataSet.FieldDefs.Add('descricao', ftstring, 255);
  FClientDataSet.FieldDefs.Add('preco_venda', ftfloat, 0);

  FClientDataSet.SetProvider(FDataSet.open(FQUERY));
  FClientDataSet.Open;

  FClientDataSet.FieldByName('codigo').DisplayWidth := 20;
  FClientDataSet.FieldByName('descricao').DisplayWidth := 20;
  FClientDataSet.FieldByName('preco_venda').DisplayWidth := 20;

  FClientDataSet.AddIndex('IdxCodigoDescricao', 'codigo;descricao', [ixUnique]);
  FClientDataSet.IndexName := 'IdxCodigoDescricao';
end;

function TModelEntidadeProdutos.Dados: IDadosProdutos;
begin
  Result := FDadosProduto;
end;

procedure TModelEntidadeProdutos.Deletar;
begin
  FClientDataSet.Cancel;
  FClientDataSet.ApplyUpdates(0);
end;

destructor TModelEntidadeProdutos.destroy;
begin
  FClientDataSet.Free;
  inherited;
end;

procedure TModelEntidadeProdutos.Editar;
begin
  FClientDataSet.Edit;
  FClientDataSet.ApplyUpdates(0);
end;

procedure TModelEntidadeProdutos.Inserir;
begin
  FClientDataSet.Insert;
end;

function TModelEntidadeProdutos.Listar: TComponent;
begin
  Result := FClientDataSet;
end;

class function TModelEntidadeProdutos.new: IModelEntidade<IDadosProdutos>;
begin
  Result := Self.create;
end;

procedure TModelEntidadeProdutos.Finalizar;
begin
   FClientDataSet.Post;
   FClientDataSet.ApplyUpdates(0);
   FClientDataSet.Refresh;
end;

{ TDadosProduto }

class function TDadosProduto.new: IDadosProdutos;
begin
  Result := Self.Create;
end;

end.
