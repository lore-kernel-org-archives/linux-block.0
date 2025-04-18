Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEED1CD15
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 04:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744949969; cv=none; b=OSzqY4rZkF7LBE5qbtJ0OLq9kkPikZHq97NncD3/RXa0ZolCRlny1jIkbuXdr2DQEtRJCjqgjNF9HYZHi8rISamos94IYhc55QkpQISTzGcNIgSm9Cc01u9KlawZBvBEJk1eektrXf0E7ptPhMSOEvhmdhPjIaKxMr2sxOQkl+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744949969; c=relaxed/simple;
	bh=ecfmD5osU8LBQCgsaoFAQ1a+pSzllWphldPYIz0xTIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mhxdF6HBjLFavdlbvwdaPexjMMKGpCAkCKJs8VGXkllNRHT4oiNyaJJ9J22+Bxz3FxIEp9Ckq2qunPHsgVlkIQKjXIyT0KC9anhnNYaEbWoMBXXnQ1BfLkDqtgJeio1VG5yjjoyRxNjv3y+2BynSSZS84zU04u+AW43Pb3cRWbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Zf1jc0w1Mz4f3kF9
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 12:19:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DCEF01A06D7
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 12:19:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgBXul7K0gFoPDtDJw--.14109S5;
	Fri, 18 Apr 2025 12:19:23 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: yangerkun@huawei.com,
	yukuai3@huawei.com,
	wozizhi@huaweicloud.com,
	ming.lei@redhat.com,
	tj@kernel.org
Subject: [PATCH V3 1/7] blk-throttle: Rename tg_may_dispatch() to tg_dispatch_time()
Date: Fri, 18 Apr 2025 12:09:18 +0800
Message-ID: <20250418040924.486324-2-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250418040924.486324-1-wozizhi@huaweicloud.com>
References: <20250418040924.486324-1-wozizhi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXul7K0gFoPDtDJw--.14109S5
X-Coremail-Antispam: 1UD129KBjvJXoWxGr4rKFy5tw17KFW8Cry5CFg_yoWrAFyrpF
	W2kF45Wa18XFsFkr43ZFnrCFyrtws7X3srGrZ3GaySya1jvr98tFn5ZryFyFWxAF93WrsI
	vrWvy3srG3WjyrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBG14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWUtw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU9zV8UUUUU=
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

tg_may_dispatch() can directly indicate whether bio can be dispatched by
returning the time to wait, without the need for the redundant "wait"
parameter. Remove it and modify the function's return type accordingly.

Since we have determined by the return time whether bio can be dispatched,
rename tg_may_dispatch() to tg_dispatch_time().

Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
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

