Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:29295 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752133AbdDJQWC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2017 12:22:02 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
CC: "hch@lst.de" <hch@lst.de>, "osandov@fb.com" <osandov@fb.com>
Subject: Re: [PATCH 3/3] blk-mq: unify hctx delay_work and run_work
Date: Mon, 10 Apr 2017 16:21:57 +0000
Message-ID: <1491841316.4199.12.camel@sandisk.com>
References: <1491839696-24783-1-git-send-email-axboe@fb.com>
         <1491839696-24783-4-git-send-email-axboe@fb.com>
In-Reply-To: <1491839696-24783-4-git-send-email-axboe@fb.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, 2017-04-10 at 09:54 -0600, Jens Axboe wrote:
> @@ -1281,27 +1280,39 @@ static void blk_mq_run_work_fn(struct work_struct=
 *work)
>  	struct blk_mq_hw_ctx *hctx;
> =20
>  	hctx =3D container_of(work, struct blk_mq_hw_ctx, run_work.work);
> -	__blk_mq_run_hw_queue(hctx);
> -}
> =20
> -static void blk_mq_delay_work_fn(struct work_struct *work)
> -{
> -	struct blk_mq_hw_ctx *hctx;
> +	/*
> +	 * If we are stopped, don't run the queue. The exception is if
> +	 * BLK_MQ_S_START_ON_RUN is set. For that case, we auto-clear
> +	 * the STOPPED bit and run it.
> +	 */
> +	if (test_bit(BLK_MQ_S_STOPPED, &hctx->state)) {
> +		if (!test_bit(BLK_MQ_S_START_ON_RUN, &hctx->state))
> +			return;
> =20
> -	hctx =3D container_of(work, struct blk_mq_hw_ctx, delay_work.work);
> +		clear_bit(BLK_MQ_S_START_ON_RUN, &hctx->state);
> +		clear_bit(BLK_MQ_S_STOPPED, &hctx->state);
> +	}
> =20
> -	if (test_and_clear_bit(BLK_MQ_S_STOPPED, &hctx->state))
> -		__blk_mq_run_hw_queue(hctx);
> +	__blk_mq_run_hw_queue(hctx);
>  }
> =20
> +
>  void blk_mq_delay_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs)
>  {
>  	if (unlikely(!blk_mq_hw_queue_mapped(hctx)))
>  		return;
> =20
> +	/*
> +	 * Stop the hw queue, then modify currently delayed work.
> +	 * This should prevent us from running the queue prematurely.
> +	 * Mark the queue as auto-clearing STOPPED when it runs.
> +	 */
>  	blk_mq_stop_hw_queue(hctx);
> -	kblockd_schedule_delayed_work_on(blk_mq_hctx_next_cpu(hctx),
> -			&hctx->delay_work, msecs_to_jiffies(msecs));
> +	set_bit(BLK_MQ_S_START_ON_RUN, &hctx->state);
> +	kblockd_mod_delayed_work_on(blk_mq_hctx_next_cpu(hctx),
> +					&hctx->run_work,
> +					msecs_to_jiffies(msecs));
>  }
>  EXPORT_SYMBOL(blk_mq_delay_queue);

Hello Jens,

Is it possible for a block driver to call blk_mq_delay_queue() while
blk_mq_delay_work_fn() is running? Can that result in BLK_MQ_S_STOPPED
and=A0BLK_MQ_S_START_ON_RUN being checked by=A0blk_mq_delay_work_fn() after
blk_mq_delay_queue() has set BLK_MQ_S_STOPPED and before it has set
BLK_MQ_S_START_ON_RUN?

Thanks,

Bart.=
