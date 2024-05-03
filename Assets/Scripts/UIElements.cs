// DONE BY SAMUEL BARNETT
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class UIElements : MonoBehaviour
{
    bool active1, active2, active3, active4;

    // water surface
    [Header("Surface Settings")]
    public Material waterSurfaceMat;
    public Slider waterDepth;
    public Slider waterDepthGradient;
    public Slider waterNMTilingX;
    public Slider waterNMTilingY;
    public Slider waterSmoothness;
    public Slider waterStrength;
    public Slider waterDisplacement;

    // water caustic
    [Header("Caustic Settings")]
    public Material causticMat;
    public Slider causticFPS;
    public Slider causticStrength;

    // fish
    [Header("Fish Settings")]
    public Material fishMat;
    public Slider fishAnimationSpeed;
    public Slider fishAnimationScale;
    public Slider fishYaw;
    public Slider fishRoll;
    public Slider fishMask;

    // seaweed
    [Header("Seaweed Settings")]
    public Material seaweedMat;
    public Slider seaweedSpeed;
    public Slider seaweedScale;
    public Slider seaweedYaw;
    public Slider seaweedRoll;
    public Slider seaweedPitch;

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.U))
        {
            active1 = false;
            active2 = false;
            active3 = false;
            active4 = false;
        }

        if (Input.GetKeyDown(KeyCode.Alpha1))
        {
            active1 = true;
            active2 = false;
            active3 = false;
            active4 = false;
        }
        if (Input.GetKeyDown(KeyCode.Alpha2))
        {
            active1 = false;
            active2 = true;
            active3 = false;
            active4 = false;
        }
        if (Input.GetKeyDown(KeyCode.Alpha3))
        {
            active1 = false;
            active2 = false;
            active3 = true;
            active4 = false;
        }
        if (Input.GetKeyDown(KeyCode.Alpha4))
        {
            active1 = false;
            active2 = false;
            active3 = false;
            active4 = true;
        }
        transform.GetChild(0).gameObject.SetActive(active1);
        transform.GetChild(1).gameObject.SetActive(active2);
        transform.GetChild(2).gameObject.SetActive(active3);
        transform.GetChild(3).gameObject.SetActive(active4);


        // water surface
        waterSurfaceMat.SetFloat("_Depth", waterDepth.value);
        waterSurfaceMat.SetFloat("_DepthGradentStreangth", waterDepthGradient.value);
        waterSurfaceMat.SetFloat("_Smoothness", waterSmoothness.value);
        waterSurfaceMat.SetVector("_NMTiling", new Vector2(waterNMTilingX.value, waterNMTilingY.value));
        waterSurfaceMat.SetFloat("_NormalStreangth", waterStrength.value);
        waterSurfaceMat.SetFloat("_Displacement", waterDisplacement.value);

        // water caustics
        causticMat.SetFloat("_FPS", causticFPS.value);
        causticMat.SetFloat("_Strength", causticStrength.value);

        // fish
        fishMat.SetFloat("_AnimationSpeed", fishAnimationSpeed.value);
        fishMat.SetFloat("_Scale", fishAnimationScale.value);
        fishMat.SetFloat("_Yaw", fishYaw.value);
        fishMat.SetFloat("_Roll", fishRoll.value);
        fishMat.SetFloat("_MaskOffset", fishMask.value);

        // seaweed
        seaweedMat.SetFloat("_AnimationSpeed", seaweedSpeed.value);
        seaweedMat.SetFloat("_Scale", seaweedScale.value);
        seaweedMat.SetFloat("_Yaw", seaweedYaw.value);
        seaweedMat.SetFloat("_Roll", seaweedRoll.value);
        seaweedMat.SetFloat("_Pitch", seaweedPitch.value);
    }




}
