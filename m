Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 3/4] blk-mq: provide internal in-flight variant
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, brking@linux.vnet.ibm.com
References: <1501790516-6924-1-git-send-email-axboe@kernel.dk>
 <1501790516-6924-4-git-send-email-axboe@kernel.dk>
 <20170804111728.GB15989@ming.t460p>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <354f5e68-ecba-853d-c6e5-3f5d363a667c@kernel.dk>
Date: Fri, 4 Aug 2017 07:55:41 -0600
MIME-Version: 1.0
In-Reply-To: <20170804111728.GB15989@ming.t460p>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/04/2017 05:17 AM, Ming Lei wrote:
> On Thu, Aug 03, 2017 at 02:01:55PM -0600, Jens Axboe wrote:
>> We don't have to inc/dec some counter, since we can just
>> iterate the tags. That makes inc/dec a noop, but means we
>> have to iterate busy tags to get an in-flight count.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  block/blk-mq.c        | 24 ++++++++++++++++++++++++
>>  block/blk-mq.h        |  2 ++
>>  block/genhd.c         | 29 +++++++++++++++++++++++++++++
>>  include/linux/genhd.h | 25 +++----------------------
>>  4 files changed, 58 insertions(+), 22 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 05dfa3f270ae..37035891e120 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -86,6 +86,30 @@ static void blk_mq_hctx_clear_pending(struct blk_mq_hw_ctx *hctx,
>>  	sbitmap_clear_bit(&hctx->ctx_map, ctx->index_hw);
>>  }
>>  
>> +struct mq_inflight {
>> +	struct hd_struct *part;
>> +	unsigned int inflight;
>> +};
>> +
>> +static void blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
>> +				  struct request *rq, void *priv,
>> +				  bool reserved)
>> +{
>> +	struct mq_inflight *mi = priv;
>> +
>> +	if (rq->part == mi->part)
>> +		mi->inflight++;
>> +}
>> +
>> +unsigned int blk_mq_in_flight(struct request_queue *q,
>> +			       struct hd_struct *part)
>> +{
>> +	struct mq_inflight mi = { .part = part, .inflight = 0 };
>> +
>> +	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
>> +	return mi.inflight;
>> +}
> 
> IMO it might not be as efficient as per-cpu variable.
> 
> For example, NVMe on one 128-core system, if we use percpu variable,
> it is enough to read 128 local variable from each CPU for accounting
> one in_flight.

IFF the system is configured with NR_CPUS=128. Most distros go
much bigger. On the other hand, we know that nr_queues will
never be bigger than the number of online cpus, not the number
of possible cpus.

> But in this way of blk_mq_in_flight(), we need to do 128 
> sbitmap search, and one sbitmap search need to read at least
> 16 words of 'unsigned long',  and total 128*16 read.

If that ends up being a problem, it hasn't in testing, then we
could always stuff an index in front of the full sbitmap.

> So maybe we need to compare the two approaches first.

We already did, back when this was originally posted. See the
thread from end may / start june and the results from Brian.

-- 
Jens Axboe
