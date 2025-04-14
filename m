Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA655129A78
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 13:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637846; cv=none; b=t0hCIlwTqHTUP/NFJJEuft09IzeGr4V0E93gY35IS2bEd2HQxahOPtD5Y3CpeR41KDRpdWze1y6gzx/eODZXfKEnGhey9goSiFLGMXz4g5H8Ad1XfAkLQDwNC/wlv450eEDBo/RjmyhdaGChWtYOeb9U7R954JjUhd4ziRRpKyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637846; c=relaxed/simple;
	bh=XKN1pJtUR6eFHYcKN4IiOh5n/NUy1AWx3wv8gj0T6xM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i4e8WJ4ggQKwYSjXpz+6VvMv1LY7SBvjNJExVBDgTpbdPfskhhbgSC+FWCAZu8xeQBDHzh46X2FNoa+370TVyx3CyXpNnLpPAVvtREZ48wvMFvgdt8qqW5tF9g+TzHIA2Bgvf7kU7zvGr+LObYbBFTmNQSf5tXGkLN7IcleZvAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4ZbpJS5XmJz27hSJ;
	Mon, 14 Apr 2025 21:38:00 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 4871A1400D4;
	Mon, 14 Apr 2025 21:37:19 +0800 (CST)
Received: from localhost.localdomain (10.175.112.188) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 14 Apr 2025 21:37:18 +0800
From: Zizhi Wo <wozizhi@huawei.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC: <yangerkun@huawei.com>, <yukuai3@huawei.com>, <wozizhi@huawei.com>,
	<ming.lei@redhat.com>, <tj@kernel.org>
Subject: [PATCH 1/7] blk-throttle: Rename tg_may_dispatch() to tg_dispatch_time()
Date: Mon, 14 Apr 2025 21:27:25 +0800
Message-ID: <20250414132731.167620-2-wozizhi@huawei.com>
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

tg_may_dispatch() can directly indicate whether bio can be dispatched by
returning the time to wait, without the need for the redundant "wait"
parameter. Remove it and modify the function's return type accordingly.

Since we have determined by the return time whether bio can be dispatched,
rename tg_may_dispatch() to tg_dispatch_time().

Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 block/blk-throttle.c | 40 +++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 91dab43c65ab..dc23c961c028 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -743,14 +743,13 @@ static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
 }
 
 /*
- * Returns whether one can dispatch a bio or not. Also returns approx number
- * of jiffies to wait before this bio is with-in IO rate and can be dispatched
+ * Returns approx number of jiffies to wait before this bio is with-in IO rate
+ * and can be dispatched.
  */
-static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
-			    unsigned long *wait)
+static unsigned long tg_dispatch_time(struct throtl_grp *tg, struct bio *bio)
 {
 	bool rw = bio_data_dir(bio);
-	unsigned long bps_wait = 0, iops_wait = 0, max_wait = 0;
+	unsigned long bps_wait, iops_wait, max_wait;
 	u64 bps_limit = tg_bps_limit(tg, rw);
 	u32 iops_limit = tg_iops_limit(tg, rw);
 
@@ -765,11 +764,8 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
 
 	/* If tg->bps = -1, then BW is unlimited */
 	if ((bps_limit == U64_MAX && iops_limit == UINT_MAX) ||
-	    tg->flags & THROTL_TG_CANCELING) {
-		if (wait)
-			*wait = 0;
-		return true;
-	}
+	    tg->flags & THROTL_TG_CANCELING)
+		return 0;
 
 	/*
 	 * If previous slice expired, start a new one otherwise renew/extend
@@ -789,21 +785,15 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
 
 	bps_wait = tg_within_bps_limit(tg, bio, bps_limit);
 	iops_wait = tg_within_iops_limit(tg, bio, iops_limit);
-	if (bps_wait + iops_wait == 0) {
-		if (wait)
-			*wait = 0;
-		return true;
-	}
+	if (bps_wait + iops_wait == 0)
+		return 0;
 
 	max_wait = max(bps_wait, iops_wait);
 
-	if (wait)
-		*wait = max_wait;
-
 	if (time_before(tg->slice_end[rw], jiffies + max_wait))
 		throtl_extend_slice(tg, rw, jiffies + max_wait);
 
-	return false;
+	return max_wait;
 }
 
 static void throtl_charge_bio(struct throtl_grp *tg, struct bio *bio)
@@ -854,16 +844,16 @@ static void throtl_add_bio_tg(struct bio *bio, struct throtl_qnode *qn,
 static void tg_update_disptime(struct throtl_grp *tg)
 {
 	struct throtl_service_queue *sq = &tg->service_queue;
-	unsigned long read_wait = -1, write_wait = -1, min_wait = -1, disptime;
+	unsigned long read_wait = -1, write_wait = -1, min_wait, disptime;
 	struct bio *bio;
 
 	bio = throtl_peek_queued(&sq->queued[READ]);
 	if (bio)
-		tg_may_dispatch(tg, bio, &read_wait);
+		read_wait = tg_dispatch_time(tg, bio);
 
 	bio = throtl_peek_queued(&sq->queued[WRITE]);
 	if (bio)
-		tg_may_dispatch(tg, bio, &write_wait);
+		write_wait = tg_dispatch_time(tg, bio);
 
 	min_wait = min(read_wait, write_wait);
 	disptime = jiffies + min_wait;
@@ -941,7 +931,7 @@ static int throtl_dispatch_tg(struct throtl_grp *tg)
 	/* Try to dispatch 75% READS and 25% WRITES */
 
 	while ((bio = throtl_peek_queued(&sq->queued[READ])) &&
-	       tg_may_dispatch(tg, bio, NULL)) {
+	       tg_dispatch_time(tg, bio) == 0) {
 
 		tg_dispatch_one_bio(tg, READ);
 		nr_reads++;
@@ -951,7 +941,7 @@ static int throtl_dispatch_tg(struct throtl_grp *tg)
 	}
 
 	while ((bio = throtl_peek_queued(&sq->queued[WRITE])) &&
-	       tg_may_dispatch(tg, bio, NULL)) {
+	       tg_dispatch_time(tg, bio) == 0) {
 
 		tg_dispatch_one_bio(tg, WRITE);
 		nr_writes++;
@@ -1610,7 +1600,7 @@ static bool tg_within_limit(struct throtl_grp *tg, struct bio *bio, bool rw)
 	if (tg->service_queue.nr_queued[rw])
 		return false;
 
-	return tg_may_dispatch(tg, bio, NULL);
+	return tg_dispatch_time(tg, bio) == 0;
 }
 
 bool __blk_throtl_bio(struct bio *bio)
-- 
2.46.1

