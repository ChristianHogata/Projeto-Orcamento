unit Sistema.Controller.TelaPesquisa;

interface

uses
  Sistema.Crontroller.Interfaces, System.Classes, Vcl.Forms, Vcl.Buttons,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB, Winapi.Windows, Datasnap.DBClient;

type
  TTela = class(TInterfacedObject, ITela, ITelaParametros)
  private
    FTipoTela: TTipoTela;
    FFormulario: TForm;
    FBotaoPesquisar: TSpeedButton;
    FDbGridPesquisa: TDBGrid;
    FEdtNomeDescricao: TEdit;
    FPainelPesquisa: TPanel;
    FDataSourcePesquisa: TDataSource;
    FLabelNomeDescricao: TLabel;
    Constructor Create;
    procedure CriarFormulario;
    procedure CriarComponentes;
    procedure CriarPainel;
    procedure CriarBotaoPesquisa;
    procedure CriarGrid;
    procedure CriarEditPesquisa;
    procedure CriarLabelPesquisa;
    procedure FiltrarDataSourcePesquisa(Sender: TObject);
  public
    destructor Destroy; override;
    function SetTelaParametros: ITelaParametros;
    function Get: TComponent;
    function SetTipoDeTela(pTipoTela: TTipoTela): ITelaParametros;
    function SetClientDataSet(pClientDataSet: TClientDataSet): ITelaParametros;
    function &End: ITela;
    class function new: ITela;
  end;

implementation

uses
  Vcl.Controls, System.SysUtils;

{ TTela }

constructor TTela.Create;
begin
  FTipoTela := tpClientes;
  FDataSourcePesquisa := TDataSource.Create(nil);
end;

procedure TTela.CriarBotaoPesquisa;
begin
  FBotaoPesquisar := TSpeedButton.Create(nil);
  FBotaoPesquisar.Parent := FPainelPesquisa;
  FBotaoPesquisar.Cursor := crHandPoint;
  FBotaoPesquisar.Top := 32;
  FBotaoPesquisar.Width := 128;
  FBotaoPesquisar.Height := 47;
  FBotaoPesquisar.Left := 368;
  FBotaoPesquisar.Caption := 'Pesquisar';
  FBotaoPesquisar.Font.Size := 10;
  FBotaoPesquisar.OnClick := FiltrarDataSourcePesquisa;
end;

procedure TTela.CriarComponentes;
begin
  CriarPainel();
  CriarGrid();
  CriarEditPesquisa();
  CriarLabelPesquisa();
  CriarBotaoPesquisa();
end;

procedure TTela.CriarEditPesquisa;
begin
  FEdtNomeDescricao := TEdit.Create(nil);
  FEdtNomeDescricao.Parent := FPainelPesquisa;
  FEdtNomeDescricao.Top := 48;
  FEdtNomeDescricao.Width := 345;
  FEdtNomeDescricao.Height := 31;
  FEdtNomeDescricao.Font.Size := 10;
  FEdtNomeDescricao.Left := 5;
end;

procedure TTela.CriarFormulario;
begin
  FFormulario := TForm.Create(nil);
  FFormulario.Width := 731;
  FFormulario.Height := 346;
  FFormulario.BorderStyle := bsDialog;
  FFormulario.Position := poDesktopCenter;
end;

procedure TTela.CriarGrid;
begin
  FDbGridPesquisa := TDBGrid.Create(nil);
  FDbGridPesquisa.Parent := FPainelPesquisa;
  FDbGridPesquisa.Top := 96;
  FDbGridPesquisa.Width := 713;
  FDbGridPesquisa.Height := 201;
  FDbGridPesquisa.DataSource := FDataSourcePesquisa;
end;

procedure TTela.CriarLabelPesquisa;
begin
  FLabelNomeDescricao := TLabel.Create(nil);
  FLabelNomeDescricao.Parent := FPainelPesquisa;

  case FTipoTela of
    tpClientes: FLabelNomeDescricao.Caption := 'Nome';
    tpProdutos: FLabelNomeDescricao.Caption := 'Descri��o';
  end;

  FLabelNomeDescricao.Top := 19;
  FLabelNomeDescricao.Width := 127;
  FLabelNomeDescricao.Height := 23;
  FLabelNomeDescricao.Left := 5;
end;

procedure TTela.CriarPainel;
begin
  FPainelPesquisa := TPanel.Create(nil);
  FPainelPesquisa.Parent := FFormulario;
  FPainelPesquisa.Align := alClient;
  FPainelPesquisa.BorderStyle := bsNone;
  FPainelPesquisa.BevelOuter := bvNone;
  FPainelPesquisa.Caption := '';
end;

destructor TTela.Destroy;
begin
  FFormulario.Free;
  FDataSourcePesquisa.Free;
  inherited;
end;

function TTela.&End: ITela;
begin
  Result := Self;
end;

procedure TTela.FiltrarDataSourcePesquisa(Sender: TObject);
begin

  case FTipoTela of
    tpClientes: FDataSourcePesquisa.DataSet.Filter := 'UPPER(nome) like UPPER(''' + ''+Trim(UpperCase(FEdtNomeDescricao.Text))+'' + '%'')';
    tpProdutos: FDataSourcePesquisa.DataSet.Filter := 'UPPER(descricao) like UPPER(''' + ''+Trim(UpperCase(FEdtNomeDescricao.Text))+'' + '%'')';
  end;

  FDataSourcePesquisa.DataSet.Filtered := true;
end;

function TTela.Get: TComponent;
begin
  CriarFormulario();
  CriarComponentes();
  FDataSourcePesquisa.DataSet.Filtered := false;
  Result := FFormulario;
end;

class function TTela.new: ITela;
begin
  Result := Self.Create();
end;

function TTela.SetClientDataSet(pClientDataSet: TClientDataSet): ITelaParametros;
begin
  FDataSourcePesquisa.DataSet := pClientDataSet;
  Result := Self;
end;

function TTela.SetTelaParametros: ITelaParametros;
begin
  Result := Self;
end;

function TTela.SetTipoDeTela(pTipoTela: TTipoTela): ITelaParametros;
begin
  FTipoTela := pTipoTela;
  Result := Self;
end;

end.
