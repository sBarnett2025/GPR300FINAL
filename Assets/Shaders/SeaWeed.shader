// DONE BY SAMUEL BARNETT
Shader "Custom/SeaWeed"
{
    Properties
    {
        _BaseMap("Base Map", 2D) = "white" {}
        _Color("Color", Color) = (1,1,1,1)

        _AnimationSpeed("Animation Speed", Range(0, 10)) = 0.5
        _Scale("Scale", Range(0, 1)) = 0.8
        _Yaw("Yaw", Float) = 0.2
        _Roll("Roll", Float) = 0.2
        _Pitch("Pitch", Float) = 0.2

        _MaskOffset("Mask offset", Range(-1, 1)) = 0

        _PerlinTexture("Perlin Noise", 2D) = "white" {}
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
            float _Pitch;

            half _MaskOffset;

            TEXTURE2D(_PerlinTexture);
            SAMPLER(sampler_PerlinTexture);

            CBUFFER_END

            VertexOutput vert(VertexInput IN)
            {

                VertexOutput OUT;
                OUT.positionCS = TransformObjectToHClip(IN.positionOS.xyz
                    += ((sin(((_Time.w * _AnimationSpeed)
                    + (IN.positionOS.x * _Yaw)
                    + (IN.positionOS.y * _Roll)
                    + (IN.positionOS.z * _Pitch))) * _Scale)
                    * float3(1, 0, 1)));
                OUT.uv = TRANSFORM_TEX(IN.uv, _BaseMap);

                return OUT;
                
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
