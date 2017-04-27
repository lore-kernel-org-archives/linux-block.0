Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Thu, 27 Apr 2017 15:37:13 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.com>, Omar Sandoval <osandov@fb.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 2/6] blk-mq: Fix the comment above blk_mq_quiesce_queue()
Message-ID: <20170427223713.GA2806@vader.DHCP.thefacebook.com>
References: <20170427155437.23228-1-bart.vanassche@sandisk.com>
 <20170427155437.23228-3-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170427155437.23228-3-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Apr 27, 2017 at 08:54:33AM -0700, Bart Van Assche wrote:
> The first version of blk_mq_quiesce_queue() that was posted on
> the linux-block mailing list waited for ongoing .queue_rq()
> calls but did not stop the request queue. The current version
> however stops the request queue. Hence reflect this behavior in
> the comment above that function.

Can you just combine this with patch 1?

> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 3b3420f76b5a..113c09d8026c 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -157,8 +157,7 @@ EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
>   * @q: request queue.
>   *
>   * Note: this function does not prevent that the struct request end_io()
> - * callback function is invoked. Additionally, it is not prevented that
> - * new queue_rq() calls occur unless the queue has been stopped first.
> + * callback function is invoked.
>   */
>  void blk_mq_quiesce_queue(struct request_queue *q)
>  {
> -- 
> 2.12.2
> 
