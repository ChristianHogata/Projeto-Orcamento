unit Sistema.Model.Entidades.Pedidos;

interface

uses
  Sistema.Model.Interfaces, Data.DB, System.Classes, Datasnap.DBClient;

type
  TModelEntidadePedidos = class(TInterfacedObject, IModelEntidade<IDadosPedidos>)
  type
    TPedidoDados = class(TInterfacedObject, IDadosPedidos)
    private
      Fvalor_total: Double;
      Fvalor_pago: Double;
      Fvalor_troco: Double;
      Fid_cliente: Integer;
      FModelEntidadePedidos: TModelEntidadePedidos;
      function ObterValorTotalPedido: Double;
      function ObterValorPagoPedido: Double;
      function ObterValorTrocoPedido: Double;
      function ObterIdClientePedido: Integer;
    public
      function DefinirValorTotalPedido(ValorTotalPedido: Double): IDadosPedidos;
      function DefinirValorPagoPedido(ValorPagoPedido: Double): IDadosPedidos;
      function DefinirValorTrocoPedido(ValorTrocoPedido: Double): IDadosPedidos;
      function DefinirIdClientePedido(IdCliente: integer): IDadosPedidos;
      function FimDoPreenchimento: IModelEntidade<IDadosPedidos>;
      constructor Create(pModelEntidadePedidos: TModelEntidadePedidos);
      class function new(pModelEntidadePedidos: TModelEntidadePedidos): IDadosPedidos;
    end;
  private
    FDataSet: IModelDataSet;
    FClientDataSet: TClientDataSet;
    FDadosPedido: IDadosPedidos;
    procedure CriarClientDataSet;
    constructor Create;
  public
    destructor Destroy; override;
    class function new: IModelEntidade<IDadosPedidos>;
    function Listar: TComponent;
    procedure Editar;
    procedure Deletar;
    procedure Inserir;
    function Dados: IDadosPedidos;
  end;

implementation

uses
  System.SysUtils, Sistema.Model.DataSetFactory;

Const
  FQUERY = 'SELECT * FROM pedidos';

{ TModelEntidadePedidos }

constructor TModelEntidadePedidos.create;
begin
  FDataSet := TModelDataSetFactory.new.dataSet;
  FClientDataSet := TClientDataSet.Create(nil);
  FDadosPedido := TPedidoDados.new(Self);

  CriarClientDataSet();
end;

procedure TModelEntidadePedidos.CriarClientDataSet;
begin
  FClientDataSet.FieldDefs.Add('codigo', ftInteger, 0);
  FClientDataSet.FieldDefs.Add('valor_total', ftfloat, 0);
  FClientDataSet.FieldDefs.Add('valor_pago', ftfloat, 0);
  FClientDataSet.FieldDefs.Add('valor_troco', ftfloat, 0);
  FClientDataSet.FieldDefs.Add('id_cliente', ftInteger, 0);
  FClientDataSet.FieldDefs.Add('data_pedido', ftDateTime, 0);

  FClientDataSet.SetProvider(FDataSet.open(FQUERY));
  FClientDataSet.Open;

  FClientDataSet.FieldByName('codigo').DisplayWidth := 10;
  FClientDataSet.FieldByName('valor_total').DisplayWidth := 25;
  FClientDataSet.FieldByName('valor_pago').DisplayWidth := 25;
  FClientDataSet.FieldByName('valor_troco').DisplayWidth := 25;
  FClientDataSet.FieldByName('id_cliente').DisplayWidth := 25;
  FClientDataSet.FieldByName('data_pedido').DisplayWidth := 25;

  FClientDataSet.AddIndex('IdxCodigoPedido', 'codigo', [ixUnique]);
  FClientDataSet.IndexName := 'IdxCodigoPedido';
end;

function TModelEntidadePedidos.Dados: IDadosPedidos;
begin
  Result := FDadosPedido;
end;

procedure TModelEntidadePedidos.Deletar;
begin
  TModelDataSetFactory
    .new
    .dataSet
    .ExecutarQuery(
      Format(
        'DELETE FROM pedidos '+
        'WHERE codigo = %d ',
        [FClientDataSet.FieldByName('codigo').AsInteger]
      )
    );

  FClientDataSet.Refresh;
end;

destructor TModelEntidadePedidos.destroy;
begin
  FClientDataSet.Free;
  inherited;
end;

procedure TModelEntidadePedidos.Editar;
begin
  TModelDataSetFactory
    .new
    .dataSet
    .ExecutarQuery(
      Format(
        ' UPDATE pedidos SET ' +
        ' valor_total = %s, valor_pago = %s, valor_troco = %s, ' +
        ' id_cliente = %d' +
        ' WHERE  codigo = %d',
        [StringReplace(FormatFloat('0.00', FDadosPedido.ObterValorTotalPedido), ',', '.', [rfReplaceAll]),
         StringReplace(FormatFloat('0.00', FDadosPedido.ObterValorPagoPedido), ',', '.', [rfReplaceAll]),
         StringReplace(FormatFloat('0.00', FDadosPedido.ObterValorTrocoPedido), ',', '.', [rfReplaceAll]),
         FDadosPedido.ObterIdClientePedido,
         FClientDataSet.FieldByName('codigo').AsInteger
        ]
      )
    );

  FClientDataSet.Refresh;
end;

procedure TModelEntidadePedidos.Inserir;
begin
  TModelDataSetFactory
    .new
    .dataSet
    .ExecutarQuery(
      Format(
        'INSERT INTO pedidos (valor_total, valor_pago, valor_troco, data_pedido) '+
        ' VALUES (%s, %s, %s, CURRENT_TIMESTAMP) ',
         [StringReplace(FormatFloat('0.00', FDadosPedido.ObterValorTotalPedido), ',', '.', [rfReplaceAll]),
          StringReplace(FormatFloat('0.00', FDadosPedido.ObterValorPagoPedido), ',', '.', [rfReplaceAll]),
          StringReplace(FormatFloat('0.00', FDadosPedido.ObterValorTrocoPedido), ',', '.', [rfReplaceAll])
         ]
      )
    );

  FClientDataSet.Refresh;

  FClientDataSet.Last;
end;

function TModelEntidadePedidos.Listar: TComponent;
begin
  Result := FClientDataSet;
end;

class function TModelEntidadePedidos.new: IModelEntidade<IDadosPedidos>;
begin
  Result := Self.create;
end;

{ TModelEntidadePedidos.TPedidoDados }

constructor TModelEntidadePedidos.TPedidoDados.Create(pModelEntidadePedidos: TModelEntidadePedidos);
begin
  FModelEntidadePedidos := pModelEntidadePedidos;
  Fvalor_total := 0;
  Fvalor_pago := 0;
  Fvalor_troco := 0;
  Fid_cliente := 0;
end;

function TModelEntidadePedidos.TPedidoDados.DefinirIdClientePedido(IdCliente: integer): IDadosPedidos;
begin
  Fid_cliente := IdCliente;
  Result := Self;
end;

function TModelEntidadePedidos.TPedidoDados.DefinirValorPagoPedido(ValorPagoPedido: Double): IDadosPedidos;
begin
  Fvalor_pago := ValorPagoPedido;
  Result := Self;
end;

function TModelEntidadePedidos.TPedidoDados.DefinirValorTotalPedido(ValorTotalPedido: Double): IDadosPedidos;
begin
  Fvalor_total := ValorTotalPedido;
  Result := Self;
end;

function TModelEntidadePedidos.TPedidoDados.DefinirValorTrocoPedido(ValorTrocoPedido: Double): IDadosPedidos;
begin
  Fvalor_troco := ValorTrocoPedido;
  Result := Self;
end;

function TModelEntidadePedidos.TPedidoDados.FimDoPreenchimento: IModelEntidade<IDadosPedidos>;
begin
  Result := FModelEntidadePedidos;
end;

class function TModelEntidadePedidos.TPedidoDados.new(pModelEntidadePedidos: TModelEntidadePedidos): IDadosPedidos;
begin
  Result := Self.Create(pModelEntidadePedidos);
end;

function TModelEntidadePedidos.TPedidoDados.ObterIdClientePedido: Integer;
begin
  Result := Fid_cliente;
end;

function TModelEntidadePedidos.TPedidoDados.ObterValorPagoPedido: Double;
begin
  Result := Fvalor_pago;
end;

function TModelEntidadePedidos.TPedidoDados.ObterValorTotalPedido: Double;
begin
  Result := Fvalor_total;
end;

function TModelEntidadePedidos.TPedidoDados.ObterValorTrocoPedido: Double;
begin
  Result := Fvalor_troco;
end;

end.
