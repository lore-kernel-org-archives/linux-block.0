Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1062E266C;
	Mon,  2 Feb 2026 08:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770019530; cv=none; b=Oy0FqO6cIBWAtsvWr+yMbwJbNOm/htSvXRZnwGKdtUvbd9HI8ElogK9LR3j8eNh4ED5ETf1S3yQS4Ni3mKn6Q1FXBlnnRofufsxZD5emeM5affzlDS1ZC9uQWQbOrCDRk5zCGcT2s47ebdbr6krw9wzRtwivaLSVSTTaDdVhSho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770019530; c=relaxed/simple;
	bh=gQFordqoJbhdZJvAzqTlCZcPa30IHDKadRzhmeEhy7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxnZYL3v0HatjA91GKr+JkJEYF5SST9iXJrQIx0H7u9g4RjKo967gcDWTJ3tqVFSRNdMo3ItXyzrJtNDxf7lXPzcwlIGKeCMHgh/hlfTVdw1PXB6r9jwyLf8gbGdBetaRJ07FdakkytBh5haCewqlxhbS9TgP3jSPC1Pm8ZaCos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2074FC116C6;
	Mon,  2 Feb 2026 08:05:27 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Hannes Reinecke <hare@suse.de>,
	yukuai@fnnas.com
Subject: [PATCH v9 1/8] blk-wbt: factor out a helper wbt_set_lat()
Date: Mon,  2 Feb 2026 16:05:16 +0800
Message-ID: <20260202080523.3947504-2-yukuai@fnnas.com>
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

To move implementation details inside blk-wbt.c, prepare to fix possible
deadlock to call wbt_init() while queue is frozen in the next patch.

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Yu Kuai <yukuai@fnnas.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-sysfs.c | 39 ++----------------------------------
 block/blk-wbt.c   | 50 ++++++++++++++++++++++++++++++++++++++++++++---
 block/blk-wbt.h   |  7 ++-----
 3 files changed, 51 insertions(+), 45 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index e0a70d26972b..a580688c3ad5 100644
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
index 8e025834f2fb..0a37d97bda75 100644
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
@@ -741,7 +743,7 @@ void wbt_init_enable_default(struct gendisk *disk)
 		WARN_ON_ONCE(wbt_init(disk));
 }
 
-u64 wbt_default_latency_nsec(struct request_queue *q)
+static u64 wbt_default_latency_nsec(struct request_queue *q)
 {
 	/*
 	 * We default to 2msec for non-rotational storage, and 75msec
@@ -901,7 +903,7 @@ static const struct rq_qos_ops wbt_rqos_ops = {
 #endif
 };
 
-int wbt_init(struct gendisk *disk)
+static int wbt_init(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
 	struct rq_wb *rwb;
@@ -948,3 +950,45 @@ int wbt_init(struct gendisk *disk)
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
index 925f22475738..6e39da17218b 100644
--- a/block/blk-wbt.h
+++ b/block/blk-wbt.h
@@ -4,16 +4,13 @@
 
 #ifdef CONFIG_BLK_WBT
 
-int wbt_init(struct gendisk *disk);
 void wbt_init_enable_default(struct gendisk *disk);
 void wbt_disable_default(struct gendisk *disk);
 void wbt_enable_default(struct gendisk *disk);
 
 u64 wbt_get_min_lat(struct request_queue *q);
-void wbt_set_min_lat(struct request_queue *q, u64 val);
-bool wbt_disabled(struct request_queue *);
-
-u64 wbt_default_latency_nsec(struct request_queue *);
+bool wbt_disabled(struct request_queue *q);
+int wbt_set_lat(struct gendisk *disk, s64 val);
 
 #else
 
-- 
2.51.0

