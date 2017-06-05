Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:37725 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751188AbdFEVZd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Jun 2017 17:25:33 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH v4 01/11] blk-mq: fix direct issue
Date: Mon, 5 Jun 2017 21:25:29 +0000
Message-ID: <1496697927.2623.23.camel@sandisk.com>
References: <20170605155925.7896-1-ming.lei@redhat.com>
         <20170605155925.7896-2-ming.lei@redhat.com>
In-Reply-To: <20170605155925.7896-2-ming.lei@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, 2017-06-05 at 23:59 +0800, Ming Lei wrote:
> +static void __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
> +					struct request *rq,
> +					blk_qc_t *cookie, bool may_sleep)
>  {
>  	struct request_queue *q =3D rq->q;
>  	struct blk_mq_queue_data bd =3D {
>  		.rq =3D rq,
>  		.last =3D true,
>  	};
> -	struct blk_mq_hw_ctx *hctx;
>  	blk_qc_t new_cookie;
>  	int ret;
> +	bool run_queue =3D true;
> +
> +	if (blk_mq_hctx_stopped(hctx)) {
> +		run_queue =3D false;
> +		goto insert;
> +	}
> =20
>  	if (q->elevator)
>  		goto insert;
> =20
> -	if (!blk_mq_get_driver_tag(rq, &hctx, false))
> +	if (!blk_mq_get_driver_tag(rq, NULL, false))
>  		goto insert;
> =20
>  	new_cookie =3D request_to_qc_t(hctx, rq);
> @@ -1439,7 +1445,7 @@ static void __blk_mq_try_issue_directly(struct requ=
est *rq, blk_qc_t *cookie,
> =20
>  	__blk_mq_requeue_request(rq);
>  insert:
> -	blk_mq_sched_insert_request(rq, false, true, false, may_sleep);
> +	blk_mq_sched_insert_request(rq, false, run_queue, false, may_sleep);
>  }
> =20
>  static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
> @@ -1447,7 +1453,7 @@ static void blk_mq_try_issue_directly(struct blk_mq=
_hw_ctx *hctx,
>  {
>  	if (!(hctx->flags & BLK_MQ_F_BLOCKING)) {
>  		rcu_read_lock();
> -		__blk_mq_try_issue_directly(rq, cookie, false);
> +		__blk_mq_try_issue_directly(hctx, rq, cookie, false);
>  		rcu_read_unlock();
>  	} else {
>  		unsigned int srcu_idx;
> @@ -1455,7 +1461,7 @@ static void blk_mq_try_issue_directly(struct blk_mq=
_hw_ctx *hctx,
>  		might_sleep();
> =20
>  		srcu_idx =3D srcu_read_lock(&hctx->queue_rq_srcu);
> -		__blk_mq_try_issue_directly(rq, cookie, true);
> +		__blk_mq_try_issue_directly(hctx, rq, cookie, true);
>  		srcu_read_unlock(&hctx->queue_rq_srcu, srcu_idx);
>  	}
>  }

Hello Ming,

It seems like you are assuming that the hardware queue of the rq argument
passed to __blk_mq_try_issue_directly() matches the hctx argument? Sorry
but I think that's an incorrect assumption. Please have a look at the
following code in blk_mq_make_request():

		if (same_queue_rq)
			blk_mq_try_issue_directly(data.hctx, same_queue_rq,
					&cookie);

Bart.=
