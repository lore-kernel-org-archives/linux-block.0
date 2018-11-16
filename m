Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1124FC43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 03:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA4C9223C8
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 03:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA4C9223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbeKPNjW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 08:39:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49696 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbeKPNjW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 08:39:22 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 61A4F315484B;
        Fri, 16 Nov 2018 03:28:43 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7E7905E7C9;
        Fri, 16 Nov 2018 03:28:42 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: [PATCH 1/2] blk-mq: not embed .mq_kobj and ctx->kobj into queue instance
Date:   Fri, 16 Nov 2018 11:28:25 +0800
Message-Id: <20181116032826.11901-2-ming.lei@redhat.com>
In-Reply-To: <20181116032826.11901-1-ming.lei@redhat.com>
References: <20181116032826.11901-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 16 Nov 2018 03:28:43 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Even though .mq_kobj, ctx->kobj and q->kobj share same lifetime
from block layer's view, actually they don't because userspace may
grab one kobject anytime via sysfs, so each kobject's lifetime has
to be independent, then the objects(mq_kobj, ctx) which hosts its
own kobject have to be allocated dynamically.

This patch fixes kernel panic issue during booting when DEBUG_KOBJECT_RELEASE
is enabled.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sysfs.c   | 59 +++++++++++++++++++++++++++++++++++++++-----------
 block/blk-mq.c         | 13 ++++++-----
 block/blk-mq.h         |  4 ++--
 include/linux/blkdev.h |  4 ++--
 4 files changed, 58 insertions(+), 22 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 3d25b9c419e9..bab236955f56 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -13,8 +13,22 @@
 #include "blk-mq.h"
 #include "blk-mq-tag.h"
 
+struct blk_mq_kobj {
+	struct kobject kobj;
+};
+
 static void blk_mq_sysfs_release(struct kobject *kobj)
 {
+	struct blk_mq_kobj *mq_kobj = container_of(kobj, struct blk_mq_kobj,
+						   kobj);
+	kfree(mq_kobj);
+}
+
+static void blk_mq_ctx_sysfs_release(struct kobject *kobj)
+{
+	struct blk_mq_ctx *ctx = container_of(kobj, struct blk_mq_ctx, kobj);
+
+	kfree(ctx);
 }
 
 static void blk_mq_hw_sysfs_release(struct kobject *kobj)
@@ -213,7 +227,7 @@ static struct kobj_type blk_mq_ktype = {
 static struct kobj_type blk_mq_ctx_ktype = {
 	.sysfs_ops	= &blk_mq_sysfs_ops,
 	.default_attrs	= default_ctx_attrs,
-	.release	= blk_mq_sysfs_release,
+	.release	= blk_mq_ctx_sysfs_release,
 };
 
 static struct kobj_type blk_mq_hw_ktype = {
@@ -245,7 +259,7 @@ static int blk_mq_register_hctx(struct blk_mq_hw_ctx *hctx)
 	if (!hctx->nr_ctx)
 		return 0;
 
-	ret = kobject_add(&hctx->kobj, &q->mq_kobj, "%u", hctx->queue_num);
+	ret = kobject_add(&hctx->kobj, q->mq_kobj, "%u", hctx->queue_num);
 	if (ret)
 		return ret;
 
@@ -268,8 +282,8 @@ void blk_mq_unregister_dev(struct device *dev, struct request_queue *q)
 	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_unregister_hctx(hctx);
 
-	kobject_uevent(&q->mq_kobj, KOBJ_REMOVE);
-	kobject_del(&q->mq_kobj);
+	kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
+	kobject_del(q->mq_kobj);
 	kobject_put(&dev->kobj);
 
 	q->mq_sysfs_init_done = false;
@@ -286,23 +300,42 @@ void blk_mq_sysfs_deinit(struct request_queue *q)
 	int cpu;
 
 	for_each_possible_cpu(cpu) {
-		ctx = per_cpu_ptr(q->queue_ctx, cpu);
+		ctx = *per_cpu_ptr(q->queue_ctx, cpu);
 		kobject_put(&ctx->kobj);
 	}
-	kobject_put(&q->mq_kobj);
+	kobject_put(q->mq_kobj);
 }
 
-void blk_mq_sysfs_init(struct request_queue *q)
+int blk_mq_sysfs_init(struct request_queue *q)
 {
 	struct blk_mq_ctx *ctx;
 	int cpu;
+	struct blk_mq_kobj *mq_kobj;
+
+	mq_kobj = kzalloc(sizeof(struct blk_mq_kobj), GFP_KERNEL);
+	if (!mq_kobj)
+		return -ENOMEM;
 
-	kobject_init(&q->mq_kobj, &blk_mq_ktype);
+	kobject_init(&mq_kobj->kobj, &blk_mq_ktype);
 
 	for_each_possible_cpu(cpu) {
-		ctx = per_cpu_ptr(q->queue_ctx, cpu);
+		ctx = kzalloc_node(sizeof(*ctx), GFP_KERNEL, cpu_to_node(cpu));
+		if (!ctx)
+			goto fail;
+		*per_cpu_ptr(q->queue_ctx, cpu) = ctx;
 		kobject_init(&ctx->kobj, &blk_mq_ctx_ktype);
 	}
+	q->mq_kobj = &mq_kobj->kobj;
+	return 0;
+
+ fail:
+	for_each_possible_cpu(cpu) {
+		ctx = *per_cpu_ptr(q->queue_ctx, cpu);
+		if (ctx)
+			kobject_put(&ctx->kobj);
+	}
+	kobject_put(&mq_kobj->kobj);
+	return -ENOMEM;
 }
 
 int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
@@ -313,11 +346,11 @@ int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
 	WARN_ON_ONCE(!q->kobj.parent);
 	lockdep_assert_held(&q->sysfs_lock);
 
-	ret = kobject_add(&q->mq_kobj, kobject_get(&dev->kobj), "%s", "mq");
+	ret = kobject_add(q->mq_kobj, kobject_get(&dev->kobj), "%s", "mq");
 	if (ret < 0)
 		goto out;
 
-	kobject_uevent(&q->mq_kobj, KOBJ_ADD);
+	kobject_uevent(q->mq_kobj, KOBJ_ADD);
 
 	queue_for_each_hw_ctx(q, hctx, i) {
 		ret = blk_mq_register_hctx(hctx);
@@ -334,8 +367,8 @@ int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
 	while (--i >= 0)
 		blk_mq_unregister_hctx(q->queue_hw_ctx[i]);
 
-	kobject_uevent(&q->mq_kobj, KOBJ_REMOVE);
-	kobject_del(&q->mq_kobj);
+	kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
+	kobject_del(q->mq_kobj);
 	kobject_put(&dev->kobj);
 	return ret;
 }
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3b823891b3ef..3589ee601f37 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2299,7 +2299,7 @@ static void blk_mq_init_cpu_queues(struct request_queue *q,
 	unsigned int i, j;
 
 	for_each_possible_cpu(i) {
-		struct blk_mq_ctx *__ctx = per_cpu_ptr(q->queue_ctx, i);
+		struct blk_mq_ctx *__ctx = *per_cpu_ptr(q->queue_ctx, i);
 		struct blk_mq_hw_ctx *hctx;
 
 		__ctx->cpu = i;
@@ -2385,7 +2385,7 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 			set->map[0].mq_map[i] = 0;
 		}
 
-		ctx = per_cpu_ptr(q->queue_ctx, i);
+		ctx = *per_cpu_ptr(q->queue_ctx, i);
 		for (j = 0; j < set->nr_maps; j++) {
 			hctx = blk_mq_map_queue_type(q, j, i);
 
@@ -2731,18 +2731,19 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	if (!q->poll_cb)
 		goto err_exit;
 
-	q->queue_ctx = alloc_percpu(struct blk_mq_ctx);
+	q->queue_ctx = alloc_percpu(struct blk_mq_ctx *);
 	if (!q->queue_ctx)
 		goto err_exit;
 
 	/* init q->mq_kobj and sw queues' kobjects */
-	blk_mq_sysfs_init(q);
+	if (blk_mq_sysfs_init(q))
+		goto err_percpu;
 
 	q->nr_queues = nr_hw_queues(set);
 	q->queue_hw_ctx = kcalloc_node(q->nr_queues, sizeof(*(q->queue_hw_ctx)),
 						GFP_KERNEL, set->numa_node);
 	if (!q->queue_hw_ctx)
-		goto err_percpu;
+		goto err_sys_init;
 
 	blk_mq_realloc_hw_ctxs(set, q);
 	if (!q->nr_hw_queues)
@@ -2794,6 +2795,8 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 
 err_hctxs:
 	kfree(q->queue_hw_ctx);
+err_sys_init:
+	blk_mq_sysfs_deinit(q);
 err_percpu:
 	free_percpu(q->queue_ctx);
 err_exit:
diff --git a/block/blk-mq.h b/block/blk-mq.h
index facb6e9ddce4..84898793c230 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -108,7 +108,7 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
 /*
  * sysfs helpers
  */
-extern void blk_mq_sysfs_init(struct request_queue *q);
+extern int blk_mq_sysfs_init(struct request_queue *q);
 extern void blk_mq_sysfs_deinit(struct request_queue *q);
 extern int __blk_mq_register_dev(struct device *dev, struct request_queue *q);
 extern int blk_mq_sysfs_register(struct request_queue *q);
@@ -129,7 +129,7 @@ static inline enum mq_rq_state blk_mq_rq_state(struct request *rq)
 static inline struct blk_mq_ctx *__blk_mq_get_ctx(struct request_queue *q,
 					   unsigned int cpu)
 {
-	return per_cpu_ptr(q->queue_ctx, cpu);
+	return *per_cpu_ptr(q->queue_ctx, cpu);
 }
 
 /*
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1d185f1fc333..9e3892bd67fd 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -407,7 +407,7 @@ struct request_queue {
 	const struct blk_mq_ops	*mq_ops;
 
 	/* sw queues */
-	struct blk_mq_ctx __percpu	*queue_ctx;
+	struct blk_mq_ctx __percpu	**queue_ctx;
 	unsigned int		nr_queues;
 
 	unsigned int		queue_depth;
@@ -456,7 +456,7 @@ struct request_queue {
 	/*
 	 * mq queue kobject
 	 */
-	struct kobject mq_kobj;
+	struct kobject *mq_kobj;
 
 #ifdef  CONFIG_BLK_DEV_INTEGRITY
 	struct blk_integrity integrity;
-- 
2.9.5

