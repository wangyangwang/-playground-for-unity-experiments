Shader "Custom/SinWaveDistor"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
        _DistorationIntensity ("_Distoration Intensity", Range(0.0,1.0)) = 0.0


	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
            float _DistorationIntensity;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
                //float4 worldPos = mul(_Object2World,o.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                float3 lerpedVer = lerp(0,4,o.vertex);
                o.vertex.x += sin(lerpedVer.y * 1.4 + _Time.y) * _DistorationIntensity - 0.5;
                //o.vertex.y += sin(lerpedVer.x * 1.4 + _Time.y) * _DistorationIntensity - 0.5;
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				fixed4 col = tex2D(_MainTex, i.uv);
				// apply fog
				UNITY_APPLY_FOG(i.fogCoord, col);
				return col;
			}
			ENDCG
		}
	}
}
