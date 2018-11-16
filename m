Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F684C43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 03:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F8412075B
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 03:28:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F8412075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbeKPNj2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 08:39:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38388 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbeKPNj1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 08:39:27 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9EDDE3082127;
        Fri, 16 Nov 2018 03:28:49 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D26F608C1;
        Fri, 16 Nov 2018 03:28:45 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/2] blk-mq: alloc q->queue_ctx as normal array
Date:   Fri, 16 Nov 2018 11:28:26 +0800
Message-Id: <20181116032826.11901-3-ming.lei@redhat.com>
In-Reply-To: <20181116032826.11901-1-ming.lei@redhat.com>
References: <20181116032826.11901-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 16 Nov 2018 03:28:49 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now q->queue_ctx is just one read-mostly table for query the
'blk_mq_ctx' instance from one cpu index, it isn't necessary
to allocate it as percpu variable. One simple array may be
more efficient.

Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sysfs.c   |  6 +++---
 block/blk-mq.c         | 12 +++++++-----
 block/blk-mq.h         |  2 +-
 include/linux/blkdev.h |  2 +-
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index bab236955f56..dc4ac733a125 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -300,7 +300,7 @@ void blk_mq_sysfs_deinit(struct request_queue *q)
 	int cpu;
 
 	for_each_possible_cpu(cpu) {
-		ctx = *per_cpu_ptr(q->queue_ctx, cpu);
+		ctx = q->queue_ctx[cpu];
 		kobject_put(&ctx->kobj);
 	}
 	kobject_put(q->mq_kobj);
@@ -322,7 +322,7 @@ int blk_mq_sysfs_init(struct request_queue *q)
 		ctx = kzalloc_node(sizeof(*ctx), GFP_KERNEL, cpu_to_node(cpu));
 		if (!ctx)
 			goto fail;
-		*per_cpu_ptr(q->queue_ctx, cpu) = ctx;
+		q->queue_ctx[cpu] = ctx;
 		kobject_init(&ctx->kobj, &blk_mq_ctx_ktype);
 	}
 	q->mq_kobj = &mq_kobj->kobj;
@@ -330,7 +330,7 @@ int blk_mq_sysfs_init(struct request_queue *q)
 
  fail:
 	for_each_possible_cpu(cpu) {
-		ctx = *per_cpu_ptr(q->queue_ctx, cpu);
+		ctx = q->queue_ctx[cpu];
 		if (ctx)
 			kobject_put(&ctx->kobj);
 	}
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3589ee601f37..20c485e1817a 100644
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
 
@@ -2541,7 +2541,7 @@ void blk_mq_release(struct request_queue *q)
 	 */
 	blk_mq_sysfs_deinit(q);
 
-	free_percpu(q->queue_ctx);
+	kfree(q->queue_ctx);
 }
 
 struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *set)
@@ -2731,7 +2731,9 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	if (!q->poll_cb)
 		goto err_exit;
 
-	q->queue_ctx = alloc_percpu(struct blk_mq_ctx *);
+	q->queue_ctx = kmalloc_array_node(nr_cpu_ids,
+					  sizeof(struct blk_mq_ctx *),
+					  GFP_KERNEL, set->numa_node);
 	if (!q->queue_ctx)
 		goto err_exit;
 
@@ -2798,7 +2800,7 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 err_sys_init:
 	blk_mq_sysfs_deinit(q);
 err_percpu:
-	free_percpu(q->queue_ctx);
+	kfree(q->queue_ctx);
 err_exit:
 	q->mq_ops = NULL;
 	return ERR_PTR(-ENOMEM);
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

