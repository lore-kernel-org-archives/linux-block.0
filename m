Return-Path: <axboe@kernel.dk>
Subject: Re: high overhead of functions blkg_*stats_* in bfq
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Tejun Heo <tj@kernel.org>, linux-block <linux-block@vger.kernel.org>,
 Luca Miccio <lucmiccio@gmail.com>
References: <07DF24AB-9B62-4EE5-8B45-3E04C1CEA84C@linaro.org>
 <20171018131918.GB1302522@devbig577.frc2.facebook.com>
 <74e06bc1-bf75-aac1-cef3-87609af8da70@kernel.dk>
 <D8400344-DD9D-498B-A177-9F2E396C8930@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <cadbe0b6-c91b-ff64-f083-0347dc49f480@kernel.dk>
Date: Wed, 18 Oct 2017 09:44:19 -0600
MIME-Version: 1.0
In-Reply-To: <D8400344-DD9D-498B-A177-9F2E396C8930@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/18/2017 09:05 AM, Paolo Valente wrote:
> 
>> Il giorno 18 ott 2017, alle ore 16:45, Jens Axboe <axboe@kernel.dk> ha scritto:
>>
>> On 10/18/2017 07:19 AM, Tejun Heo wrote:
>>>> We tried to understand the reason for this high overhead, and, in
>>>> particular, to find out whether whether there was some issue that we
>>>> could address on our own.  But the causes seem somehow substantial:
>>>> one of the most time-consuming operations needed by some blkg_*stats_*
>>>> functions is, e.g., find_next_bit, for which we don't see any trivial
>>>> replacement.
>>>
>>> Can you point to the specific ones?  I can't find find_next_bit usages
>>> in generic blkg code.
>>
>> Yeah, in general a report like this is pretty much useless without
>> any sort of call traces or perf output. The best way to get help
>> is to post exactly what to run to reproduce the performance issue,
>> and profile output that shows/highlights the issues.
>>
> 
> Yes, sorry.  To be very brief, I just provided a link to the script
> with which one can immediately reproduce the issue.

Brief is about number of words, you can never include too much
actual information or data ;-)

> I hope the information I have now provided in my reply to Tejun are> enough.

The picture is no longer attached. What list was this on?

-- 
Jens Axboe
