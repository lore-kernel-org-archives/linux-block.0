Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A4D2609FD;
	Thu, 14 Aug 2025 03:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755142997; cv=none; b=bKRsjxJwoMgBGQVHV4LRpe6O7vMR79G0d4FBbjYL+HhSHdBUReSXejvZFtCoXfvsmtX3JGr8S9NqzuQAOQKItJiJX09E38PIimCANNaw7UXiEUvyKc7922i+DrdNHTBigfXdUs8xphQ7uaSAtc0SBSrgHSARJIGUnXaMca0Tljw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755142997; c=relaxed/simple;
	bh=5Z3kjnyI5tTIJkojp9LQTJHdQ/0EqGDz+asxv2zVa90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CxTdkC6rUy6JhMBEKvSm0fQcGXQGZYouYgeUMLm7SOHcXKfF4FKUMnn372B5OkkChqkEX2UOgLFoSgTqDBAlyld+Aqyfxeppf1AvlfKpPMD+eN0M2hZvvx3RzIi8hFVEsiyMdDEzMYGLhrCKSxIFBf0UlvHvTR+37oAZH4CK/o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c2WKt2qH8zKHLwq;
	Thu, 14 Aug 2025 11:43:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A997C1A01A3;
	Thu, 14 Aug 2025 11:43:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCnIxRKW51ogs93Dg--.15627S15;
	Thu, 14 Aug 2025 11:43:13 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	yukuai3@huawei.com,
	bvanassche@acm.org,
	nilay@linux.ibm.com,
	hare@suse.de,
	ming.lei@redhat.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH 11/16] blk-mq: add a new queue sysfs attribute async_depth
Date: Thu, 14 Aug 2025 11:35:17 +0800
Message-Id: <20250814033522.770575-12-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250814033522.770575-1-yukuai1@huaweicloud.com>
References: <20250814033522.770575-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnIxRKW51ogs93Dg--.15627S15
X-Coremail-Antispam: 1UD129KBjvJXoW3JFy5KFWrCF4DKw4UCF1rWFg_yoW7Zr43pr
	45Ja1Ykw10qF4xW34ftw13Xw43J3sagr1xJF4ay34akry7trs7XF1rCFyUXFZ2yrZ5CFsr
	Wr4DJFZ8uFy2q3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0JUQFxUUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Add a new field async_depth to request_queue and related APIs, this is
currently not used, following patches will convert elevators to use
this instead of internal async_depth.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-core.c       |  1 +
 block/blk-mq.c         | 24 ++++++++++++++++++---
 block/blk-sysfs.c      | 47 ++++++++++++++++++++++++++++++++++++++++++
 block/elevator.c       |  1 +
 include/linux/blkdev.h |  1 +
 5 files changed, 71 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index fdac48aec5ef..443056be1c4c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -463,6 +463,7 @@ struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id)
 	fs_reclaim_release(GFP_KERNEL);
 
 	q->nr_requests = BLKDEV_DEFAULT_RQ;
+	q->async_depth = BLKDEV_DEFAULT_RQ;
 
 	return q;
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index f1c11f591c27..699f7a2a36e5 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -520,6 +520,8 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 			data->rq_flags |= RQF_USE_SCHED;
 			if (ops->limit_depth)
 				ops->limit_depth(data->cmd_flags, data);
+			else if (!blk_mq_sched_sync_request(data->cmd_flags))
+				data->shallow_depth = q->async_depth;
 		}
 	} else {
 		blk_mq_tag_busy(data->hctx);
@@ -4606,6 +4608,7 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	spin_lock_init(&q->requeue_lock);
 
 	q->nr_requests = set->queue_depth;
+	q->async_depth = set->queue_depth;
 
 	blk_mq_init_cpu_queues(q, set->nr_hw_queues);
 	blk_mq_map_swqueue(q);
@@ -4934,6 +4937,23 @@ static int blk_mq_sched_grow_tags(struct request_queue *q, unsigned int nr)
 	return 0;
 }
 
+static void __blk_mq_update_nr_requests(struct request_queue *q,
+					unsigned int nr)
+{
+	unsigned int old_nr = q->nr_requests;
+
+	q->nr_requests = nr;
+	if (!q->elevator) {
+		q->async_depth = nr;
+		return;
+	}
+
+	/* keep the percentage of async requests */
+	q->async_depth = max(q->async_depth * nr / old_nr, 1);
+	if (q->elevator->type->ops.depth_updated)
+		q->elevator->type->ops.depth_updated(q);
+}
+
 int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 {
 	struct blk_mq_tag_set *set = q->tag_set;
@@ -4962,9 +4982,7 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 			goto out;
 	}
 
-	q->nr_requests = nr;
-	if (q->elevator && q->elevator->type->ops.depth_updated)
-		q->elevator->type->ops.depth_updated(q);
+	__blk_mq_update_nr_requests(q, nr);
 
 out:
 	blk_mq_unquiesce_queue(q);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index f3d08edcc34f..8f55730f06c6 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -99,6 +99,51 @@ queue_requests_store(struct gendisk *disk, const char *page, size_t count)
 	return ret;
 }
 
+static ssize_t queue_async_depth_show(struct gendisk *disk, char *page)
+{
+	ssize_t ret;
+
+	mutex_lock(&disk->queue->elevator_lock);
+	ret = queue_var_show(disk->queue->async_depth, page);
+	mutex_unlock(&disk->queue->elevator_lock);
+	return ret;
+}
+
+static ssize_t
+queue_async_depth_store(struct gendisk *disk, const char *page, size_t count)
+{
+	struct request_queue *q = disk->queue;
+	unsigned int memflags;
+	unsigned long nr;
+	int ret;
+
+	if (!queue_is_mq(q))
+		return -EINVAL;
+
+	ret = queue_var_store(&nr, page, count);
+	if (ret < 0)
+		return ret;
+
+	if (nr == 0)
+		return -EINVAL;
+
+	memflags = blk_mq_freeze_queue(q);
+	mutex_lock(&q->elevator_lock);
+
+	if (q->elevator) {
+		q->async_depth = min(q->nr_requests, nr);
+		if (q->elevator->type->ops.depth_updated)
+			q->elevator->type->ops.depth_updated(q);
+	} else {
+		ret = -EINVAL;
+	}
+
+	mutex_unlock(&q->elevator_lock);
+	blk_mq_unfreeze_queue(q, memflags);
+
+	return ret;
+}
+
 static ssize_t queue_ra_show(struct gendisk *disk, char *page)
 {
 	ssize_t ret;
@@ -514,6 +559,7 @@ static struct queue_sysfs_entry _prefix##_entry = {	\
 }
 
 QUEUE_RW_ENTRY(queue_requests, "nr_requests");
+QUEUE_RW_ENTRY(queue_async_depth, "async_depth");
 QUEUE_RW_ENTRY(queue_ra, "read_ahead_kb");
 QUEUE_LIM_RW_ENTRY(queue_max_sectors, "max_sectors_kb");
 QUEUE_LIM_RO_ENTRY(queue_max_hw_sectors, "max_hw_sectors_kb");
@@ -736,6 +782,7 @@ static struct attribute *blk_mq_queue_attrs[] = {
 	 */
 	&elv_iosched_entry.attr,
 	&queue_requests_entry.attr,
+	&queue_async_depth_entry.attr,
 #ifdef CONFIG_BLK_WBT
 	&queue_wb_lat_entry.attr,
 #endif
diff --git a/block/elevator.c b/block/elevator.c
index f8a04f32cbcf..6bdb05d2500d 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -601,6 +601,7 @@ static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
 		blk_queue_flag_clear(QUEUE_FLAG_SQ_SCHED, q);
 		q->elevator = NULL;
 		q->nr_requests = q->tag_set->queue_depth;
+		q->async_depth = q->tag_set->queue_depth;
 	}
 	blk_add_trace_msg(q, "elv switch: %s", ctx->name);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ad5087d5cade..2e33298fcc15 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -542,6 +542,7 @@ struct request_queue {
 	 * queue settings
 	 */
 	unsigned int		nr_requests;	/* Max # of requests */
+	unsigned int		async_depth;	/* Max # of async requests */
 
 #ifdef CONFIG_BLK_INLINE_ENCRYPTION
 	struct blk_crypto_profile *crypto_profile;
-- 
2.39.2

