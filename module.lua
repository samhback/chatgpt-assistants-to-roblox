local apiKey = '' -- Replace with your API key
local assistantId = '' --Replace with assistant id

local HttpService = game:GetService("HttpService")
local function httpPost(url, data, headers)
	local response = HttpService:RequestAsync({
		Url = url,
		Method = "POST",
		Headers = headers,
		Body = HttpService:JSONEncode(data)
	})
	return response
end

-- Function to make HTTP GET request
local function httpGet(url, headers)
	local response = HttpService:RequestAsync({
		Url = url,
		Method = "GET",
		Headers = headers
	})
	return response
end

local function waitForRunCompletion(threadId, runId, apiKey, timeout)
	timeout = timeout or 50
	local startTime = tick()

	while tick() - startTime < timeout do
		local statusResponse = httpGet(
			"https://api.openai.com/v1/threads/" .. threadId .. "/runs/" .. runId,
			{["Authorization"] = "Bearer " .. apiKey,
				["Content-Type"] = "application/json",
				["OpenAI-Beta"] = "assistants=v1"}
		)
		local runStatus = HttpService:JSONDecode(statusResponse.Body).status

		print(runStatus)

		if runStatus == 'completed' then
			return statusResponse
		elseif runStatus == 'failed' then
			error("Run failed.")
			break
		end

		wait(1)  -- Delay before the next status check
	end

	error("Run did not complete within the specified timeout.")
end


local agpt = {}

function agpt.ask(question)
	local threadResponse = httpPost(
		"https://api.openai.com/v1/threads",
		{messages = {{["role"] = "user", ["content"] = question}}},
		{["Authorization"] = "Bearer " .. apiKey,
			["Content-Type"] = "application/json",
			["OpenAI-Beta"] = "assistants=v1"}
	)
	local thread = HttpService:JSONDecode(threadResponse.Body)
	print(thread)
	-- Create run
	local runResponse = httpPost(
		"https://api.openai.com/v1/threads/" .. thread.id .. "/runs",
		{assistant_id = assistantId},
		{["Authorization"] = "Bearer " .. apiKey,
			["Content-Type"] = "application/json",
			["OpenAI-Beta"] = "assistants=v1"}
	)
	local run = HttpService:JSONDecode(runResponse.Body)

	-- Wait for completion
	local completedRun = waitForRunCompletion(thread.id, run.id, apiKey, 60)

	-- Retrieve messages
	local messagesResponse = httpGet(
		"https://api.openai.com/v1/threads/" .. thread.id .. "/messages",
		{["Authorization"] = "Bearer " .. apiKey,
			["Content-Type"] = "application/json",
			["OpenAI-Beta"] = "assistants=v1"}
	)
	local messages = HttpService:JSONDecode(messagesResponse.Body)

	-- Log messages
	print(messages.data[1].content[1].text.value)
end
return agpt
