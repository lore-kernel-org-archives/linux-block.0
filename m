Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH IMPROVEMENT] block, bfq: limit sectors served with
 interactive weight raising
To: Paolo Valente <paolo.valente@linaro.org>,
 =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Cc: linux-block <linux-block@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, bfq-iosched@googlegroups.com,
 oleksandr@natalenko.name
References: <20171228111917.2767-1-paolo.valente@linaro.org>
 <5a9c6573-84a6-ae7b-7058-f202c7187065@applied-asynchrony.com>
 <12660CC7-AD89-434A-9BEA-BA0B4C362807@linaro.org>
 <c1cb979a-007c-7607-0c02-4f9110f90a13@applied-asynchrony.com>
 <9F56E963-E99C-4B7A-B66A-83FC29B544CD@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <309e2981-c7dc-9be9-8ad8-0d8c7b864a3d@kernel.dk>
Date: Fri, 12 Jan 2018 08:13:22 -0700
MIME-Version: 1.0
In-Reply-To: <9F56E963-E99C-4B7A-B66A-83FC29B544CD@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/12/18 3:20 AM, Paolo Valente wrote:
> 
> 
>> Il giorno 12 gen 2018, alle ore 11:15, Holger Hoffstätte <holger@applied-asynchrony.com> ha scritto:
>>
>> On 01/12/18 06:58, Paolo Valente wrote:
>>>
>>>
>>>> Il giorno 28 dic 2017, alle ore 15:00, Holger Hoffstätte <holger@applied-asynchrony.com> ha scritto:
>>>>
>>>>
>>>> On 12/28/17 12:19, Paolo Valente wrote:
>>>> (snip half a tech report ;)
>>>>
>>>> So either this or the previous patch ("limit tags for writes and async I/O"
>>>> can lead to a hard, unrecoverable hang with heavy writes. Since I couldn't
>>>> log into the affected system anymore I couldn't get any stack traces, blk-mq
>>>> debug output etc. but there was nothing in dmesg/on the console, so it
>>>> wasn't a BUG/OOPS.
>>>>
>>>> -h
>>>
>>> Hi Holger,
>>> if, as I guess, this problem hasn't gone away for you, I have two
>>> requests:
>>> 1) could you share your exact test
>>> 2) if nothing happens in my systems with your test, would you be
>>> willing to retry with the dev version of bfq?  It should be able to
>>> tell us what takes to your hang.  If you are willing to do this test,
>>> I'll prepare a branch with everything already configured for you.
>>
>> Hi,
>>
>> thanks for following up but there's no need for any of that; it turned out
>> to be something else since I got the same hang without those patches at
>> least once (during a btrfs balance, even though it didn't look like btrfs'
>> fault directly; more like block/mm/helpers.
>>
>> So on January 7 I posted to linux-block et.al. where I said
>> "So this turned out to be something else, sorry for the false alarm."
>> but apparently that didn't make it through since it's not in the
>> archives either. Sorry.
>>
>> Long story short, the good news is that I've been running with both patches
>> since then without any issue. :)
>>
> 
> Wow, what a relief! :)
> 
> So, Jens, being the only issue reported gone, can you please consider
> queueing this patch and the other pending one [1]?  They are both
> critical for bfq performance.

Please just resend them.

-- 
Jens Axboe
