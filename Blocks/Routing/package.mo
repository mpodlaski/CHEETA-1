within CHEETA.Blocks;
package Routing
    model RealExtract
    "Pass a Real signal through without modification"
    parameter Integer index= 3 "output which variable in the array";

    Modelica.Blocks.Interfaces.RealInput u[3]
      annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
    Modelica.Blocks.Interfaces.RealOutput y
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    equation
    y = u[index];
    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={Line(points={{-100,0},{100,0}},
              color={0,0,127}), Rectangle(extent={{-100,100},{100,-100}},
              lineColor={28,108,200}),
          Line(points={{-80,80}}, color={28,108,200}),
          Line(points={{-100,60},{0,60},{100,0}}, color={28,108,200}),
          Line(points={{-80,0},{0,0}}, color={255,0,0}),
          Line(points={{-100,-60},{0,-60}}, color={255,0,0}),
          Rectangle(
            extent={{0,20},{4,-20}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{0,-40},{4,-80}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid)}),
                      Documentation(info="<html>
<p>
Passes a Real signal through without modification.  Enables signals to be read out of one bus, have their name changed and be sent back to a bus.
</p>
</html>"));
    end RealExtract;

  model RealExtend
    "Pass a Real signal through without modification"

    Modelica.Blocks.Interfaces.RealInput u
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
          iconTransformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.RealOutput y[3]
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  equation
    y = {u,u,u};
    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={Line(points={{-100,0},{100,0}},
              color={0,0,127}), Rectangle(extent={{-100,100},{100,-100}},
              lineColor={28,108,200}),
          Line(points={{-80,0}}, color={81,255,0}),
          Line(points={{-100,0},{0,60},{100,60}},color={28,108,200}),
          Line(points={{-100,0},{100,0},{100,-60},{0,-60},{-100,0}},
                                                                   color={28,
                108,200})}),
                      Documentation(info="<html>
<p>
Passes a Real signal through without modification. 
This enables a single input to enter the system, then translates the signal into an array.
</p>
</html>"));
  end RealExtend;

  model RealExtendMultiple
    "Pass a Real signal through without modification"

    Modelica.Blocks.Interfaces.RealInput u
      annotation (Placement(transformation(extent={{-120,40},{-80,80}})));
    Modelica.Blocks.Interfaces.RealOutput y[3]
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.RealInput u1
      annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
    Modelica.Blocks.Interfaces.RealInput u2
      annotation (Placement(transformation(extent={{-120,-80},{-80,-40}})));
  equation
    y = {u,u1,u2};
    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={Line(points={{-100,0},{100,0}},
              color={0,0,127}), Rectangle(extent={{-100,100},{100,-100}},
              lineColor={28,108,200}),
          Line(points={{-80,0}}, color={81,255,0}),
          Line(points={{-80,0},{0,60},{100,60}}, color={28,108,200}),
          Line(points={{-80,0},{100,0},{100,-60},{0,-60},{-80,0}}, color={28,108,200})}),
                      Documentation(info="<html>
<p>
Passes a Real signal through without modification.  Enables signals to be read out of one bus, have their name changed and be sent back to a bus.
</p>
</html>"));
  end RealExtendMultiple;

  model VectorInput
    "Duplicates a single input signal into multiple output signals"
    extends Modelica.Blocks.Icons.Block;
    parameter Integer n(min=1) = 1 "Number of output signals required";
    Modelica.Blocks.Interfaces.RealInput u "Connector of Real input signal"
                                       annotation(Placement(transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.RealVectorOutput y[n]
      "Connector of Real output signals"
                                        annotation(Placement(transformation(extent={{80,70},{120,-70}})));

  equation
    for i in 1:n loop
      y[i] = u;
    end for
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
    annotation (Icon(graphics={
          Line(
            points={{-100,0},{-20,2}},
            color={217,67,180},
            thickness=1),
          Line(
            points={{-98,-2},{-40,-2},{-54,2}},
            color={238,46,47},
            thickness=1),
          Line(
            points={{-98,0},{100,70}},
            color={238,46,47},
            thickness=1),
          Rectangle(
            extent={{-68,52},{38,-30}},
            lineColor={238,46,47},
            lineThickness=1),
          Bitmap(extent={{-88,60},{64,-56}}, fileName=""),
          Bitmap(extent={{-90,-72},{90,74}}, fileName=
                "modelica://ArduinoProjects/multiinput.png"),
          Text(
            textString="Edit Here",
            extent={{-50,82},{40,32}},
            lineColor={238,46,47},
            lineThickness=1)}));
  end VectorInput;

annotation (Icon(graphics={
        Rectangle(
          lineColor={200,200,200},
          fillColor={248,248,248},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100.0,-100.0},{100.0,100.0}},
          radius=25.0),
        Rectangle(
          lineColor={128,128,128},
          extent={{-100.0,-100.0},{100.0,100.0}},
          radius=25.0),
        Line(points={{-90,0},{4,0}}, color={95,95,95}),
        Line(points={{88,65},{48,65},{-8,0}}, color={95,95,95}),
        Line(points={{-8,0},{93,0}}, color={95,95,95}),
        Line(points={{87,-65},{48,-65},{-8,0}}, color={95,95,95})}));
end Routing;
