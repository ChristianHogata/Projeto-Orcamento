unit Sistema.Model.Entidades.PedidosItens;

interface

uses
  Sistema.Model.Interfaces, Data.DB, System.Classes, Datasnap.DBClient;

type
  TModelEntidadePedidosItens = class(TInterfacedObject, IModelEntidade<IDadosPedidosItens>)
  type
    TDadosPedidoItens = class(TInterfacedObject, IDadosPedidosItens)
    private
      Fid_produto: integer;
      Fid_pedido: integer;
      Fquantidade: extended;
      Fvalor_total_item: Double;
      FModelEntidadePedidosItens: TModelEntidadePedidosItens;
      function ObterIdProduto: Integer;
      function ObterIdPedido: Integer;
      function ObterQuantidade: extended;
      function ObterValorTotalItem: Double;
    public
      function DefinirIdProduto(id_produto: integer): IDadosPedidosItens;
      function DefinirIdPedido(id_pedido: integer): IDadosPedidosItens;
      function DefinirQuantidade(quantidade: extended): IDadosPedidosItens;
      function DefinirValorTotalItem(valor_total_item: Double): IDadosPedidosItens;
      function FimDoPreenchimento: IModelEntidade<IDadosPedidosItens>;
      constructor Create(pModelEntidadePedidosItens: TModelEntidadePedidosItens);
      class function new(pModelEntidadePedidosItens: TModelEntidadePedidosItens): IDadosPedidosItens;
    end;

  private
    FDataSet: IModelDataSet;
    FClientDataSet: TClientDataSet;
    FDadosParametros: IDadosPedidosItens;
    procedure CriarClientDataSet;
    constructor Create;
  public
    destructor Destroy; override;
    class function new: IModelEntidade<IDadosPedidosItens>;
    function Listar: TComponent;
    procedure Editar;
    procedure Deletar;
    procedure Inserir;
    function Dados: IDadosPedidosItens;
  end;

implementation

uses
  System.SysUtils, Sistema.Model.DataSetFactory;

Const
  FQUERY = 'SELECT * FROM pedidos_itens';

{ TModelEntidadePedidosItens }

constructor TModelEntidadePedidosItens.create;
begin
  FDataSet := TModelDataSetFactory.new.dataSet;
  FClientDataSet := TClientDataSet.Create(nil);
  FDadosParametros := TDadosPedidoItens.new(Self);

  CriarClientDataSet();
end;

procedure TModelEntidadePedidosItens.CriarClientDataSet;
begin
  FClientDataSet.FieldDefs.Add('codigo', ftInteger, 0);
  FClientDataSet.FieldDefs.Add('id_produto', ftInteger, 0);
  FClientDataSet.FieldDefs.Add('id_pedido', ftInteger, 0);
  FClientDataSet.FieldDefs.Add('quantidade', ftfloat, 0);
  FClientDataSet.FieldDefs.Add('valor_total_item', ftfloat, 0);

  FClientDataSet.SetProvider(FDataSet.open(FQUERY));
  FClientDataSet.Open;

  FClientDataSet.FieldByName('codigo').DisplayWidth := 10;
  FClientDataSet.FieldByName('id_produto').DisplayWidth := 20;
  FClientDataSet.FieldByName('id_pedido').DisplayWidth := 20;
  FClientDataSet.FieldByName('quantidade').DisplayWidth := 20;
  FClientDataSet.FieldByName('valor_total_item').DisplayWidth := 20;

  FClientDataSet.AddIndex('Idxid_pedidoPedidoItens', 'id_pedido', [ixPrimary]);
  FClientDataSet.IndexName := 'Idxid_pedidoPedidoItens';
end;

function TModelEntidadePedidosItens.Dados: IDadosPedidosItens;
begin
  Result := FDadosParametros;
end;

procedure TModelEntidadePedidosItens.Deletar;
begin
  TModelDataSetFactory
    .new
    .dataSet
    .ExecutarQuery(
      Format(
        'DELETE FROM pedidos_itens '+
        'WHERE codigo = %d ',
        [FClientDataSet.FieldByName('codigo').AsInteger]
      )
    );

  FClientDataSet.Refresh;
end;

destructor TModelEntidadePedidosItens.destroy;
begin
  FClientDataSet.Free;
  inherited;
end;

procedure TModelEntidadePedidosItens.Editar;
begin
  TModelDataSetFactory
    .new
    .dataSet
    .ExecutarQuery(
      Format(
        'UPDATE pedidos_itens SET ' +
        'id_produto = %d, id_pedido = %d, quantidade = %s, valor_total_item = %s '+
        'WHERE codigo = %d ',
        [FDadosParametros.ObterIdProduto, FDadosParametros.ObterIdPedido,
        StringReplace(FormatFloat('0.00', FDadosParametros.ObterQuantidade), ',', '.', [rfReplaceAll]),
         StringReplace(FormatFloat('0.00', FDadosParametros.ObterValorTotalItem), ',', '.', [rfReplaceAll]),
         FClientDataSet.FieldByName('codigo').AsInteger
        ]
      )
    );

  FClientDataSet.Refresh;
end;

procedure TModelEntidadePedidosItens.Inserir;
begin
  TModelDataSetFactory
    .new
    .dataSet
    .ExecutarQuery(
      Format(
        'INSERT INTO pedidos_itens (id_produto, id_pedido, quantidade, valor_total_item) '+
        ' VALUES (%d, %d, %s, %s) ',
        [FDadosParametros.ObterIdProduto, FDadosParametros.ObterIdPedido,
         StringReplace(FormatFloat('0.00', FDadosParametros.ObterQuantidade), ',', '.', [rfReplaceAll]),
         StringReplace(FormatFloat('0.00', FDadosParametros.ObterValorTotalItem), ',', '.', [rfReplaceAll])
        ]
      )
    );

  FClientDataSet.Refresh;
end;

function TModelEntidadePedidosItens.Listar: TComponent;
begin
  Result := FClientDataSet;
end;

class function TModelEntidadePedidosItens.new: IModelEntidade<IDadosPedidosItens>;
begin
  Result := Self.create;
end;

{ TModelEntidadePedidosItens.TDadosPedidoItens }

constructor TModelEntidadePedidosItens.TDadosPedidoItens.Create(pModelEntidadePedidosItens: TModelEntidadePedidosItens);
begin
  FModelEntidadePedidosItens := pModelEntidadePedidosItens;
  Fid_produto := 0;
  Fid_pedido := 0;
  Fquantidade := 0;
  Fvalor_total_item := 0;
end;

function TModelEntidadePedidosItens.TDadosPedidoItens.DefinirIdPedido(id_pedido: integer): IDadosPedidosItens;
begin
  Fid_pedido := id_pedido;
  Result := Self;
end;

function TModelEntidadePedidosItens.TDadosPedidoItens.DefinirIdProduto(id_produto: integer): IDadosPedidosItens;
begin
  Fid_produto := id_produto;
  Result := Self;
end;

function TModelEntidadePedidosItens.TDadosPedidoItens.DefinirQuantidade(quantidade: extended): IDadosPedidosItens;
begin
  Fquantidade := quantidade;
  Result := Self;
end;

function TModelEntidadePedidosItens.TDadosPedidoItens.DefinirValorTotalItem(valor_total_item: Double): IDadosPedidosItens;
begin
  Fvalor_total_item := valor_total_item;
  Result := Self;
end;

function TModelEntidadePedidosItens.TDadosPedidoItens.FimDoPreenchimento: IModelEntidade<IDadosPedidosItens>;
begin
  Result := FModelEntidadePedidosItens;
end;

class function TModelEntidadePedidosItens.TDadosPedidoItens.new(pModelEntidadePedidosItens: TModelEntidadePedidosItens): IDadosPedidosItens;
begin
  Result := Self.Create(pModelEntidadePedidosItens);
end;

function TModelEntidadePedidosItens.TDadosPedidoItens.ObterIdPedido: Integer;
begin
  Result := Fid_pedido;
end;

function TModelEntidadePedidosItens.TDadosPedidoItens.ObterIdProduto: Integer;
begin
  Result := Fid_produto;
end;

function TModelEntidadePedidosItens.TDadosPedidoItens.ObterQuantidade: extended;
begin
  Result := Fquantidade;
end;

function TModelEntidadePedidosItens.TDadosPedidoItens.ObterValorTotalItem: Double;
begin
  Result := Fvalor_total_item;
end;

end.
