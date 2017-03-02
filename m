Subject: Re: [PATCH] blk-mq-sched: don't hold queue_lock when calling exit_icq
To: Paolo Valente <paolo.valente@linaro.org>
References: <73cd0cf484e8b75a771d908c172cd3a931dc00a3.1486751329.git.osandov@fb.com>
 <A71AF11B-8A3A-42A5-845A-B9FBEEF74FBA@linaro.org>
 <a3e62a57-d401-99e0-6487-fc8277204e71@fb.com>
 <9fe1b3a9-2a80-8891-1044-f83558e28d15@fb.com>
 <1720FEB5-FBBA-4EAA-8292-E820AA15389D@linaro.org>
Cc: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org,
 kernel-team@fb.com
From: Jens Axboe <axboe@fb.com>
Message-ID: <dc4dc011-7038-2c05-b1c0-f6f7a07fa9ae@fb.com>
Date: Thu, 2 Mar 2017 08:00:21 -0700
MIME-Version: 1.0
In-Reply-To: <1720FEB5-FBBA-4EAA-8292-E820AA15389D@linaro.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/02/2017 03:28 AM, Paolo Valente wrote:
> 
>> Il giorno 15 feb 2017, alle ore 19:04, Jens Axboe <axboe@fb.com> ha scritto:
>>
>> On 02/15/2017 10:58 AM, Jens Axboe wrote:
>>> On 02/15/2017 10:24 AM, Paolo Valente wrote:
>>>>
>>>>> Il giorno 10 feb 2017, alle ore 19:32, Omar Sandoval <osandov@osandov.com> ha scritto:
>>>>>
>>>>> From: Omar Sandoval <osandov@fb.com>
>>>>>
>>>>> None of the other blk-mq elevator hooks are called with this lock held.
>>>>> Additionally, it can lead to circular locking dependencies between
>>>>> queue_lock and the private scheduler lock.
>>>>>
>>>>
>>>> Hi Omar,
>>>> I'm sorry but it seems that a new potential deadlock has showed up.
>>>> See lockdep splat below.
>>>>
>>>> I've tried to think about different solutions than turning back to
>>>> deferring the body of exit_icq, but at no avail.
>>>
>>> Looks like a interaction between bfqd->lock and q->queue_lock. Since the
>>> core has no notion of you bfqd->lock, the naturally dependency here
>>> would be to nest bfqd->lock inside q->queue_lock. Is that possible for
>>> you?
>>>
>>> Looking at the code a bit, maybe it'd just be simpler to get rid of
>>> holding the queue lock for that spot. For the mq scheduler, we really
>>> don't want places where we invoke with that held already. Does the below
>>> work for you?
>>
>> Would need to remove one more lockdep assert. And only test this for
>> the mq parts, we'd need to spread a bit of love on the classic
>> scheduling icq exit path for this to work on that side.
>>
> 
> 
> Jens,
> here is the reply I anticipated in my previous email: after rebasing
> against master, I'm getting again the deadlock that this patch of
> yours solved (together with some changes in bfq-mq).  I thought you added a
> sort of equivalent commit (now) to the mainline branch.  Am I wrong?

The patch I posted was never pulled to completion, it wasn't clear
to me if it fixed your issue or not. Maybe I missed a reply on
that?

Let me take another stab at it today, I'll send you a version to test
on top of my for-linus branch.

-- 
Jens Axboe
