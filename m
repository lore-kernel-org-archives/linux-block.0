Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:65455 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751116AbdCQRe2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2017 13:34:28 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "tom.leiming@gmail.com" <tom.leiming@gmail.com>,
        "axboe@fb.com" <axboe@fb.com>
CC: "yizhan@redhat.com" <yizhan@redhat.com>,
        "tj@kernel.org" <tj@kernel.org>
Subject: Re: [PATCH v1 3/3] blk-mq: start to freeze queue just after setting
 dying
Date: Fri, 17 Mar 2017 17:32:09 +0000
Message-ID: <1489771915.2826.4.camel@sandisk.com>
References: <20170317095711.5819-1-tom.leiming@gmail.com>
         <20170317095711.5819-4-tom.leiming@gmail.com>
In-Reply-To: <20170317095711.5819-4-tom.leiming@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, 2017-03-17 at 17:57 +0800, Ming Lei wrote:
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
> need to worry about undoing the counter.
>=20
> Cc: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
> ---
>  block/blk-core.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/blk-core.c b/block/blk-core.c
> index d772c221cc17..62d4967c369f 100644
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

Hello Ming,

I think we need the queue freezing not only for blk-mq but also for blk-sq.
Since the queue flags and the mq_freeze_depth are stored in different
variables we need to prevent that the CPU reorders the stores to these
variables. The comment about=A0blk_mq_freeze_queue_start() should be more
clear. How about something like the patch below?


[PATCH] blk-mq: Force block layer users to check the "dying" flag=A0after i=
t has been set

Commit 780db2071ac4 removed the blk_queue_dying() check from the
hot path of blk_mq_queue_enter() although that check is necessary
when cleaning up a queue. Hence make sure that blk_queue_enter()
and blk_mq_queue_enter() check the dying flag after it has been set.

Because blk_set_queue_dying() is only called from the remove path
of a block device we don't need to worry about unfreezing the queue.

Fixes: commit 780db2071ac4 ("blk-mq: decouble blk-mq freezing from generic =
bypassing")
---
=A0block/blk-core.c | 13 +++++++++++++
=A01 file changed, 13 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index d772c221cc17..730f715b72ff 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -500,6 +500,19 @@ void blk_set_queue_dying(struct request_queue *q)
=A0	queue_flag_set(QUEUE_FLAG_DYING, q);
=A0	spin_unlock_irq(q->queue_lock);
=A0
+	/*
+	=A0* Avoid that the updates of the queue flags and q_usage_counter
+	=A0* are reordered.
+	=A0*/
+	smp_wmb();
+
+	/*
+	=A0* Force blk_queue_enter() and blk_mq_queue_enter() to check the
+	=A0* "dying" flag. Despite its name, blk_mq_freeze_queue_start()
+	=A0* affects blk-sq and blk-mq queues.
+	=A0*/
+	blk_mq_freeze_queue_start(q);
+
=A0	if (q->mq_ops)
=A0		blk_mq_wake_waiters(q);
=A0	else {


Thanks,

Bart.
