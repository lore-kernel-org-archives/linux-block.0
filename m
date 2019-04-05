Return-Path: <SRS0=t+Ub=SH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D76C282CE
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 21:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96482173C
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 21:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfDEV5v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Apr 2019 17:57:51 -0400
Received: from mga14.intel.com ([192.55.52.115]:50398 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbfDEV5v (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Apr 2019 17:57:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Apr 2019 14:57:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,313,1549958400"; 
   d="scan'208";a="129011346"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by orsmga007.jf.intel.com with ESMTP; 05 Apr 2019 14:57:50 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     Jianchao Wang <jianchao.w.wang@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Keith Busch <keith.busch@intel.com>,
        Ming Lei <ming.lei@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] blk-mq: Wait for for hctx requests on CPU unplug
Date:   Fri,  5 Apr 2019 15:59:20 -0600
Message-Id: <20190405215920.27085-1-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Managed interrupts can not migrate affinity when their CPUs are offline.
If the CPU is allowed to shutdown before they're returned, commands
dispatched to managed queues won't be able to complete through their
irq handlers.

Introduce per-hctx reference counting so we can block the CPU dead
notification for all allocated requests to complete if an hctx's last
CPU is being taken offline.

Cc: Ming Lei <ming.lei@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 block/blk-mq-sched.c   |  2 ++
 block/blk-mq-sysfs.c   |  1 +
 block/blk-mq-tag.c     |  1 +
 block/blk-mq.c         | 36 ++++++++++++++++++++++++++++--------
 block/blk-mq.h         | 10 +++++++++-
 include/linux/blk-mq.h |  3 +++
 6 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 40905539afed..d1179e3d0fd1 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -326,6 +326,7 @@ bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio)
 	enum hctx_type type;
 
 	if (e && e->type->ops.bio_merge) {
+		blk_mq_unmap_queue(hctx);
 		blk_mq_put_ctx(ctx);
 		return e->type->ops.bio_merge(hctx, bio);
 	}
@@ -339,6 +340,7 @@ bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio)
 		spin_unlock(&ctx->lock);
 	}
 
+	blk_mq_unmap_queue(hctx);
 	blk_mq_put_ctx(ctx);
 	return ret;
 }
diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 3f9c3f4ac44c..e85e702fbaaf 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -34,6 +34,7 @@ static void blk_mq_hw_sysfs_release(struct kobject *kobj)
 	struct blk_mq_hw_ctx *hctx = container_of(kobj, struct blk_mq_hw_ctx,
 						  kobj);
 	free_cpumask_var(hctx->cpumask);
+	percpu_ref_exit(&hctx->mapped);
 	kfree(hctx->ctxs);
 	kfree(hctx);
 }
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index a4931fc7be8a..df36af944e4a 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -162,6 +162,7 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 
 		if (data->ctx)
 			blk_mq_put_ctx(data->ctx);
+		blk_mq_unmap_queue(data->hctx);
 
 		bt_prev = bt;
 		io_schedule();
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3ff3d7b49969..6b2fbe895c6b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -385,6 +385,7 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 
 	tag = blk_mq_get_tag(data);
 	if (tag == BLK_MQ_TAG_FAIL) {
+		blk_mq_unmap_queue(data->hctx);
 		if (put_ctx_on_error) {
 			blk_mq_put_ctx(data->ctx);
 			data->ctx = NULL;
@@ -516,6 +517,7 @@ void blk_mq_free_request(struct request *rq)
 	ctx->rq_completed[rq_is_sync(rq)]++;
 	if (rq->rq_flags & RQF_MQ_INFLIGHT)
 		atomic_dec(&hctx->nr_active);
+	blk_mq_unmap_queue(hctx);
 
 	if (unlikely(laptop_mode && !blk_rq_is_passthrough(rq)))
 		laptop_io_completion(q->backing_dev_info);
@@ -2222,14 +2224,19 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 	}
 	spin_unlock(&ctx->lock);
 
-	if (list_empty(&tmp))
-		return 0;
-
-	spin_lock(&hctx->lock);
-	list_splice_tail_init(&tmp, &hctx->dispatch);
-	spin_unlock(&hctx->lock);
+	if (!list_empty(&tmp)) {
+		spin_lock(&hctx->lock);
+		list_splice_tail_init(&tmp, &hctx->dispatch);
+		spin_unlock(&hctx->lock);
+	}
 
 	blk_mq_run_hw_queue(hctx, true);
+
+	if (cpumask_first_and(hctx->cpumask, cpu_online_mask) >= nr_cpu_ids) {
+		percpu_ref_kill(&hctx->mapped);
+		wait_event(hctx->mapped_wq, percpu_ref_is_zero(&hctx->mapped));
+		percpu_ref_reinit(&hctx->mapped);
+	}
 	return 0;
 }
 
@@ -2275,6 +2282,14 @@ static void blk_mq_exit_hw_queues(struct request_queue *q,
 	}
 }
 
+static void hctx_mapped_release(struct percpu_ref *ref)
+{
+	struct blk_mq_hw_ctx *hctx =
+		container_of(ref, struct blk_mq_hw_ctx, mapped);
+
+	wake_up(&hctx->mapped_wq);
+}
+
 static int blk_mq_init_hctx(struct request_queue *q,
 		struct blk_mq_tag_set *set,
 		struct blk_mq_hw_ctx *hctx, unsigned hctx_idx)
@@ -2323,14 +2338,19 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	if (!hctx->fq)
 		goto exit_hctx;
 
-	if (blk_mq_init_request(set, hctx->fq->flush_rq, hctx_idx, node))
+	init_waitqueue_head(&hctx->mapped_wq);
+	if (percpu_ref_init(&hctx->mapped, hctx_mapped_release, 0, GFP_KERNEL))
 		goto free_fq;
 
+	if (blk_mq_init_request(set, hctx->fq->flush_rq, hctx_idx, node))
+		goto free_pcpu;
+
 	if (hctx->flags & BLK_MQ_F_BLOCKING)
 		init_srcu_struct(hctx->srcu);
 
 	return 0;
-
+ free_pcpu:
+	percpu_ref_exit(&hctx->mapped);
  free_fq:
 	kfree(hctx->fq);
  exit_hctx:
diff --git a/block/blk-mq.h b/block/blk-mq.h
index d704fc7766f4..1adee26a7b96 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -105,6 +105,7 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
 						     unsigned int flags,
 						     struct blk_mq_ctx *ctx)
 {
+	struct blk_mq_hw_ctx *hctx;
 	enum hctx_type type = HCTX_TYPE_DEFAULT;
 
 	/*
@@ -115,7 +116,14 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
 	else if ((flags & REQ_OP_MASK) == REQ_OP_READ)
 		type = HCTX_TYPE_READ;
 	
-	return ctx->hctxs[type];
+	hctx = ctx->hctxs[type];
+	percpu_ref_get(&hctx->mapped);
+	return hctx;
+}
+
+static inline void blk_mq_unmap_queue(struct blk_mq_hw_ctx *hctx)
+{
+	percpu_ref_put(&hctx->mapped);
 }
 
 /*
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index cb2aa7ecafff..66e19611a46d 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -58,6 +58,9 @@ struct blk_mq_hw_ctx {
 
 	atomic_t		nr_active;
 
+	wait_queue_head_t	mapped_wq;
+	struct percpu_ref	mapped;
+
 	struct hlist_node	cpuhp_dead;
 	struct kobject		kobj;
 
-- 
2.14.4

