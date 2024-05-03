using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FishMove : MonoBehaviour
{
    public float moveSpeed = 5f; // Speed of the fish movement
    public float rotationSpeed = 2f; // Speed of the fish rotation
    public float minX = -10f; // Minimum X position of the fish's movement area
    public float maxX = 10f; // Maximum X position of the fish's movement area
    public float minY = -10f; // Minimum Y position of the fish's movement area
    public float maxY = 10f; // Maximum Y position of the fish's movement area
    public float minZ = -10f; // Minimum Z position of the fish's movement area
    public float maxZ = 10f; // Maximum Z position of the fish's movement area

    private Vector3 targetPosition;

    // Start is called before the first frame update
    void Start()
    {
        SetNewTargetPosition();
    }

    // Update is called once per frame
    void Update()
    {
        // Move towards the target position
        transform.position = Vector3.MoveTowards(transform.position, targetPosition, moveSpeed * Time.deltaTime);

        // Rotate towards the target position
        Vector3 direction = (targetPosition - transform.position).normalized;
        Quaternion lookRotation = Quaternion.LookRotation(direction);
        transform.rotation = Quaternion.Slerp(transform.rotation, lookRotation, rotationSpeed * Time.deltaTime);

        // If the fish reaches the target position, set a new target position
        if (Vector3.Distance(transform.position, targetPosition) < 0.1f)
        {
            SetNewTargetPosition();
        }
    }

    void SetNewTargetPosition()
    {
        // Generate a random position within the specified area
        float randomX = Random.Range(minX, maxX);
        float randomY = Random.Range(minY, maxY);
        float randomZ = Random.Range(minZ, maxZ);
        targetPosition = new Vector3(randomX, randomY, randomZ);
    }

}
