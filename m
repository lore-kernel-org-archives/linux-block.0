Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E41F2DF703
	for <linux-block@vger.kernel.org>; Fri,  9 Jan 2026 06:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767941582; cv=none; b=VeX87SX9SFz0Sjc8rNNNkJ/oULdFCxiI66wxyhorDx89UqLpXAO1mp43stYfOpJdKIhuoDOrmNvW6JNdlEfj79ogkalhrmpMOf7VhhmfA8ZRuHMXJPRglD+d3iwx+jSyG/I22DF+QIOijGhA3zqoifROaN24AiSTRgE9x3uewlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767941582; c=relaxed/simple;
	bh=T353R1t6yV0vI4XlCt+mQ5DErKXBGF4G/9O6ZwbBDZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ug7NP9YGnjlXwFrdryk6f7Ev+Ke9Nx3uATBibiYLTy6kVL5PC3fqImSktSfMI4jpTc2N7kdSJqyTmpffUJRG10Brax9I0+JOoFy4mlGDYEjTDim82c0Tw6cbIirgx0TDDQ6mPPvdk1dxHFgD4eiKILECT8Ak3jzZGH4nRYXbQA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A78C4CEF1;
	Fri,  9 Jan 2026 06:52:59 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: yukuai@fnnas.com
Subject: [PATCH v8 6/8] blk-mq-debugfs: remove blk_mq_debugfs_unregister_rqos()
Date: Fri,  9 Jan 2026 14:52:28 +0800
Message-ID: <20260109065230.653281-7-yukuai@fnnas.com>
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

Because this helper is only used by iocost and iolatency, while they
don't have debugfs entries.

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c | 10 ----------
 block/blk-mq-debugfs.h |  4 ----
 block/blk-rq-qos.c     |  4 ----
 3 files changed, 18 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 11f00a868541..22c182b40bc3 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -734,16 +734,6 @@ static const char *rq_qos_id_to_name(enum rq_qos_id id)
 	return "unknown";
 }
 
-void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
-{
-	lockdep_assert_held(&rqos->disk->queue->debugfs_mutex);
-
-	if (!rqos->disk->queue->debugfs_dir)
-		return;
-	debugfs_remove_recursive(rqos->debugfs_dir);
-	rqos->debugfs_dir = NULL;
-}
-
 static void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
 {
 	struct request_queue *q = rqos->disk->queue;
diff --git a/block/blk-mq-debugfs.h b/block/blk-mq-debugfs.h
index d94daa66556b..49bb1aaa83dc 100644
--- a/block/blk-mq-debugfs.h
+++ b/block/blk-mq-debugfs.h
@@ -34,7 +34,6 @@ void blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
 void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx);
 
 void blk_mq_debugfs_register_rq_qos(struct request_queue *q);
-void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos);
 #else
 static inline void blk_mq_debugfs_register(struct request_queue *q)
 {
@@ -78,9 +77,6 @@ static inline void blk_mq_debugfs_register_rq_qos(struct request_queue *q)
 {
 }
 
-static inline void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
-{
-}
 #endif
 
 #if defined(CONFIG_BLK_DEV_ZONED) && defined(CONFIG_BLK_DEBUG_FS)
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index d7ce99ce2e80..85cf74402a09 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -371,8 +371,4 @@ void rq_qos_del(struct rq_qos *rqos)
 	if (!q->rq_qos)
 		blk_queue_flag_clear(QUEUE_FLAG_QOS_ENABLED, q);
 	blk_mq_unfreeze_queue(q, memflags);
-
-	mutex_lock(&q->debugfs_mutex);
-	blk_mq_debugfs_unregister_rqos(rqos);
-	mutex_unlock(&q->debugfs_mutex);
 }
-- 
2.51.0

