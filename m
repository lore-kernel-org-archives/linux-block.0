Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH v4] blk-mq: Fix race conditions in request timeout
 handling
To: "tj@kernel.org" <tj@kernel.org>, Bart Van Assche
 <Bart.VanAssche@wdc.com>, "israelr@mellanox.com" <israelr@mellanox.com>
Cc: "ming.lei@redhat.com" <ming.lei@redhat.com>, "hch@lst.de" <hch@lst.de>,
 "maxg@mellanox.com" <maxg@mellanox.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>
References: <20180410135541.GA22340@ming.t460p>
 <7c4a8b019182d5a9259ef20e6462b3f6a533abed.camel@wdc.com>
 <20180410143007.GB22340@ming.t460p>
 <e2762e359649946543ee22cf6ebf0c08410f7963.camel@wdc.com>
 <20180410152553.GC22340@ming.t460p>
 <20180410153031.GO3126663@devbig577.frc2.facebook.com>
 <20180410153812.GA3219@ming.t460p>
 <20180410154043.GP3126663@devbig577.frc2.facebook.com>
 <20180410213323.GC793541@devbig577.frc2.facebook.com>
 <d88becef654cde4b5382c1ebddb0aeba963c0578.camel@wdc.com>
 <20180410215456.GD793541@devbig577.frc2.facebook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7a586854-33a5-fe3b-6d94-24d305696126@grimberg.me>
Date: Wed, 11 Apr 2018 17:24:49 +0300
MIME-Version: 1.0
In-Reply-To: <20180410215456.GD793541@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


> Ah, yeah, I was moving it out of add_timer but forgot to actully add
> it to the issue path.  Fixed patch below.
> 
> BTW, no matter what we do w/ the request handover between normal and
> timeout paths, we'd need something similar.  Otherwise, while we can
> reduce the window, we can't get rid of it.
> 
> Thanks.

Just noticed this one, this looks interesting to me as well. Israel,
can you run your test with this patch?

> 
> ---
>   block/blk-mq.c         |   45 ++++++++++++++++++++++++++++++++-------------
>   include/linux/blkdev.h |    2 ++
>   2 files changed, 34 insertions(+), 13 deletions(-)
> 
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -642,6 +642,8 @@ void blk_mq_complete_request(struct requ
>   	hctx_lock(hctx, &srcu_idx);
>   	if (blk_mq_rq_aborted_gstate(rq) != rq->gstate)
>   		__blk_mq_complete_request(rq);
> +	else
> +		rq->missed_completion = true;
>   	hctx_unlock(hctx, srcu_idx);
>   }
>   EXPORT_SYMBOL(blk_mq_complete_request);
> @@ -684,6 +686,7 @@ void blk_mq_start_request(struct request
>   
>   	blk_mq_rq_update_state(rq, MQ_RQ_IN_FLIGHT);
>   	blk_add_timer(rq);
> +	rq->missed_completion = false;
>   
>   	write_seqcount_end(&rq->gstate_seq);
>   	preempt_enable();
> @@ -881,7 +884,7 @@ static void blk_mq_check_expired(struct
>   	}
>   }
>   
> -static void blk_mq_timeout_sync_rcu(struct request_queue *q)
> +static void blk_mq_timeout_sync_rcu(struct request_queue *q, bool clear)
>   {
>   	struct blk_mq_hw_ctx *hctx;
>   	bool has_rcu = false;
> @@ -896,7 +899,8 @@ static void blk_mq_timeout_sync_rcu(stru
>   		else
>   			synchronize_srcu(hctx->srcu);
>   
> -		hctx->need_sync_rcu = false;
> +		if (clear)
> +			hctx->need_sync_rcu = false;
>   	}
>   	if (has_rcu)
>   		synchronize_rcu();
> @@ -917,25 +921,37 @@ static void blk_mq_terminate_expired(str
>   		blk_mq_rq_timed_out(hctx, rq, priv, reserved);
>   }
>   
> -static void blk_mq_finish_timeout_reset(struct blk_mq_hw_ctx *hctx,
> +static void blk_mq_timeout_reset_return(struct blk_mq_hw_ctx *hctx,
>   		struct request *rq, void *priv, bool reserved)
>   {
>   	/*
>   	 * @rq's timer reset has gone through rcu synchronization and is
>   	 * visible now.  Allow normal completions again by resetting
>   	 * ->aborted_gstate.  Don't clear RQF_MQ_TIMEOUT_RESET here as
> -	 * there's no memory ordering around ->aborted_gstate making it the
> -	 * only field safe to update.  Let blk_add_timer() clear it later
> -	 * when the request is recycled or times out again.
> -	 *
> -	 * As nothing prevents from completion happening while
> -	 * ->aborted_gstate is set, this may lead to ignored completions
> -	 * and further spurious timeouts.
> +	 * blk_mq_timeout_reset_cleanup() needs it again and there's no
> +	 * memory ordering around ->aborted_gstate making it the only field
> +	 * safe to update.  Let blk_add_timer() clear it later when the
> +	 * request is recycled or times out again.
>   	 */
>   	if (rq->rq_flags & RQF_MQ_TIMEOUT_RESET)
>   		blk_mq_rq_update_aborted_gstate(rq, 0);
>   }
>   
> +static void blk_mq_timeout_reset_cleanup(struct blk_mq_hw_ctx *hctx,
> +		struct request *rq, void *priv, bool reserved)
> +{
> +	/*
> +	 * @rq is now fully returned to the normal path.  If normal
> +	 * completion raced timeout handling, execute the missed completion
> +	 * here.  This is safe because 1. ->missed_completion can no longer
> +	 * be asserted because nothing is timing out right now and 2. if
> +	 * ->missed_completion is set, @rq is safe from recycling because
> +	 * nobody could have completed it.
> +	 */
> +	if ((rq->rq_flags & RQF_MQ_TIMEOUT_RESET) && rq->missed_completion)
> +		blk_mq_complete_request(rq);
> +}
> +
>   static void blk_mq_timeout_work(struct work_struct *work)
>   {
>   	struct request_queue *q =
> @@ -976,7 +992,7 @@ static void blk_mq_timeout_work(struct w
>   		 * becomes a problem, we can add per-hw_ctx rcu_head and
>   		 * wait in parallel.
>   		 */
> -		blk_mq_timeout_sync_rcu(q);
> +		blk_mq_timeout_sync_rcu(q, true);
>   
>   		/* terminate the ones we won */
>   		blk_mq_queue_tag_busy_iter(q, blk_mq_terminate_expired,
> @@ -988,9 +1004,12 @@ static void blk_mq_timeout_work(struct w
>   		 * reset racing against recycling.
>   		 */
>   		if (nr_resets) {
> -			blk_mq_timeout_sync_rcu(q);
> +			blk_mq_timeout_sync_rcu(q, false);
> +			blk_mq_queue_tag_busy_iter(q,
> +					blk_mq_timeout_reset_return, NULL);
> +			blk_mq_timeout_sync_rcu(q, true);
>   			blk_mq_queue_tag_busy_iter(q,
> -					blk_mq_finish_timeout_reset, NULL);
> +					blk_mq_timeout_reset_cleanup, NULL);
>   		}
>   	}
>   
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -227,6 +227,8 @@ struct request {
>   
>   	unsigned int extra_len;	/* length of alignment and padding */
>   
> +	bool missed_completion;
> +

Would be nicer if we can flag this somewhere instead of adding a hole to
struct request...
