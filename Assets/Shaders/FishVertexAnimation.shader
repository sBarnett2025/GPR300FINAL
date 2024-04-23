Shader "Custom/FishVertexAnimation"
{
    Properties
    {
        _BaseMap("Base Map", 2D) = "white" {}
        _Color("Color", Color) = (1,1,1,1)

        _AnimationSpeed("Animation Speed", Range(0, 10)) = 0.5
        _Scale("Scale", Range(0, 1)) = 0.8
        _Yaw("Yaw", Float) = 0.2
        _Roll("Roll", Float) = 0.2

        _EffectRadius("Wave Effect Radius",Range(0.0,1.0)) = 0.5
        _WaveSpeed("Wave Speed", Range(0.0,100.0)) = 3.0
        _WaveHeight("Wave Height", Range(0.0,30.0)) = 5.0
        _WaveDensity("Wave Density", Range(0.0001,1.0)) = 0.007
        _Yoffset("Y Offset",Float) = 0.0
        _Threshold("Threshold",Range(0,30)) = 3 
        _StrideSpeed("Stride Speed",Range(0.0,10.0)) = 2.0
        _StrideStrength("Stride Strength", Range(0.0,20.0)) = 3.0
        _MoveOffset("Move Offset",Float) = 0.0

        _TranslationAmount("Translation amount", float) = 1
        _DisplacementAmount("Displacement amount", float) = 1
        _DisplacementSpeed("Displacement speed", float) = 1
        _MaskOffset("Mask offset", Range(0, 1)) = 0


    }

    SubShader
    {
        Tags { "RenderType" = "Opaque" "RenderPipeline" = "UniversalPipeline" }

        Pass
        {
            HLSLPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            struct VertexInput
            {
                float4 positionOS   : POSITION;
                float2 uv: TEXCOORD0;
            };

            struct VertexOutput
            {
                float4 positionCS  : SV_POSITION;
                float2 uv: TEXCOORD0;
            };

            TEXTURE2D(_BaseMap);
            SAMPLER(sampler_BaseMap);

            CBUFFER_START(UnityPerMaterial)
            float4 _Color;
            float4 _BaseMap_ST;

            float _AnimationSpeed;
            float _Scale;
            float _Yaw;
            float _Roll;

            half _EffectRadius;
            half _WaveSpeed;
            half _WaveHeight;
            half _WaveDensity;
            half _Yoffset;
            int _Threshold;
            half _StrideSpeed;
            half _StrideStrength;
            half _MoveOffset;


            float _MaskOffset;
            float _TranslationAmount;
            float _DisplacementAmount;
            float _DisplacementSpeed;



            CBUFFER_END

            VertexOutput vert(VertexInput IN)
            {
                
                
                // https://halisavakis.com/my-take-on-shaders-butterflies-and-fish-shader/
                VertexOutput OUT;
                float mask = saturate(sin((IN.uv.x + _MaskOffset) * 3.1415f));
                OUT.positionCS = TransformObjectToHClip(IN.positionOS.xyz
                    += ((sin(((_Time.w * _AnimationSpeed)
                    + (IN.positionOS.z * _Yaw)
                    + (IN.positionOS.y * _Roll))) * _Scale)
                    * float3(1, 0, 0)));
                OUT.uv = TRANSFORM_TEX(IN.uv, _BaseMap);

                return OUT;
                

                /*
                // https://www.bitshiftprogrammer.com/2018/01/how-to-animate-fish-swimming-with.html
                VertexOutput OUT;
                half sinUse = sin(-_Time.w * _WaveSpeed + _MoveOffset + IN.positionOS.y * _WaveDensity);
                half yValue = IN.positionOS.y - _Yoffset;
                half yDirScaling = clamp(pow(yValue * _EffectRadius,_Threshold),0.0,1.0);
                IN.positionOS.x = IN.positionOS.x + sinUse * _WaveHeight* yDirScaling;
                IN.positionOS.x = IN.positionOS.x + sin(-_Time.w * _StrideSpeed + _MoveOffset) * _StrideStrength;
                OUT.positionCS = UnityObjectToClipPos(IN.positionOS);
                OUT.uv = TRANSFORM_TEX(IN.uv, _MainTex);
                UNITY_TRANSFER_FOG(OUT,OUT.positionCS);
                return OUT;
                */

                /*
                // https://halisavakis.com/my-take-on-shaders-butterflies-and-fish-shader/
                VertexOutput OUT;
                float mask = saturate(sin((IN.uv.x + _MaskOffset) * 3.1415f));
                IN.positionOS.x += sin(_Time.y * _DisplacementSpeed) * _TranslationAmount;
                IN.positionOS.x += sin(IN.uv.x * 3.1415f + _Time.y * _DisplacementSpeed) * _DisplacementAmount * mask;
                OUT.positionCS = TransformObjectToHClip(IN.positionOS);
                OUT.uv = TRANSFORM_TEX(IN.uv, _BaseMap);
                return OUT;
                */

            }

            half4 frag(VertexOutput IN) : SV_Target
            {
                float4 texel = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, IN.uv);
                return texel * _Color;
            }
            ENDHLSL
        }
    }
}