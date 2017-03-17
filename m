Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:11197 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751101AbdCQRkR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2017 13:40:17 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "tom.leiming@gmail.com" <tom.leiming@gmail.com>,
        "axboe@fb.com" <axboe@fb.com>
CC: "yizhan@redhat.com" <yizhan@redhat.com>
Subject: Re: [PATCH v1 2/3] blk-mq: comment on races related with timeout
 handler
Date: Fri, 17 Mar 2017 17:39:06 +0000
Message-ID: <1489772332.2826.6.camel@sandisk.com>
References: <20170317095711.5819-1-tom.leiming@gmail.com>
         <20170317095711.5819-3-tom.leiming@gmail.com>
In-Reply-To: <20170317095711.5819-3-tom.leiming@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, 2017-03-17 at 17:57 +0800, Ming Lei wrote:
> +/*
> + * When we reach here because queue is busy, REQ_ATOM_COMPLETE
> + * flag isn't set yet, so there may be race with timeout hanlder,
> + * but given rq->deadline is just set in .queue_rq() under
> + * this sitation, the race won't be possible in reality because
> + * rq->timeout should be set as big enough to cover the window
> + * between blk_mq_start_request() called from .queue_rq() and
> + * clearing REQ_ATOM_STARTED here.
> + */
>  static void __blk_mq_requeue_request(struct request *rq)
>  {
>  	struct request_queue *q =3D rq->q;
> @@ -700,6 +709,19 @@ static void blk_mq_check_expired(struct blk_mq_hw_ct=
x *hctx,
>  	if (!test_bit(REQ_ATOM_STARTED, &rq->atomic_flags))
>  		return;
> =20
> +	/*
> +	 * The rq being checked may have been freed and reallocated
> +	 * out already here, we avoid this race by checking rq->deadline
> +	 * and REQ_ATOM_COMPLETE flag together:
> +	 *
> +	 * - if rq->deadline is observed as new value because of
> +	 *   reusing, the rq won't be timed out because of timing.
> +	 * - if rq->deadline is observed as previous value,
> +	 *   REQ_ATOM_COMPLETE flag won't be cleared in reuse path
> +	 *   because we put a barrier between setting rq->deadline
> +	 *   and clearing the flag in blk_mq_start_request(), so
> +	 *   this rq won't be timed out too.
> +	 */
>  	if (time_after_eq(jiffies, rq->deadline)) {
>  		if (!blk_mark_rq_complete(rq))
>  			blk_mq_rq_timed_out(rq, reserved);

Since this explanation applies to the same race addressed by patch 1/3,
please consider squashing this patch into patch 1/3.

Thanks,

Bart.=
