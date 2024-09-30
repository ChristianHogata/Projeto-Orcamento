unit Sistema.Model.DataSetFactory;

interface

uses
  Sistema.Model.Interfaces;

type
  TModelDataSetFactory = class(TInterfacedObject, IModelDataSetFactory)
  private

  public
    class function new: IModelDataSetFactory;
    function dataSet: IModelDataSet;
  end;

implementation

uses
  Sistema.Model.DataSet, Sistema.Model.ConexaoFactory;

{ TModelDataSetFactory }

function TModelDataSetFactory.dataSet: IModelDataSet;
begin
  Result := TModelDataSet.new;
end;

class function TModelDataSetFactory.new: IModelDataSetFactory;
begin
  Result := Self.Create;
end;

end.
