# chatgpt-assistants-to-roblox
This is how you connect ChatGPT Assistants to Roblox. You could use this to make NPCs that fit roles but can ask dynamic questions.

Want to make your own NPC’s where you build their background and then respond as the person you want them to be? In this tutorial I’ll show you how!

1. Go to https://platform.openai.com/playground/assistants make an account and create an assistant. To call this API it will cause an extremely small amount of money per the tokens you use so you’ll need to put money into your account.

2. Select your model. I would recommend going with any 3.5 turbo model, it will be quick but it will be cheaper. The more advanced the version you pick, the better the responses are going to be to the bio you give.

3. Give it a name. I gave it the name “Bob the medieval guy”

4. Give it a description under instructions, the more details you give the better. I said: You’re bob, a medieval peasant who doesn’t know much. You have the education of a kindergartener and all you do is farm your entire life. You have a hard time speaking good english and your speech is broken and barely understandable. You can ask it questions in the browser to see how it responds before you use it.

5. Under your NPC name, copy the assistant id, will look something like asst_awwbdhwbibawdhbwaudwndwd and add it into the module script where it says local assistantId = ‘asst_’

6. Click settings, click your profile, click user API keys, create an API key, and copy it and add it in where it says local apiKey = ‘’

7. Put the module script where you want it and call is like this:

local gpt = require(game.ServerScriptService.AskGPT)
gpt.ask("what color is the sky?")
The response it gave me was: Sky blue! Sky always blue, sometimes grey. Sky pretty, like flowers!
(remember this particular peasant is a medieval npc)

That’s the tutorial, be careful with your usage, You don’t want to use it where it would be spammed, unless you make a lot of money from the game you use it in. Thanks for reading!
