Return-Path: <SRS0=69Bb=5X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1B8C2BABC
	for <linux-block@archiver.kernel.org>; Tue,  7 Apr 2020 09:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E45820719
	for <linux-block@archiver.kernel.org>; Tue,  7 Apr 2020 09:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZGyPH6+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgDGJ37 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Apr 2020 05:29:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34830 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726353AbgDGJ37 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 7 Apr 2020 05:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586251798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0G/MVOWzQzZuobkcqy5n4ULS40rbTKZMOu90BsQv8rY=;
        b=ZGyPH6+MKvHL0XZpEWQDLT4r1xmCGaTlGFQsFFXQHHWBIe+ZDnGv2l8HeoHIQ3H/KvG09q
        qJcclfdzfsfCgPzOcBMAY/9jDGX19sKXI5082/CxqHGaCLjLz2WqFRxEIUFVXihFji6GgI
        gRDZUBhzeaO3NzoOkK/XMLjJSy/tsiw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-NHpVMRcAPqabn9Wa5KIlLg-1; Tue, 07 Apr 2020 05:29:52 -0400
X-MC-Unique: NHpVMRcAPqabn9Wa5KIlLg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 684938017CE;
        Tue,  7 Apr 2020 09:29:51 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 23159CDBCA;
        Tue,  7 Apr 2020 09:29:47 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH V6 7/8] blk-mq: handle requests dispatched from IO scheduler in case of inactive hctx
Date:   Tue,  7 Apr 2020 17:29:00 +0800
Message-Id: <20200407092901.314228-8-ming.lei@redhat.com>
In-Reply-To: <20200407092901.314228-1-ming.lei@redhat.com>
References: <20200407092901.314228-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
 block/blk-mq.c | 103 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 64 insertions(+), 39 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6749f39fdd11..a8dbb1bc0a36 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2407,6 +2407,52 @@ static void blk_mq_resubmit_io(struct request *rq)
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
@@ -2414,53 +2460,32 @@ static void blk_mq_resubmit_io(struct request *rq=
)
  */
 static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *=
node)
 {
-	struct blk_mq_hw_ctx *hctx;
-	struct blk_mq_ctx *ctx;
-	LIST_HEAD(tmp);
-	enum hctx_type type;
-
-	hctx =3D hlist_entry_safe(node, struct blk_mq_hw_ctx, cpuhp_dead);
-	ctx =3D __blk_mq_get_ctx(hctx->queue, cpu);
-	type =3D hctx->type;
+	struct blk_mq_hw_ctx *hctx =3D hlist_entry_safe(node,
+			struct blk_mq_hw_ctx, cpuhp_dead);
=20
-	spin_lock(&ctx->lock);
-	if (!list_empty(&ctx->rq_lists[type])) {
-		list_splice_init(&ctx->rq_lists[type], &tmp);
-		blk_mq_hctx_clear_pending(hctx, ctx);
-	}
-	spin_unlock(&ctx->lock);
+	if (test_bit(BLK_MQ_S_INACTIVE, &hctx->state)) {
+		WARN_ON_ONCE(blk_mq_tags_inflight_rqs(hctx) > 0);
+		blk_mq_hctx_deactivate(hctx);
+		clear_bit(BLK_MQ_S_INACTIVE, &hctx->state);
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
-
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
=20
-		while (!list_empty(&tmp)) {
-			rq =3D list_first_entry(&tmp, struct request, queuelist);
-			list_del_init(&rq->queuelist);
-			blk_mq_resubmit_io(rq);
+			blk_mq_run_hw_queue(hctx, true);
 		}
-		clear_bit(BLK_MQ_S_INACTIVE, &hctx->state);
 	}
=20
 	return 0;
--=20
2.25.2

