Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB40DC43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 11:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A33A5208A3
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 11:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A33A5208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389574AbeKPVfd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 16:35:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47336 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727567AbeKPVfd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 16:35:33 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 370E7307DAA4;
        Fri, 16 Nov 2018 11:23:37 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 66423608C2;
        Fri, 16 Nov 2018 11:23:34 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        "jianchao.wang" <jianchao.w.wang@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH V2 for-4.21 2/2] blk-mq: alloc q->queue_ctx as normal array
Date:   Fri, 16 Nov 2018 19:23:11 +0800
Message-Id: <20181116112311.4117-3-ming.lei@redhat.com>
In-Reply-To: <20181116112311.4117-1-ming.lei@redhat.com>
References: <20181116112311.4117-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 16 Nov 2018 11:23:37 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now q->queue_ctx is just one read-mostly table for query the
'blk_mq_ctx' instance from one cpu index, it isn't necessary
to allocate it as percpu variable. One simple array may be
more efficient.

Cc: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sysfs.c   | 14 ++++----------
 block/blk-mq.c         | 18 ++++++++++--------
 block/blk-mq.h         |  2 +-
 include/linux/blkdev.h |  2 +-
 4 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index cc2fef909afc..ae2cafd6f8a8 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -290,19 +290,15 @@ void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx)
 
 void blk_mq_sysfs_deinit(struct request_queue *q)
 {
-	struct blk_mq_ctx *ctx;
 	int cpu;
 
-	for_each_possible_cpu(cpu) {
-		ctx = *per_cpu_ptr(q->queue_ctx, cpu);
-		kobject_put(&ctx->kobj);
-	}
+	for_each_possible_cpu(cpu)
+		kobject_put(&q->queue_ctx[cpu]->kobj);
 	kobject_put(q->mq_kobj);
 }
 
 int blk_mq_sysfs_init(struct request_queue *q)
 {
-	struct blk_mq_ctx *ctx;
 	int cpu;
 	struct kobject *mq_kobj;
 
@@ -312,10 +308,8 @@ int blk_mq_sysfs_init(struct request_queue *q)
 
 	kobject_init(mq_kobj, &blk_mq_ktype);
 
-	for_each_possible_cpu(cpu) {
-		ctx = *per_cpu_ptr(q->queue_ctx, cpu);
-		kobject_init(&ctx->kobj, &blk_mq_ctx_ktype);
-	}
+	for_each_possible_cpu(cpu)
+		kobject_init(&q->queue_ctx[cpu]->kobj, &blk_mq_ctx_ktype);
 	q->mq_kobj = mq_kobj;
 	return 0;
 }
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 376c04778d33..85d5dba56272 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2299,7 +2299,7 @@ static void blk_mq_init_cpu_queues(struct request_queue *q,
 	unsigned int i, j;
 
 	for_each_possible_cpu(i) {
-		struct blk_mq_ctx *__ctx = *per_cpu_ptr(q->queue_ctx, i);
+		struct blk_mq_ctx *__ctx = q->queue_ctx[i];
 		struct blk_mq_hw_ctx *hctx;
 
 		__ctx->cpu = i;
@@ -2385,7 +2385,7 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 			set->map[0].mq_map[i] = 0;
 		}
 
-		ctx = *per_cpu_ptr(q->queue_ctx, i);
+		ctx = q->queue_ctx[i];
 		for (j = 0; j < set->nr_maps; j++) {
 			hctx = blk_mq_map_queue_type(q, j, i);
 
@@ -2520,9 +2520,9 @@ static void blk_mq_dealloc_queue_ctx(struct request_queue *q, bool free_ctxs)
 	if (free_ctxs) {
 		int cpu;
 		for_each_possible_cpu(cpu)
-			kfree(*per_cpu_ptr(q->queue_ctx, cpu));
+			kfree(q->queue_ctx[cpu]);
 	}
-	free_percpu(q->queue_ctx);
+	kfree(q->queue_ctx);
 }
 
 static int blk_mq_alloc_queue_ctx(struct request_queue *q)
@@ -2530,7 +2530,9 @@ static int blk_mq_alloc_queue_ctx(struct request_queue *q)
 	struct blk_mq_ctx *ctx;
 	int cpu;
 
-	q->queue_ctx = alloc_percpu(struct blk_mq_ctx *);
+	q->queue_ctx = kmalloc_array_node(nr_cpu_ids,
+					  sizeof(struct blk_mq_ctx *),
+					  GFP_KERNEL, q->tag_set->numa_node);
 	if (!q->queue_ctx)
 		return -ENOMEM;
 
@@ -2538,7 +2540,7 @@ static int blk_mq_alloc_queue_ctx(struct request_queue *q)
 		ctx = kzalloc_node(sizeof(*ctx), GFP_KERNEL, cpu_to_node(cpu));
 		if (!ctx)
 			goto fail;
-		*per_cpu_ptr(q->queue_ctx, cpu) = ctx;
+		q->queue_ctx[cpu] = ctx;
 	}
 
 	return 0;
@@ -2759,6 +2761,8 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	/* mark the queue as mq asap */
 	q->mq_ops = set->ops;
 
+	q->tag_set = set;
+
 	q->poll_cb = blk_stat_alloc_callback(blk_mq_poll_stats_fn,
 					     blk_mq_poll_stats_bkt,
 					     BLK_MQ_POLL_STATS_BKTS, q);
@@ -2786,8 +2790,6 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	INIT_WORK(&q->timeout_work, blk_mq_timeout_work);
 	blk_queue_rq_timeout(q, set->timeout ? set->timeout : 30 * HZ);
 
-	q->tag_set = set;
-
 	q->queue_flags |= QUEUE_FLAG_MQ_DEFAULT;
 
 	if (!(set->flags & BLK_MQ_F_SG_MERGE))
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 84898793c230..97829388e1db 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -129,7 +129,7 @@ static inline enum mq_rq_state blk_mq_rq_state(struct request *rq)
 static inline struct blk_mq_ctx *__blk_mq_get_ctx(struct request_queue *q,
 					   unsigned int cpu)
 {
-	return *per_cpu_ptr(q->queue_ctx, cpu);
+	return q->queue_ctx[cpu];
 }
 
 /*
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9e3892bd67fd..9b6ddc5c7a40 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -407,7 +407,7 @@ struct request_queue {
 	const struct blk_mq_ops	*mq_ops;
 
 	/* sw queues */
-	struct blk_mq_ctx __percpu	**queue_ctx;
+	struct blk_mq_ctx	**queue_ctx;
 	unsigned int		nr_queues;
 
 	unsigned int		queue_depth;
-- 
2.9.5

