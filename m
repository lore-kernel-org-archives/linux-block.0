Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/3] blk-mq: use list_splice_tail() to insert requests
To: Steven Rostedt <rostedt@goodmis.org>,
 Johannes Thumshirn <jthumshirn@suse.de>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Kashyap Desai <kashyap.desai@broadcom.com>,
 Laurence Oberman <loberman@redhat.com>, Omar Sandoval <osandov@fb.com>,
 Christoph Hellwig <hch@lst.de>, Bart Van Assche <bart.vanassche@wdc.com>
References: <20180628031918.17694-1-ming.lei@redhat.com>
 <20180628031918.17694-2-ming.lei@redhat.com>
 <20180628072708.o2l56feqtdfbqail@linux-x5ow.site>
 <20180628155251.61a28180@gandalf.local.home>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <23eaca4b-65f7-00e5-aa9a-570306ea091d@kernel.dk>
Date: Thu, 28 Jun 2018 13:58:55 -0600
MIME-Version: 1.0
In-Reply-To: <20180628155251.61a28180@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/28/18 1:52 PM, Steven Rostedt wrote:
> On Thu, 28 Jun 2018 09:27:08 +0200
> Johannes Thumshirn <jthumshirn@suse.de> wrote:
> 
>> Hi Ming,
>>
>> On Thu, Jun 28, 2018 at 11:19:16AM +0800, Ming Lei wrote:
>>> +	list_for_each_entry(rq, list, queuelist) {
>>>  		BUG_ON(rq->mq_ctx != ctx);
>>> -		list_del_init(&rq->queuelist);
>>> -		__blk_mq_insert_req_list(hctx, rq, false);
>>> +		trace_block_rq_insert(hctx->queue, rq);
>>>  	}  
>>
>> I wonder if we really need the above loop unconditionally. It does
>> some BUG_ON() sanity checking (which I hate but it was already there
>> so not your problem) and tracing of the request insertion.
>>
>> So can we maybe only run this loop if tracing is enabled? Not sure if
>> this is possible though. Maybe Steven (Cced) can help here.
> 
> Yes:
> 
> 	if (trace_block_rq_insert_enabled()) {
> 		list_for_each_entry(rq, list, queuelist) {
> 			BUG_ON(rq->mq_ctx != ctx);
> 			list_del_init(&rq->queuelist);
> 			__blk_mq_insert_req_list(hctx, rq, false);
> 			trace_block_rq_insert(hctx->queue, rq);
> 	 	}
> 	}
> 
> This will only call the loop if the trace event "block_rq_insert" has
> been activated. It also uses the jump label infrastructure, so that if
> statement is a non-conditional branch (static_key_false()).

This works for both ftrace and blktrace?

-- 
Jens Axboe
