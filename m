Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:40026 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754769AbdCIQ6s (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Mar 2017 11:58:48 -0500
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "tom.leiming@gmail.com" <tom.leiming@gmail.com>,
        "axboe@fb.com" <axboe@fb.com>
CC: "yizhan@redhat.com" <yizhan@redhat.com>,
        "tj@kernel.org" <tj@kernel.org>
Subject: Re: [PATCH 2/2] blk-mq: start to freeze queue just after setting
 dying
Date: Thu, 9 Mar 2017 16:58:26 +0000
Message-ID: <1489078694.2597.5.camel@sandisk.com>
References: <1489064578-17305-1-git-send-email-tom.leiming@gmail.com>
         <1489064578-17305-4-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1489064578-17305-4-git-send-email-tom.leiming@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, 2017-03-09 at 21:02 +0800, Ming Lei wrote:
> Before commit 780db2071a(blk-mq: decouble blk-mq freezing
> from generic bypassing), the dying flag is checked before
> entering queue, and Tejun converts the checking into .mq_freeze_depth,
> and assumes the counter is increased just after dying flag
> is set. Unfortunately we doesn't do that in blk_set_queue_dying().
>=20
> This patch calls blk_mq_freeze_queue_start() for blk-mq in
> blk_set_queue_dying(), so that we can block new I/O coming
> once the queue is set as dying.
>=20
> Given blk_set_queue_dying() is always called in remove path
> of block device, and queue will be cleaned up later, we don't
> need to worry about undo of the counter.
>=20
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
> ---
>  block/blk-core.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 0eeb99ef654f..559487e58296 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -500,9 +500,12 @@ void blk_set_queue_dying(struct request_queue *q)
>  	queue_flag_set(QUEUE_FLAG_DYING, q);
>  	spin_unlock_irq(q->queue_lock);
> =20
> -	if (q->mq_ops)
> +	if (q->mq_ops) {
>  		blk_mq_wake_waiters(q);
> -	else {
> +
> +		/* block new I/O coming */
> +		blk_mq_freeze_queue_start(q);
> +	} else {
>  		struct request_list *rl;
> =20
>  		spin_lock_irq(q->queue_lock);

The comment above blk_mq_freeze_queue_start() should explain more clearly
why that call is needed. Additionally, I think this patch makes the
blk_freeze_queue() call in blk_cleanup_queue() superfluous. How about the
(entirely untested) patch below?

diff --git a/block/blk-core.c b/block/blk-core.c
index 1086dac8724c..3ce48f2d65cf 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -500,6 +500,12 @@ void blk_set_queue_dying(struct request_queue *q)
=A0	queue_flag_set(QUEUE_FLAG_DYING, q);
=A0	spin_unlock_irq(q->queue_lock);
=A0
+	/*
+	=A0* Force blk_queue_enter() and blk_mq_queue_enter() to check the
+	=A0* "dying" flag.
+	=A0*/
+	blk_freeze_queue(q);
+
=A0	if (q->mq_ops)
=A0		blk_mq_wake_waiters(q);
=A0	else {
@@ -555,7 +561,7 @@ void blk_cleanup_queue(struct request_queue *q)
=A0	=A0* Drain all requests queued before DYING marking. Set DEAD flag to
=A0	=A0* prevent that q->request_fn() gets invoked after draining finished.
=A0	=A0*/
-	blk_freeze_queue(q);
+	WARN_ON_ONCE(!atomic_read(&q->mq_freeze_depth));
=A0	spin_lock_irq(lock);
=A0	if (!q->mq_ops)
=A0		__blk_drain_queue(q, true);

Thanks,

Bart.=
