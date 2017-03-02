Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44671 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751821AbdCBUsS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 Mar 2017 15:48:18 -0500
Subject: Re: [PATCH] blk-mq-sched: don't hold queue_lock when calling exit_icq
To: Paolo Valente <paolo.valente@linaro.org>
References: <73cd0cf484e8b75a771d908c172cd3a931dc00a3.1486751329.git.osandov@fb.com>
 <A71AF11B-8A3A-42A5-845A-B9FBEEF74FBA@linaro.org>
 <a3e62a57-d401-99e0-6487-fc8277204e71@fb.com>
 <9fe1b3a9-2a80-8891-1044-f83558e28d15@fb.com>
 <1720FEB5-FBBA-4EAA-8292-E820AA15389D@linaro.org>
 <dc4dc011-7038-2c05-b1c0-f6f7a07fa9ae@fb.com>
 <80de4554-a14b-4ce6-7c6e-ec66f70b14b1@fb.com>
 <6C03BF2A-0902-431A-A545-933F56D3E134@linaro.org>
 <75978d1d-8022-75c2-7799-aa65132fdcdd@fb.com>
 <54B1C78E-F58F-4F59-A31B-2E9E64444773@linaro.org>
CC: Omar Sandoval <osandov@osandov.com>, <linux-block@vger.kernel.org>,
        <kernel-team@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <d182fad4-d108-2d3d-06ea-72748ea166b4@fb.com>
Date: Thu, 2 Mar 2017 11:25:06 -0700
MIME-Version: 1.0
In-Reply-To: <54B1C78E-F58F-4F59-A31B-2E9E64444773@linaro.org>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 03/02/2017 11:07 AM, Paolo Valente wrote:
> 
>> Il giorno 02 mar 2017, alle ore 17:13, Jens Axboe <axboe@fb.com> ha scritto:
>>
>> On 03/02/2017 09:07 AM, Paolo Valente wrote:
>>>
>>>> Il giorno 02 mar 2017, alle ore 16:13, Jens Axboe <axboe@fb.com> ha scritto:
>>>>
>>>> On 03/02/2017 08:00 AM, Jens Axboe wrote:
>>>>> On 03/02/2017 03:28 AM, Paolo Valente wrote:
>>>>>>
>>>>>>> Il giorno 15 feb 2017, alle ore 19:04, Jens Axboe <axboe@fb.com> ha scritto:
>>>>>>>
>>>>>>> On 02/15/2017 10:58 AM, Jens Axboe wrote:
>>>>>>>> On 02/15/2017 10:24 AM, Paolo Valente wrote:
>>>>>>>>>
>>>>>>>>>> Il giorno 10 feb 2017, alle ore 19:32, Omar Sandoval <osandov@osandov.com> ha scritto:
>>>>>>>>>>
>>>>>>>>>> From: Omar Sandoval <osandov@fb.com>
>>>>>>>>>>
>>>>>>>>>> None of the other blk-mq elevator hooks are called with this lock held.
>>>>>>>>>> Additionally, it can lead to circular locking dependencies between
>>>>>>>>>> queue_lock and the private scheduler lock.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Hi Omar,
>>>>>>>>> I'm sorry but it seems that a new potential deadlock has showed up.
>>>>>>>>> See lockdep splat below.
>>>>>>>>>
>>>>>>>>> I've tried to think about different solutions than turning back to
>>>>>>>>> deferring the body of exit_icq, but at no avail.
>>>>>>>>
>>>>>>>> Looks like a interaction between bfqd->lock and q->queue_lock. Since the
>>>>>>>> core has no notion of you bfqd->lock, the naturally dependency here
>>>>>>>> would be to nest bfqd->lock inside q->queue_lock. Is that possible for
>>>>>>>> you?
>>>>>>>>
>>>>>>>> Looking at the code a bit, maybe it'd just be simpler to get rid of
>>>>>>>> holding the queue lock for that spot. For the mq scheduler, we really
>>>>>>>> don't want places where we invoke with that held already. Does the below
>>>>>>>> work for you?
>>>>>>>
>>>>>>> Would need to remove one more lockdep assert. And only test this for
>>>>>>> the mq parts, we'd need to spread a bit of love on the classic
>>>>>>> scheduling icq exit path for this to work on that side.
>>>>>>>
>>>>>>
>>>>>>
>>>>>> Jens,
>>>>>> here is the reply I anticipated in my previous email: after rebasing
>>>>>> against master, I'm getting again the deadlock that this patch of
>>>>>> yours solved (together with some changes in bfq-mq).  I thought you added a
>>>>>> sort of equivalent commit (now) to the mainline branch.  Am I wrong?
>>>>>
>>>>> The patch I posted was never pulled to completion, it wasn't clear
>>>>> to me if it fixed your issue or not. Maybe I missed a reply on
>>>>> that?
>>>>>
>>>>> Let me take another stab at it today, I'll send you a version to test
>>>>> on top of my for-linus branch.
>>>>
>>>> I took at look at my last posting, and I think it was only missing a
>>>> lock grab in cfq, since we don't hold that for icq exit anymore.  Paolo,
>>>> it'd be great if you could verify that this works. Not for bfq-mq (we
>>>> already know it does), but for CFQ.
>>>
>>> No luck, sorry :(
>>>
>>> It looks like to have just not to take q->queue_lock in cfq_exit_icq.
>>
>> I was worried about that. How about the below? We need to grab the lock
>> at some point for legacy scheduling, but the ordering should be correct.
>>
>>
> 
> It seems to be: no more crashes or lockdep complains after several tests, boots and shutdowns :)

Great! Can I add your Tested-by?

-- 
Jens Axboe
