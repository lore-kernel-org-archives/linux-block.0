Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 2/8] blk-mq: protect completion path with RCU
To: Hannes Reinecke <hare@suse.de>, Tejun Heo <tj@kernel.org>, jack@suse.cz,
 axboe@kernel.dk, clm@fb.com, jbacik@fb.com
Cc: kernel-team@fb.com, linux-kernel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, peterz@infradead.org,
 jianchao.w.wang@oracle.com, Bart.VanAssche@wdc.com,
 linux-block@vger.kernel.org
References: <20180108191542.379478-1-tj@kernel.org>
 <20180108191542.379478-3-tj@kernel.org>
 <b4fdf1c4-2728-5537-a00f-09db0a4b25e4@suse.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9e10e315-fc97-a365-035c-7b88e1be0971@kernel.dk>
Date: Tue, 9 Jan 2018 08:22:36 -0700
MIME-Version: 1.0
In-Reply-To: <b4fdf1c4-2728-5537-a00f-09db0a4b25e4@suse.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/9/18 12:08 AM, Hannes Reinecke wrote:
> On 01/08/2018 08:15 PM, Tejun Heo wrote:
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
>>  
>>
> Hmm. Why do we need to call blk_mq_map_queue() here?
> Is there a chance that we end up with a _different_ hctx on completion
> than that one used for submission?
> If not, why can't we just keep a pointer to the hctx in struct request?

Mapping is the right thing to do. We cache the software queue, which
allows us to map back to the same hardware queue. There would be no
point in storing both, the mapping is very cheap. No point in bloating
the request with redundant information.

-- 
Jens Axboe
