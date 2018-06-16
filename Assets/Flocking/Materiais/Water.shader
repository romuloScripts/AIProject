Shader "Custom/Water" {
Properties {
	_Color ("Main Color", Color) = (1,1,1,1)
	_MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
	_ScrollXSpeed ("Velocidade X", Float) = 2
	_ScrollYSpeed ("Velocidade Y", Float) = 2
}

SubShader {
	Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
	LOD 200

CGPROGRAM
#pragma surface surf Lambert alpha

	sampler2D _MainTex;
	fixed4 _Color;
	fixed _ScrollXSpeed;
	fixed _ScrollYSpeed;
	
	struct Input {
		float2 uv_MainTex;
		float3 worldPos;
	};
	
	void surf (Input IN, inout SurfaceOutput o) {
		
		fixed2 scrolledUV = IN.uv_MainTex;
				
		fixed xScrollValue = _ScrollXSpeed * _Time;
		fixed yScrollValue = _ScrollYSpeed * _Time;
				
		scrolledUV += fixed2(xScrollValue, yScrollValue);
		
		fixed4 c = tex2D(_MainTex, scrolledUV) * _Color;
		o.Albedo = c.rgb;
		o.Alpha = c.a;
	}
	ENDCG
	}

Fallback "Transparent/VertexLit"
}