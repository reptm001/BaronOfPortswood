using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using Ink.Runtime;
using TMPro;

public class StoryEngine : MonoBehaviour
{
    public TextAsset inkAsset; // Compiled JSON asset
    private Story _inkStory;

    public GameObject player;

    public Canvas HUDCanvas;
    private TextMeshProUGUI mainText;
    private GameObject c1;
    private GameObject c2;
    private GameObject c3;
    private List<GameObject> choiceBoxes = new List<GameObject>();
    private GameObject input;

    public Canvas bookCanvas;
    private Slider foodSlider;
    private Slider goldSlider;
    private Slider popSlider;

    public Canvas infoCanvas;
    private TextMeshProUGUI date;

    public Canvas endMenuCanvas;

    public Desk desk;
    public Bed bed;
    public List<NPC> NPCs;

    private string currentText;
    private List<string> currentTags;
    private List<Choice> currentChoices;

    private bool next = false;
    private int choice = 0;
    private string player_name;
    private string alertObj;
    private List<string> charsSeen = new List<string>();

    private List<string> dates = new List<string> {"1/2/1345", "2/2/1345", "5/8/1356", "30/3/1360"};

    private void Awake()
    {
        _inkStory = new Story(inkAsset.text);

        mainText = HUDCanvas.transform.Find("MainText").GetComponent<TextMeshProUGUI>();
        c1 = HUDCanvas.transform.Find("C1").gameObject;
        choiceBoxes.Add(c1);
        c2 = HUDCanvas.transform.Find("C2").gameObject;
        choiceBoxes.Add(c2);
        c3 = HUDCanvas.transform.Find("C3").gameObject;
        choiceBoxes.Add(c3);
        input = HUDCanvas.transform.Find("Input").gameObject;

        Transform bookElements = bookCanvas.transform.Find("BookElements").transform;

        foodSlider = bookElements.Find("FoodSlider").GetComponent<Slider>();
        _inkStory.ObserveVariable("food", (string varName, object newValue) =>
        {
            if ((int)newValue > 0 && (int)newValue <= 10)
                foodSlider.value = (int)newValue;
            else if ((int)newValue > 10)
                foodSlider.value = 10;
            else
                _inkStory.ChoosePathString("Traits_Empty");
        });
        goldSlider = bookElements.Find("GoldSlider").GetComponent<Slider>();
        _inkStory.ObserveVariable("gold", (string varName, object newValue) =>
        {
            if ((int)newValue > 0 && (int)newValue <= 10)
                goldSlider.value = (int)newValue;
            else if ((int)newValue > 10)
                goldSlider.value = 10;
            else
                _inkStory.ChoosePathString("Traits_Empty");
        });
        popSlider = bookElements.Find("PopSlider").GetComponent<Slider>();
        _inkStory.ObserveVariable("wb_pop", (string varName, object newValue) =>
        {
            if ((int)newValue > 0 && (int)newValue <= 10)
                popSlider.value = (int)newValue;
            else if ((int)newValue > 10)
                popSlider.value = 10;
            else
                _inkStory.ChoosePathString("Traits_Empty");
        });

        date = infoCanvas.transform.Find("Date").GetComponent<TextMeshProUGUI>();
        date.text = dates[0];
        _inkStory.ObserveVariable("day", (string varName, object newValue) =>
        {
            int index = (int)newValue;
            date.text = dates[index-1];
        });
    }

    private void Start()
    {
        StartCoroutine(StoryLoop());
    }

    private IEnumerator StoryLoop()
    {
        while (_inkStory.canContinue)
        {
            Time.timeScale = 0f;
            HUDCanvas.gameObject.SetActive(true);
            currentText = _inkStory.Continue();
            currentTags = _inkStory.currentTags;
            currentChoices = _inkStory.currentChoices;

            Debug.Log("Tags: ");
            foreach (string t in currentTags)
            {
                Debug.Log("    " + t);
            }

            Debug.Log("Choices: ");
            foreach (Choice c in currentChoices)
            {
                Debug.Log("    " + c.text);
            }

            bool textEnabled = true;
            bool nextEnabled = true;
            bool choiceEnabled = true;

            foreach (string tag in currentTags)
            {
                switch (tag)
                {
                    case "setName":
                        textEnabled = false;
                        yield return PlayText(currentText);
                        input.SetActive(true);
                        nextEnabled = false;
                        yield return WaitForName();
                        input.SetActive(false);
                        break;
                    case "waitDesk":
                        textEnabled = false;
                        yield return PlayText(currentText);
                        yield return WaitForNext();
                        nextEnabled = false;
                        Time.timeScale = 1f;
                        HUDCanvas.gameObject.SetActive(false);
                        yield return WaitForAlert("Desk");
                        break;
                    case "enableBook":
                        textEnabled = false;
                        yield return PlayText(currentText);
                        yield return WaitForNext();
                        nextEnabled = false;
                        Time.timeScale = 1f;
                        HUDCanvas.gameObject.SetActive(false);
                        desk.EnableBook();
                        desk.OpenBook();
                        yield return WaitForAlert("BookClose");
                        break;
                    case "delay":
                        yield return new WaitForSecondsRealtime(1f);
                        break;
                    case "waitChars":
                        Debug.Log("waitChars");
                        foreach (Choice c in currentChoices)
                        {
                            foreach (NPC n in NPCs)
                            {
                                if (n.characterName == c.text)
                                    n.SetAction(true);
                            }
                        }
                        textEnabled = false;
                        choiceEnabled = false;
                        nextEnabled = false;
                        Time.timeScale = 1f;
                        HUDCanvas.gameObject.SetActive(false);
                        yield return WaitForChoice();
                        break;
                    case "endWaitChars":
                        charsSeen = new List<string>();
                        break;
                    case "waitBed":
                        textEnabled = false;
                        yield return PlayText(currentText);
                        yield return WaitForNext();
                        nextEnabled = false;
                        Time.timeScale = 1f;
                        HUDCanvas.gameObject.SetActive(false);
                        bed.setSleep(true);
                        yield return WaitForAlert("Bed");
                        yield return new WaitForSecondsRealtime(1f);
                        bed.setSleep(false);
                        break;
                    case "dreamStart":
                        Time.timeScale = 1f;
                        player.transform.position = new Vector3(52f, -5.2f);
                        textEnabled = false;
                        yield return PlayText(currentText);
                        Time.timeScale = 0f;
                        break;
                    case "dreamEnd":
                        Time.timeScale = 1f;
                        player.transform.position = new Vector3(7.5f, 3.7f);
                        break;
                    case "spawnBrother":
                        NPCs.Find(n => n.characterName == "Brother").Spawn();
                        break;
                    case "despawnBrother":
                        NPCs.Find(n => n.characterName == "Brother").Despawn();
                        break;
                    case "playTense":
                        SoundManager.ChangeBackgroundAudio(SoundManager.Sound.BackgroundTense);
                        break;
                    default:
                        Debug.LogError("Error: Tag '" + tag + "' not recognised.");
                        break;
                }
            }

            if (textEnabled)
                yield return PlayText(currentText);

            if (choiceEnabled)
            {
                if (currentChoices.Count > 0)
                {
                    for (int i = 0; i < currentChoices.Count; i++)
                    {
                        choiceBoxes[i].SetActive(true);
                        TextMeshProUGUI choiceBoxText = choiceBoxes[i].transform.Find("Text").GetComponent<TextMeshProUGUI>();
                        choiceBoxText.text = currentChoices[i].text;
                    }
                    yield return WaitForChoice();

                    foreach (GameObject cb in choiceBoxes) cb.SetActive(false);

                    nextEnabled = false;
                }
            }

            if (nextEnabled)
                yield return WaitForNext();
        }
        Debug.Log("END OF STORY");
        SoundManager.ChangeBackgroundAudio(SoundManager.Sound.BackgroundAmbience);
        endMenuCanvas.gameObject.SetActive(true);
    }

    private IEnumerator WaitForNext()
    {
        next = false;
        while(!next) { yield return null; }
    }

    public void Next()
    {
        next = true;
    }

    private IEnumerator WaitForChoice()
    {
        choice = -1;
        while (choice < 0) { yield return null; }
        _inkStory.ChooseChoiceIndex(choice);
    }

    public void SelectChoice(int n)
    {
        choice = n;
    }

    private IEnumerator WaitForName()
    {
        player_name = null;
        while (player_name == null) { yield return null; }
        _inkStory.variablesState["name"] = player_name;
    }

    public void EnterName(string s)
    {
        player_name = s;
    }

    private IEnumerator WaitForAlert(string s)
    {
        alertObj = null;
        while (alertObj != s) { yield return null; }
    }

    public void AlertFromObject(string s)
    {
        alertObj = s;
    }

    public void AlertFromChar(string s)
    {
        if (!charsSeen.Contains(s))
        {
            charsSeen.Add(s);
            _inkStory.variablesState["char_count"] = (int)_inkStory.variablesState["char_count"] + 1;
            if (currentChoices.Count > 0)
            {
                int choiceIndex = 0;
                for (int i = 0; i < currentChoices.Count; i++)
                {
                    if (currentChoices[i].text == s)
                        choiceIndex = i;
                }
                Debug.Log(choiceIndex + " " + currentChoices[choiceIndex].text);
                Debug.Log("char_count=" + _inkStory.variablesState["char_count"]);
                SelectChoice(choiceIndex);
            }
        }
    }

    private IEnumerator PlayText(string text)
    {
        mainText.text = "";
        foreach (char c in text)
        {
            mainText.text += c;
            yield return new WaitForSecondsRealtime(0.01f);
        }
    }

    // Update is called once per frame
    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.Space) || Input.GetKeyDown(KeyCode.Return))
        {
            Next();
        }
    }
}
