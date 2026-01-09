Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109EB2DF703
	for <linux-block@vger.kernel.org>; Fri,  9 Jan 2026 06:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767941589; cv=none; b=pl7GGhr4Pa82ovyK7ehDtwebn+qzoX2FX0rB3KR6PJD3DsZ66hOKWxi7Y5yLrrFlfarVYLiscDeWBpS608Gy4Q+dVoGNAkT6hSEn+NFtDwlTajSQQq8W2YUpNre6VUhp+xddDJYwTgVTWXVeCHGy3oxxeqZ1O5mSx3iaGbesQiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767941589; c=relaxed/simple;
	bh=zP3KwaA8friKL3MCN2fFkcB2YnJQ2SB9fftYrJaLF34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gdqlbatEX6TX9Ed9YJKXCVYJLx3pOlvyfkKYiVqh3uDLMOFURmk+r8kSq42ODOjJTFi6rPxZTPvVrvhF9b2Lpb4xjpkKS7dwsSfFRF0yA6kK7FxKZfrs5GZXzkX/z42wpCUhYDHRpaAOSWPd9bf4Nl21RlndEqmNcVLWgAt7g/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78ACC4CEF7;
	Fri,  9 Jan 2026 06:53:06 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: yukuai@fnnas.com
Subject: [PATCH v8 8/8] blk-mq-debugfs: warn about possible deadlock
Date: Fri,  9 Jan 2026 14:52:30 +0800
Message-ID: <20260109065230.653281-9-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260109065230.653281-1-yukuai@fnnas.com>
References: <20260109065230.653281-1-yukuai@fnnas.com>
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
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 5c7cadf51a88..faeaa1fc86a7 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -608,9 +608,23 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_ctx_attrs[] = {
 	{},
 };
 
-static void debugfs_create_files(struct dentry *parent, void *data,
+static void debugfs_create_files(struct request_queue *q, struct dentry *parent,
+				 void *data,
 				 const struct blk_mq_debugfs_attr *attr)
 {
+	lockdep_assert_held(&q->debugfs_mutex);
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
 
@@ -624,7 +638,7 @@ void blk_mq_debugfs_register(struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i;
 
-	debugfs_create_files(q->debugfs_dir, q, blk_mq_debugfs_queue_attrs);
+	debugfs_create_files(q, q->debugfs_dir, q, blk_mq_debugfs_queue_attrs);
 
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (!hctx->debugfs_dir)
@@ -643,7 +657,8 @@ static void blk_mq_debugfs_register_ctx(struct blk_mq_hw_ctx *hctx,
 	snprintf(name, sizeof(name), "cpu%u", ctx->cpu);
 	ctx_dir = debugfs_create_dir(name, hctx->debugfs_dir);
 
-	debugfs_create_files(ctx_dir, ctx, blk_mq_debugfs_ctx_attrs);
+	debugfs_create_files(hctx->queue, ctx_dir, ctx,
+			     blk_mq_debugfs_ctx_attrs);
 }
 
 void blk_mq_debugfs_register_hctx(struct request_queue *q,
@@ -659,7 +674,8 @@ void blk_mq_debugfs_register_hctx(struct request_queue *q,
 	snprintf(name, sizeof(name), "hctx%u", hctx->queue_num);
 	hctx->debugfs_dir = debugfs_create_dir(name, q->debugfs_dir);
 
-	debugfs_create_files(hctx->debugfs_dir, hctx, blk_mq_debugfs_hctx_attrs);
+	debugfs_create_files(q, hctx->debugfs_dir, hctx,
+			     blk_mq_debugfs_hctx_attrs);
 
 	hctx_for_each_ctx(hctx, ctx, i)
 		blk_mq_debugfs_register_ctx(hctx, ctx);
@@ -712,7 +728,7 @@ void blk_mq_debugfs_register_sched(struct request_queue *q)
 
 	q->sched_debugfs_dir = debugfs_create_dir("sched", q->debugfs_dir);
 
-	debugfs_create_files(q->sched_debugfs_dir, q, e->queue_debugfs_attrs);
+	debugfs_create_files(q, q->sched_debugfs_dir, q, e->queue_debugfs_attrs);
 }
 
 void blk_mq_debugfs_unregister_sched(struct request_queue *q)
@@ -751,7 +767,8 @@ static void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
 							 q->debugfs_dir);
 
 	rqos->debugfs_dir = debugfs_create_dir(dir_name, q->rqos_debugfs_dir);
-	debugfs_create_files(rqos->debugfs_dir, rqos, rqos->ops->debugfs_attrs);
+	debugfs_create_files(q, rqos->debugfs_dir, rqos,
+			     rqos->ops->debugfs_attrs);
 }
 
 void blk_mq_debugfs_register_rq_qos(struct request_queue *q)
@@ -788,7 +805,7 @@ void blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
 
 	hctx->sched_debugfs_dir = debugfs_create_dir("sched",
 						     hctx->debugfs_dir);
-	debugfs_create_files(hctx->sched_debugfs_dir, hctx,
+	debugfs_create_files(q, hctx->sched_debugfs_dir, hctx,
 			     e->hctx_debugfs_attrs);
 }
 
-- 
2.51.0

