Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [GIT PULL] Block fixes for 4.17-rc2
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <08D740DA-3918-47B8-867A-F1AAAA94E08D@linaro.org>
Date: Fri, 27 Apr 2018 09:57:04 +0200
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Mark Brown <broonie@kernel.org>
Message-Id: <AF1C1826-49A6-4219-9BA0-0ABB86FDD1C3@linaro.org>
References: <4af49398-d746-f9a9-a9bc-ca2007b39a00@kernel.dk>
 <E045C6CF-0E1E-44DB-B82B-43932F76A327@linaro.org>
 <96816828-4521-0bab-df73-1e2ecddd7f77@kernel.dk>
 <110372C3-6206-45FC-9610-614790144564@linaro.org>
 <cb9cc55a-8696-98b1-143a-4ee66630c483@kernel.dk>
 <078F88D3-B9E3-415F-BA56-7B02D5CB6407@linaro.org>
 <1e743001-6284-d18b-1cfa-dc3edde3fd35@kernel.dk>
 <08D740DA-3918-47B8-867A-F1AAAA94E08D@linaro.org>
To: Jens Axboe <axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 25 apr 2018, alle ore 20:42, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
>=20
>=20
>> Il giorno 25 apr 2018, alle ore 20:18, Jens Axboe <axboe@kernel.dk> =
ha scritto:
>>=20
>> On 4/25/18 12:02 PM, Paolo Valente wrote:
>>>=20
>>>=20
>>>> Il giorno 25 apr 2018, alle ore 19:34, Jens Axboe <axboe@kernel.dk> =
ha scritto:
>>>>=20
>>>> On 4/25/18 11:25 AM, Paolo Valente wrote:
>>>>>=20
>>>>>=20
>>>>>> Il giorno 25 apr 2018, alle ore 19:06, Jens Axboe =
<axboe@kernel.dk> ha scritto:
>>>>>>=20
>>>>>> On 4/25/18 11:03 AM, Paolo Valente wrote:
>>>>>>>=20
>>>>>>>=20
>>>>>>>> Il giorno 25 apr 2018, alle ore 18:50, Jens Axboe =
<axboe@kernel.dk> ha scritto:
>>>>>>>>=20
>>>>>>>> Hi Linus,
>>>>>>>>=20
>>>>>>>> I ended up sitting on this about a week longer than I wanted =
to,
>>>>>>>> since we were hashing out details with a timeout change. I've =
now
>>>>>>>> killed that patch, so we can flush the existing queue in due =
time.
>>>>>>>>=20
>>>>>>>> This pull request contains:
>>>>>>>>=20
>>>>>>>> - Fix for an old regression, where entering the queue can be =
disturbed
>>>>>>>> by a signal to the process. This can cause spurious EIO. Fix =
from Alan
>>>>>>>> Jenkins.
>>>>>>>>=20
>>>>>>>> - cdrom information leak fix from Dan.
>>>>>>>>=20
>>>>>>>> - Trivial helper for testing queue FUA from Dave Chinner, part =
of his
>>>>>>>> O_DIRECT FUA series.
>>>>>>>>=20
>>>>>>>> - Series of swim fixes from Finn that actually makes it work =
again.
>>>>>>>>=20
>>>>>>>> - Loop O_DIRECT corruption fix, which caused data corruption in
>>>>>>>> production for us. =46rom me.
>>>>>>>>=20
>>>>>>>> - BFQ crash fix from me.
>>>>>>>>=20
>>>>>>>=20
>>>>>>> For what it's worth, I disagree with this patch.  This change is =
based
>>>>>>> on an apparently buggy motivation, as I wrote in my reply in the
>>>>>>> thread where Jens proposed it.  As such, I think it might even =
bury
>>>>>>> more deeply the actual bug that causes the crash (although of =
course
>>>>>>> this patch does eliminate the crash for the use case reported in =
that
>>>>>>> thread).
>>>>>>=20
>>>>>> The patch fixes the issue and I've explained why.
>>>>>=20
>>>>> Definitely, but I wrote you that your explanation seems wrong.
>>>>>=20
>>>>>> If you have a
>>>>>> motivation to fix it differently, for whatever reason, then by =
all
>>>>>> means submit a patch. So far I haven't seen it, and we still have
>>>>>> the known crash that people are actually hitting.
>>>>>>=20
>>>>>=20
>>>>> Unfortunately I don't have a solution, because I don't know what =
the
>>>>> bug is.  I only know that there's a bug in your explanation for =
the
>>>>> bug you want to fix.
>>>>>=20
>>>>>> I'll be happy to work with you on that later in the week, when
>>>>>> the LSFMM conference has wound down.
>>>>>>=20
>>>>>=20
>>>>> I do thank you for that.  If you can, please start by answering my
>>>>> concerns on your explanation.  Maybe your explanation can be fixed =
(or
>>>>> I'm simply wrong), and all will be fine.  Or, if your explanation =
is
>>>>> really buggy and we don't find the actual bug in the code, we can
>>>>> just enrich your proposed change with a comment, and state that =
this
>>>>> is a crutch to walk on, while waiting for the actual bug to show =
up.
>>>>=20
>>>> The reproduction case was there, so should not be hard to run with
>>>> that and add some instrumentation to verify or disprove theories.
>>>=20
>>> Simple code check seems enough for that, see below.
>>>=20
>>>> For the flush case, you start out with a regular request, and =
assign
>>>> the pointers. Then when we transform that into a flush, it's
>>>> bypass inserted, and later retrieved in __bfq_dispatch_request().
>>>=20
>>> Before the transformation, the request undergoes a finish or a
>>> requeue, right?  If so, bfq clears the pointers there.
>>=20
>> If the request has an end_io hook, we go through there and don't
>> finish the request. The request is reused.
>>=20
>=20
> Then, neither elv->finish_request or elv->requeue_request hooks are
> invoked, right?  This is one of the possibilities I feared, because it
> just breaks the balance of bfq counters, making bfq fail in more or
> less unpredictable ways.  So, if I did get you right, then I'll have a
> look at the code involved outside bfq, to fully see and learn what you
> wrote above; after that, I'll start working on how to make bfq comply
> with this new possibility.
>=20

Should Jens' commit for bfq be still blocked by my concern, this is
just to inform you that I think I found a way to improve bfq, so that
it can handle also requests that are prepared, but then disappear
without any communication to bfq.  In particular, my change would
include Jens's change, so I will simply base my change on Jens' one,
and I remove my disagreement.  Of course, Jens' change alone would
just move the system from an immediate crash, to an unpredictable
behavior, which may include later crashes.

Thanks,
Paolo

> Thanks for answering my questions,
> Paolo
>=20
>>>> As
>>>> I said earlier, you could either check that in there (add a =
->elv.icq
>>>> non-NULL check before doing the bfqq check),
>>>=20
>>> They must be already cleared, because of the above.
>>=20
>> Wrong
>>=20
>>>> or you can have it
>>>> cleaner and just always clear the pointers if ->elv.icq isn't =
assigned.
>>>>=20
>>>=20
>>> It is the cleanest solution, if it is ok that those pointers are
>>> dirtied (for reasons I don't know) before or during the
>>> transformation.
>>=20
>> Of course it is, they are not valid if ->elv.icq isn't valid. You
>> must clear them, or they can be stale.
>>=20
>> --=20
>> Jens Axboe
