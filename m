Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Thu, 20 Apr 2017 13:07:06 -0700
From: Omar Sandoval <osandov@osandov.com>
To: sbates@raithlin.com
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Damien.LeMoal@wdc.com,
	sagi@grimberg.me
Subject: Re: [PATCH v3 2/2] blk-mq: Add a polling specific stats function
Message-ID: <20170420200706.GA24823@vader.DHCP.thefacebook.com>
References: <1491567843-26190-1-git-send-email-sbates@raithlin.com>
 <1491567843-26190-3-git-send-email-sbates@raithlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491567843-26190-3-git-send-email-sbates@raithlin.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Apr 07, 2017 at 06:24:03AM -0600, sbates@raithlin.com wrote:
> From: Stephen Bates <sbates@raithlin.com>
> 
> Rather than bucketing IO statisics based on direction only we also
> bucket based on the IO size. This leads to improved polling
> performance. Update the bucket callback function and use it in the
> polling latency estimation.
> 
> Signed-off-by: Stephen Bates <sbates@raithlin.com>

Hey, Stephen, just taking a look at this now. Comments below.

> ---
>  block/blk-mq.c | 45 +++++++++++++++++++++++++++++++++++----------
>  1 file changed, 35 insertions(+), 10 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 061fc2c..5fd376b 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -42,6 +42,25 @@ static LIST_HEAD(all_q_list);
>  static void blk_mq_poll_stats_start(struct request_queue *q);
>  static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
>  
> +/* Must be consisitent with function below */
> +#define BLK_MQ_POLL_STATS_BKTS 16
> +static int blk_mq_poll_stats_bkt(const struct request *rq)
> +{
> +	int ddir, bytes, bucket;
> +
> +	ddir = blk_stat_rq_ddir(rq);

No need to call the wrapper function here, we can use rq_data_dir()
directly.

> +	bytes = blk_rq_bytes(rq);
> +
> +	bucket = ddir + 2*(ilog2(bytes) - 9);
> +
> +	if (bucket < 0)
> +		return -1;
> +	else if (bucket >= BLK_MQ_POLL_STATS_BKTS)
> +		return ddir + BLK_MQ_POLL_STATS_BKTS - 2;
> +
> +	return bucket;
> +}

Nitpicking here, but defining things in terms of the number of size
buckets seems more natural to me. How about something like this
(untested)? Note that this obviates the need for patch 1.

#define BLK_MQ_POLL_STATS_SIZE_BKTS 8
static unsigned int blk_mq_poll_stats_bkt(const struct request *rq)
{
	unsigned int size_bucket;

	size_bucket = clamp(ilog2(blk_rq_bytes(rq)) - 9, 0,
			    BLK_MQ_POLL_STATS_SIZE_BKTS - 1);
	return 2 * size_bucket + rq_data_dir(rq);
}

>  /*
>   * Check if any of the ctx's have pending work in this hardware queue
>   */
> @@ -2245,7 +2264,8 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
>  	q->mq_ops = set->ops;
>  
>  	q->poll_cb = blk_stat_alloc_callback(blk_mq_poll_stats_fn,
> -					     blk_stat_rq_ddir, 2, q);
> +					     blk_mq_poll_stats_bkt,
> +					     BLK_MQ_POLL_STATS_BKTS, q);

With the above change, this would become 2 * BLK_MQ_POLL_STATS_SIZE_BKTS.
