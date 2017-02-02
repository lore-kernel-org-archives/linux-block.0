Return-Path: <prvs=32061165df=axboe@fb.com>
Subject: Re: [PATCH 7/8] mq-deadline: add blk-mq adaptation of the deadline IO
 scheduler
To: Paolo Valente <paolo.valente@linaro.org>
References: <1481933536-12844-1-git-send-email-axboe@fb.com>
 <1481933536-12844-8-git-send-email-axboe@fb.com>
 <26ED11F4-2507-4A5D-ACB9-C501AA9CBB29@linaro.org>
CC: Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        Linux-Kernal
	<linux-kernel@vger.kernel.org>, <osandov@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <d71f9feb-c231-a32a-6910-a781f15fdc8c@fb.com>
Date: Wed, 1 Feb 2017 22:20:02 -0700
MIME-Version: 1.0
In-Reply-To: <26ED11F4-2507-4A5D-ACB9-C501AA9CBB29@linaro.org>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-block@vger.kernel.org>

On 02/01/2017 04:56 AM, Paolo Valente wrote:
>> +/*
>> + * add rq to rbtree and fifo
>> + */
>> +static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>> +			      bool at_head)
>> +{
>> +	struct request_queue *q = hctx->queue;
>> +	struct deadline_data *dd = q->elevator->elevator_data;
>> +	const int data_dir = rq_data_dir(rq);
>> +
>> +	if (blk_mq_sched_try_insert_merge(q, rq))
>> +		return;
>> +
> 
> A related doubt: shouldn't blk_mq_sched_try_insert_merge be invoked
> with the scheduler lock held too, as blk_mq_sched_try_merge, to
> protect (at least) q->last_merge?
>
> In bfq this function is invoked with the lock held.

It doesn't matter which lock you use, as long as:

1) You use the same one consistently
2) It has the same scope as the queue lock (the one you call the
   scheduler lock)

mq-deadline sets up a per-queue structure, deadline_data, and it has a
lock embedded in that structure. This is what mq-deadline uses to
serialize access to its data structures, as well as those in the queue
(like last_merge).

-- 
Jens Axboe
