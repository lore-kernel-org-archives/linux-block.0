Return-Path: <ming.lei@redhat.com>
Date: Tue, 17 Apr 2018 12:46:08 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: axboe@kernel.dk, bart.vanassche@wdc.com, tj@kernel.org,
	Martin@Lichtvoll.de, stable@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: start request gstate with gen 1
Message-ID: <20180417044603.GA16286@ming.t460p>
References: <1523936780-1589-1-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1523936780-1589-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Apr 17, 2018 at 11:46:20AM +0800, Jianchao Wang wrote:
> rq->gstate and rq->aborted_gstate both are zero before rqs are
> allocated. If we have a small timeout, when the timer fires,
> there could be rqs that are never allocated, and also there could
> be rq that has been allocated but not initialized and started. At
> the moment, the rq->gstate and rq->aborted_gstate both are 0, thus
> the blk_mq_terminate_expired will identify the rq is timed out and
> invoke .timeout early.
> 
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
> @@ -201,6 +201,10 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
>  	rq->part = NULL;
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
> @@ -2069,6 +2069,13 @@ static int blk_mq_init_request(struct blk_mq_tag_set *set, struct request *rq,
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

Good catch, blk_mq_check_expired() is bypassed, but it is still hit
by blk_mq_terminate_expired().

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming
