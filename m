Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH] blk-mq: Allow blocking queue tag iter callbacks
To: Keith Busch <keith.busch@intel.com>,
        Linux Block <linux-block@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bart.vanassche@gmail.com>
References: <20180924210919.9995-1-keith.busch@intel.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <45fc0cf9-92b2-2380-d11b-428613a470c2@oracle.com>
Date: Tue, 25 Sep 2018 10:11:23 +0800
MIME-Version: 1.0
In-Reply-To: <20180924210919.9995-1-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Keith

On 09/25/2018 05:09 AM, Keith Busch wrote:
> -	/* A deadlock might occur if a request is stuck requiring a
> -	 * timeout at the same time a queue freeze is waiting
> -	 * completion, since the timeout code would not be able to
> -	 * acquire the queue reference here.
> -	 *
> -	 * That's why we don't use blk_queue_enter here; instead, we use
> -	 * percpu_ref_tryget directly, because we need to be able to
> -	 * obtain a reference even in the short window between the queue
> -	 * starting to freeze, by dropping the first reference in
> -	 * blk_freeze_queue_start, and the moment the last request is
> -	 * consumed, marked by the instant q_usage_counter reaches
> -	 * zero.
> -	 */
> -	if (!percpu_ref_tryget(&q->q_usage_counter))
> +	if (!blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &next))
>  		return;

We cannot discard the percpu_ref_tryget here.

There following code in blk_mq_timeout_work still need it:

	if (next != 0) {
		mod_timer(&q->timeout, next);
	} else {
		queue_for_each_hw_ctx(q, hctx, i) {
			/* the hctx may be unmapped, so check it here */
			if (blk_mq_hw_queue_mapped(hctx))
				blk_mq_tag_idle(hctx);
		}
	}

Thanks
Jianchao
