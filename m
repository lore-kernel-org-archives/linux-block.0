Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 7/8] mq-deadline: add blk-mq adaptation of the deadline IO scheduler
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <048a5a0a-1793-4698-4bc0-213d36fad161@fb.com>
Date: Fri, 20 Jan 2017 12:07:03 +0100
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>,
 osandov@fb.com
Message-Id: <8191D993-76A7-47F9-AF5D-585B0EA1718B@linaro.org>
References: <1481933536-12844-1-git-send-email-axboe@fb.com> <1481933536-12844-8-git-send-email-axboe@fb.com> <2B1CBA75-606E-48FA-A2FC-A435FBB3968E@linaro.org> <048a5a0a-1793-4698-4bc0-213d36fad161@fb.com>
To: Jens Axboe <axboe@fb.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 17 gen 2017, alle ore 03:47, Jens Axboe <axboe@fb.com> ha =
scritto:
>=20
> On 12/22/2016 09:49 AM, Paolo Valente wrote:
>>=20
>>> Il giorno 17 dic 2016, alle ore 01:12, Jens Axboe <axboe@fb.com> ha =
scritto:
>>>=20
>>> This is basically identical to deadline-iosched, except it registers
>>> as a MQ capable scheduler. This is still a single queue design.
>>>=20
>>=20
>> One last question (for today ...):in mq-deadline there are no
>> "schedule dispatch" or "unplug work" functions.  In blk, CFQ and BFQ
>> do these schedules/unplugs in a lot of cases.  What's the right
>> replacement?  Just doing nothing?
>=20
> You just use blk_mq_run_hw_queue() or variants thereof to kick off =
queue
> runs.
>=20

Hi Jens,
I'm working on this right now.  I have a pair of quick questions about
performance.

In the blk version of bfq, if the in-service bfq_queue happen to have
no more budget when the bfq dispatch function is invoked, then bfq:
returns no request (NULL), immediately expires the in-service
bfq_queue, and schedules a new dispatch.  The third step is taken so
that, if other bfq_queues have requests, then a new in-service
bfq_queue will be selected on the upcoming new dispatch, and a new
request will be provided right away.

My questions are: is this dispatch-schedule step still needed with
blk-mq, to avoid a stall?  If it is not needed to avoid a stall, would
it still be needed to boost throughput, because it would force an
immediate, next dispatch?

BTW, bfq-mq survived its first request completion.  I will provide you
with a link to a github branch as soon as bfq-mq seems able to stand
up with a minimal workload.

Thanks,
Paolo

> --=20
> Jens Axboe
>=20
