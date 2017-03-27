Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:2865 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751385AbdC0Ptk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2017 11:49:40 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "tom.leiming@gmail.com" <tom.leiming@gmail.com>,
        "axboe@fb.com" <axboe@fb.com>
CC: "tj@kernel.org" <tj@kernel.org>, "hare@suse.de" <hare@suse.de>
Subject: Re: [PATCH v3 4/4] block: block new I/O just after queue is set as
 dying
Date: Mon, 27 Mar 2017 15:49:10 +0000
Message-ID: <1490629737.2461.10.camel@sandisk.com>
References: <20170327120658.29864-1-tom.leiming@gmail.com>
         <20170327120658.29864-5-tom.leiming@gmail.com>
In-Reply-To: <20170327120658.29864-5-tom.leiming@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, 2017-03-27 at 20:06 +0800, Ming Lei wrote:
> Before commit 780db2071a(blk-mq: decouble blk-mq freezing
> from generic bypassing), the dying flag is checked before
> entering queue, and Tejun converts the checking into .mq_freeze_depth,
> and assumes the counter is increased just after dying flag
> is set. Unfortunately we doesn't do that in blk_set_queue_dying().
>=20
> This patch calls blk_freeze_queue_start() in blk_set_queue_dying(),
> so that we can block new I/O coming once the queue is set as dying.
>=20
> Given blk_set_queue_dying() is always called in remove path
> of block device, and queue will be cleaned up later, we don't
> need to worry about undoing the counter.
>=20
> Cc: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Tejun Heo <tj@kernel.org>
> Reviewed-by: Hannes Reinecke <hare@suse.com>
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
> ---
>  block/blk-core.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 60f364e1d36b..e22c4ea002ec 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -500,6 +500,13 @@ void blk_set_queue_dying(struct request_queue *q)
>  	queue_flag_set(QUEUE_FLAG_DYING, q);
>  	spin_unlock_irq(q->queue_lock);
> =20
> +	/*
> +	 * When queue DYING flag is set, we need to block new req
> +	 * entering queue, so we call blk_freeze_queue_start() to
> +	 * prevent I/O from crossing blk_queue_enter().
> +	 */
> +	blk_freeze_queue_start(q);
>
> 	if (q->mq_ops)
>  		blk_mq_wake_waiters(q);
>  	else {
> @@ -672,9 +679,9 @@ int blk_queue_enter(struct request_queue *q, bool now=
ait)
>  		/*
>  		 * read pair of barrier in blk_freeze_queue_start(),
>  		 * we need to order reading __PERCPU_REF_DEAD flag of
> -		 * .q_usage_counter and reading .mq_freeze_depth,
> -		 * otherwise the following wait may never return if the
> -		 * two reads are reordered.
> +		 * .q_usage_counter and reading .mq_freeze_depth or
> +		 * queue dying flag, otherwise the following wait may
> +		 * never return if the two reads are reordered.
>  		 */
>  		smp_rmb();
> =20

An explanation of why that crossing can happen is still missing above the
blk_freeze_queue_start() call. Additionally, I'm still wondering whether
or not we need "Cc: stable" tags for the patches in this series. But since
the code looks fine:

Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>
> =
