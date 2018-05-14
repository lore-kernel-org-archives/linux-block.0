Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH] blk-mq: Rework blk-mq timeout handling again
To: Bart Van Assche <Bart.VanAssche@wdc.com>, "hch@lst.de" <hch@lst.de>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "israelr@mellanox.com" <israelr@mellanox.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "sebott@linux.ibm.com" <sebott@linux.ibm.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "maxg@mellanox.com" <maxg@mellanox.com>,
        "tj@kernel.org" <tj@kernel.org>
References: <20180510175607.27937-1-bart.vanassche@wdc.com>
 <73f77c62-25ca-0915-6f5b-452d60258f05@oracle.com>
 <20180511123519.GA14123@lst.de>
 <13279046837412fd5cfe845a27e469a23125caf3.camel@wdc.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <beab60f7-5fee-f1d8-12c3-c43d005d6427@oracle.com>
Date: Mon, 14 May 2018 09:37:30 +0800
MIME-Version: 1.0
In-Reply-To: <13279046837412fd5cfe845a27e469a23125caf3.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>


Hi bart

On 05/11/2018 11:29 PM, Bart Van Assche wrote:
> On Fri, 2018-05-11 at 14:35 +0200, Christoph Hellwig wrote:
>>> It should be due to union blk_deadline_and_state. 
>>> +union blk_deadline_and_state {
>>> +	struct {
>>> +		uint32_t generation:30;
>>> +		uint32_t state:2;
>>> +		uint32_t deadline;
>>> +	};
>>> +	unsigned long legacy_deadline;
>>> +	uint64_t das;
>>> +};
>>
>> Yikes.  Or we just move it into a separate field.  This patch already
>> shrinks struct request a lot, so I'd rather do that to keep it simple.
> 
> Hello Christoph,
> 
> Are you perhaps referring to the legacy_deadline field? Have you noticed that
> Jianchao used a legacy block layer function in blk-mq code and that that is
> why a wrong value for the deadline appeared in the trace output?
> 

I use blk_rq_deadline because __blk_add_timer uses it.

-
 	/*
 	 * If the timer isn't already pending or this timeout is earlier
 	 * than an existing one, modify the timer. Round up to next nearest
 	 * second.
 	 */
 	expiry = blk_rq_timeout(round_jiffies_up(blk_rq_deadline(req)));
-
 	if (!timer_pending(&q->timeout) ||
 	    time_before(expiry, q->timeout.expires)) {
 		unsigned long diff = q->timeout.expires - expiry;


This is also the reason why there is no issue about timeout when test.
blk_rq_timeout will return reasonable value.

In addition, on a 64bit system, how do you set up the timer with a 32bit deadline ?


Thanks
Jianchao
