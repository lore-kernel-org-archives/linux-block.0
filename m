Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5EAC43441
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 01:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F41E52089F
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 01:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F41E52089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730646AbeKTMLW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 07:11:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55026 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbeKTMLW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 07:11:22 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 81EF6307D85B;
        Tue, 20 Nov 2018 01:44:46 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E16695D75E;
        Tue, 20 Nov 2018 01:44:42 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        "jianchao.wang" <jianchao.w.wang@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: [PATCH 4.21 V3] blk-mq: not embed .mq_kobj and ctx->kobj into queue instance
Date:   Tue, 20 Nov 2018 09:44:35 +0800
Message-Id: <20181120014435.3339-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 20 Nov 2018 01:44:46 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Even though .mq_kobj, ctx->kobj and q->kobj share same lifetime
from block layer's view, actually they don't because userspace may
grab one kobject anytime via sysfs.

This patch fixes the issue by the following approach:

1) introduce 'struct blk_mq_ctxs' for holding .mq_kobj and managing
all ctxs

2) free all allocated ctxs and the 'blk_mq_ctxs' instance in release
handler of .mq_kobj

3) grab one ref of .mq_kobj before initializing each ctx->kobj, so that
.mq_kobj is always released after all ctxs are freed.

This patch fixes kernel panic issue during booting when DEBUG_KOBJECT_RELEASE
is enabled.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Cc: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V3:
	- keep to allocate q->queue_ctx via percpu allocator, so one extra
	  pointer reference can be saved for getting ctx
V2:
	- allocate 'blk_mq_ctx' inside blk_mq_init_allocated_queue()
	- allocate q->mq_kobj directly 

 block/blk-mq-sysfs.c   | 34 ++++++++++++++++++++++++----------
 block/blk-mq.c         | 39 ++++++++++++++++++++++++++++++++-------
 block/blk-mq.h         |  6 ++++++
 include/linux/blkdev.h |  2 +-
 4 files changed, 63 insertions(+), 18 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 3d25b9c419e9..6efef1f679f0 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -15,6 +15,18 @@
 
 static void blk_mq_sysfs_release(struct kobject *kobj)
 {
+	struct blk_mq_ctxs *ctxs = container_of(kobj, struct blk_mq_ctxs, kobj);
+
+	free_percpu(ctxs->queue_ctx);
+	kfree(ctxs);
+}
+
+static void blk_mq_ctx_sysfs_release(struct kobject *kobj)
+{
+	struct blk_mq_ctx *ctx = container_of(kobj, struct blk_mq_ctx, kobj);
+
+	/* ctx->ctxs won't be released until all ctx are freed */
+	kobject_put(&ctx->ctxs->kobj);
 }
 
 static void blk_mq_hw_sysfs_release(struct kobject *kobj)
@@ -213,7 +225,7 @@ static struct kobj_type blk_mq_ktype = {
 static struct kobj_type blk_mq_ctx_ktype = {
 	.sysfs_ops	= &blk_mq_sysfs_ops,
 	.default_attrs	= default_ctx_attrs,
-	.release	= blk_mq_sysfs_release,
+	.release	= blk_mq_ctx_sysfs_release,
 };
 
 static struct kobj_type blk_mq_hw_ktype = {
@@ -245,7 +257,7 @@ static int blk_mq_register_hctx(struct blk_mq_hw_ctx *hctx)
 	if (!hctx->nr_ctx)
 		return 0;
 
-	ret = kobject_add(&hctx->kobj, &q->mq_kobj, "%u", hctx->queue_num);
+	ret = kobject_add(&hctx->kobj, q->mq_kobj, "%u", hctx->queue_num);
 	if (ret)
 		return ret;
 
@@ -268,8 +280,8 @@ void blk_mq_unregister_dev(struct device *dev, struct request_queue *q)
 	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_unregister_hctx(hctx);
 
-	kobject_uevent(&q->mq_kobj, KOBJ_REMOVE);
-	kobject_del(&q->mq_kobj);
+	kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
+	kobject_del(q->mq_kobj);
 	kobject_put(&dev->kobj);
 
 	q->mq_sysfs_init_done = false;
@@ -289,7 +301,7 @@ void blk_mq_sysfs_deinit(struct request_queue *q)
 		ctx = per_cpu_ptr(q->queue_ctx, cpu);
 		kobject_put(&ctx->kobj);
 	}
-	kobject_put(&q->mq_kobj);
+	kobject_put(q->mq_kobj);
 }
 
 void blk_mq_sysfs_init(struct request_queue *q)
@@ -297,10 +309,12 @@ void blk_mq_sysfs_init(struct request_queue *q)
 	struct blk_mq_ctx *ctx;
 	int cpu;
 
-	kobject_init(&q->mq_kobj, &blk_mq_ktype);
+	kobject_init(q->mq_kobj, &blk_mq_ktype);
 
 	for_each_possible_cpu(cpu) {
 		ctx = per_cpu_ptr(q->queue_ctx, cpu);
+
+		kobject_get(q->mq_kobj);
 		kobject_init(&ctx->kobj, &blk_mq_ctx_ktype);
 	}
 }
@@ -313,11 +327,11 @@ int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
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
@@ -334,8 +348,8 @@ int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
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
index 32b246ed44c0..9228f2e9bd40 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2515,6 +2515,34 @@ static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
 	mutex_unlock(&set->tag_list_lock);
 }
 
+/* All allocations will be freed in release handler of q->mq_kobj */
+static int blk_mq_alloc_ctxs(struct request_queue *q)
+{
+	struct blk_mq_ctxs *ctxs;
+	int cpu;
+
+	ctxs = kzalloc(sizeof(*ctxs), GFP_KERNEL);
+	if (!ctxs)
+		return -ENOMEM;
+
+	ctxs->queue_ctx = alloc_percpu(struct blk_mq_ctx);
+	if (!ctxs->queue_ctx)
+		goto fail;
+
+	for_each_possible_cpu(cpu) {
+		struct blk_mq_ctx *ctx = per_cpu_ptr(ctxs->queue_ctx, cpu);
+		ctx->ctxs = ctxs;
+	}
+
+	q->mq_kobj = &ctxs->kobj;
+	q->queue_ctx = ctxs->queue_ctx;
+
+	return 0;
+ fail:
+	kfree(ctxs);
+	return -ENOMEM;
+}
+
 /*
  * It is the actual release handler for mq, but we do it from
  * request queue's release handler for avoiding use-after-free
@@ -2540,8 +2568,6 @@ void blk_mq_release(struct request_queue *q)
 	 * both share lifetime with request queue.
 	 */
 	blk_mq_sysfs_deinit(q);
-
-	free_percpu(q->queue_ctx);
 }
 
 struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *set)
@@ -2731,8 +2757,7 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	if (!q->poll_cb)
 		goto err_exit;
 
-	q->queue_ctx = alloc_percpu(struct blk_mq_ctx);
-	if (!q->queue_ctx)
+	if (blk_mq_alloc_ctxs(q))
 		goto err_exit;
 
 	/* init q->mq_kobj and sw queues' kobjects */
@@ -2742,7 +2767,7 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	q->queue_hw_ctx = kcalloc_node(q->nr_queues, sizeof(*(q->queue_hw_ctx)),
 						GFP_KERNEL, set->numa_node);
 	if (!q->queue_hw_ctx)
-		goto err_percpu;
+		goto err_sys_init;
 
 	blk_mq_realloc_hw_ctxs(set, q);
 	if (!q->nr_hw_queues)
@@ -2794,8 +2819,8 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 
 err_hctxs:
 	kfree(q->queue_hw_ctx);
-err_percpu:
-	free_percpu(q->queue_ctx);
+err_sys_init:
+	blk_mq_sysfs_deinit(q);
 err_exit:
 	q->mq_ops = NULL;
 	return ERR_PTR(-ENOMEM);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index facb6e9ddce4..9ae8e9f8f8b1 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -7,6 +7,11 @@
 
 struct blk_mq_tag_set;
 
+struct blk_mq_ctxs {
+	struct kobject kobj;
+	struct blk_mq_ctx __percpu	*queue_ctx;
+};
+
 /**
  * struct blk_mq_ctx - State for a software queue facing the submitting CPUs
  */
@@ -27,6 +32,7 @@ struct blk_mq_ctx {
 	unsigned long		____cacheline_aligned_in_smp rq_completed[2];
 
 	struct request_queue	*queue;
+	struct blk_mq_ctxs      *ctxs;
 	struct kobject		kobj;
 } ____cacheline_aligned_in_smp;
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1ad6eafc43f2..efd9a31bd226 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
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

