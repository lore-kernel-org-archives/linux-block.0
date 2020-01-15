Return-Path: <SRS0=otcQ=3E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AC0C33CB2
	for <linux-block@archiver.kernel.org>; Wed, 15 Jan 2020 11:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0EBD207E0
	for <linux-block@archiver.kernel.org>; Wed, 15 Jan 2020 11:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HsVEsihS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbgAOLpw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jan 2020 06:45:52 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33600 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729841AbgAOLpw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jan 2020 06:45:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579088751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YMY428Unwnm02bM00sdkoigU6nD+rlm0oxtJ3+bIR6A=;
        b=HsVEsihSkWPluH6MrAsdoOK0y18sh3evCXeR11CNhI+Vy1Jx22SAlbNIgal7CqjgcT65ky
        rEHMMB+0XuD7uCq9Yh1O4xbKH1BeiJEOR59pmSaW1/k9Kw+zDnTBRjc0hR8JV6bRIxshMu
        mpJ7HWxVZbLScDL6F/FAyT1VEg0k8cE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-oQirY1V0POmVDipl8fn5Aw-1; Wed, 15 Jan 2020 06:45:47 -0500
X-MC-Unique: oQirY1V0POmVDipl8fn5Aw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBBC4477;
        Wed, 15 Jan 2020 11:45:45 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 11513675AF;
        Wed, 15 Jan 2020 11:45:44 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 5/6] blk-mq: handle requests dispatched from IO scheduler in case of inactive hctx
Date:   Wed, 15 Jan 2020 19:44:08 +0800
Message-Id: <20200115114409.28895-6-ming.lei@redhat.com>
In-Reply-To: <20200115114409.28895-1-ming.lei@redhat.com>
References: <20200115114409.28895-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Cc: Keith Busch <keith.busch@intel.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 80 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 52 insertions(+), 28 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3e52ba74661e..93c835312d42 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2311,6 +2311,42 @@ static void blk_mq_resubmit_io(struct request *rq)
 	}
 }
=20
+static void blk_mq_hctx_deactivate(struct blk_mq_hw_ctx *hctx)
+{
+	LIST_HEAD(sched_tmp);
+	LIST_HEAD(re_submit);
+	struct request *rq;
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
+	/* requests in dispatch list has to be re-submitted too */
+	spin_lock(&hctx->lock);
+	list_splice_tail_init(&hctx->dispatch, &re_submit);
+	spin_unlock(&hctx->lock);
+
+	while (!list_empty(&re_submit)) {
+		rq =3D list_entry(re_submit.next, struct request, queuelist);
+		list_del_init(&rq->queuelist);
+		blk_mq_resubmit_io(rq);
+	}
+}
+
 /*
  * 'cpu' has gone away. If this hctx is inactive, we can't dispatch requ=
est
  * to the hctx any more, so steal bios from requests of this hctx, and
@@ -2318,42 +2354,30 @@ static void blk_mq_resubmit_io(struct request *rq=
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
 			blk_mq_run_hw_queue(hctx, true);
 		}
-	} else {
-		/* requests in dispatch list has to be re-submitted too */
-		spin_lock(&hctx->lock);
-		list_splice_tail_init(&hctx->dispatch, &tmp);
-		spin_unlock(&hctx->lock);
-
-		while (!list_empty(&tmp)) {
-			struct request *rq =3D list_entry(tmp.next,
-					struct request, queuelist);
-			list_del_init(&rq->queuelist);
-			blk_mq_resubmit_io(rq);
-		}
-		clear_bit(BLK_MQ_S_INACTIVE, &hctx->state);
 	}
=20
 	return 0;
--=20
2.20.1

