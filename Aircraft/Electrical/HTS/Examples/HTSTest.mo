within CHEETA.Aircraft.Electrical.HTS.Examples;
model HTSTest
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-8,-52},{12,-32}})));
  HTS_Piline
         hTS_Piline(
    l=10,
    n=20,
    R_L=0.1,
    a(displayUnit="mm") = 0.0037,
    b(displayUnit="mm") = 0.00615,
    resistor(v(start=-4.1359030627651384E-25)),
    UIC=false,
    IC=0.1)
    annotation (Placement(transformation(extent={{-6,6},{10,-2}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T(
        displayUnit="K") = 77)
    annotation (Placement(transformation(extent={{-58,10},{-38,30}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G=0.1)
           annotation (Placement(transformation(extent={{-28,10},{-8,30}})));
  Modelica.Electrical.Analog.Sources.RampVoltage rampVoltage(
    V=0.5,                                                          duration=5,
    offset=0.001)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-18,-18})));
equation
  connect(hTS_Piline.pin_n, ground.p) annotation (Line(points={{11,2},{20,2},{
          20,-32},{2,-32}}, color={0,0,255}));
  connect(fixedTemperature.port,thermalConductor. port_a)
    annotation (Line(points={{-38,20},{-28,20}}, color={191,0,0}));
  connect(thermalConductor.port_b, hTS_Piline.port_a)
    annotation (Line(points={{-8,20},{2,20},{2,6}}, color={191,0,0}));
  connect(rampVoltage.p, hTS_Piline.pin_p)
    annotation (Line(points={{-18,-8},{-18,2},{-7,2}}, color={0,0,255}));
  connect(rampVoltage.n, ground.p)
    annotation (Line(points={{-18,-28},{-18,-32},{2,-32}}, color={0,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=10, __Dymola_Algorithm="Dassl"));
end HTSTest;
