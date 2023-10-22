using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Desk : MonoBehaviour
{
    public GameObject player;
    public StoryEngine storyEngine;

    private GameObject indicator;

    public GameObject book;
    private Animator animator;

    private bool canOpen = false;
    private bool bookOpen = false;

    // Start is called before the first frame update
    void Start()
    {
        indicator = transform.Find("Indicator").gameObject;
        animator = book.GetComponent<Animator>();
    }

    // Update is called once per frame
    void Update()
    {
        // Show indicator when player is close
        if (Vector3.Distance(player.transform.position, transform.position) < 2f)
            indicator.SetActive(true);
        else
            indicator.SetActive(false);

        // E pressed
        if (Input.GetKeyDown(KeyCode.E))
        {
            // Player within distance
            if (Vector3.Distance(player.transform.position, transform.position) < 2f)
            {
                storyEngine.AlertFromObject("Desk");
                if (canOpen)
                {
                    if (!bookOpen)
                    {
                        OpenBook();
                    }
                    else
                    {
                        CloseBook();
                    }
                }
            }
        }
    }

    public void OpenBook()
    {
        bookOpen = true;
        Time.timeScale = 0f;
        SoundManager.PlaySound(SoundManager.Sound.BookOpen);
        book.SetActive(true);
        animator.SetTrigger("Open");
    }

    public void CloseBook()
    {
        bookOpen = false;
        storyEngine.AlertFromObject("BookClose");
        Time.timeScale = 1f;
        SoundManager.PlaySound(SoundManager.Sound.BookClose);
        animator.SetTrigger("Close");
    }

    public void EnableBook()
    {
        canOpen = true;
    }
}
