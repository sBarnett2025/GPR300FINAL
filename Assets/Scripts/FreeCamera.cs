// DONE BY SAMUEL BARNETT
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FreeCamera : MonoBehaviour
{
    public float moveSpeed = 5f; // Speed of camera movement
    public float lookSpeed = 2f; // Speed of camera rotation
    public float verticalLookLimit = 80f; // Limit of vertical camera rotation
    public float verticalMoveSpeed = 2f; // Speed of camera vertical movement

    private float rotationX = 0;

    public Transform carp;

    bool lockCamera;

    // Start is called before the first frame update
    void Start()
    {
        Cursor.visible = false;
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.B))
        {
            if (transform.parent != carp)
            {
                transform.parent = carp;
                transform.localPosition = Vector3.forward;
            }
            else
            {
                transform.parent = null;
            }
        }

        if (Input.GetKeyDown(KeyCode.L))
        {
            lockCamera = !lockCamera;
        }

        if (!lockCamera)
        {
            // Move the camera
            float horizontalInput = Input.GetAxis("Horizontal");
            float verticalInput = Input.GetAxis("Vertical");
            float verticalMovement = 0f;

            // Check for vertical movement
            if (Input.GetKey(KeyCode.Space))
            {
                verticalMovement = verticalMoveSpeed * Time.deltaTime;
            }
            else if (Input.GetKey(KeyCode.LeftShift))
            {
                verticalMovement = -verticalMoveSpeed * Time.deltaTime;
            }

            Vector3 moveDirection = new Vector3(horizontalInput, verticalMovement, verticalInput) * moveSpeed * Time.deltaTime;
            transform.Translate(moveDirection);

            // Rotate the camera
            float mouseX = Input.GetAxis("Mouse X") * lookSpeed;
            float mouseY = Input.GetAxis("Mouse Y") * lookSpeed;

            rotationX -= mouseY;
            rotationX = Mathf.Clamp(rotationX, -verticalLookLimit, verticalLookLimit);

            transform.localRotation = Quaternion.Euler(rotationX, transform.localEulerAngles.y + mouseX, 0);
        }
        
    }
}
