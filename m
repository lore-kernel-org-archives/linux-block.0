Return-Path: <axboe@kernel.dk>
Subject: Re: bug in tag handling in blk-mq?
To: Mike Galbraith <efault@gmx.de>, Paolo Valente <paolo.valente@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-block
 <linux-block@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Oleksandr Natalenko <oleksandr@natalenko.name>
References: <999DF2B3-4EE8-4BDF-89C5-EB0C2D8BF69E@linaro.org>
 <7760d23b-7a4c-a645-1c7a-da7569bb44dc@kernel.dk>
 <84145CD7-B917-4B32-8A5C-310C1910DB71@linaro.org>
 <1525755090.24338.1.camel@gmx.de> <1525768632.5208.4.camel@gmx.de>
 <ffd0c030-43f8-0dbe-42b3-03bb9c410bea@kernel.dk>
 <1525797766.5204.2.camel@gmx.de>
 <3692ce7d-a767-72e6-65ae-6178b6c2e7d8@kernel.dk>
 <f04636df-3f97-6c16-f37b-d407e062b9e5@kernel.dk>
 <57952405-bdeb-f4e4-1aef-a7c0a8a68674@kernel.dk>
 <1525839089.15732.1.camel@gmx.de>
 <ce5ee556-9552-6ffd-7578-7b3b983c07bf@kernel.dk>
 <1525885030.15732.6.camel@gmx.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <1e51eb57-6d9b-a53c-9cd6-2adfc86b21b5@kernel.dk>
Date: Wed, 9 May 2018 11:01:52 -0600
MIME-Version: 1.0
In-Reply-To: <1525885030.15732.6.camel@gmx.de>
Content-Type: text/plain; charset=iso-8859-15
List-ID: <linux-block@vger.kernel.org>

On 5/9/18 10:57 AM, Mike Galbraith wrote:
> On Wed, 2018-05-09 at 09:18 -0600, Jens Axboe wrote:
>> On 5/8/18 10:11 PM, Mike Galbraith wrote:
>>> On Tue, 2018-05-08 at 19:09 -0600, Jens Axboe wrote:
>>>>
>>>> Alright, I managed to reproduce it. What I think is happening is that
>>>> BFQ is limiting the inflight case to something less than the wake
>>>> batch for sbitmap, which can lead to stalls. I don't have time to test
>>>> this tonight, but perhaps you can give it a go when you are back at it.
>>>> If not, I'll try tomorrow morning.
>>>>
>>>> If this is the issue, I can turn it into a real patch. This is just to
>>>> confirm that the issue goes away with the below.
>>>
>>> Confirmed.  Impressive high speed bug stomping.
>>
>> Well, that's good news. Can I get you to try this patch?
> 
> Sure thing.  The original hang (minus provocation patch) being
> annoyingly non-deterministic, this will (hopefully) take a while.

You can verify with the provocation patch as well first, if you wish.
Just need to hand-apply since it'll conflict with this patch in
bfq. But it's a trivial resolve.

-- 
Jens Axboe
