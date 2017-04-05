Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:60712 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755283AbdDESdR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2017 14:33:17 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "osandov@osandov.com" <osandov@osandov.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
CC: "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v2 1/8] blk-mq: use the right hctx when getting a driver
 tag fails
Date: Wed, 5 Apr 2017 18:33:14 +0000
Message-ID: <1491417192.2787.11.camel@sandisk.com>
References: <cover.1491416593.git.osandov@fb.com>
         <89da4a6561df3e24af3ba1c8625470d3088d2fa1.1491416593.git.osandov@fb.com>
In-Reply-To: <89da4a6561df3e24af3ba1c8625470d3088d2fa1.1491416593.git.osandov@fb.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, 2017-04-05 at 11:28 -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
>=20
> While dispatching requests, if we fail to get a driver tag, we mark the
> hardware queue as waiting for a tag and put the requests on a
> hctx->dispatch list to be run later when a driver tag is freed. However,
> blk_mq_dispatch_rq_list() may dispatch requests from multiple hardware
> queues if using a single-queue scheduler with a multiqueue device. If
> blk_mq_get_driver_tag() fails, it doesn't update the hardware queue we
> are processing. This means we end up using the hardware queue of the
> previous request, which may or may not be the same as that of the
> current request. If it isn't, the wrong hardware queue will end up
> waiting for a tag, and the requests will be on the wrong dispatch list,
> leading to a hang.
>=20
> The fix is twofold:
>=20
> 1. Make sure we save which hardware queue we were trying to get a
>    request for in blk_mq_get_driver_tag() regardless of whether it
>    succeeds or not.
> 2. Make blk_mq_dispatch_rq_list() take a request_queue instead of a
>    blk_mq_hw_queue to make it clear that it must handle multiple
>    hardware queues, since I've already messed this up on a couple of
>    occasions.
>=20
> This didn't appear in testing with nvme and mq-deadline because nvme has
> more driver tags than the default number of scheduler tags. However,
> with the blk_mq_update_nr_hw_queues() fix, it showed up with nbd.

Would the patch below be a valid alternative?

Thanks,

Bart.

[PATCH] blk-mq: Simplify blk_mq_get_driver_tag()

The blk_mq_get_driver_tag() callers either assume that *hctx is not
modified or that it points to a valid hctx pointer upon return if
tag allocation succeeded. Avoid this confusion by returning the hctx
pointer if and only if tag allocation succeeded and by only storing
the return value into hctx in those blk_mq_get_driver_tag() callers
for which the hctx pointer had not yet been computed before the
blk_mq_get_driver_tag() call.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
---
=A0block/blk-mq-sched.c |=A0=A04 +++-
=A0block/blk-mq.c=A0=A0=A0=A0=A0=A0=A0| 24 ++++++++++--------------
=A0block/blk-mq.h=A0=A0=A0=A0=A0=A0=A0|=A0=A03 +--
=A03 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index a85d939ef450..bfb8bdb95a87 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -386,7 +386,9 @@ void blk_mq_sched_restart_a_queue(struct blk_mq_hw_ctx =
*hctx)
=A0static void blk_mq_sched_insert_flush(struct blk_mq_hw_ctx *hctx,
=A0				=A0=A0=A0=A0=A0=A0struct request *rq, bool can_block)
=A0{
-	if (blk_mq_get_driver_tag(rq, &hctx, can_block)) {
+	WARN_ON_ONCE(!hctx);
+
+	if (blk_mq_get_driver_tag(rq, can_block)) {
=A0		blk_insert_flush(rq);
=A0		blk_mq_run_hw_queue(hctx, true);
=A0	} else
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 45e7f597cea3..c8e0c02dc8ca 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -857,8 +857,7 @@ static inline unsigned int queued_to_index(unsigned int=
 queued)
=A0	return min(BLK_MQ_MAX_DISPATCH_ORDER - 1, ilog2(queued) + 1);
=A0}
=A0
-bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx=
,
-			=A0=A0=A0bool wait)
+struct blk_mq_hw_ctx *blk_mq_get_driver_tag(struct request *rq, bool wait)
=A0{
=A0	struct blk_mq_alloc_data data =3D {
=A0		.q =3D rq->q,
@@ -866,12 +865,8 @@ bool blk_mq_get_driver_tag(struct request *rq, struct =
blk_mq_hw_ctx **hctx,
=A0		.flags =3D wait ? 0 : BLK_MQ_REQ_NOWAIT,
=A0	};
=A0
-	if (rq->tag !=3D -1) {
-done:
-		if (hctx)
-			*hctx =3D data.hctx;
-		return true;
-	}
+	if (rq->tag !=3D -1)
+		return data.hctx;
=A0
=A0	if (blk_mq_tag_is_reserved(data.hctx->sched_tags, rq->internal_tag))
=A0		data.flags |=3D BLK_MQ_REQ_RESERVED;
@@ -883,10 +878,10 @@ bool blk_mq_get_driver_tag(struct request *rq, struct=
 blk_mq_hw_ctx **hctx,
=A0			atomic_inc(&data.hctx->nr_active);
=A0		}
=A0		data.hctx->tags->rqs[rq->tag] =3D rq;
-		goto done;
+		return data.hctx;
=A0	}
=A0
-	return false;
+	return NULL;
=A0}
=A0
=A0static void blk_mq_put_driver_tag_hctx(struct blk_mq_hw_ctx *hctx,
@@ -985,7 +980,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx=
, struct list_head *list)
=A0		struct blk_mq_queue_data bd;
=A0
=A0		rq =3D list_first_entry(list, struct request, queuelist);
-		if (!blk_mq_get_driver_tag(rq, &hctx, false)) {
+		if (!blk_mq_get_driver_tag(rq, false)) {
=A0			if (!queued && reorder_tags_to_front(list))
=A0				continue;
=A0
@@ -999,7 +994,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx=
, struct list_head *list)
=A0				=A0* window between the allocation failure and
=A0				=A0* adding the hardware queue to the wait queue.
=A0				=A0*/
-				if (!blk_mq_get_driver_tag(rq, &hctx, false))
+				if (!blk_mq_get_driver_tag(rq, false))
=A0					break;
=A0			} else {
=A0				break;
@@ -1020,7 +1015,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hc=
tx, struct list_head *list)
=A0			struct request *nxt;
=A0
=A0			nxt =3D list_first_entry(list, struct request, queuelist);
-			bd.last =3D !blk_mq_get_driver_tag(nxt, NULL, false);
+			bd.last =3D !blk_mq_get_driver_tag(nxt, false);
=A0		}
=A0
=A0		ret =3D q->mq_ops->queue_rq(hctx, &bd);
@@ -1435,7 +1430,8 @@ static void __blk_mq_try_issue_directly(struct reques=
t *rq, blk_qc_t *cookie,
=A0	if (q->elevator)
=A0		goto insert;
=A0
-	if (!blk_mq_get_driver_tag(rq, &hctx, false))
+	hctx =3D blk_mq_get_driver_tag(rq, false);
+	if (!hctx)
=A0		goto insert;
=A0
=A0	new_cookie =3D request_to_qc_t(hctx, rq);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 8d49c06fc520..b1917fbe955c 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -33,8 +33,7 @@ void blk_mq_wake_waiters(struct request_queue *q);
=A0bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *, struct list_head *)=
;
=A0void blk_mq_flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head=
 *list);
=A0bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx);
-bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx=
,
-				bool wait);
+struct blk_mq_hw_ctx *blk_mq_get_driver_tag(struct request *rq, bool wait)=
;
=A0
=A0/*
=A0 * Internal helpers for allocating/freeing the request map
--=A0
2.12.0
