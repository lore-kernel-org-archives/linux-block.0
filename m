Return-Path: <jack@suse.cz>
Date: Mon, 14 Nov 2016 10:01:13 +0100
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@fb.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, jack@suse.cz
Subject: Re: [PATCH 1/2] blk-wbt: store queue instead of bdi
Message-ID: <20161114090113.GD2524@quack2.suse.cz>
References: <1478877717-19624-1-git-send-email-axboe@fb.com>
 <1478877717-19624-2-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478877717-19624-2-git-send-email-axboe@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Fri 11-11-16 08:21:56, Jens Axboe wrote:
> The bdi was a leftover from when the code was block layer agnostic.
> Now that we just support a block layer user, store the queue directly.
> 
> Signed-off-by: Jens Axboe <axboe@fb.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

									Honza
> ---
>  block/blk-wbt.c | 20 ++++++++++++--------
>  block/blk-wbt.h |  4 +---
>  2 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> index 889c17ff8503..4ab9cebc8003 100644
> --- a/block/blk-wbt.c
> +++ b/block/blk-wbt.c
> @@ -96,7 +96,7 @@ static void wb_timestamp(struct rq_wb *rwb, unsigned long *var)
>   */
>  static bool wb_recent_wait(struct rq_wb *rwb)
>  {
> -	struct bdi_writeback *wb = &rwb->bdi->wb;
> +	struct bdi_writeback *wb = &rwb->queue->backing_dev_info.wb;
>  
>  	return time_before(jiffies, wb->dirty_sleep + HZ);
>  }
> @@ -279,6 +279,7 @@ enum {
>  
>  static int __latency_exceeded(struct rq_wb *rwb, struct blk_rq_stat *stat)
>  {
> +	struct backing_dev_info *bdi = &rwb->queue->backing_dev_info;
>  	u64 thislat;
>  
>  	/*
> @@ -293,7 +294,7 @@ static int __latency_exceeded(struct rq_wb *rwb, struct blk_rq_stat *stat)
>  	thislat = rwb_sync_issue_lat(rwb);
>  	if (thislat > rwb->cur_win_nsec ||
>  	    (thislat > rwb->min_lat_nsec && !stat[0].nr_samples)) {
> -		trace_wbt_lat(rwb->bdi, thislat);
> +		trace_wbt_lat(bdi, thislat);
>  		return LAT_EXCEEDED;
>  	}
>  
> @@ -317,13 +318,13 @@ static int __latency_exceeded(struct rq_wb *rwb, struct blk_rq_stat *stat)
>  	 * If the 'min' latency exceeds our target, step down.
>  	 */
>  	if (stat[0].min > rwb->min_lat_nsec) {
> -		trace_wbt_lat(rwb->bdi, stat[0].min);
> -		trace_wbt_stat(rwb->bdi, stat);
> +		trace_wbt_lat(bdi, stat[0].min);
> +		trace_wbt_stat(bdi, stat);
>  		return LAT_EXCEEDED;
>  	}
>  
>  	if (rwb->scale_step)
> -		trace_wbt_stat(rwb->bdi, stat);
> +		trace_wbt_stat(bdi, stat);
>  
>  	return LAT_OK;
>  }
> @@ -338,7 +339,9 @@ static int latency_exceeded(struct rq_wb *rwb)
>  
>  static void rwb_trace_step(struct rq_wb *rwb, const char *msg)
>  {
> -	trace_wbt_step(rwb->bdi, msg, rwb->scale_step, rwb->cur_win_nsec,
> +	struct backing_dev_info *bdi = &rwb->queue->backing_dev_info;
> +
> +	trace_wbt_step(bdi, msg, rwb->scale_step, rwb->cur_win_nsec,
>  			rwb->wb_background, rwb->wb_normal, rwb->wb_max);
>  }
>  
> @@ -420,7 +423,8 @@ static void wb_timer_fn(unsigned long data)
>  
>  	status = latency_exceeded(rwb);
>  
> -	trace_wbt_timer(rwb->bdi, status, rwb->scale_step, inflight);
> +	trace_wbt_timer(&rwb->queue->backing_dev_info, status, rwb->scale_step,
> +			inflight);
>  
>  	/*
>  	 * If we exceeded the latency target, step down. If we did not,
> @@ -700,7 +704,7 @@ int wbt_init(struct request_queue *q, struct wb_stat_ops *ops)
>  	rwb->wc = 1;
>  	rwb->queue_depth = RWB_DEF_DEPTH;
>  	rwb->last_comp = rwb->last_issue = jiffies;
> -	rwb->bdi = &q->backing_dev_info;
> +	rwb->queue = q;
>  	rwb->win_nsec = RWB_WINDOW_NSEC;
>  	rwb->stat_ops = ops;
>  	rwb->ops_data = q;
> diff --git a/block/blk-wbt.h b/block/blk-wbt.h
> index e57700337c26..09c61a3f8295 100644
> --- a/block/blk-wbt.h
> +++ b/block/blk-wbt.h
> @@ -87,7 +87,7 @@ struct rq_wb {
>  	unsigned long last_issue;		/* last non-throttled issue */
>  	unsigned long last_comp;		/* last non-throttled comp */
>  	unsigned long min_lat_nsec;
> -	struct backing_dev_info *bdi;
> +	struct request_queue *queue;
>  	struct rq_wait rq_wait[WBT_NUM_RWQ];
>  
>  	struct wb_stat_ops *stat_ops;
> @@ -104,8 +104,6 @@ static inline unsigned int wbt_inflight(struct rq_wb *rwb)
>  	return ret;
>  }
>  
> -struct backing_dev_info;
> -
>  #ifdef CONFIG_BLK_WBT
>  
>  void __wbt_done(struct rq_wb *, enum wbt_flags);
> -- 
> 2.7.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
