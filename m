Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f172.google.com ([209.85.128.172]:35361 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750910AbdCBVfW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Mar 2017 16:35:22 -0500
Received: by mail-wr0-f172.google.com with SMTP id g10so61762914wrg.2
        for <linux-block@vger.kernel.org>; Thu, 02 Mar 2017 13:34:20 -0800 (PST)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] blk-mq-sched: don't hold queue_lock when calling exit_icq
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <d182fad4-d108-2d3d-06ea-72748ea166b4@fb.com>
Date: Thu, 2 Mar 2017 21:31:02 +0100
Cc: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org,
        kernel-team@fb.com
Message-Id: <667F3201-BE63-4340-A6AA-5B1292B7E479@linaro.org>
References: <73cd0cf484e8b75a771d908c172cd3a931dc00a3.1486751329.git.osandov@fb.com> <A71AF11B-8A3A-42A5-845A-B9FBEEF74FBA@linaro.org> <a3e62a57-d401-99e0-6487-fc8277204e71@fb.com> <9fe1b3a9-2a80-8891-1044-f83558e28d15@fb.com> <1720FEB5-FBBA-4EAA-8292-E820AA15389D@linaro.org> <dc4dc011-7038-2c05-b1c0-f6f7a07fa9ae@fb.com> <80de4554-a14b-4ce6-7c6e-ec66f70b14b1@fb.com> <6C03BF2A-0902-431A-A545-933F56D3E134@linaro.org> <75978d1d-8022-75c2-7799-aa65132fdcdd@fb.com> <54B1C78E-F58F-4F59-A31B-2E9E64444773@linaro.org> <d182fad4-d108-2d3d-06ea-72748ea166b4@fb.com>
To: Jens Axboe <axboe@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> Il giorno 02 mar 2017, alle ore 19:25, Jens Axboe <axboe@fb.com> ha =
scritto:
>=20
> On 03/02/2017 11:07 AM, Paolo Valente wrote:
>>=20
>>> Il giorno 02 mar 2017, alle ore 17:13, Jens Axboe <axboe@fb.com> ha =
scritto:
>>>=20
>>> On 03/02/2017 09:07 AM, Paolo Valente wrote:
>>>>=20
>>>>> Il giorno 02 mar 2017, alle ore 16:13, Jens Axboe <axboe@fb.com> =
ha scritto:
>>>>>=20
>>>>> On 03/02/2017 08:00 AM, Jens Axboe wrote:
>>>>>> On 03/02/2017 03:28 AM, Paolo Valente wrote:
>>>>>>>=20
>>>>>>>> Il giorno 15 feb 2017, alle ore 19:04, Jens Axboe =
<axboe@fb.com> ha scritto:
>>>>>>>>=20
>>>>>>>> On 02/15/2017 10:58 AM, Jens Axboe wrote:
>>>>>>>>> On 02/15/2017 10:24 AM, Paolo Valente wrote:
>>>>>>>>>>=20
>>>>>>>>>>> Il giorno 10 feb 2017, alle ore 19:32, Omar Sandoval =
<osandov@osandov.com> ha scritto:
>>>>>>>>>>>=20
>>>>>>>>>>> From: Omar Sandoval <osandov@fb.com>
>>>>>>>>>>>=20
>>>>>>>>>>> None of the other blk-mq elevator hooks are called with this =
lock held.
>>>>>>>>>>> Additionally, it can lead to circular locking dependencies =
between
>>>>>>>>>>> queue_lock and the private scheduler lock.
>>>>>>>>>>>=20
>>>>>>>>>>=20
>>>>>>>>>> Hi Omar,
>>>>>>>>>> I'm sorry but it seems that a new potential deadlock has =
showed up.
>>>>>>>>>> See lockdep splat below.
>>>>>>>>>>=20
>>>>>>>>>> I've tried to think about different solutions than turning =
back to
>>>>>>>>>> deferring the body of exit_icq, but at no avail.
>>>>>>>>>=20
>>>>>>>>> Looks like a interaction between bfqd->lock and q->queue_lock. =
Since the
>>>>>>>>> core has no notion of you bfqd->lock, the naturally dependency =
here
>>>>>>>>> would be to nest bfqd->lock inside q->queue_lock. Is that =
possible for
>>>>>>>>> you?
>>>>>>>>>=20
>>>>>>>>> Looking at the code a bit, maybe it'd just be simpler to get =
rid of
>>>>>>>>> holding the queue lock for that spot. For the mq scheduler, we =
really
>>>>>>>>> don't want places where we invoke with that held already. Does =
the below
>>>>>>>>> work for you?
>>>>>>>>=20
>>>>>>>> Would need to remove one more lockdep assert. And only test =
this for
>>>>>>>> the mq parts, we'd need to spread a bit of love on the classic
>>>>>>>> scheduling icq exit path for this to work on that side.
>>>>>>>>=20
>>>>>>>=20
>>>>>>>=20
>>>>>>> Jens,
>>>>>>> here is the reply I anticipated in my previous email: after =
rebasing
>>>>>>> against master, I'm getting again the deadlock that this patch =
of
>>>>>>> yours solved (together with some changes in bfq-mq).  I thought =
you added a
>>>>>>> sort of equivalent commit (now) to the mainline branch.  Am I =
wrong?
>>>>>>=20
>>>>>> The patch I posted was never pulled to completion, it wasn't =
clear
>>>>>> to me if it fixed your issue or not. Maybe I missed a reply on
>>>>>> that?
>>>>>>=20
>>>>>> Let me take another stab at it today, I'll send you a version to =
test
>>>>>> on top of my for-linus branch.
>>>>>=20
>>>>> I took at look at my last posting, and I think it was only missing =
a
>>>>> lock grab in cfq, since we don't hold that for icq exit anymore.  =
Paolo,
>>>>> it'd be great if you could verify that this works. Not for bfq-mq =
(we
>>>>> already know it does), but for CFQ.
>>>>=20
>>>> No luck, sorry :(
>>>>=20
>>>> It looks like to have just not to take q->queue_lock in =
cfq_exit_icq.
>>>=20
>>> I was worried about that. How about the below? We need to grab the =
lock
>>> at some point for legacy scheduling, but the ordering should be =
correct.
>>>=20
>>>=20
>>=20
>> It seems to be: no more crashes or lockdep complains after several =
tests, boots and shutdowns :)
>=20
> Great! Can I add your Tested-by?

Sure!

Thanks,
Paolo

>=20
> --=20
> Jens Axboe
