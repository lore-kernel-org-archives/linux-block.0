Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 4/4] block: rearrange a few request fields for better
 cache layout
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-block@vger.kernel.org, osandov@fb.com, bart.vanassche@wdc.com
References: <1515544167-10751-1-git-send-email-axboe@kernel.dk>
 <1515544167-10751-5-git-send-email-axboe@kernel.dk>
 <20180110184333.GC30831@vader.DHCP.thefacebook.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f81424de-4dc0-a458-1f0c-5592c7fbcd20@kernel.dk>
Date: Wed, 10 Jan 2018 11:45:49 -0700
MIME-Version: 1.0
In-Reply-To: <20180110184333.GC30831@vader.DHCP.thefacebook.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/10/18 11:43 AM, Omar Sandoval wrote:
>> -	INIT_LIST_HEAD(&rq->queuelist);
>>  	/* csd/requeue_work/fifo_time is initialized before use */
>>  	rq->q = data->q;
>>  	rq->mq_ctx = data->ctx;
>> +	rq->rq_flags = 0;
>> +	rq->cpu = -1;
>>  	rq->cmd_flags = op;
>>  	if (data->flags & BLK_MQ_REQ_PREEMPT)
>>  		rq->rq_flags |= RQF_PREEMPT;
>>  	if (blk_queue_io_stat(data->q))
>>  		rq->rq_flags |= RQF_IO_STAT;
>> -	rq->cpu = -1;
>> +	/* do not touch atomic flags, it needs atomic ops against the timer */
> 
> This comment was just removed in a previous patch but it snuck back in.

Eagle eyes - thanks, I will kill it.

-- 
Jens Axboe
