Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v4 12/12] blk-mq: Warn when attempting to run a hardware
 queue that is not mapped
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bart.vanassche@sandisk.com>, Hannes Reinecke
 <hare@suse.com>, Omar Sandoval <osandov@fb.com>,
 Ming Lei <ming.lei@redhat.com>
References: <20170619220801.12557-1-bart.vanassche@wdc.com>
 <20170619220801.12557-13-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f8454b86-b7d2-1f9c-69f6-0e191cea1bef@kernel.dk>
Date: Mon, 19 Jun 2017 17:06:01 -0600
MIME-Version: 1.0
In-Reply-To: <20170619220801.12557-13-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/19/2017 04:08 PM, Bart Van Assche wrote:
> From: Bart Van Assche <bart.vanassche@sandisk.com>
> 
> A queue must be frozen while the mapped state of a hardware queue
> is changed. Additionally, any change of the mapped state is
> followed by a call to blk_mq_map_swqueue() (see also
> blk_mq_init_allocated_queue() and blk_mq_update_nr_hw_queues()).
> Since blk_mq_map_swqueue() does not map any unmapped hardware
> queue onto any software queue, no attempt will be made to run
> an unmapped hardware queue. Hence issue a warning upon attempts
> to run an unmapped hardware queue.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e7b0d69fdf65..c6218f32770d 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1140,8 +1140,9 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
>  static void __blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async,
>  					unsigned long msecs)
>  {
> -	if (unlikely(blk_mq_hctx_stopped(hctx) ||
> -		     !blk_mq_hw_queue_mapped(hctx)))
> +	WARN_ON_ONCE(!blk_mq_hw_queue_mapped(hctx));
> +

	if (WARN_ON_ONCE(!blk_mq_hw_queue_mapped(hctx)))
		return;

-- 
Jens Axboe
