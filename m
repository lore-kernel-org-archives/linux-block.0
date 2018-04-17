Return-Path: <martin@lichtvoll.de>
From: Martin Steigerwald <martin@lichtvoll.de>
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: axboe@kernel.dk, bart.vanassche@wdc.com, tj@kernel.org, ming.lei@redhat.com, stable@vger.kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: start request gstate with gen 1
Date: Tue, 17 Apr 2018 14:10:08 +0200
Message-ID: <2612135.Ur0PZolWSD@merkaba>
In-Reply-To: <1523936780-1589-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1523936780-1589-1-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-block@vger.kernel.org>

Hi Jianchao,

Jianchao Wang - 17.04.18, 05:46:
> rq->gstate and rq->aborted_gstate both are zero before rqs are
> allocated. If we have a small timeout, when the timer fires,
> there could be rqs that are never allocated, and also there could
> be rq that has been allocated but not initialized and started. At
> the moment, the rq->gstate and rq->aborted_gstate both are 0, thus
> the blk_mq_terminate_expired will identify the rq is timed out and
> invoke .timeout early.

For testing it I add it to 4.16.2 with the patches I have already?

- '[PATCH] blk-mq_Directly schedule q->timeout_work when aborting a 
request.mbox'

- '[PATCH v2] block: Change a rcu_read_{lock,unlock}_sched() pair into 
rcu_read_{lock,unlock}().mbox'

- '[PATCH V4 1_2] blk-mq_set RQF_MQ_TIMEOUT_EXPIRED when the rq'\''s 
timeout isn'\''t handled.mbox'

- '[PATCH V4 2_2] blk-mq_fix race between complete and 
BLK_EH_RESET_TIMER.mbox'

> For scsi, this will cause scsi_times_out to be invoked before the
> scsi_cmnd is not initialized, scsi_cmnd->device is still NULL at
> the moment, then we will get crash.
> 
> Cc: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Martin Steigerwald <Martin@Lichtvoll.de>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>  block/blk-core.c | 4 ++++
>  block/blk-mq.c   | 7 +++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index abcb868..ce62681 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -201,6 +201,10 @@ void blk_rq_init(struct request_queue *q, struct
> request *rq) rq->part = NULL;
>  	seqcount_init(&rq->gstate_seq);
>  	u64_stats_init(&rq->aborted_gstate_sync);
> +	/*
> +	 * See comment of blk_mq_init_request
> +	 */
> +	WRITE_ONCE(rq->gstate, MQ_RQ_GEN_INC);
>  }
>  EXPORT_SYMBOL(blk_rq_init);
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index f5c7dbc..d62030a 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2069,6 +2069,13 @@ static int blk_mq_init_request(struct
> blk_mq_tag_set *set, struct request *rq,
> 
>  	seqcount_init(&rq->gstate_seq);
>  	u64_stats_init(&rq->aborted_gstate_sync);
> +	/*
> +	 * start gstate with gen 1 instead of 0, otherwise it will be equal
> +	 * to aborted_gstate, and be identified timed out by
> +	 * blk_mq_terminate_expired.
> +	 */
> +	WRITE_ONCE(rq->gstate, MQ_RQ_GEN_INC);
> +
>  	return 0;
>  }


-- 
Martin
