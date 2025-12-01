Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFCD2EA468
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 08:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764578070; cv=none; b=gAeuhYG0FfMAeA0VA9wz0TppevXjnzp8I4uMSB+sZgJZfbtAqN57V/v2FPbszc+17tITVRpFLErJhUk9u2VqnsXg+lbLvhwpMRx7Wygd5lFEp8ZsDkJe/oT9ied2um5CxODSsEbcpuDKJ8L+Fw1DRWeVUmGFe65/XfP3M6kQAEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764578070; c=relaxed/simple;
	bh=KpzvXJbiIsIiP2wwLPEfoCYZGj28qHN7Js/gQX2JgAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjdf7BkeR4Ro69qVIWJBYiLLvxK1GVxmlFGIfOsGvnSO3wJtTZWbvsQHVb17tN+fVzZ9xr4JzOzBElqJwoemB+y2DQTmZB7qmG8PRdjHV+Dw65q74QEP+OI+aa/vvXYe1fJaNCAmdHbxMxH4ijeW3w+DaJHe8Q8u6B2ycbENLX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F16C116D0;
	Mon,  1 Dec 2025 08:34:28 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com,
	bvanassche@acm.org
Cc: yukuai@fnnas.com
Subject: [PATCH v4 06/12] blk-mq-debugfs: warn about possible deadlock
Date: Mon,  1 Dec 2025 16:34:09 +0800
Message-ID: <20251201083415.2407888-7-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251201083415.2407888-1-yukuai@fnnas.com>
References: <20251201083415.2407888-1-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Creating new debugfs entries can trigger fs reclaim, hence we can't do
this with queue frozen, meanwhile, other locks that can be held while
queue is frozen should not be held as well.

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 block/blk-mq-debugfs.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 99466595c0a4..d54f8c29d2f4 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -610,9 +610,22 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_ctx_attrs[] = {
 	{},
 };
 
-static void debugfs_create_files(struct dentry *parent, void *data,
+static void debugfs_create_files(struct request_queue *q, struct dentry *parent,
+				 void *data,
 				 const struct blk_mq_debugfs_attr *attr)
 {
+	/*
+	 * Creating new debugfs entries with queue freezed has the risk of
+	 * deadlock.
+	 */
+	WARN_ON_ONCE(q->mq_freeze_depth != 0);
+	/*
+	 * debugfs_mutex should not be nested under other locks that can be
+	 * grabbed while queue is frozen.
+	 */
+	lockdep_assert_not_held(&q->elevator_lock);
+	lockdep_assert_not_held(&q->rq_qos_mutex);
+
 	if (IS_ERR_OR_NULL(parent))
 		return;
 
@@ -640,7 +653,7 @@ void blk_mq_debugfs_register(struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i;
 
-	debugfs_create_files(q->debugfs_dir, q, blk_mq_debugfs_queue_attrs);
+	debugfs_create_files(q, q->debugfs_dir, q, blk_mq_debugfs_queue_attrs);
 
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (!hctx->debugfs_dir)
@@ -659,7 +672,8 @@ static void blk_mq_debugfs_register_ctx(struct blk_mq_hw_ctx *hctx,
 	snprintf(name, sizeof(name), "cpu%u", ctx->cpu);
 	ctx_dir = debugfs_create_dir(name, hctx->debugfs_dir);
 
-	debugfs_create_files(ctx_dir, ctx, blk_mq_debugfs_ctx_attrs);
+	debugfs_create_files(hctx->queue, ctx_dir, ctx,
+			     blk_mq_debugfs_ctx_attrs);
 }
 
 void blk_mq_debugfs_register_hctx(struct request_queue *q,
@@ -675,7 +689,8 @@ void blk_mq_debugfs_register_hctx(struct request_queue *q,
 	snprintf(name, sizeof(name), "hctx%u", hctx->queue_num);
 	hctx->debugfs_dir = debugfs_create_dir(name, q->debugfs_dir);
 
-	debugfs_create_files(hctx->debugfs_dir, hctx, blk_mq_debugfs_hctx_attrs);
+	debugfs_create_files(q, hctx->debugfs_dir, hctx,
+			     blk_mq_debugfs_hctx_attrs);
 
 	hctx_for_each_ctx(hctx, ctx, i)
 		blk_mq_debugfs_register_ctx(hctx, ctx);
@@ -726,7 +741,7 @@ void blk_mq_debugfs_register_sched(struct request_queue *q)
 
 	q->sched_debugfs_dir = debugfs_create_dir("sched", q->debugfs_dir);
 
-	debugfs_create_files(q->sched_debugfs_dir, q, e->queue_debugfs_attrs);
+	debugfs_create_files(q, q->sched_debugfs_dir, q, e->queue_debugfs_attrs);
 }
 
 void blk_mq_debugfs_unregister_sched(struct request_queue *q)
@@ -775,7 +790,8 @@ static void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
 							 q->debugfs_dir);
 
 	rqos->debugfs_dir = debugfs_create_dir(dir_name, q->rqos_debugfs_dir);
-	debugfs_create_files(rqos->debugfs_dir, rqos, rqos->ops->debugfs_attrs);
+	debugfs_create_files(q, rqos->debugfs_dir, rqos,
+			     rqos->ops->debugfs_attrs);
 }
 
 void blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
@@ -798,7 +814,7 @@ void blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
 
 	hctx->sched_debugfs_dir = debugfs_create_dir("sched",
 						     hctx->debugfs_dir);
-	debugfs_create_files(hctx->sched_debugfs_dir, hctx,
+	debugfs_create_files(q, hctx->sched_debugfs_dir, hctx,
 			     e->hctx_debugfs_attrs);
 }
 
-- 
2.51.0

