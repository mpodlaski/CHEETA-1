within CHEETA.Aircraft.Electrical.FuelCell;
model SimplifiedFuelCell
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=V/2)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-38,4})), __Dymola_choicesAllMatching=true);
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={2,20})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p annotation (Placement(
        transformation(extent={{60,30},{80,50}}), iconTransformation(extent={{
            60,30},{80,50}})));
  parameter Modelica.SIunits.Resistance R "Impedance";
  parameter Modelica.SIunits.Inductance L "Impedance";
  parameter Modelica.SIunits.Voltage V=1000 "Fuel cell voltage";
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage1(V=V/2)
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-38,-26})),
                          __Dymola_choicesAllMatching=true);
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-62,-34},{-42,-14}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor1(R=R)
                                                          annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={2,-40})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p1
                                                          annotation (Placement(
        transformation(extent={{54,-50},{74,-30}}),
                                                  iconTransformation(extent={{60,-50},
            {80,-30}})));
equation
  connect(constantVoltage.p, resistor.p)
    annotation (Line(points={{-38,14},{-38,20},{-8,20}}, color={0,0,255}));
  connect(ground.p, constantVoltage.n) annotation (Line(points={{-52,-14},{-52,
          -12},{-38,-12},{-38,-6}}, color={0,0,255}));
  connect(constantVoltage1.p, constantVoltage.n)
    annotation (Line(points={{-38,-16},{-38,-6}}, color={0,0,255}));
  connect(constantVoltage1.n, resistor1.p)
    annotation (Line(points={{-38,-36},{-38,-40},{-8,-40}}, color={0,0,255}));
  connect(resistor.n, pin_p) annotation (Line(points={{12,20},{40,20},{40,40},{
          70,40}}, color={0,0,255}));
  connect(resistor1.n, pin_p1)
    annotation (Line(points={{12,-40},{64,-40}}, color={0,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-60,-60},
            {60,60}}), graphics={Rectangle(extent={{-60,60},{60,-60}},
            lineColor={28,108,200})}), Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-60,-60},{60,60}})));
end SimplifiedFuelCell;
