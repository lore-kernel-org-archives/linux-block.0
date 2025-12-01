Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B92733985
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 08:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764578063; cv=none; b=kL8VmQW2ommTOy/uScCBXhsUl0UC6b6MBpF48vEUZoqxpnepW/2vgZU4OQw6FWNvzmMhBHffDEZnOGMvmcUV9VYXTX8uHD4e9vMBtdCxvrAZf/1QDMY+JiUWbwoFWYFtctmCfi1BSBXb76IptrStY3U3ePSRdON2BUy+Zw5t2IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764578063; c=relaxed/simple;
	bh=J2GkoZAt9segBUKqWjyuurpA4Hzz50rWLddubm+FksY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SpQJkVl8uoQ56U6MtVxY4dnrDxUJXxBdQG6FlLHtxx7tGpPmMAnIlkvvRxa16UET+DY8IVROvesoVpAthF97Gd/lAR1ygHOeTksKj6ij8i836TlLcWhzZOxQ7dFPsOORfGj0ERrk/xkrdr6okl3WdDl1q35ifkXZhU9903FABD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 520E0C19421;
	Mon,  1 Dec 2025 08:34:21 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com,
	bvanassche@acm.org
Cc: yukuai@fnnas.com
Subject: [PATCH v4 02/12] blk-wbt: fix possible deadlock to nest pcpu_alloc_mutex under q_usage_counter
Date: Mon,  1 Dec 2025 16:34:05 +0800
Message-ID: <20251201083415.2407888-3-yukuai@fnnas.com>
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

If wbt is disabled by default and user configures wbt by sysfs, queue
will be frozen first and then pcpu_alloc_mutex will be held in
blk_stat_alloc_callback().

Fix this problem by allocating memory first before queue frozen.

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 block/blk-wbt.c | 94 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 57 insertions(+), 37 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index ba807649b29a..3777255b99ad 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -93,7 +93,7 @@ struct rq_wb {
 	struct rq_depth rq_depth;
 };
 
-static int wbt_init(struct gendisk *disk);
+static int wbt_init(struct gendisk *disk, struct rq_wb *rwb);
 
 static inline struct rq_wb *RQWB(struct rq_qos *rqos)
 {
@@ -698,6 +698,35 @@ static void wbt_requeue(struct rq_qos *rqos, struct request *rq)
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
 /*
  * Enable wbt if defaults are configured that way
  */
@@ -726,8 +755,12 @@ void wbt_enable_default(struct gendisk *disk)
 	if (!blk_queue_registered(q))
 		return;
 
-	if (queue_is_mq(q) && enable)
-		wbt_init(disk);
+	if (queue_is_mq(q) && enable) {
+		struct rq_wb *rwb = wbt_alloc();
+
+		if (rwb)
+			wbt_init(disk, rwb);
+	}
 }
 EXPORT_SYMBOL_GPL(wbt_enable_default);
 
@@ -743,32 +776,24 @@ static u64 wbt_default_latency_nsec(struct request_queue *q)
 		return 75000000ULL;
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
 	wbt_update_limits(RQWB(rqos));
 }
 
+static void wbt_free(struct rq_wb *rwb)
+{
+	blk_stat_free_callback(rwb->cb);
+	kfree(rwb);
+}
+
 static void wbt_exit(struct rq_qos *rqos)
 {
 	struct rq_wb *rwb = RQWB(rqos);
 
 	blk_stat_remove_callback(rqos->disk->queue, rwb->cb);
-	blk_stat_free_callback(rwb->cb);
-	kfree(rwb);
+	wbt_free(rwb);
 }
 
 /*
@@ -892,22 +917,11 @@ static const struct rq_qos_ops wbt_rqos_ops = {
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
@@ -934,19 +948,24 @@ static int wbt_init(struct gendisk *disk)
 	return 0;
 
 err_free:
-	blk_stat_free_callback(rwb->cb);
-	kfree(rwb);
+	wbt_free(rwb);
 	return ret;
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
@@ -956,9 +975,11 @@ int wbt_set_lat(struct gendisk *disk, s64 val)
 
 	rqos = wbt_rq_qos(q);
 	if (!rqos) {
-		ret = wbt_init(disk);
+		ret = wbt_init(disk, rwb);
 		if (ret)
 			goto out;
+	} else if (rwb) {
+		wbt_free(rwb);
 	}
 
 	if (val == -1)
@@ -978,6 +999,5 @@ int wbt_set_lat(struct gendisk *disk, s64 val)
 	blk_mq_unquiesce_queue(q);
 out:
 	blk_mq_unfreeze_queue(q, memflags);
-
 	return ret;
 }
-- 
2.51.0

