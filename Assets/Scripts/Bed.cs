using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Bed : MonoBehaviour
{
    public GameObject player;
    public StoryEngine storyEngine;

    private GameObject indicator;

    private bool canSleep = false;

    // Start is called before the first frame update
    void Start()
    {
        indicator = transform.Find("Indicator").gameObject;
    }

    // Update is called once per frame
    void Update()
    {
        // Show indicator when player is close
        if (Vector3.Distance(player.transform.position, transform.position) < 2f)
            if (canSleep)
                indicator.SetActive(true);
        else
            indicator.SetActive(false);

        // E pressed
        if (Input.GetKeyDown(KeyCode.E))
        {
            // Player within distance
            if (Vector3.Distance(player.transform.position, transform.position) < 2f)
            {
                if (canSleep)
                {
                    canSleep = false;
                    storyEngine.AlertFromObject("Bed");
                    player.transform.position = new Vector3(9f, 3.7f);
                }
            }
        }
    }

    public void setSleep(bool x)
    {
        canSleep = x;
    }
}
