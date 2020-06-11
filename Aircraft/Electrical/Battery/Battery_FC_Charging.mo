within CHEETA.Aircraft.Electrical.Battery;
model Battery_FC_Charging
  import Battery;
  parameter Real batteryVoltage = 900 "Minimum bus voltage needed to turn on the battery";
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(transformation(extent={{28,-34},
            {48,-14}})));
  Battery.Packs.Scaled.ScaledPackCylindric batteryPack(
    N_verticalElements=3,
    SOC_init=0.6,
    redeclare Battery.Cells.Variants.DemoCell3dSDF cell,
    N_serialCells=250,
    N_parallelCells=5,
    redeclare Battery.Packs.Scaled.Housings.IdealHousingCylindric housing,
    T_init=300.15)
    annotation (Placement(transformation(extent={{4,50},{28,74}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature     [batteryPack.N_x, batteryPack.N_y]
    packBottomTemperatureBoundary(T=298.15)
                                  "Fixed housing temperature boundary"
    annotation (Placement(transformation(extent={{108,-8},{88,12}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature[batteryPack.N_x, batteryPack.N_y]
    packTopTemperatureBoundary(each T(displayUnit="degC") = 298.15)
    "Fixed housing temperature boundary on the top"
    annotation (Placement(transformation(extent={{108,32},{88,52}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature[batteryPack.N_y, batteryPack.N_z]
    packLeftRightTemperatureBoundary(each T(displayUnit="degC") = 298.15)
    "Fixed housing temperature boundary left and right"
    annotation (Placement(transformation(extent={{108,-48},{88,-28}})));
public
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature[batteryPack.N_y, batteryPack.N_z]
    packFrontBackTemperatureBoundary(each T(displayUnit="degC") = 298.15)
    "Fixed housing temperature boundary front and back"
    annotation (Placement(transformation(extent={{108,-88},{88,-68}})));
  ElectrifiedPowertrains.PowerElectronics.Converters.Averaged.CurrentInputConstantEfficiency
                                                         converterVoltageInput1(
      redeclare
      ElectrifiedPowertrains.PowerElectronics.Converters.Averaged.Records.Data.ConstantEfficiency.Constant100percent
      data)                                                   annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-68,78})));
  Modelica.Electrical.Analog.Interfaces.PositivePin p1
    "Positive pin of the left port (potential p.v > n.v for positive voltage drop v)"
    annotation (Placement(transformation(extent={{-60,90},{-40,110}}),
        iconTransformation(extent={{-60,90},{-40,110}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n1 "Negative pin of the left port"
    annotation (Placement(transformation(extent={{40,90},{60,110}}),
        iconTransformation(extent={{40,90},{60,110}})));
  BMS bms(N_parallelCells=5, N_cells=batteryPack.N_x*batteryPack.N_y)
    annotation (Placement(transformation(extent={{-12,0},{-36,22}})));
  Modelica.Blocks.Interfaces.BooleanInput u1 annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={140,20})));
protected
  Battery.Common.Interfaces.HousingHeatPort housingHeatPort(
    N_x=batteryPack.N_x,
    N_y=batteryPack.N_y,
    N_z=batteryPack.N_z,
    pinHeatTransfer=false) annotation (Placement(transformation(extent={{30,72},
            {90,92}})));
equation
  connect(packTopTemperatureBoundary.port,housingHeatPort. top)
    annotation (Line(points={{88,42},{60.0625,42},{60.0625,82.05}},        color={191,0,0}));
  connect(batteryPack.housingHeatPort,housingHeatPort)
    annotation (Line(points={{16,74},{16,82},{60,82}},         color={255,0,0}));
  connect(packBottomTemperatureBoundary.port,housingHeatPort. bottom)
    annotation (Line(points={{88,2},{60.0625,2},{60.0625,82.05}},                            color={191,0,0}));
  connect(packLeftRightTemperatureBoundary.port,housingHeatPort. left)
    annotation (Line(points={{88,-38},{60.0625,-38},{60.0625,82.05}},                  color={191,0,0}));
  connect(packLeftRightTemperatureBoundary.port,housingHeatPort. right)
    annotation (Line(points={{88,-38},{60.0625,-38},{60.0625,82.05}},        color={191,0,0}));
  connect(packFrontBackTemperatureBoundary.port,housingHeatPort. front)
    annotation (Line(points={{88,-78},{60.0625,-78},{60.0625,82.05}},        color={191,0,0}));
  connect(packFrontBackTemperatureBoundary.port,housingHeatPort. back)
    annotation (Line(points={{88,-78},{60.0625,-78},{60.0625,82.05}},                                   color={191,0,0}));
  connect(batteryPack.n, ground.p) annotation (Line(points={{28,62},{38,62},{38,
          -14}},                         color={0,0,255}));
  connect(converterVoltageInput1.p2, batteryPack.p)
    annotation (Line(points={{-58,84},{-28,84},{-28,62},{4,62}},
                                                 color={0,0,255}));
  connect(converterVoltageInput1.n2, ground.p) annotation (Line(points={{-58,72},
          {-8,72},{-8,44},{38,44},{38,-14}},                         color={0,0,
          255}));
  connect(converterVoltageInput1.p1, p1) annotation (Line(points={{-78,84},{
          -106,84},{-106,100},{-50,100}}, color={0,0,255}));
  connect(converterVoltageInput1.n1, n1) annotation (Line(points={{-78,72},{-92,
          72},{-92,100},{50,100}}, color={0,0,255}));
  connect(batteryPack.packBus, bms.packBus1) annotation (Line(
      points={{16,50},{16,40},{-24,40},{-24,22}},
      color={83,189,255},
      thickness=0.5));
  connect(bms.i, converterVoltageInput1.i)
    annotation (Line(points={{-37,10},{-60,10},{-60,66}}, color={0,0,127}));
  connect(bms.pin, p1) annotation (Line(points={{-12,10},{16,10},{16,-10},{-120,
          -10},{-120,100},{-50,100}}, color={0,0,255}));
  connect(bms.u, u1) annotation (Line(points={{-9.8,16},{10,16},{10,20},{140,20}},
        color={255,0,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,-100},{180,
            120}}), graphics={
        Rectangle(
          extent={{-80,72},{80,-68}},
          lineColor={95,95,95},
          fillPattern=FillPattern.Solid,
          fillColor={215,215,215}),
        Line(
          points={{-50,102},{-50,72}},
          color={95,95,95},
          smooth=Smooth.None),
        Line(
          points={{50,102},{50,72}},
          color={95,95,95},
          smooth=Smooth.None),
        Text(
          extent={{-50,66},{-90,106}},
          lineColor={95,95,95},
          textString="+"),
        Text(
          extent={{92,68},{52,108}},
          lineColor={95,95,95},
          textString="-"),
        Line(
          points={{-60,-46},{-60,34}},
          color={95,95,95},
          smooth=Smooth.None),
        Line(
          points={{-40,-46},{-40,34}},
          color={95,95,95},
          smooth=Smooth.None),
        Line(
          points={{-20,-46},{-20,34}},
          color={95,95,95},
          smooth=Smooth.None),
        Line(
          points={{0,-46},{0,34}},
          color={95,95,95},
          smooth=Smooth.None),
        Line(
          points={{20,-46},{20,34}},
          color={95,95,95},
          smooth=Smooth.None),
        Line(
          points={{40,-46},{40,34}},
          color={95,95,95},
          smooth=Smooth.None),
        Line(
          points={{60,-46},{60,34}},
          color={95,95,95},
          smooth=Smooth.None)}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-160,-100},{
            180,120}})),
    experiment(StopTime=10800, __Dymola_Algorithm="Dassl"));
end Battery_FC_Charging;
