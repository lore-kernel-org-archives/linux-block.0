Received: from sg-1-12.ptr.blmpb.com (sg-1-12.ptr.blmpb.com [118.26.132.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BB2231A23
	for <linux-block@vger.kernel.org>; Sun, 16 Nov 2025 02:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763260926; cv=none; b=DRQY/F1C+VXnqxYK1/3jIDPH4/n5JFHijmXvcmlSmEcSdVXso2HVLnxleO/VyZFZ9sJCAnODb4lbS+ghcHQGjAs+jIKcu1AARYck2pDmVqSp9O4ypjlbtefh88B+gzS+vF1UXAAnNOb0nyAht4dt4gU6bPJdcOd9TbMMnid3//0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763260926; c=relaxed/simple;
	bh=bp2OCGjuLR9VSuQ6uIMPbUSycqO5C4T7uB7lILXZWMs=;
	h=Content-Type:To:Subject:Message-Id:Cc:From:Date:Mime-Version; b=f8DwkKgStLYAcTZ1m0VhHkrf78J8lxKRGMnFaZiMcDVOhI3dLoOctEtrZcfZxAm4FJrs0emZGsZmM3Yi2osBIhxayuyWTPyPtEBkXQHhHHLYgbBXu9qbwRpMD+oS6hovU/hDVaSehAhqrsksxzr3ePwH/p2Q9V17iL/CrsoGyfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=FdK/utRD; arc=none smtp.client-ip=118.26.132.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="FdK/utRD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1763260918;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=4G57tjAMn6RZr+xrcoTIUbR3Zx93nRpRrw23LdyOeR0=;
 b=FdK/utRD01IjQ4E2icqCbNR1Z3pLKN98Mq8kg3V1jGw2DZnfaaM6N7TXlyjY2W7AityXmP
 7QtZJTfbrxRaaQ2HXfXxWampOq2vLqDaIA4ympyOGVzKMSOYhoFyYMGqvtjHm00/uA4fB0
 iCf64zrV5wygByMYC+n6u8JpsMHDErRfqvSF2wxOQZ6oep00l3xFvs5FkEwgwTtqVsS/mS
 ZMnl4bR8FwGFZ/4o4NjRY97eWYeCaaTR/ve/pHfI62SqAUoh2dJJEaDe94i1t4tj1JzJp6
 h0Wy7++rSbV6KvM4AzRzs2F5xeA+ZlYNHSuwGx/N4yx84Ir/XHkoQEQursOzbw==
Content-Type: text/plain; charset=UTF-8
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <tj@kernel.org>, <nilay@linux.ibm.com>, 
	<ming.lei@redhat.com>
Subject: [PATCH 5/5] block/blk-rq-qos: cleanup rq_qos_add()
Message-Id: <20251116024134.115685-6-yukuai@fnnas.com>
X-Lms-Return-Path: <lba+2691939f4+1d33b4+vger.kernel.org+yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
Cc: <yukuai@fnnas.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Received: from localhost.localdomain ([39.182.0.135]) by smtp.feishu.cn with ESMTPS; Sun, 16 Nov 2025 10:41:55 +0800
Content-Transfer-Encoding: 7bit
Date: Sun, 16 Nov 2025 10:41:34 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Yu Kuai <yukuai@fnnas.com>

Now that there is no caller of rq_qos_add(), remove it, and also rename
rq_qos_add_freezed() back to rq_qos_add().

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 block/blk-iocost.c    |  2 +-
 block/blk-iolatency.c |  4 ++--
 block/blk-rq-qos.c    | 42 ++----------------------------------------
 block/blk-rq-qos.h    |  6 ++----
 block/blk-wbt.c       |  2 +-
 5 files changed, 8 insertions(+), 48 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 233c9749bfc9..0948f628386f 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2927,7 +2927,7 @@ static int blk_iocost_init(struct gendisk *disk)
 	 * called before policy activation completion, can't assume that the
 	 * target bio has an iocg associated and need to test for NULL iocg.
 	 */
-	ret = rq_qos_add_freezed(&ioc->rqos, disk, RQ_QOS_COST, &ioc_rqos_ops);
+	ret = rq_qos_add(&ioc->rqos, disk, RQ_QOS_COST, &ioc_rqos_ops);
 	if (ret)
 		goto err_free_ioc;
 
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 1565352b176d..5b18125e21c9 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -764,8 +764,8 @@ static int blk_iolatency_init(struct gendisk *disk)
 	if (!blkiolat)
 		return -ENOMEM;
 
-	ret = rq_qos_add_freezed(&blkiolat->rqos, disk, RQ_QOS_LATENCY,
-				 &blkcg_iolatency_ops);
+	ret = rq_qos_add(&blkiolat->rqos, disk, RQ_QOS_LATENCY,
+			 &blkcg_iolatency_ops);
 	if (ret)
 		goto err_free;
 	ret = blkcg_activate_policy(disk, &blkcg_policy_iolatency);
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 353397d7e126..3a49af00b738 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -322,8 +322,8 @@ void rq_qos_exit(struct request_queue *q)
 	mutex_unlock(&q->rq_qos_mutex);
 }
 
-int rq_qos_add_freezed(struct rq_qos *rqos, struct gendisk *disk,
-		       enum rq_qos_id id, const struct rq_qos_ops *ops)
+int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk,
+	       enum rq_qos_id id, const struct rq_qos_ops *ops)
 {
 	struct request_queue *q = disk->queue;
 
@@ -349,44 +349,6 @@ int rq_qos_add_freezed(struct rq_qos *rqos, struct gendisk *disk,
 	return 0;
 }
 
-int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
-		const struct rq_qos_ops *ops)
-{
-	struct request_queue *q = disk->queue;
-	unsigned int memflags;
-
-	lockdep_assert_held(&q->rq_qos_mutex);
-
-	rqos->disk = disk;
-	rqos->id = id;
-	rqos->ops = ops;
-
-	/*
-	 * No IO can be in-flight when adding rqos, so freeze queue, which
-	 * is fine since we only support rq_qos for blk-mq queue.
-	 */
-	memflags = blk_mq_freeze_queue(q);
-
-	if (rq_qos_id(q, rqos->id))
-		goto ebusy;
-	rqos->next = q->rq_qos;
-	q->rq_qos = rqos;
-	blk_queue_flag_set(QUEUE_FLAG_QOS_ENABLED, q);
-
-	blk_mq_unfreeze_queue(q, memflags);
-
-	if (rqos->ops->debugfs_attrs) {
-		mutex_lock(&q->debugfs_mutex);
-		blk_mq_debugfs_register_rqos(rqos);
-		mutex_unlock(&q->debugfs_mutex);
-	}
-
-	return 0;
-ebusy:
-	blk_mq_unfreeze_queue(q, memflags);
-	return -EBUSY;
-}
-
 void rq_qos_del(struct rq_qos *rqos)
 {
 	struct request_queue *q = rqos->disk->queue;
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 4a7fec01600b..8bbf178c16b0 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -85,10 +85,8 @@ static inline void rq_wait_init(struct rq_wait *rq_wait)
 	init_waitqueue_head(&rq_wait->wait);
 }
 
-int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
-		const struct rq_qos_ops *ops);
-int rq_qos_add_freezed(struct rq_qos *rqos, struct gendisk *disk,
-		       enum rq_qos_id id, const struct rq_qos_ops *ops);
+int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk,
+	       enum rq_qos_id id, const struct rq_qos_ops *ops);
 void rq_qos_del(struct rq_qos *rqos);
 
 typedef bool (acquire_inflight_cb_t)(struct rq_wait *rqw, void *private_data);
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index a784f6d338b4..d7f1e6ba1790 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -926,7 +926,7 @@ int wbt_init(struct gendisk *disk)
 	 * Assign rwb and add the stats callback.
 	 */
 	mutex_lock(&q->rq_qos_mutex);
-	ret = rq_qos_add_freezed(&rwb->rqos, disk, RQ_QOS_WBT, &wbt_rqos_ops);
+	ret = rq_qos_add(&rwb->rqos, disk, RQ_QOS_WBT, &wbt_rqos_ops);
 	mutex_unlock(&q->rq_qos_mutex);
 	if (ret)
 		goto err_free;
-- 
2.51.0
