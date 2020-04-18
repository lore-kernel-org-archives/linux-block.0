Return-Path: <SRS0=95tF=6C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BD1C2BA19
	for <linux-block@archiver.kernel.org>; Sat, 18 Apr 2020 03:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDCCD22201
	for <linux-block@archiver.kernel.org>; Sat, 18 Apr 2020 03:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJAqqEU4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgDRDKU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Apr 2020 23:10:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30183 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725867AbgDRDKT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Apr 2020 23:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587179418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FlzibB5Q0KXMJIrDEi6XGwwg9jtUNRXPdCNmVUdCgNQ=;
        b=fJAqqEU4Ujokw76JNWaXcvw/1IJzEFFb9BD20f7JMlGftW0IKyVrkzAOpkhQyWXoq+wmuH
        XmA9u0UUHNI415mmm3ITqgKZAIhTh1Upf45u4HX+8tiPi+It3LbeDceroD+/pAJU/4rq6L
        6np4v6rt4EnhYyD9UbASt/rBT3KRkGI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-P-mFX_tMONCQaIg0I5iiSQ-1; Fri, 17 Apr 2020 23:10:14 -0400
X-MC-Unique: P-mFX_tMONCQaIg0I5iiSQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE5BB1007275;
        Sat, 18 Apr 2020 03:10:12 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 92D2360BFB;
        Sat, 18 Apr 2020 03:10:09 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH V7 8/9] blk-mq: handle requests dispatched from IO scheduler in case of inactive hctx
Date:   Sat, 18 Apr 2020 11:09:24 +0800
Message-Id: <20200418030925.31996-9-ming.lei@redhat.com>
In-Reply-To: <20200418030925.31996-1-ming.lei@redhat.com>
References: <20200418030925.31996-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If one hctx becomes inactive when its CPUs are all offline, all in-queue
requests aimed at this hctx have to be re-submitted.

Re-submit requests from both sw queue or scheduler queue when the hctx
is found as inactive.

Cc: John Garry <john.garry@huawei.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 100 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 62 insertions(+), 38 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ae1e57c64ca1..54ba8a9c3c93 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2456,6 +2456,52 @@ static void blk_mq_resubmit_io(struct request *rq)
 		blk_mq_resubmit_fs_io(rq);
 }
=20
+static void blk_mq_hctx_deactivate(struct blk_mq_hw_ctx *hctx)
+{
+	LIST_HEAD(sched_tmp);
+	LIST_HEAD(re_submit);
+	LIST_HEAD(flush_in);
+	LIST_HEAD(flush_out);
+	struct request *rq, *nxt;
+	struct elevator_queue *e =3D hctx->queue->elevator;
+
+	if (!e) {
+		blk_mq_flush_busy_ctxs(hctx, &re_submit);
+	} else {
+		while ((rq =3D e->type->ops.dispatch_request(hctx))) {
+			if (rq->mq_hctx !=3D hctx)
+				list_add(&rq->queuelist, &sched_tmp);
+			else
+				list_add(&rq->queuelist, &re_submit);
+		}
+	}
+	while (!list_empty(&sched_tmp)) {
+		rq =3D list_entry(sched_tmp.next, struct request,
+				queuelist);
+		list_del_init(&rq->queuelist);
+		blk_mq_sched_insert_request(rq, true, true, true);
+	}
+
+	/* requests in dispatch list have to be re-submitted too */
+	spin_lock(&hctx->lock);
+	list_splice_tail_init(&hctx->dispatch, &re_submit);
+	spin_unlock(&hctx->lock);
+
+	/* blk_end_flush_machinery will cover flush request */
+	list_for_each_entry_safe(rq, nxt, &re_submit, queuelist) {
+		if (rq->rq_flags & RQF_FLUSH_SEQ)
+			list_move(&rq->queuelist, &flush_in);
+	}
+	blk_end_flush_machinery(hctx, &flush_in, &flush_out);
+	list_splice_tail(&flush_out, &re_submit);
+
+	while (!list_empty(&re_submit)) {
+		rq =3D list_first_entry(&re_submit, struct request, queuelist);
+		list_del_init(&rq->queuelist);
+		blk_mq_resubmit_io(rq);
+	}
+}
+
 /*
  * 'cpu' has gone away. If this hctx is inactive, we can't dispatch requ=
est
  * to the hctx any more, so steal bios from requests of this hctx, and
@@ -2463,54 +2509,32 @@ static void blk_mq_resubmit_io(struct request *rq=
)
  */
 static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *=
node)
 {
-	struct blk_mq_hw_ctx *hctx;
-	struct blk_mq_ctx *ctx;
-	LIST_HEAD(tmp);
-	enum hctx_type type;
+	struct blk_mq_hw_ctx *hctx =3D hlist_entry_safe(node,
+			struct blk_mq_hw_ctx, cpuhp_dead);
=20
 	if (!cpumask_test_cpu(cpu, hctx->cpumask))
 		return 0;
=20
-	hctx =3D hlist_entry_safe(node, struct blk_mq_hw_ctx, cpuhp_dead);
-	ctx =3D __blk_mq_get_ctx(hctx->queue, cpu);
-	type =3D hctx->type;
-
-	spin_lock(&ctx->lock);
-	if (!list_empty(&ctx->rq_lists[type])) {
-		list_splice_init(&ctx->rq_lists[type], &tmp);
-		blk_mq_hctx_clear_pending(hctx, ctx);
-	}
-	spin_unlock(&ctx->lock);
+	if (test_bit(BLK_MQ_S_INACTIVE, &hctx->state)) {
+		blk_mq_hctx_deactivate(hctx);
+	} else if (!hctx->queue->elevator) {
+		struct blk_mq_ctx *ctx =3D __blk_mq_get_ctx(hctx->queue, cpu);
+		enum hctx_type type =3D hctx->type;
+		LIST_HEAD(tmp);
+
+		spin_lock(&ctx->lock);
+		if (!list_empty(&ctx->rq_lists[type])) {
+			list_splice_init(&ctx->rq_lists[type], &tmp);
+			blk_mq_hctx_clear_pending(hctx, ctx);
+		}
+		spin_unlock(&ctx->lock);
=20
-	if (!test_bit(BLK_MQ_S_INACTIVE, &hctx->state)) {
 		if (!list_empty(&tmp)) {
 			spin_lock(&hctx->lock);
 			list_splice_tail_init(&tmp, &hctx->dispatch);
 			spin_unlock(&hctx->lock);
-			blk_mq_run_hw_queue(hctx, true);
-		}
-	} else {
-		LIST_HEAD(flush_in);
-		LIST_HEAD(flush_out);
-		struct request *rq, *nxt;
=20
-		/* requests in dispatch list have to be re-submitted too */
-		spin_lock(&hctx->lock);
-		list_splice_tail_init(&hctx->dispatch, &tmp);
-		spin_unlock(&hctx->lock);
-
-		/* blk_end_flush_machinery will cover flush request */
-		list_for_each_entry_safe(rq, nxt, &tmp, queuelist) {
-			if (rq->rq_flags & RQF_FLUSH_SEQ)
-				list_move(&rq->queuelist, &flush_in);
-		}
-		blk_end_flush_machinery(hctx, &flush_in, &flush_out);
-		list_splice_tail(&flush_out, &tmp);
-
-		while (!list_empty(&tmp)) {
-			rq =3D list_first_entry(&tmp, struct request, queuelist);
-			list_del_init(&rq->queuelist);
-			blk_mq_resubmit_io(rq);
+			blk_mq_run_hw_queue(hctx, true);
 		}
 	}
=20
--=20
2.25.2

