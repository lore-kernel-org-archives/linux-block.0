Return-Path: <SRS0=nYW3=6I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CEBC54FCB
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 10:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEFF920736
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 10:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EKNK+18F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgDXKYn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Apr 2020 06:24:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23458 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726821AbgDXKYm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 06:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587723880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iUveOtSCfYq0ERyvJ7uWUtiAw5TIwI6Hb46of9ePO08=;
        b=EKNK+18FyPJfHeEijORU1yySq4SIteQQc8FRjaKJ3e0Jh8wanNtSgCmInZLu1jrSxwjDKW
        Vv1e1+zzZdiAKrvqQYMfRFvo4CyMjvyvGxXWBi0hXIMaQAb5Oowz7LWoVL/mnEIN5gkCQe
        WreacL40t9Zphtt2ae/IL1ReXsR6rwk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-FszD_scjNlC9dLXZFV9NbA-1; Fri, 24 Apr 2020 06:24:36 -0400
X-MC-Unique: FszD_scjNlC9dLXZFV9NbA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36D3E107ACF3;
        Fri, 24 Apr 2020 10:24:35 +0000 (UTC)
Received: from localhost (ovpn-8-38.pek2.redhat.com [10.72.8.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 43703100238A;
        Fri, 24 Apr 2020 10:24:33 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH V8 04/11] blk-mq: assign rq->tag in blk_mq_get_driver_tag
Date:   Fri, 24 Apr 2020 18:23:44 +0800
Message-Id: <20200424102351.475641-5-ming.lei@redhat.com>
In-Reply-To: <20200424102351.475641-1-ming.lei@redhat.com>
References: <20200424102351.475641-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Especially for none elevator, rq->tag is assigned after the request is
allocated, so there isn't any way to figure out if one request is in
being dispatched. Also the code path wrt. driver tag becomes a bit
difference between none and io scheduler.

When one hctx becomes inactive, we have to prevent any request from
being dispatched to LLD. And get driver tag provides one perfect chance
to do that. Meantime we can drain any such requests by checking if
rq->tag is assigned.

So only assign rq->tag until blk_mq_get_driver_tag() is called.

This way also simplifies code of dealing with driver tag a lot.

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Garry <john.garry@huawei.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-flush.c | 18 ++----------
 block/blk-mq.c    | 75 ++++++++++++++++++++++++-----------------------
 block/blk-mq.h    | 21 +++++++------
 block/blk.h       |  5 ----
 4 files changed, 51 insertions(+), 68 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index c7f396e3d5e2..977edf95d711 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -236,13 +236,8 @@ static void flush_end_io(struct request *flush_rq, b=
lk_status_t error)
 		error =3D fq->rq_status;
=20
 	hctx =3D flush_rq->mq_hctx;
-	if (!q->elevator) {
-		blk_mq_tag_set_rq(hctx, flush_rq->tag, fq->orig_rq);
-		flush_rq->tag =3D -1;
-	} else {
-		blk_mq_put_driver_tag(flush_rq);
-		flush_rq->internal_tag =3D -1;
-	}
+	flush_rq->internal_tag =3D -1;
+	blk_mq_put_driver_tag(flush_rq);
=20
 	running =3D &fq->flush_queue[fq->flush_running_idx];
 	BUG_ON(fq->flush_pending_idx =3D=3D fq->flush_running_idx);
@@ -317,14 +312,7 @@ static void blk_kick_flush(struct request_queue *q, =
struct blk_flush_queue *fq,
 	flush_rq->mq_ctx =3D first_rq->mq_ctx;
 	flush_rq->mq_hctx =3D first_rq->mq_hctx;
=20
-	if (!q->elevator) {
-		fq->orig_rq =3D first_rq;
-		flush_rq->tag =3D first_rq->tag;
-		blk_mq_tag_set_rq(flush_rq->mq_hctx, first_rq->tag, flush_rq);
-	} else {
-		flush_rq->internal_tag =3D first_rq->internal_tag;
-	}
-
+	flush_rq->internal_tag =3D first_rq->internal_tag;
 	flush_rq->cmd_flags =3D REQ_OP_FLUSH | REQ_PREFLUSH;
 	flush_rq->cmd_flags |=3D (flags & REQ_DRV) | (flags & REQ_FAILFAST_MASK=
);
 	flush_rq->rq_flags |=3D RQF_FLUSH_SEQ;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 79267f2e8960..65f0aaed55ff 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -276,18 +276,8 @@ static struct request *blk_mq_rq_ctx_init(struct blk=
_mq_alloc_data *data,
 	struct request *rq =3D tags->static_rqs[tag];
 	req_flags_t rq_flags =3D 0;
=20
-	if (data->flags & BLK_MQ_REQ_INTERNAL) {
-		rq->tag =3D -1;
-		rq->internal_tag =3D tag;
-	} else {
-		if (data->hctx->flags & BLK_MQ_F_TAG_SHARED) {
-			rq_flags =3D RQF_MQ_INFLIGHT;
-			atomic_inc(&data->hctx->nr_active);
-		}
-		rq->tag =3D tag;
-		rq->internal_tag =3D -1;
-		data->hctx->tags->rqs[rq->tag] =3D rq;
-	}
+	rq->internal_tag =3D tag;
+	rq->tag =3D -1;
=20
 	/* csd/requeue_work/fifo_time is initialized before use */
 	rq->q =3D data->q;
@@ -472,14 +462,18 @@ static void __blk_mq_free_request(struct request *r=
q)
 	struct request_queue *q =3D rq->q;
 	struct blk_mq_ctx *ctx =3D rq->mq_ctx;
 	struct blk_mq_hw_ctx *hctx =3D rq->mq_hctx;
-	const int sched_tag =3D rq->internal_tag;
=20
 	blk_pm_mark_last_busy(rq);
 	rq->mq_hctx =3D NULL;
-	if (rq->tag !=3D -1)
-		blk_mq_put_tag(hctx->tags, ctx, rq->tag);
-	if (sched_tag !=3D -1)
-		blk_mq_put_tag(hctx->sched_tags, ctx, sched_tag);
+
+	if (hctx->sched_tags) {
+		if (rq->tag >=3D 0)
+			blk_mq_put_tag(hctx->tags, ctx, rq->tag);
+		blk_mq_put_tag(hctx->sched_tags, ctx, rq->internal_tag);
+	} else {
+		blk_mq_put_tag(hctx->tags, ctx, rq->internal_tag);
+        }
+
 	blk_mq_sched_restart(hctx);
 	blk_queue_exit(q);
 }
@@ -527,7 +521,7 @@ inline void __blk_mq_end_request(struct request *rq, =
blk_status_t error)
 		blk_stat_add(rq, now);
 	}
=20
-	if (rq->internal_tag !=3D -1)
+	if (rq->q->elevator && rq->internal_tag !=3D -1)
 		blk_mq_sched_completed_request(rq, now);
=20
 	blk_account_io_done(rq, now);
@@ -1027,33 +1021,40 @@ static inline unsigned int queued_to_index(unsign=
ed int queued)
 	return min(BLK_MQ_MAX_DISPATCH_ORDER - 1, ilog2(queued) + 1);
 }
=20
-static bool blk_mq_get_driver_tag(struct request *rq)
+static bool __blk_mq_get_driver_tag(struct request *rq)
 {
 	struct blk_mq_alloc_data data =3D {
-		.q =3D rq->q,
-		.hctx =3D rq->mq_hctx,
-		.flags =3D BLK_MQ_REQ_NOWAIT,
-		.cmd_flags =3D rq->cmd_flags,
+		.q		=3D rq->q,
+		.hctx		=3D rq->mq_hctx,
+		.flags		=3D BLK_MQ_REQ_NOWAIT,
+		.cmd_flags	=3D rq->cmd_flags,
 	};
-	bool shared;
=20
-	if (rq->tag !=3D -1)
-		return true;
+	if (data.hctx->sched_tags) {
+		if (blk_mq_tag_is_reserved(data.hctx->sched_tags,
+				rq->internal_tag))
+			data.flags |=3D BLK_MQ_REQ_RESERVED;
+		rq->tag =3D blk_mq_get_tag(&data);
+	} else {
+		rq->tag =3D rq->internal_tag;
+	}
=20
-	if (blk_mq_tag_is_reserved(data.hctx->sched_tags, rq->internal_tag))
-		data.flags |=3D BLK_MQ_REQ_RESERVED;
+	if (rq->tag =3D=3D -1)
+		return false;
=20
-	shared =3D blk_mq_tag_busy(data.hctx);
-	rq->tag =3D blk_mq_get_tag(&data);
-	if (rq->tag >=3D 0) {
-		if (shared) {
-			rq->rq_flags |=3D RQF_MQ_INFLIGHT;
-			atomic_inc(&data.hctx->nr_active);
-		}
-		data.hctx->tags->rqs[rq->tag] =3D rq;
+	if (blk_mq_tag_busy(data.hctx)) {
+		rq->rq_flags |=3D RQF_MQ_INFLIGHT;
+		atomic_inc(&data.hctx->nr_active);
 	}
+	data.hctx->tags->rqs[rq->tag] =3D rq;
+	return true;
+}
=20
-	return rq->tag !=3D -1;
+static bool blk_mq_get_driver_tag(struct request *rq)
+{
+	if (rq->tag !=3D -1)
+		return true;
+	return __blk_mq_get_driver_tag(rq);
 }
=20
 static int blk_mq_dispatch_wake(wait_queue_entry_t *wait, unsigned mode,
diff --git a/block/blk-mq.h b/block/blk-mq.h
index e7d1da4b1f73..d0c72d7d07c8 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -196,26 +196,25 @@ static inline bool blk_mq_get_dispatch_budget(struc=
t blk_mq_hw_ctx *hctx)
 	return true;
 }
=20
-static inline void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
-					   struct request *rq)
+static inline void blk_mq_put_driver_tag(struct request *rq)
 {
-	blk_mq_put_tag(hctx->tags, rq->mq_ctx, rq->tag);
+	struct blk_mq_hw_ctx *hctx =3D rq->mq_hctx;
+	int tag =3D rq->tag;
+
+	if (tag < 0)
+		return;
+
 	rq->tag =3D -1;
=20
+	if (hctx->sched_tags)
+		blk_mq_put_tag(hctx->tags, rq->mq_ctx, tag);
+
 	if (rq->rq_flags & RQF_MQ_INFLIGHT) {
 		rq->rq_flags &=3D ~RQF_MQ_INFLIGHT;
 		atomic_dec(&hctx->nr_active);
 	}
 }
=20
-static inline void blk_mq_put_driver_tag(struct request *rq)
-{
-	if (rq->tag =3D=3D -1 || rq->internal_tag =3D=3D -1)
-		return;
-
-	__blk_mq_put_driver_tag(rq->mq_hctx, rq);
-}
-
 static inline void blk_mq_clear_mq_map(struct blk_mq_queue_map *qmap)
 {
 	int cpu;
diff --git a/block/blk.h b/block/blk.h
index bbbced0b3c8c..446b2893b478 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -26,11 +26,6 @@ struct blk_flush_queue {
 	struct list_head	flush_data_in_flight;
 	struct request		*flush_rq;
=20
-	/*
-	 * flush_rq shares tag with this rq, both can't be active
-	 * at the same time
-	 */
-	struct request		*orig_rq;
 	struct lock_class_key	key;
 	spinlock_t		mq_flush_lock;
 };
--=20
2.25.2

