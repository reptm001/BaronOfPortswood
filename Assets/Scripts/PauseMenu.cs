using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class PauseMenu : MonoBehaviour
{
    public static bool GamePaused = false;

    public GameObject pauseMenuUI;

    private float prevTimeScale = 1f;

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Escape))
        {
            if (GamePaused)
            {
                Resume();
            } else
            {
                Pause();
            }
        }
    }

    public void Resume()
    {
        // Only resume if in pause menu (not control menu)
        if (pauseMenuUI.activeSelf)
        {
            pauseMenuUI.SetActive(false);
            Time.timeScale = prevTimeScale;
            GamePaused = false;
        }
    }

    void Pause()
    {
        if (!pauseMenuUI.activeSelf)
        {
            pauseMenuUI.SetActive(true);
            prevTimeScale = Time.timeScale;
            Time.timeScale = 0f;
            GamePaused = true;
        }
    }

    public void LoadMainMenu()
    {
        GamePaused = false;
        SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex - 1);
    }

    public void QuitGame()
    {
        Application.Quit();
    }
}
