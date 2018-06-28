Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/3] blk-mq: use list_splice_tail() to insert requests
To: Johannes Thumshirn <jthumshirn@suse.de>, Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Kashyap Desai <kashyap.desai@broadcom.com>,
 Laurence Oberman <loberman@redhat.com>, Omar Sandoval <osandov@fb.com>,
 Christoph Hellwig <hch@lst.de>, Bart Van Assche <bart.vanassche@wdc.com>,
 Steven Rostedt <rostedt@goodmis.org>
References: <20180628031918.17694-1-ming.lei@redhat.com>
 <20180628031918.17694-2-ming.lei@redhat.com>
 <20180628072708.o2l56feqtdfbqail@linux-x5ow.site>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ed23b5c4-1f75-46e6-2dea-ff21c3fe58cd@kernel.dk>
Date: Thu, 28 Jun 2018 13:44:37 -0600
MIME-Version: 1.0
In-Reply-To: <20180628072708.o2l56feqtdfbqail@linux-x5ow.site>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/28/18 1:27 AM, Johannes Thumshirn wrote:
> Hi Ming,
> 
> On Thu, Jun 28, 2018 at 11:19:16AM +0800, Ming Lei wrote:
>> +	list_for_each_entry(rq, list, queuelist) {
>>  		BUG_ON(rq->mq_ctx != ctx);
>> -		list_del_init(&rq->queuelist);
>> -		__blk_mq_insert_req_list(hctx, rq, false);
>> +		trace_block_rq_insert(hctx->queue, rq);
>>  	}
> 
> I wonder if we really need the above loop unconditionally. It does
> some BUG_ON() sanity checking (which I hate but it was already there
> so not your problem) and tracing of the request insertion.

We can probably kill that now, but jfyi, this was introduced because
of a specific issue.

> So can we maybe only run this loop if tracing is enabled? Not sure if
> this is possible though. Maybe Steven (Cced) can help here.

Don't think it is, since we can be tracing through a variety of
different ways. I think it's best to leave this as-is. If this
were to be changed, it'd have to be a separate patch anyway,
it should not be mixed up with this change.

It does need the list_splice_tail_init() as others found out,
or you'll leave the source list corrupted.

-- 
Jens Axboe
