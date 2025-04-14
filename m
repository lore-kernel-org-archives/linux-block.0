Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ADE25392A
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 13:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637846; cv=none; b=a8cuYABLobQZPfsX6coU9z89avKD3BxkJ6kbw+AAYk4xCYqLsvgoZ1zzmwivlbA60r1pPZYS9n97+F04RRVeRxG/R/3abkH1PvHhPnqqTPyws8fbZ2d3OZCTvlj0wDfaCnAhK6wzOZ/nNfxSEv6XFy/RLWYkbf0CfgjMIhHMIcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637846; c=relaxed/simple;
	bh=8BqsgyJ7gZkqz+bmoZDTV8piKYk3wMri8io8ImKw86w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XJB3Sze+2fe+iRS8iF7JGW+rGKxHvuXBbPisK/m6hNbHYErjr03RPed7lQRPJyrG3Q5lx6PJfa62BxQkl88b6pmH0tEAP11X1w7imIdDmNmNO0UJ1bG1yrC/P5JOlq3ndJFh1pDx8XuaV6Ut5LGM44vPcGuih3fo+sHT58XWGp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZbpCm0zBNzHrPv;
	Mon, 14 Apr 2025 21:33:56 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id CD95E140144;
	Mon, 14 Apr 2025 21:37:21 +0800 (CST)
Received: from localhost.localdomain (10.175.112.188) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 14 Apr 2025 21:37:21 +0800
From: Zizhi Wo <wozizhi@huawei.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC: <yangerkun@huawei.com>, <yukuai3@huawei.com>, <wozizhi@huawei.com>,
	<ming.lei@redhat.com>, <tj@kernel.org>
Subject: [PATCH 5/7] blk-throttle: Split the blkthrotl queue
Date: Mon, 14 Apr 2025 21:27:29 +0800
Message-ID: <20250414132731.167620-6-wozizhi@huawei.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250414132731.167620-1-wozizhi@huawei.com>
References: <20250414132731.167620-1-wozizhi@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf100017.china.huawei.com (7.202.181.16)

This patch splits the single queue into separate bps and iops queues. Now,
an IO request must first pass through the bps queue, then the iops queue,
and finally be dispatched. Due to the queue splitting, we need to modify
the throtl add/peek/pop function.

Additionally, the patch modifies the logic related to tg_dispatch_time().
If bio needs to wait for bps, function directly returns the bps wait time;
otherwise, it charges bps and returns the iops wait time so that bio can be
directly placed into the iops queue afterward. Note that this may lead to
more frequent updates to disptime, but the overhead is negligible for the
slow path.

Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 block/blk-throttle.c | 49 ++++++++++++++++++++++++++++++--------------
 block/blk-throttle.h |  3 ++-
 2 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index caae2e3b7534..542db54f995c 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -143,7 +143,8 @@ static inline unsigned int throtl_bio_data_size(struct bio *bio)
 static void throtl_qnode_init(struct throtl_qnode *qn, struct throtl_grp *tg)
 {
 	INIT_LIST_HEAD(&qn->node);
-	bio_list_init(&qn->bios);
+	bio_list_init(&qn->bios_bps);
+	bio_list_init(&qn->bios_iops);
 	qn->tg = tg;
 }
 
@@ -160,7 +161,11 @@ static void throtl_qnode_init(struct throtl_qnode *qn, struct throtl_grp *tg)
 static void throtl_qnode_add_bio(struct bio *bio, struct throtl_qnode *qn,
 				 struct list_head *queued)
 {
-	bio_list_add(&qn->bios, bio);
+	if (bio_flagged(bio, BIO_TG_BPS_THROTTLED))
+		bio_list_add(&qn->bios_iops, bio);
+	else
+		bio_list_add(&qn->bios_bps, bio);
+
 	if (list_empty(&qn->node)) {
 		list_add_tail(&qn->node, queued);
 		blkg_get(tg_to_blkg(qn->tg));
@@ -170,6 +175,10 @@ static void throtl_qnode_add_bio(struct bio *bio, struct throtl_qnode *qn,
 /**
  * throtl_peek_queued - peek the first bio on a qnode list
  * @queued: the qnode list to peek
+ *
+ * Always take a bio from the head of the iops queue first. If the queue
+ * is empty, we then take it from the bps queue to maintain the overall
+ * idea of fetching bios from the head.
  */
 static struct bio *throtl_peek_queued(struct list_head *queued)
 {
@@ -180,7 +189,9 @@ static struct bio *throtl_peek_queued(struct list_head *queued)
 		return NULL;
 
 	qn = list_first_entry(queued, struct throtl_qnode, node);
-	bio = bio_list_peek(&qn->bios);
+	bio = bio_list_peek(&qn->bios_iops);
+	if (!bio)
+		bio = bio_list_peek(&qn->bios_bps);
 	WARN_ON_ONCE(!bio);
 	return bio;
 }
@@ -190,9 +201,10 @@ static struct bio *throtl_peek_queued(struct list_head *queued)
  * @queued: the qnode list to pop a bio from
  * @tg_to_put: optional out argument for throtl_grp to put
  *
- * Pop the first bio from the qnode list @queued.  After popping, the first
- * qnode is removed from @queued if empty or moved to the end of @queued so
- * that the popping order is round-robin.
+ * Pop the first bio from the qnode list @queued.  Note that we firstly focus
+ * on the iops list here because bios are ultimately dispatched from it.
+ * After popping, the first qnode is removed from @queued if empty or moved to
+ * the end of @queued so that the popping order is round-robin.
  *
  * When the first qnode is removed, its associated throtl_grp should be put
  * too.  If @tg_to_put is NULL, this function automatically puts it;
@@ -209,10 +221,12 @@ static struct bio *throtl_pop_queued(struct list_head *queued,
 		return NULL;
 
 	qn = list_first_entry(queued, struct throtl_qnode, node);
-	bio = bio_list_pop(&qn->bios);
+	bio = bio_list_pop(&qn->bios_iops);
+	if (!bio)
+		bio = bio_list_pop(&qn->bios_bps);
 	WARN_ON_ONCE(!bio);
 
-	if (bio_list_empty(&qn->bios)) {
+	if (bio_list_empty(&qn->bios_bps) && bio_list_empty(&qn->bios_iops)) {
 		list_del_init(&qn->node);
 		if (tg_to_put)
 			*tg_to_put = qn->tg;
@@ -805,12 +819,12 @@ static unsigned long tg_dispatch_iops_time(struct throtl_grp *tg, struct bio *bi
 
 /*
  * Returns approx number of jiffies to wait before this bio is with-in IO rate
- * and can be dispatched.
+ * and can be moved to other queue or dispatched.
  */
 static unsigned long tg_dispatch_time(struct throtl_grp *tg, struct bio *bio)
 {
 	bool rw = bio_data_dir(bio);
-	unsigned long bps_wait, iops_wait;
+	unsigned long wait;
 
 	/*
  	 * Currently whole state machine of group depends on first bio
@@ -821,10 +835,17 @@ static unsigned long tg_dispatch_time(struct throtl_grp *tg, struct bio *bio)
 	BUG_ON(tg->service_queue.nr_queued[rw] &&
 	       bio != throtl_peek_queued(&tg->service_queue.queued[rw]));
 
-	bps_wait = tg_dispatch_bps_time(tg, bio);
-	iops_wait = tg_dispatch_iops_time(tg, bio);
+	wait = tg_dispatch_bps_time(tg, bio);
+	if (wait != 0)
+		return wait;
 
-	return max(bps_wait, iops_wait);
+	/*
+	 * Charge bps here because @bio will be directly placed into the
+	 * iops queue afterward.
+	 */
+	throtl_charge_bps_bio(tg, bio);
+
+	return tg_dispatch_iops_time(tg, bio);
 }
 
 /**
@@ -913,7 +934,6 @@ static void tg_dispatch_one_bio(struct throtl_grp *tg, bool rw)
 	bio = throtl_pop_queued(&sq->queued[rw], &tg_to_put);
 	sq->nr_queued[rw]--;
 
-	throtl_charge_bps_bio(tg, bio);
 	throtl_charge_iops_bio(tg, bio);
 
 	/*
@@ -1641,7 +1661,6 @@ bool __blk_throtl_bio(struct bio *bio)
 	while (true) {
 		if (tg_within_limit(tg, bio, rw)) {
 			/* within limits, let's charge and dispatch directly */
-			throtl_charge_bps_bio(tg, bio);
 			throtl_charge_iops_bio(tg, bio);
 
 			/*
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index 7964cc041e06..5257e5c053e6 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -28,7 +28,8 @@
  */
 struct throtl_qnode {
 	struct list_head	node;		/* service_queue->queued[] */
-	struct bio_list		bios;		/* queued bios */
+	struct bio_list		bios_bps;	/* queued bios for bps limit */
+	struct bio_list		bios_iops;	/* queued bios for iops limit */
 	struct throtl_grp	*tg;		/* tg this qnode belongs to */
 };
 
-- 
2.46.1

