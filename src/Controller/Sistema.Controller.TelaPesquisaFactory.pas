unit Sistema.Controller.TelaPesquisaFactory;

interface

uses
  Sistema.Crontroller.Interfaces;

type
  TTelaPesquisaFactory = class(TInterfacedObject, ITelaPesquisaFactory)
  private
  public
    function GetTela: ITela;
    class function new: ITelaPesquisaFactory;
  end;

implementation
{ TTelaPesquisaFactory }

uses
  Sistema.Controller.TelaPesquisa;

function TTelaPesquisaFactory.GetTela: ITela;
begin
  Result := TTela.new;
end;

class function TTelaPesquisaFactory.new: ITelaPesquisaFactory;
begin
  Result := Self.Create;
end;

end.
