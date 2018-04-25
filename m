Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] Block fixes for 4.17-rc2
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>
References: <4af49398-d746-f9a9-a9bc-ca2007b39a00@kernel.dk>
 <E045C6CF-0E1E-44DB-B82B-43932F76A327@linaro.org>
 <96816828-4521-0bab-df73-1e2ecddd7f77@kernel.dk>
 <110372C3-6206-45FC-9610-614790144564@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <cb9cc55a-8696-98b1-143a-4ee66630c483@kernel.dk>
Date: Wed, 25 Apr 2018 11:34:22 -0600
MIME-Version: 1.0
In-Reply-To: <110372C3-6206-45FC-9610-614790144564@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/25/18 11:25 AM, Paolo Valente wrote:
> 
> 
>> Il giorno 25 apr 2018, alle ore 19:06, Jens Axboe <axboe@kernel.dk> ha scritto:
>>
>> On 4/25/18 11:03 AM, Paolo Valente wrote:
>>>
>>>
>>>> Il giorno 25 apr 2018, alle ore 18:50, Jens Axboe <axboe@kernel.dk> ha scritto:
>>>>
>>>> Hi Linus,
>>>>
>>>> I ended up sitting on this about a week longer than I wanted to,
>>>> since we were hashing out details with a timeout change. I've now
>>>> killed that patch, so we can flush the existing queue in due time.
>>>>
>>>> This pull request contains:
>>>>
>>>> - Fix for an old regression, where entering the queue can be disturbed
>>>> by a signal to the process. This can cause spurious EIO. Fix from Alan
>>>> Jenkins.
>>>>
>>>> - cdrom information leak fix from Dan.
>>>>
>>>> - Trivial helper for testing queue FUA from Dave Chinner, part of his
>>>> O_DIRECT FUA series.
>>>>
>>>> - Series of swim fixes from Finn that actually makes it work again.
>>>>
>>>> - Loop O_DIRECT corruption fix, which caused data corruption in
>>>> production for us. From me.
>>>>
>>>> - BFQ crash fix from me.
>>>>
>>>
>>> For what it's worth, I disagree with this patch.  This change is based
>>> on an apparently buggy motivation, as I wrote in my reply in the
>>> thread where Jens proposed it.  As such, I think it might even bury
>>> more deeply the actual bug that causes the crash (although of course
>>> this patch does eliminate the crash for the use case reported in that
>>> thread).
>>
>> The patch fixes the issue and I've explained why.
> 
> Definitely, but I wrote you that your explanation seems wrong.
> 
>> If you have a
>> motivation to fix it differently, for whatever reason, then by all
>> means submit a patch. So far I haven't seen it, and we still have
>> the known crash that people are actually hitting.
>>
> 
> Unfortunately I don't have a solution, because I don't know what the
> bug is.  I only know that there's a bug in your explanation for the
> bug you want to fix.
> 
>> I'll be happy to work with you on that later in the week, when
>> the LSFMM conference has wound down.
>>
> 
> I do thank you for that.  If you can, please start by answering my
> concerns on your explanation.  Maybe your explanation can be fixed (or
> I'm simply wrong), and all will be fine.  Or, if your explanation is
> really buggy and we don't find the actual bug in the code, we can
> just enrich your proposed change with a comment, and state that this
> is a crutch to walk on, while waiting for the actual bug to show up.

The reproduction case was there, so should not be hard to run with
that and add some instrumentation to verify or disprove theories.
For the flush case, you start out with a regular request, and assign
the pointers. Then when we transform that into a flush, it's
bypass inserted, and later retrieved in __bfq_dispatch_request(). As
I said earlier, you could either check that in there (add a ->elv.icq
non-NULL check before doing the bfqq check), or you can have it
cleaner and just always clear the pointers if ->elv.icq isn't assigned.

The patch clears the pointers if ->elv.icq isn't set, since the whole
set has to be valid. If ->elv.icq isn't set, then we can't trust
potentially earlier content of ->priv[0/1]. It's better to clear them
explicitly, rather than add extra checks for ->elv.icq where we would
otherwise check for RQ_BIC() or RQ_BFQQ().


-- 
Jens Axboe
