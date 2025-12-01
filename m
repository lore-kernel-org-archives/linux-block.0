Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59766296BCF
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 08:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764578061; cv=none; b=U5NcOTiVQJDN40pdd9Ihe1bOKv3NuSC+SLaxp10f6M/WlOl3h3+BvUB/RJubtMQyNd4SAY5dZfAOosGC8+JaO/MP1h8TRUWTtWAJvaMGunt4FzWe/jy5aAc2pvvJYkb+HoC/WKG/IoQ3QCORt2uPZ0gJ0YIYqCnLXBhPAPwxQ8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764578061; c=relaxed/simple;
	bh=Ax57KnbXTDm1tRsm35tKvsE7ysS+19tFDU24APMIHVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uvj1gZkxWia3r8BPWEOVPbnMhGcnbuDvo7Eapi8hHAQ8y1i94tjfVlNIg41mUx+hTVapDqfLCfNRabLS9GXWHDwowiq3U8S98RSGOvlWASDbHXtsh6iNRghN3c6t6vRWz+qTyGavfPnlkUDJbULNOq+lD8Iw0XqSQhVjjA0P5CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1DCC116D0;
	Mon,  1 Dec 2025 08:34:19 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com,
	bvanassche@acm.org
Cc: yukuai@fnnas.com
Subject: [PATCH v4 01/12] blk-wbt: factor out a helper wbt_set_lat()
Date: Mon,  1 Dec 2025 16:34:04 +0800
Message-ID: <20251201083415.2407888-2-yukuai@fnnas.com>
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

To move implementation details inside blk-wbt.c, prepare to fix possible
deadlock to call wbt_init() while queue is frozen in the next patch.

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 block/blk-sysfs.c | 39 ++----------------------------------
 block/blk-wbt.c   | 50 ++++++++++++++++++++++++++++++++++++++++++++---
 block/blk-wbt.h   |  8 ++------
 3 files changed, 51 insertions(+), 46 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 8684c57498cc..96f10e1bcbd1 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -636,11 +636,8 @@ static ssize_t queue_wb_lat_show(struct gendisk *disk, char *page)
 static ssize_t queue_wb_lat_store(struct gendisk *disk, const char *page,
 				  size_t count)
 {
-	struct request_queue *q = disk->queue;
-	struct rq_qos *rqos;
 	ssize_t ret;
 	s64 val;
-	unsigned int memflags;
 
 	ret = queue_var_store64(&val, page);
 	if (ret < 0)
@@ -648,40 +645,8 @@ static ssize_t queue_wb_lat_store(struct gendisk *disk, const char *page,
 	if (val < -1)
 		return -EINVAL;
 
-	/*
-	 * Ensure that the queue is idled, in case the latency update
-	 * ends up either enabling or disabling wbt completely. We can't
-	 * have IO inflight if that happens.
-	 */
-	memflags = blk_mq_freeze_queue(q);
-
-	rqos = wbt_rq_qos(q);
-	if (!rqos) {
-		ret = wbt_init(disk);
-		if (ret)
-			goto out;
-	}
-
-	ret = count;
-	if (val == -1)
-		val = wbt_default_latency_nsec(q);
-	else if (val >= 0)
-		val *= 1000ULL;
-
-	if (wbt_get_min_lat(q) == val)
-		goto out;
-
-	blk_mq_quiesce_queue(q);
-
-	mutex_lock(&disk->rqos_state_mutex);
-	wbt_set_min_lat(q, val);
-	mutex_unlock(&disk->rqos_state_mutex);
-
-	blk_mq_unquiesce_queue(q);
-out:
-	blk_mq_unfreeze_queue(q, memflags);
-
-	return ret;
+	ret = wbt_set_lat(disk, val);
+	return ret ? ret : count;
 }
 
 QUEUE_RW_ENTRY(queue_wb_lat, "wbt_lat_usec");
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index eb8037bae0bd..ba807649b29a 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -93,6 +93,8 @@ struct rq_wb {
 	struct rq_depth rq_depth;
 };
 
+static int wbt_init(struct gendisk *disk);
+
 static inline struct rq_wb *RQWB(struct rq_qos *rqos)
 {
 	return container_of(rqos, struct rq_wb, rqos);
@@ -506,7 +508,7 @@ u64 wbt_get_min_lat(struct request_queue *q)
 	return RQWB(rqos)->min_lat_nsec;
 }
 
-void wbt_set_min_lat(struct request_queue *q, u64 val)
+static void wbt_set_min_lat(struct request_queue *q, u64 val)
 {
 	struct rq_qos *rqos = wbt_rq_qos(q);
 	if (!rqos)
@@ -729,7 +731,7 @@ void wbt_enable_default(struct gendisk *disk)
 }
 EXPORT_SYMBOL_GPL(wbt_enable_default);
 
-u64 wbt_default_latency_nsec(struct request_queue *q)
+static u64 wbt_default_latency_nsec(struct request_queue *q)
 {
 	/*
 	 * We default to 2msec for non-rotational storage, and 75msec
@@ -890,7 +892,7 @@ static const struct rq_qos_ops wbt_rqos_ops = {
 #endif
 };
 
-int wbt_init(struct gendisk *disk)
+static int wbt_init(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
 	struct rq_wb *rwb;
@@ -937,3 +939,45 @@ int wbt_init(struct gendisk *disk)
 	return ret;
 
 }
+
+int wbt_set_lat(struct gendisk *disk, s64 val)
+{
+	struct request_queue *q = disk->queue;
+	unsigned int memflags;
+	struct rq_qos *rqos;
+	int ret = 0;
+
+	/*
+	 * Ensure that the queue is idled, in case the latency update
+	 * ends up either enabling or disabling wbt completely. We can't
+	 * have IO inflight if that happens.
+	 */
+	memflags = blk_mq_freeze_queue(q);
+
+	rqos = wbt_rq_qos(q);
+	if (!rqos) {
+		ret = wbt_init(disk);
+		if (ret)
+			goto out;
+	}
+
+	if (val == -1)
+		val = wbt_default_latency_nsec(q);
+	else if (val >= 0)
+		val *= 1000ULL;
+
+	if (wbt_get_min_lat(q) == val)
+		goto out;
+
+	blk_mq_quiesce_queue(q);
+
+	mutex_lock(&disk->rqos_state_mutex);
+	wbt_set_min_lat(q, val);
+	mutex_unlock(&disk->rqos_state_mutex);
+
+	blk_mq_unquiesce_queue(q);
+out:
+	blk_mq_unfreeze_queue(q, memflags);
+
+	return ret;
+}
diff --git a/block/blk-wbt.h b/block/blk-wbt.h
index e5fc653b9b76..414cf1c34212 100644
--- a/block/blk-wbt.h
+++ b/block/blk-wbt.h
@@ -4,15 +4,11 @@
 
 #ifdef CONFIG_BLK_WBT
 
-int wbt_init(struct gendisk *disk);
 void wbt_disable_default(struct gendisk *disk);
 void wbt_enable_default(struct gendisk *disk);
-
-u64 wbt_get_min_lat(struct request_queue *q);
-void wbt_set_min_lat(struct request_queue *q, u64 val);
 bool wbt_disabled(struct request_queue *);
-
-u64 wbt_default_latency_nsec(struct request_queue *);
+u64 wbt_get_min_lat(struct request_queue *q);
+int wbt_set_lat(struct gendisk *disk, s64 val);
 
 #else
 
-- 
2.51.0

