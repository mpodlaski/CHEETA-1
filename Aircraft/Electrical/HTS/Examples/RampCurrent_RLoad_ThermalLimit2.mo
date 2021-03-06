within CHEETA.Aircraft.Electrical.HTS.Examples;
model RampCurrent_RLoad_ThermalLimit2
  Modelica.Electrical.Analog.Sources.RampCurrent rampCurrent(
    I=6280.95,
    duration=15,
    offset=0.1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,-24})));
  Modelica.Electrical.Analog.Basic.Resistor resistor1(R=0)   annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,-24})));
  Modelica.Electrical.Analog.Basic.Ground ground2
    annotation (Placement(transformation(extent={{-34,-76},{-14,-56}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{-10,32},{-30,52}})));
  Modelica.Blocks.Sources.Constant const(k=20)
    annotation (Placement(transformation(extent={{36,32},{16,52}})));
  LiquidCooled.HTS_filmboiling_Current
                            HTS(
    l=10,
    n=20,
    I_c0=5000,
    A=0.1,
    A_cu=0.1,
    I_crit=3000,
    T_c(displayUnit="K"),
    R_L=3.3e-3,
    G_d=3.325e5,
    a(displayUnit="cm") = 0.256,
    b(displayUnit="cm") = 0.363,
    P=0.1) annotation (Placement(transformation(extent={{-46,24},{-30,16}})));
equation
  connect(rampCurrent.p,ground2. p) annotation (Line(points={{-70,-34},{-70,-56},
          {-24,-56}},      color={0,0,255}));
  connect(resistor1.n,ground2. p)
    annotation (Line(points={{-10,-34},{-10,-56},{-24,-56}},
                                                        color={0,0,255}));
  connect(prescribedTemperature.T, const.y)
    annotation (Line(points={{-8,42},{15,42}},   color={0,0,127}));
  connect(prescribedTemperature.port, HTS.port_a) annotation (Line(points={{-30,42},
          {-38,42},{-38,34},{-37.8,34},{-37.8,24}},     color={191,0,0}));
  connect(HTS.pin_p, rampCurrent.n)
    annotation (Line(points={{-47,20},{-70,20},{-70,-14}}, color={0,0,255}));
  connect(HTS.pin_n, resistor1.p)
    annotation (Line(points={{-29,20},{-10,20},{-10,-14}}, color={0,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=20,
      __Dymola_NumberOfIntervals=1000,
      __Dymola_Algorithm="Euler"));
end RampCurrent_RLoad_ThermalLimit2;
