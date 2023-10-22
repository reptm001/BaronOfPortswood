using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NPC : MonoBehaviour
{
    public GameObject player;
    public StoryEngine storyEngine;

    public string characterName;

    private GameObject indicator;
    private GameObject nametag;

    private bool hasAction = false;

    private void Start()
    {
        indicator = transform.Find("Indicator").gameObject;
        nametag = transform.Find("Nametag").gameObject;
    }

    // Update is called once per frame
    private void Update()
    {
        // Show nametag when player is close
        if (Vector3.Distance(player.transform.position, transform.position) < 2.7f)
            nametag.SetActive(true);
        else
            nametag.SetActive(false);

        // Show indicator if npc has action
        indicator.SetActive(hasAction);

        // E pressed
        if (Input.GetKeyDown(KeyCode.E))
        {
            // Player within distance
            if (Vector3.Distance(player.transform.position, transform.position) < 2.7f)
            {
                // NPC has action
                if (hasAction)
                {
                    hasAction = false;
                    storyEngine.AlertFromChar(characterName);
                } else
                {
                    SoundManager.PlaySound(SoundManager.Sound.NPCNoAction, transform.position);
                }
            }
        }
    }

    public void SetAction(bool x)
    {
        Debug.Log(characterName + " given action " + x);
        hasAction = x;
    }

    public void Spawn()
    {
        gameObject.SetActive(true);
    }

    public void Despawn()
    {
        gameObject.SetActive(false);
    }
}
