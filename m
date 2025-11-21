Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D99E3191D7
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 06:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763706522; cv=none; b=cWS03oWMN1hBBS6Ckyws/FF1PgCGnE86MESClLXTQoxLM8hfXf35DolQyFzQasJizbqDKphoYM4Z3UUntvj//jZYHZh4iSUaIGw2IlyQdlqk401IFMniuhRAMTq3iVNAawTp6tcnsMow5OaGK/1E5hZU1477NyQEmpjaOr1o11I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763706522; c=relaxed/simple;
	bh=YbCd0eXtXkER375AD7sgP+HAx3EVdiXoeWDH07cdte8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0kthsZrGPITNI/odl1w95cLcOh1pPG5CFN5jjUK7Kn6aRym3WLOabW2vQTIKvtPNIGyt6tRZ1mlVJpKh51bKDWZ/fZS/b1RrO7r5u2GX7UiIiVLbZOxY17MDRVP5GOfSROjHsuN17ej+VWIAH0l+MC9DoyKMfKGovHkPUSDFk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23809C4CEF1;
	Fri, 21 Nov 2025 06:28:39 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com,
	bvanassche@acm.org
Cc: yukuai@fnnas.com
Subject: [PATCH v2 4/9] blk-mq-debugfs: warn about possible deadlock
Date: Fri, 21 Nov 2025 14:28:24 +0800
Message-ID: <20251121062829.1433332-5-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121062829.1433332-1-yukuai@fnnas.com>
References: <20251121062829.1433332-1-yukuai@fnnas.com>
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
 block/blk-mq-debugfs.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 99466595c0a4..39004603a670 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -610,9 +610,23 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_ctx_attrs[] = {
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
+	lockdep_assert_not_held(&q->blkcg_mutex);
+
 	if (IS_ERR_OR_NULL(parent))
 		return;
 
@@ -640,7 +654,7 @@ void blk_mq_debugfs_register(struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i;
 
-	debugfs_create_files(q->debugfs_dir, q, blk_mq_debugfs_queue_attrs);
+	debugfs_create_files(q, q->debugfs_dir, q, blk_mq_debugfs_queue_attrs);
 
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (!hctx->debugfs_dir)
@@ -659,7 +673,8 @@ static void blk_mq_debugfs_register_ctx(struct blk_mq_hw_ctx *hctx,
 	snprintf(name, sizeof(name), "cpu%u", ctx->cpu);
 	ctx_dir = debugfs_create_dir(name, hctx->debugfs_dir);
 
-	debugfs_create_files(ctx_dir, ctx, blk_mq_debugfs_ctx_attrs);
+	debugfs_create_files(hctx->queue, ctx_dir, ctx,
+			     blk_mq_debugfs_ctx_attrs);
 }
 
 void blk_mq_debugfs_register_hctx(struct request_queue *q,
@@ -675,7 +690,8 @@ void blk_mq_debugfs_register_hctx(struct request_queue *q,
 	snprintf(name, sizeof(name), "hctx%u", hctx->queue_num);
 	hctx->debugfs_dir = debugfs_create_dir(name, q->debugfs_dir);
 
-	debugfs_create_files(hctx->debugfs_dir, hctx, blk_mq_debugfs_hctx_attrs);
+	debugfs_create_files(q, hctx->debugfs_dir, hctx,
+			     blk_mq_debugfs_hctx_attrs);
 
 	hctx_for_each_ctx(hctx, ctx, i)
 		blk_mq_debugfs_register_ctx(hctx, ctx);
@@ -726,7 +742,7 @@ void blk_mq_debugfs_register_sched(struct request_queue *q)
 
 	q->sched_debugfs_dir = debugfs_create_dir("sched", q->debugfs_dir);
 
-	debugfs_create_files(q->sched_debugfs_dir, q, e->queue_debugfs_attrs);
+	debugfs_create_files(q, q->sched_debugfs_dir, q, e->queue_debugfs_attrs);
 }
 
 void blk_mq_debugfs_unregister_sched(struct request_queue *q)
@@ -775,7 +791,8 @@ static void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
 							 q->debugfs_dir);
 
 	rqos->debugfs_dir = debugfs_create_dir(dir_name, q->rqos_debugfs_dir);
-	debugfs_create_files(rqos->debugfs_dir, rqos, rqos->ops->debugfs_attrs);
+	debugfs_create_files(q, rqos->debugfs_dir, rqos,
+			     rqos->ops->debugfs_attrs);
 }
 
 void blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
@@ -798,7 +815,7 @@ void blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
 
 	hctx->sched_debugfs_dir = debugfs_create_dir("sched",
 						     hctx->debugfs_dir);
-	debugfs_create_files(hctx->sched_debugfs_dir, hctx,
+	debugfs_create_files(q, hctx->sched_debugfs_dir, hctx,
 			     e->hctx_debugfs_attrs);
 }
 
-- 
2.51.0

