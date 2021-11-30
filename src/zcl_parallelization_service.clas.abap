class zcl_parallelization_service definition
  public
  final
  create public .

  public section.
    interfaces zif_parallelization_service .

  protected section.
  private section.
endclass.



class zcl_parallelization_service implementation.
  method zif_parallelization_service~start.
    data(settings) = zcl_aps_settings_factory=>provide(
                       i_appid    = i_appId
                       i_configid = i_configId
                     ).

    data(objects) = zcl_aps_objectSelectorFactory=>provideObjectSelector( settings )->calculateObjects(
                      i_settings        = settings
                      i_infoFromCaller  = i_infoFromCaller
                    ).

    data(packages) = zcl_aps_object_packetizer_fact=>provide( settings )->packetize( objects ).

    zcl_aps_task_starter_factory=>provide( settings )->start( packages ).
  endmethod.

endclass.
