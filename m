Return-Path: <prvs=2190b29283=axboe@fb.com>
Subject: Re: [PATCHSET v4] blk-mq-scheduling framework
To: Paolo Valente <paolo.valente@linaro.org>
References: <1481933536-12844-1-git-send-email-axboe@fb.com>
 <7A8A5078-E9B8-4EBF-BAB1-9E8EEBF3A043@linaro.org>
 <dd9501e9-5fc2-66d3-5c62-f8b727a6b6c9@fb.com>
 <CF1D593B-8BD0-4B59-9193-9D1D4E8BE3E4@linaro.org>
 <f5303f81-811a-8d0a-b271-d091d8839778@fb.com>
 <37570439-97C8-4009-B143-C5E78789A137@linaro.org>
CC: Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        Linux-Kernal
	<linux-kernel@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown
	<broonie@kernel.org>
From: Jens Axboe <axboe@fb.com>
Message-ID: <b258d716-5c9a-c999-cec4-6bea38a8b975@fb.com>
Date: Mon, 16 Jan 2017 18:47:15 -0800
MIME-Version: 1.0
In-Reply-To: <37570439-97C8-4009-B143-C5E78789A137@linaro.org>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-block@vger.kernel.org>

On 12/22/2016 08:28 AM, Paolo Valente wrote:
> 
>> Il giorno 19 dic 2016, alle ore 22:05, Jens Axboe <axboe@fb.com> ha scritto:
>>
>> On 12/19/2016 11:21 AM, Paolo Valente wrote:
>>>
>>>> Il giorno 19 dic 2016, alle ore 16:20, Jens Axboe <axboe@fb.com> ha scritto:
>>>>
>>>> On 12/19/2016 04:32 AM, Paolo Valente wrote:
>>>>>
>>>>>> Il giorno 17 dic 2016, alle ore 01:12, Jens Axboe <axboe@fb.com> ha scritto:
>>>>>>
>>>>>> This is version 4 of this patchset, version 3 was posted here:
>>>>>>
>>>>>> https://marc.info/?l=linux-block&m=148178513407631&w=2
>>>>>>
>>>>>> From the discussion last time, I looked into the feasibility of having
>>>>>> two sets of tags for the same request pool, to avoid having to copy
>>>>>> some of the request fields at dispatch and completion time. To do that,
>>>>>> we'd have to replace the driver tag map(s) with our own, and augment
>>>>>> that with tag map(s) on the side representing the device queue depth.
>>>>>> Queuing IO with the scheduler would allocate from the new map, and
>>>>>> dispatching would acquire the "real" tag. We would need to change
>>>>>> drivers to do this, or add an extra indirection table to map a real
>>>>>> tag to the scheduler tag. We would also need a 1:1 mapping between
>>>>>> scheduler and hardware tag pools, or additional info to track it.
>>>>>> Unless someone can convince me otherwise, I think the current approach
>>>>>> is cleaner.
>>>>>>
>>>>>> I wasn't going to post v4 so soon, but I discovered a bug that led
>>>>>> to drastically decreased merging. Especially on rotating storage,
>>>>>> this release should be fast, and on par with the merging that we
>>>>>> get through the legacy schedulers.
>>>>>>
>>>>>
>>>>> I'm to modifying bfq.  You mentioned other missing pieces to come.  Do
>>>>> you already have an idea of what they are, so that I am somehow
>>>>> prepared to what won't work even if my changes are right?
>>>>
>>>> I'm mostly talking about elevator ops hooks that aren't there in the new
>>>> framework, but exist in the old one. There should be no hidden
>>>> surprises, if that's what you are worried about.
>>>>
>>>> On the ops side, the only ones I can think of are the activate and
>>>> deactivate, and those can be done in the dispatch_request hook for
>>>> activate, and put/requeue for deactivate.
>>>>
>>>
>>> You mean that there is no conceptual problem in moving the code of the
>>> activate interface function into the dispatch function, and the code
>>> of the deactivate into the put_request? (for a requeue it is a little
>>> less clear to me, so one step at a time)  Or am I missing
>>> something more complex?
>>
>> Yes, what I mean is that there isn't a 1:1 mapping between the old ops
>> and the new ops. So you'll have to consider the cases.
>>
>>
> 
> Problem: whereas it seems easy and safe to do somewhere else the
> simple increment that was done in activate_request, I wonder if it may
> happen that a request is deactivate before being completed.  In it may
> happen, then, without a deactivate_request hook, the increments would
> remain unbalanced.  Or are request completions always guaranteed till
> no hw/sw components breaks?

You should be able to do it in get/put_request. But you might need some
extra tracking, I'd need to double check. I'm trying to avoid adding
hooks that we don't truly need, the old interface had a lot of that. If
you find that you need a hook and it isn't there, feel free to add it.
activate/deactivate might be a good change.

-- 
Jens Axboe
