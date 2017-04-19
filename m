Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V4 00/16] Introduce the BFQ I/O scheduler
To: Paolo Valente <paolo.valente@linaro.org>
References: <20170412162322.11139-1-paolo.valente@linaro.org>
 <62E939C2-CBA8-4D33-AEEF-380616616E52@linaro.org>
 <9270aa70-a40a-68b1-c93c-5229014abb39@kernel.dk>
 <B408C981-D97D-4BEC-979A-6C555CF1446A@linaro.org>
Cc: Tejun Heo <tj@kernel.org>, Fabio Checconi <fchecconi@gmail.com>,
 Arianna Avanzini <avanzini.arianna@gmail.com>, linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, broonie@kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5a0d1cd7-dbeb-be2e-e966-e4e661408132@kernel.dk>
Date: Wed, 19 Apr 2017 13:34:12 -0600
MIME-Version: 1.0
In-Reply-To: <B408C981-D97D-4BEC-979A-6C555CF1446A@linaro.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/19/2017 01:05 PM, Paolo Valente wrote:
> 
>> Il giorno 19 apr 2017, alle ore 16:33, Jens Axboe <axboe@kernel.dk> ha scritto:
>>
>> On 04/19/2017 03:23 AM, Paolo Valente wrote:
>>>
>>>> Il giorno 12 apr 2017, alle ore 18:23, Paolo Valente <paolo.valente@linaro.org> ha scritto:
>>>>
>>>> Hi,
>>>> new patch series, addressing (both) issues raised by Bart [1], and
>>>> with block/Makefile fixed as suggested by Bart [2].
>>>>
>>>
>>> Hi Jens,
>>> apparently no complain of any sort on this last series.  Do you think
>>> we could make it for 4.12, or shall we aim at 4.13?
>>
>> We may as well queue it up now, I don't think there's much point in
>> deferring an extra cycle.
>>
> 
> A little scary, but (of course) fine for me.

Reaching the culmination of having your big project merged after
a long time is always a little scary. For now, kick back and open
a Tignanello, and brace yourself for tending to potential bug
reports once the 4.12 merge window opens.

-- 
Jens Axboe
