Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CA831076D;
	Mon,  2 Feb 2026 08:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770019532; cv=none; b=l6lOr8toBLr5++VIhtdlOEPWuiRfI2V+rUbaeSibe3fgxXl9w8NAQ6avBGlahe8lC2a8K0shuLmjXq6XFkvSsRaEt6sDjL0pFjDgJaTYMutypJdvT/HKb8x9GliR5hS5Tjt48DNS+vm1ZqyUwk7yXG1Xoe44KCgEMe8xuH8BBPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770019532; c=relaxed/simple;
	bh=3AZcyUVL5hbvTRPlY6JGfimIl0dbowc32m5wWsZDtaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XcfQa0YUZTJk3A5TDAxnXubZfZC+7SVKlGZWFd1ri99alwK15A79gQ/M8j9pgBY/QhZsBcNwHZAn6zS8FgHXMzVm+B8K/oV739GTW7e/+iEdBhepLCeIxGVNvTfIw1AZJgYciZd0qJguHr3ABZDYHKY6JE/gxggPNIrfGledPcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D125C116C6;
	Mon,  2 Feb 2026 08:05:30 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Hannes Reinecke <hare@suse.de>,
	yukuai@fnnas.com
Subject: [PATCH v9 2/8] blk-wbt: fix possible deadlock to nest pcpu_alloc_mutex under q_usage_counter
Date: Mon,  2 Feb 2026 16:05:17 +0800
Message-ID: <20260202080523.3947504-3-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260202080523.3947504-1-yukuai@fnnas.com>
References: <20260202080523.3947504-1-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If wbt is disabled by default and user configures wbt by sysfs, queue
will be frozen first and then pcpu_alloc_mutex will be held in
blk_stat_alloc_callback().

Fix this problem by allocating memory first before queue frozen.

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-wbt.c | 108 ++++++++++++++++++++++++++++--------------------
 1 file changed, 63 insertions(+), 45 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 0a37d97bda75..665760274e60 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -93,7 +93,7 @@ struct rq_wb {
 	struct rq_depth rq_depth;
 };
 
-static int wbt_init(struct gendisk *disk);
+static int wbt_init(struct gendisk *disk, struct rq_wb *rwb);
 
 static inline struct rq_wb *RQWB(struct rq_qos *rqos)
 {
@@ -698,6 +698,41 @@ static void wbt_requeue(struct rq_qos *rqos, struct request *rq)
 	}
 }
 
+static int wbt_data_dir(const struct request *rq)
+{
+	const enum req_op op = req_op(rq);
+
+	if (op == REQ_OP_READ)
+		return READ;
+	else if (op_is_write(op))
+		return WRITE;
+
+	/* don't account */
+	return -1;
+}
+
+static struct rq_wb *wbt_alloc(void)
+{
+	struct rq_wb *rwb = kzalloc(sizeof(*rwb), GFP_KERNEL);
+
+	if (!rwb)
+		return NULL;
+
+	rwb->cb = blk_stat_alloc_callback(wb_timer_fn, wbt_data_dir, 2, rwb);
+	if (!rwb->cb) {
+		kfree(rwb);
+		return NULL;
+	}
+
+	return rwb;
+}
+
+static void wbt_free(struct rq_wb *rwb)
+{
+	blk_stat_free_callback(rwb->cb);
+	kfree(rwb);
+}
+
 /*
  * Enable wbt if defaults are configured that way
  */
@@ -739,8 +774,17 @@ EXPORT_SYMBOL_GPL(wbt_enable_default);
 
 void wbt_init_enable_default(struct gendisk *disk)
 {
-	if (__wbt_enable_default(disk))
-		WARN_ON_ONCE(wbt_init(disk));
+	struct rq_wb *rwb;
+
+	if (!__wbt_enable_default(disk))
+		return;
+
+	rwb = wbt_alloc();
+	if (WARN_ON_ONCE(!rwb))
+		return;
+
+	if (WARN_ON_ONCE(wbt_init(disk, rwb)))
+		wbt_free(rwb);
 }
 
 static u64 wbt_default_latency_nsec(struct request_queue *q)
@@ -754,19 +798,6 @@ static u64 wbt_default_latency_nsec(struct request_queue *q)
 	return 2000000ULL;
 }
 
-static int wbt_data_dir(const struct request *rq)
-{
-	const enum req_op op = req_op(rq);
-
-	if (op == REQ_OP_READ)
-		return READ;
-	else if (op_is_write(op))
-		return WRITE;
-
-	/* don't account */
-	return -1;
-}
-
 static void wbt_queue_depth_changed(struct rq_qos *rqos)
 {
 	RQWB(rqos)->rq_depth.queue_depth = blk_queue_depth(rqos->disk->queue);
@@ -778,8 +809,7 @@ static void wbt_exit(struct rq_qos *rqos)
 	struct rq_wb *rwb = RQWB(rqos);
 
 	blk_stat_remove_callback(rqos->disk->queue, rwb->cb);
-	blk_stat_free_callback(rwb->cb);
-	kfree(rwb);
+	wbt_free(rwb);
 }
 
 /*
@@ -903,22 +933,11 @@ static const struct rq_qos_ops wbt_rqos_ops = {
 #endif
 };
 
-static int wbt_init(struct gendisk *disk)
+static int wbt_init(struct gendisk *disk, struct rq_wb *rwb)
 {
 	struct request_queue *q = disk->queue;
-	struct rq_wb *rwb;
-	int i;
 	int ret;
-
-	rwb = kzalloc(sizeof(*rwb), GFP_KERNEL);
-	if (!rwb)
-		return -ENOMEM;
-
-	rwb->cb = blk_stat_alloc_callback(wb_timer_fn, wbt_data_dir, 2, rwb);
-	if (!rwb->cb) {
-		kfree(rwb);
-		return -ENOMEM;
-	}
+	int i;
 
 	for (i = 0; i < WBT_NUM_RWQ; i++)
 		rq_wait_init(&rwb->rq_wait[i]);
@@ -938,38 +957,38 @@ static int wbt_init(struct gendisk *disk)
 	ret = rq_qos_add(&rwb->rqos, disk, RQ_QOS_WBT, &wbt_rqos_ops);
 	mutex_unlock(&q->rq_qos_mutex);
 	if (ret)
-		goto err_free;
+		return ret;
 
 	blk_stat_add_callback(q, rwb->cb);
-
 	return 0;
-
-err_free:
-	blk_stat_free_callback(rwb->cb);
-	kfree(rwb);
-	return ret;
-
 }
 
 int wbt_set_lat(struct gendisk *disk, s64 val)
 {
 	struct request_queue *q = disk->queue;
+	struct rq_qos *rqos = wbt_rq_qos(q);
+	struct rq_wb *rwb = NULL;
 	unsigned int memflags;
-	struct rq_qos *rqos;
 	int ret = 0;
 
+	if (!rqos) {
+		rwb = wbt_alloc();
+		if (!rwb)
+			return -ENOMEM;
+	}
+
 	/*
 	 * Ensure that the queue is idled, in case the latency update
 	 * ends up either enabling or disabling wbt completely. We can't
 	 * have IO inflight if that happens.
 	 */
 	memflags = blk_mq_freeze_queue(q);
-
-	rqos = wbt_rq_qos(q);
 	if (!rqos) {
-		ret = wbt_init(disk);
-		if (ret)
+		ret = wbt_init(disk, rwb);
+		if (ret) {
+			wbt_free(rwb);
 			goto out;
+		}
 	}
 
 	if (val == -1)
@@ -989,6 +1008,5 @@ int wbt_set_lat(struct gendisk *disk, s64 val)
 	blk_mq_unquiesce_queue(q);
 out:
 	blk_mq_unfreeze_queue(q, memflags);
-
 	return ret;
 }
-- 
2.51.0

