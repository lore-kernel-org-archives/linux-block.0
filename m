Return-Path: <SRS0=69Bb=5X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60062C2BB1D
	for <linux-block@archiver.kernel.org>; Tue,  7 Apr 2020 09:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317E820719
	for <linux-block@archiver.kernel.org>; Tue,  7 Apr 2020 09:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XvjjNCLR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgDGJ3j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Apr 2020 05:29:39 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38456 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgDGJ3j (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Apr 2020 05:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586251779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=We1v/DrYB0R+dM450gz4zCexI7n4QNt2ntUmaEBBfrU=;
        b=XvjjNCLRsNqG1HqnwLfJSNskYq05MJ1phBK1ptpOrGoFLp5HzRc9vagZtvio7s4RBM/Q50
        fbMAl2TOOK0dnAk9J4RCMoNbIHDNo8Ej+NcNpvV3pcCCizDvjG9UpNWyBFiKqoG0xVwb80
        kJ/MfuhKij4HtzywFt2RXgXQhIwtYmM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-_2lUFK8AP0KgWEkJCvVTRA-1; Tue, 07 Apr 2020 05:29:35 -0400
X-MC-Unique: _2lUFK8AP0KgWEkJCvVTRA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9040C107ACCD;
        Tue,  7 Apr 2020 09:29:33 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE3D49D379;
        Tue,  7 Apr 2020 09:29:29 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH V6 4/8] blk-mq: stop to handle IO and drain IO before hctx becomes inactive
Date:   Tue,  7 Apr 2020 17:28:57 +0800
Message-Id: <20200407092901.314228-5-ming.lei@redhat.com>
In-Reply-To: <20200407092901.314228-1-ming.lei@redhat.com>
References: <20200407092901.314228-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Before one CPU becomes offline, check if it is the last online CPU
of hctx. If yes, mark this hctx as inactive, meantime wait for
completion of all in-flight IOs originated from this hctx.

This way guarantees that there isn't any inflight IO before shutdowning
the managed IRQ line.

Cc: John Garry <john.garry@huawei.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-tag.c |  2 +-
 block/blk-mq-tag.h |  2 ++
 block/blk-mq.c     | 67 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 586c9d6e904a..82a58b2cebe7 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -317,7 +317,7 @@ static void bt_tags_for_each(struct blk_mq_tags *tags=
, struct sbitmap_queue *bt,
  *		true to continue iterating tags, false to stop.
  * @priv:	Will be passed as second argument to @fn.
  */
-static void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
+void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
 		busy_tag_iter_fn *fn, void *priv)
 {
 	if (tags->nr_reserved_tags)
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 2b8321efb682..346d570d52a9 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -34,6 +34,8 @@ extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx=
 *hctx,
 extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *f=
n,
 		void *priv);
+void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
+		busy_tag_iter_fn *fn, void *priv);
=20
 static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue *b=
t,
 						 struct blk_mq_hw_ctx *hctx)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4ee8695142c0..aac86cd99f02 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1054,6 +1054,11 @@ bool blk_mq_get_driver_tag(struct request *rq)
 		data.hctx->tags->rqs[rq->tag] =3D rq;
 	}
=20
+	if (unlikely(test_bit(BLK_MQ_S_INACTIVE, &data.hctx->state))) {
+		blk_mq_put_driver_tag(rq);
+		return false;
+	}
+
 	return rq->tag !=3D -1;
 }
=20
@@ -2249,8 +2254,68 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, s=
truct blk_mq_tags *tags,
 	return -ENOMEM;
 }
=20
+struct count_inflight_data {
+	unsigned count;
+	struct blk_mq_hw_ctx *hctx;
+};
+
+static bool blk_mq_count_inflight_rq(struct request *rq, void *data,
+				     bool reserved)
+{
+	struct count_inflight_data *count_data =3D data;
+
+	/*
+	 * Can't check rq's state because it is updated to MQ_RQ_IN_FLIGHT
+	 * in blk_mq_start_request(), at that time we can't prevent this rq
+	 * from being issued.
+	 *
+	 * So check if driver tag is assigned, if yes, count this rq as
+	 * inflight.
+	 */
+	if (rq->tag >=3D 0 && rq->mq_hctx =3D=3D count_data->hctx)
+		count_data->count++;
+
+	return true;
+}
+
+static unsigned blk_mq_tags_inflight_rqs(struct blk_mq_hw_ctx *hctx)
+{
+	struct count_inflight_data count_data =3D {
+		.count	=3D 0,
+		.hctx	=3D hctx,
+	};
+
+	blk_mq_all_tag_busy_iter(hctx->tags, blk_mq_count_inflight_rq,
+			&count_data);
+
+	return count_data.count;
+}
+
+static void blk_mq_hctx_drain_inflight_rqs(struct blk_mq_hw_ctx *hctx)
+{
+	while (1) {
+		if (!blk_mq_tags_inflight_rqs(hctx))
+			break;
+		msleep(5);
+	}
+}
+
 static int blk_mq_hctx_notify_online(unsigned int cpu, struct hlist_node=
 *node)
 {
+	struct blk_mq_hw_ctx *hctx =3D hlist_entry_safe(node,
+			struct blk_mq_hw_ctx, cpuhp_online);
+
+	if ((cpumask_next_and(-1, hctx->cpumask, cpu_online_mask) =3D=3D cpu) &=
&
+			(cpumask_next_and(cpu, hctx->cpumask, cpu_online_mask)
+			 >=3D nr_cpu_ids)) {
+		/*
+		 * The current CPU is the last one in this hctx, S_INACTIVE
+		 * can be observed in dispatch path without any barrier needed,
+		 * cause both are run on one same CPU.
+		 */
+		set_bit(BLK_MQ_S_INACTIVE, &hctx->state);
+		blk_mq_hctx_drain_inflight_rqs(hctx);
+        }
 	return 0;
 }
=20
@@ -2277,6 +2342,8 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu=
, struct hlist_node *node)
 	}
 	spin_unlock(&ctx->lock);
=20
+	clear_bit(BLK_MQ_S_INACTIVE, &hctx->state);
+
 	if (list_empty(&tmp))
 		return 0;
=20
--=20
2.25.2

