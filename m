Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCHSET v4] blk-mq-scheduling framework
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <C5DAF0C3-0509-4297-B12F-C436923A8311@linaro.org>
Date: Wed, 18 Jan 2017 17:14:39 +0100
Cc: Jens Axboe <axboe@fb.com>,
 Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>,
 Omar Sandoval <osandov@fb.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Mark Brown <broonie@kernel.org>
Message-Id: <2028A64C-40E5-403D-B5E9-05863E94B4C5@linaro.org>
References: <1481933536-12844-1-git-send-email-axboe@fb.com> <7A8A5078-E9B8-4EBF-BAB1-9E8EEBF3A043@linaro.org> <dd9501e9-5fc2-66d3-5c62-f8b727a6b6c9@fb.com> <CF1D593B-8BD0-4B59-9193-9D1D4E8BE3E4@linaro.org> <f5303f81-811a-8d0a-b271-d091d8839778@fb.com> <37570439-97C8-4009-B143-C5E78789A137@linaro.org> <b258d716-5c9a-c999-cec4-6bea38a8b975@fb.com> <C5DAF0C3-0509-4297-B12F-C436923A8311@linaro.org>
To: Paolo Valente <paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 17 gen 2017, alle ore 11:49, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
> [NEW RESEND ATTEMPT]
>=20
>> Il giorno 17 gen 2017, alle ore 03:47, Jens Axboe <axboe@fb.com> ha =
scritto:
>>=20
>> On 12/22/2016 08:28 AM, Paolo Valente wrote:
>>>=20
>>>> Il giorno 19 dic 2016, alle ore 22:05, Jens Axboe <axboe@fb.com> ha =
scritto:
>>>>=20
>>>> On 12/19/2016 11:21 AM, Paolo Valente wrote:
>>>>>=20
>>>>>> Il giorno 19 dic 2016, alle ore 16:20, Jens Axboe <axboe@fb.com> =
ha scritto:
>>>>>>=20
>>>>>> On 12/19/2016 04:32 AM, Paolo Valente wrote:
>>>>>>>=20
>>>>>>>> Il giorno 17 dic 2016, alle ore 01:12, Jens Axboe =
<axboe@fb.com> ha scritto:
>>>>>>>>=20
>>>>>>>> This is version 4 of this patchset, version 3 was posted here:
>>>>>>>>=20
>>>>>>>> https://marc.info/?l=3Dlinux-block&m=3D148178513407631&w=3D2
>>>>>>>>=20
>>>>>>>> =46rom the discussion last time, I looked into the feasibility =
of having
>>>>>>>> two sets of tags for the same request pool, to avoid having to =
copy
>>>>>>>> some of the request fields at dispatch and completion time. To =
do that,
>>>>>>>> we'd have to replace the driver tag map(s) with our own, and =
augment
>>>>>>>> that with tag map(s) on the side representing the device queue =
depth.
>>>>>>>> Queuing IO with the scheduler would allocate from the new map, =
and
>>>>>>>> dispatching would acquire the "real" tag. We would need to =
change
>>>>>>>> drivers to do this, or add an extra indirection table to map a =
real
>>>>>>>> tag to the scheduler tag. We would also need a 1:1 mapping =
between
>>>>>>>> scheduler and hardware tag pools, or additional info to track =
it.
>>>>>>>> Unless someone can convince me otherwise, I think the current =
approach
>>>>>>>> is cleaner.
>>>>>>>>=20
>>>>>>>> I wasn't going to post v4 so soon, but I discovered a bug that =
led
>>>>>>>> to drastically decreased merging. Especially on rotating =
storage,
>>>>>>>> this release should be fast, and on par with the merging that =
we
>>>>>>>> get through the legacy schedulers.
>>>>>>>>=20
>>>>>>>=20
>>>>>>> I'm to modifying bfq.  You mentioned other missing pieces to =
come.  Do
>>>>>>> you already have an idea of what they are, so that I am somehow
>>>>>>> prepared to what won't work even if my changes are right?
>>>>>>=20
>>>>>> I'm mostly talking about elevator ops hooks that aren't there in =
the new
>>>>>> framework, but exist in the old one. There should be no hidden
>>>>>> surprises, if that's what you are worried about.
>>>>>>=20
>>>>>> On the ops side, the only ones I can think of are the activate =
and
>>>>>> deactivate, and those can be done in the dispatch_request hook =
for
>>>>>> activate, and put/requeue for deactivate.
>>>>>>=20
>>>>>=20
>>>>> You mean that there is no conceptual problem in moving the code of =
the
>>>>> activate interface function into the dispatch function, and the =
code
>>>>> of the deactivate into the put_request? (for a requeue it is a =
little
>>>>> less clear to me, so one step at a time)  Or am I missing
>>>>> something more complex?
>>>>=20
>>>> Yes, what I mean is that there isn't a 1:1 mapping between the old =
ops
>>>> and the new ops. So you'll have to consider the cases.
>>>>=20
>>>>=20
>>>=20
>>> Problem: whereas it seems easy and safe to do somewhere else the
>>> simple increment that was done in activate_request, I wonder if it =
may
>>> happen that a request is deactivate before being completed.  In it =
may
>>> happen, then, without a deactivate_request hook, the increments =
would
>>> remain unbalanced.  Or are request completions always guaranteed =
till
>>> no hw/sw components breaks?
>>=20
>> You should be able to do it in get/put_request. But you might need =
some
>> extra tracking, I'd need to double check.
>=20
> Exactly, AFAICT something extra is apparently needed.  In particular,
> get is not ok, because dispatch is a different event (but dispatch is
> however an already controlled event), while put could be used,
> provided that it is guaranteed to be executed only after dispatch.  If
> it is not, then I think that an extra flag or something should be
> added to the request.  I don't know whether adding this extra piece
> would be worst than adding an extra hook.
>=20
>>=20
>> I'm trying to avoid adding
>> hooks that we don't truly need, the old interface had a lot of that. =
If
>> you find that you need a hook and it isn't there, feel free to add =
it.
>> activate/deactivate might be a good change.
>>=20
>=20
> If my comments above do not trigger any proposal of a better solution,
> then I will try by adding only one extra 'deactivate' hook.  Unless
> unbalanced hooks are a bad idea too.
>=20

Jens,
according to the function blk_mq_sched_put_request, the
mq.completed_request hook seems to always be invoked (if set) for a
request for which the mq.put_rq_priv is invoked (if set).

If you don't warn me that I'm wrong, I will base on the above
assumption, and complete bfq without any additional hook or flag.

Thanks,
Paolo

> Thanks,
> Paolo
>=20
>> --=20
>> Jens Axboe
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
