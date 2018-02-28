Return-Path: <ming.lei@redhat.com>
Date: Wed, 28 Feb 2018 09:35:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <damien.lemoal@wdc.com>,
	Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH] blk-mq: Make sure that the affected zone is unlocked if
 a request times out
Message-ID: <20180228013537.GD11230@ming.t460p>
References: <20180228002830.3052-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180228002830.3052-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Feb 27, 2018 at 04:28:30PM -0800, Bart Van Assche wrote:
> If a request times out the .completed_request() method is not called

If BLK_EH_HANDLED is returned from .timeout(), __blk_mq_complete_request()
should have called .completed_request(). Otherwise, somewhere may be
wrong about timeout handling. Could you investigate why .completed_request
isn't called under this situation?

> and the .finish_request() method is only called if RQF_ELVPRIV has

.finish_request() is counter-pair of .prepare_request(), and both
aren't implemented by mq-deadline, so RQF_ELVPRIV needn't to be set,
and the current rule is that this flag is managed by block core.

> been set. Hence this patch that sets RQF_ELVPRIV and that adds a
> .finish_request() method. Without this patch, if a request times out
> the zone that request applies to remains locked forever and no further
> writes are accepted for that zone.
> 
> Fixes: 5700f69178e9 ("mq-deadline: Introduce zone locking support")
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> ---
>  block/mq-deadline.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index c56f211c8440..55d5b7a02d62 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -367,7 +367,8 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd)
>  	 * If the request needs its target zone locked, do it.
>  	 */
>  	blk_req_zone_write_lock(rq);
> -	rq->rq_flags |= RQF_STARTED;
> +	/* Set RQF_ELVPRIV to ensure that .finish_request() gets called */
> +	rq->rq_flags |= RQF_STARTED | RQF_ELVPRIV;
>  	return rq;
>  }
>  
> @@ -539,7 +540,9 @@ static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
>   * For zoned block devices, write unlock the target zone of
>   * completed write requests. Do this while holding the zone lock
>   * spinlock so that the zone is never unlocked while deadline_fifo_request()
> - * while deadline_next_request() are executing.
> + * while deadline_next_request() are executing. This function is called twice
> + * for requests that complete in a normal way and once for requests that time
> + * out.
>   */
>  static void dd_completed_request(struct request *rq)
>  {
> @@ -757,6 +760,7 @@ static struct elevator_type mq_deadline = {
>  		.insert_requests	= dd_insert_requests,
>  		.dispatch_request	= dd_dispatch_request,
>  		.completed_request	= dd_completed_request,
> +		.finish_request		= dd_completed_request,
>  		.next_request		= elv_rb_latter_request,
>  		.former_request		= elv_rb_former_request,
>  		.bio_merge		= dd_bio_merge,
> -- 
> 2.16.2
> 

-- 
Ming
