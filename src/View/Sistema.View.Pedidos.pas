unit Sistema.View.Pedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, Sistema.Crontroller.Interfaces,
  Vcl.Mask, Vcl.DBCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Comp.Client,
  FireDAC.Phys.PGDef, FireDAC.Phys.PG, Sistema.Controller.Entidade,
  Vcl.NumberBox;

type
  Tfrm_consulta_pedidos = class(TForm)
    pnlListaPedidos: TPanel;
    pnlTopo: TPanel;
    lblTitulo: TLabel;
    pnlGrid: TPanel;
    dbgRegistros: TDBGrid;
    BtnExcluir: TSpeedButton;
    BtnInserir: TSpeedButton;
    pnlCadastroPedido: TPanel;
    pnlInformacoesCadastroClientes: TPanel;
    LblNome: TLabel;
    lblCodigoPedido: TLabel;
    edtNome: TDBEdit;
    edtCodigoPedido: TDBEdit;
    pnlInformacoesPedido: TPanel;
    PnlTopoCadastro: TPanel;
    LblTituloCadastro: TLabel;
    PnlSeparaCadastro1: TPanel;
    PnlSeparaCadastro2: TPanel;
    PnlBotoes: TPanel;
    PnlCancelar: TPanel;
    PnlFinalizar: TPanel;
    DBGridListaPedidosItens: TDBGrid;
    lblProduto: TLabel;
    edtDescricao: TDBEdit;
    lblValorPago: TLabel;
    lblTroco: TLabel;
    lblTotal: TLabel;
    BtnPesquisaClientes: TSpeedButton;
    BtnPesquisarProdutos: TSpeedButton;
    BtnExcluirProdutoPedido: TSpeedButton;
    pnlInformacoesCadastroEnderecoClientes: TPanel;
    lbEndereco: TLabel;
    lbNumero: TLabel;
    lbBairro: TLabel;
    lbCidade: TLabel;
    lbUf: TLabel;
    lbCep: TLabel;
    lbReferencia: TLabel;
    edtEndereco: TDBEdit;
    edtNumero: TDBEdit;
    edtBairro: TDBEdit;
    edtCidade: TDBEdit;
    edtUf: TDBEdit;
    edtCep: TDBEdit;
    edtReferencia: TDBEdit;
    lbQuantidade: TLabel;
    btnIncluirProduto: TSpeedButton;
    edtTotal: TNumberBox;
    edtValorPago: TNumberBox;
    edtTroco: TNumberBox;
    edtQuantidade: TNumberBox;
    procedure BtnInserirClick(Sender: TObject);
    procedure PnlCancelarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnPesquisaClientesClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnPesquisarProdutosClick(Sender: TObject);
    procedure dbgRegistrosDblClick(Sender: TObject);
    procedure btnIncluirProdutoClick(Sender: TObject);
    procedure BtnExcluirProdutoPedidoClick(Sender: TObject);
    procedure PnlFinalizarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure edtValorPagoExit(Sender: TObject);
    procedure edtQuantidadeExit(Sender: TObject);
  private
    { Private declarations }
    FControllerEntidade: IControllerEntidade;
    FDataSourcePedidos: TDataSource;
    FDataSourcePedidosItens: TDataSource;
    FDataSourceClientes: TDataSource;
    FDataSourceProdutos: TDataSource;
    FDataSourceEnderecos: TDataSource;
    procedure CarregarGridPedidos;
    procedure LimparCamposPedidos;
    procedure LimparCamposClientes;
    procedure LimparCamposProdutos;
    procedure AlimentarCamposClientes;
    procedure AlimentarCamposEnderecoClientes;
    procedure HabilitarDesabilitarPainel;
    procedure CalcularTotal;
    procedure CalcularTroco;
    procedure NovoPedido;
  public
    { Public declarations }
  end;

var
  frm_consulta_pedidos: Tfrm_consulta_pedidos;

implementation

uses
  Sistema.Controller.TelaPesquisaFactory, Sistema.Controller.Entidades.Factory, System.TypInfo, Datasnap.DBClient;

{$R *.dfm}


{ Tfrm_consulta_pedidos }

procedure Tfrm_consulta_pedidos.AlimentarCamposClientes;
begin
  for Var I := 0 to Pred(Self.pnlInformacoesCadastroClientes.ControlCount) do
    begin
      if Self.pnlInformacoesCadastroClientes.Controls[I] is TDBEdit then
        begin
          Var PropInfo := GetPropInfo(Self.pnlInformacoesCadastroClientes.Controls[I], 'DataSource');

          if PropInfo <> nil then
          begin
            SetObjectProp(Self.pnlInformacoesCadastroClientes.Controls[I], PropInfo, Self.FDataSourceClientes);
          end;
        end;
    end;
end;

procedure Tfrm_consulta_pedidos.AlimentarCamposEnderecoClientes;
begin
  for Var I := 0 to Pred(Self.pnlInformacoesCadastroEnderecoClientes.ControlCount) do
    begin
      if Self.pnlInformacoesCadastroEnderecoClientes.Controls[I] is TDBEdit then
        begin
          Var PropInfo := GetPropInfo(Self.pnlInformacoesCadastroEnderecoClientes.Controls[I], 'DataSource');

          if PropInfo <> nil then
          begin
            SetObjectProp(Self.pnlInformacoesCadastroEnderecoClientes.Controls[I], PropInfo, Self.FDataSourceEnderecos);
          end;
        end;
    end;
end;

procedure Tfrm_consulta_pedidos.BtnExcluirClick(Sender: TObject);
begin
  if not FDataSourcePedidos.DataSet.IsEmpty then
    begin
      FControllerEntidade.Pedidos.Deletar();
      FDataSourcePedidosItens.DataSet.Refresh;
    end;
end;

procedure Tfrm_consulta_pedidos.BtnExcluirProdutoPedidoClick(Sender: TObject);
begin
  if not FDataSourcePedidosItens.DataSet.IsEmpty then
    begin
      FControllerEntidade.PedidosItens.Deletar();
      CalcularTotal();
      CalcularTroco();
    end;
end;

procedure Tfrm_consulta_pedidos.btnIncluirProdutoClick(Sender: TObject);
begin
  if edtDescricao.Text = '' then
    raise Exception.Create('Selecione um produto');

  FControllerEntidade.PedidosItens
    .Dados
      .DefinirIdProduto(FDataSourceProdutos.DataSet.FieldByName('codigo').AsInteger)
      .DefinirIdPedido(FDataSourcePedidos.DataSet.FieldByName('codigo').AsInteger)
      .DefinirQuantidade(edtQuantidade.value)
      .DefinirValorTotalItem(FDataSourceProdutos.DataSet.FieldByName('preco_venda').AsFloat)
    .FimDoPreenchimento
    .Inserir;

   TClientDataSet(FDataSourcePedidosItens.DataSet).FindKey([FDataSourcePedidos.DataSet.FieldByName('codigo').AsInteger]);

  CalcularTotal();
  CalcularTroco();
end;

procedure Tfrm_consulta_pedidos.BtnInserirClick(Sender: TObject);
begin
  HabilitarDesabilitarPainel();
  NovoPedido();
end;

procedure Tfrm_consulta_pedidos.BtnPesquisaClientesClick(Sender: TObject);
begin
  TForm(
    TTelaPesquisaFactory
      .new
      .GetTela
      .SetTelaParametros
        .SetTipoDeTela(tpClientes)
        .SetClientDataSet(TClientDataSet(FDataSourceClientes.DataSet))
      .&End
      .Get
   ).ShowModal;

   TClientDataSet(FDataSourceEnderecos.DataSet).FindKey([FDataSourceClientes.DataSet.FieldByName('codigo').AsString]);

   AlimentarCamposClientes();
   AlimentarCamposEnderecoClientes();
end;

procedure Tfrm_consulta_pedidos.BtnPesquisarProdutosClick(Sender: TObject);
begin
  TForm(
    TTelaPesquisaFactory
      .new
      .GetTela
      .SetTelaParametros
        .SetTipoDeTela(tpProdutos)
        .SetClientDataSet(TClientDataSet(FDataSourceProdutos.DataSet))
      .&End
      .Get
   ).ShowModal;

  edtDescricao.DataSource := FDataSourceProdutos;
end;

procedure Tfrm_consulta_pedidos.CalcularTotal;
var
  lValorTotal: Double;
begin
  lValorTotal := 0;

  FDataSourcePedidosItens.DataSet.First;

  while not FDataSourcePedidosItens.DataSet.Eof do
    begin
      lValorTotal := lValorTotal +
        (FDataSourcePedidosItens.DataSet.FieldByName('valor_total_item').AsFloat *
         FDataSourcePedidosItens.DataSet.FieldByName('quantidade').AsFloat);

      FDataSourcePedidosItens.DataSet.Next;
    end;

  edtTotal.value := lValorTotal;
end;

procedure Tfrm_consulta_pedidos.CalcularTroco;
var
  lValorTroco: Double;
begin
 lValorTroco := edtValorPago.value - edtTotal.value;

 if lValorTroco < 0 then
  edtTroco.value := 0
 else
  edtTroco.value := lValorTroco;
end;

procedure Tfrm_consulta_pedidos.CarregarGridPedidos;
begin
  dbgRegistros.DataSource := FDataSourcePedidos;
end;

procedure Tfrm_consulta_pedidos.dbgRegistrosDblClick(Sender: TObject);
begin
  TClientDataSet(FDataSourceClientes.DataSet).FindKey([FDataSourcePedidos.DataSet.FieldByName('id_cliente').AsInteger]);
  TClientDataSet(FDataSourceEnderecos.DataSet).FindKey([FDataSourcePedidos.DataSet.FieldByName('id_cliente').AsInteger]);

  AlimentarCamposClientes();
  AlimentarCamposEnderecoClientes();
end;

procedure Tfrm_consulta_pedidos.edtQuantidadeExit(Sender: TObject);
begin
  if edtQuantidade.value <= 0 then
    edtQuantidade.value := 1;
end;

procedure Tfrm_consulta_pedidos.edtValorPagoExit(Sender: TObject);
begin
  CalcularTroco();
end;

procedure Tfrm_consulta_pedidos.FormCreate(Sender: TObject);
begin
  FControllerEntidade := TControllerEntidade.new();

  FDataSourcePedidos := TDataSource.Create(nil);
  FDataSourcePedidos.DataSet :=  TClientDataSet(FControllerEntidade.Pedidos.Listar);

  FDataSourcePedidosItens := TDataSource.Create(nil);
  FDataSourcePedidosItens.DataSet :=  TClientDataSet(FControllerEntidade.PedidosItens.Listar);

  FDataSourceProdutos := TDataSource.Create(nil);
  FDataSourceProdutos.DataSet := TClientDataSet(FControllerEntidade.Produtos.Listar());

  FDataSourceClientes := TDataSource.Create(nil);
  FDataSourceClientes.DataSet := TClientDataSet(FControllerEntidade.Clientes.Listar());

  FDataSourceEnderecos := TDataSource.Create(nil);
  FDataSourceEnderecos.DataSet :=  TClientDataSet(FControllerEntidade.Enderecos.Listar());
end;

procedure Tfrm_consulta_pedidos.FormDestroy(Sender: TObject);
begin
  FDataSourcePedidos.Free;
  FDataSourceProdutos.Free;
  FDataSourcePedidosItens.Free;
  FDataSourceEnderecos.Free;
  FDataSourceClientes.Free;
end;

procedure Tfrm_consulta_pedidos.FormShow(Sender: TObject);
begin
  CarregarGridPedidos();
  DBGridListaPedidosItens.DataSource := FDataSourcePedidosItens;
end;

procedure Tfrm_consulta_pedidos.HabilitarDesabilitarPainel;
begin
  if pnlCadastroPedido.Enabled then
    begin
      pnlCadastroPedido.Enabled := false;
      pnlCadastroPedido.Visible := false;
      pnlListaPedidos.Enabled := true;
      pnlListaPedidos.Visible := true;
    end
  else
    begin
      pnlCadastroPedido.Enabled := true;
      pnlCadastroPedido.Visible := true;
      pnlListaPedidos.Enabled := false;
      pnlListaPedidos.Visible := false;
    end;
end;

procedure Tfrm_consulta_pedidos.LimparCamposClientes;
begin
  for Var I := 0 to Pred(Self.pnlInformacoesCadastroClientes.ControlCount) do
    begin
      if Self.pnlInformacoesCadastroClientes.Controls[I] is TDBEdit then
        TDBEdit(Self.pnlInformacoesCadastroClientes.Controls[I]).Clear();
    end;

  for Var J := 0 to Pred(Self.pnlInformacoesCadastroEnderecoClientes.ControlCount) do
    begin
      if Self.pnlInformacoesCadastroEnderecoClientes.Controls[J] is TDBEdit then
        TDBEdit(Self.pnlInformacoesCadastroEnderecoClientes.Controls[J]).Clear();
    end;
end;

procedure Tfrm_consulta_pedidos.LimparCamposPedidos;
begin
  for Var I := 0 to Pred(Self.pnlInformacoesPedido.ControlCount) do
    begin
      if (Self.pnlInformacoesPedido.Controls[I] is TDBEdit)  then
        TDBEdit(Self.pnlInformacoesPedido.Controls[I]).Clear();
    end;
end;

procedure Tfrm_consulta_pedidos.LimparCamposProdutos;
begin
  edtDescricao.Clear;
end;

procedure Tfrm_consulta_pedidos.NovoPedido;
begin
  FControllerEntidade.Pedidos.Inserir();

  TClientDataSet(FDataSourcePedidosItens.DataSet).DisableControls;
  try
    TClientDataSet(FDataSourcePedidosItens.DataSet).Filter :=
    Format('id_pedido = %d ', [FDataSourcePedidos.DataSet.FieldByName('codigo').AsInteger]);

    TClientDataSet(FDataSourcePedidosItens.DataSet).Filtered := true;
  finally
    TClientDataSet(FDataSourcePedidosItens.DataSet).EnableControls;
  end;
end;

procedure Tfrm_consulta_pedidos.PnlCancelarClick(Sender: TObject);
begin
  HabilitarDesabilitarPainel();

  FControllerEntidade.Pedidos.Deletar();
  FDataSourcePedidosItens.DataSet.Refresh;

  LimparCamposProdutos();
  LimparCamposClientes();
  LimparCamposPedidos();
end;

procedure Tfrm_consulta_pedidos.PnlFinalizarClick(Sender: TObject);
begin
  if edtValorPago.value < edtTotal.value then
    raise Exception.Create('O valor pago é menor que o valor total.');

  CalcularTroco();

  FControllerEntidade.Pedidos
    .Dados
      .DefinirValorTotalPedido(edtTotal.Value)
      .DefinirValorPagoPedido(edtValorPago.Value)
      .DefinirValorTrocoPedido(edtTroco.Value)
      .DefinirIdClientePedido(FDataSourceClientes.DataSet.FieldByName('codigo').AsInteger)
      .FimDoPreenchimento
    .Editar;

  HabilitarDesabilitarPainel();

  LimparCamposProdutos();
  LimparCamposClientes();
  LimparCamposPedidos();
end;

end.
