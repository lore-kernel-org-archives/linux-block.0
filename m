Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 2/8] blk-mq: protect completion path with RCU
To: Bart Van Assche <Bart.VanAssche@wdc.com>, "jbacik@fb.com"
 <jbacik@fb.com>, "tj@kernel.org" <tj@kernel.org>, "jack@suse.cz"
 <jack@suse.cz>, "clm@fb.com" <clm@fb.com>
Cc: "kernel-team@fb.com" <kernel-team@fb.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>
References: <20180108191542.379478-1-tj@kernel.org>
 <20180108191542.379478-3-tj@kernel.org> <1515514359.2721.9.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <56f76ba3-839a-82de-b2ae-a1ddc40d9076@kernel.dk>
Date: Tue, 9 Jan 2018 09:17:11 -0700
MIME-Version: 1.0
In-Reply-To: <1515514359.2721.9.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/9/18 9:12 AM, Bart Van Assche wrote:
> On Mon, 2018-01-08 at 11:15 -0800, Tejun Heo wrote:
>> Currently, blk-mq protects only the issue path with RCU.  This patch
>> puts the completion path under the same RCU protection.  This will be
>> used to synchronize issue/completion against timeout by later patches,
>> which will also add the comments.
>>
>> Signed-off-by: Tejun Heo <tj@kernel.org>
>> ---
>>  block/blk-mq.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index ddc9261..6741c3e 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -584,11 +584,16 @@ static void hctx_lock(struct blk_mq_hw_ctx *hctx, int *srcu_idx)
>>  void blk_mq_complete_request(struct request *rq)
>>  {
>>  	struct request_queue *q = rq->q;
>> +	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, rq->mq_ctx->cpu);
>> +	int srcu_idx;
>>  
>>  	if (unlikely(blk_should_fake_timeout(q)))
>>  		return;
>> +
>> +	hctx_lock(hctx, &srcu_idx);
>>  	if (!blk_mark_rq_complete(rq))
>>  		__blk_mq_complete_request(rq);
>> +	hctx_unlock(hctx, srcu_idx);
>>  }
>>  EXPORT_SYMBOL(blk_mq_complete_request);
> 
> Hello Tejun,
> 
> I'm concerned about the additional CPU cycles needed for the new blk_mq_map_queue()
> call, although I know this call is cheap. Would the timeout code really get that
> much more complicated if the hctx_lock() and hctx_unlock() calls would be changed
> into rcu_read_lock() and rcu_read_unlock() calls? Would it be sufficient if
> "if (has_rcu) synchronize_rcu();" would be changed into "synchronize_rcu();" in
> blk_mq_timeout_work()?

It's a non concern, imho. We do queue mapping all over the place for a variety
of reasons, it's total noise, especially since we're calling [s]rcu anyway
after that.

-- 
Jens Axboe
