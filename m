Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B65922DA1C
	for <linux-block@vger.kernel.org>; Sun, 30 Nov 2025 02:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764470643; cv=none; b=NM55uESk8YzCU72yfyTXAPRyaUSbCU8e1Sg4ea/LZpmTGo13dRpW2xixDsEoHwm37OfvetygQBZGqkAih9gXiF1tEPXj2pyDnOtkhb2XO+ioDFROy4TMjXYhfHKOTQy0u4rDL7nouRxcQ/PJOem6sZpKEFU2m5aV/oy3H71KRzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764470643; c=relaxed/simple;
	bh=KpzvXJbiIsIiP2wwLPEfoCYZGj28qHN7Js/gQX2JgAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZfPJ54KHjFSDq2mrp1QN0HZLd9DFf3zc5L7z8shJbQhyV8b3AnA1oaVYPMNsvv3P5+6YCPveJ4Sw6YjfBmF17HDudyMCqdwXjSSsfR3jGXXxrcxKVkPgucfnh2uI0p0bNlLjjLS5LYmjodXZAo5GXm5XlgmJF4auS3kClSEOs9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2CCBC4CEF7;
	Sun, 30 Nov 2025 02:44:00 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com,
	bvanassche@acm.org
Cc: yukuai@fnnas.com
Subject: [PATCH v3 04/10] blk-mq-debugfs: warn about possible deadlock
Date: Sun, 30 Nov 2025 10:43:43 +0800
Message-ID: <20251130024349.2302128-5-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251130024349.2302128-1-yukuai@fnnas.com>
References: <20251130024349.2302128-1-yukuai@fnnas.com>
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

