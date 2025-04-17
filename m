Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D115C22AE74
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 11:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744888121; cv=none; b=C2vDt13wXakaI9WZwyRzHt4PEwc4GHgBD3tJ+XSeaxJj1jHhqyERAu01tzywKH0VmDXFOry/Yg39braIjlgEdnlBgXVrk+b0gs6iQsvUoYmwD4JYWZxdsCcGYaDga4dCzcGDbPYfjf/42dXcAFdCbO87RXv9u5tmnW0FVDkiAfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744888121; c=relaxed/simple;
	bh=C7h4JePUzyuPmQOS4n7fYcAG45/rSbNIWBwh81LbkfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HT14sOZXuMLBasSsvXJA3NHlowhO40h7n6Q4qr2EnT284IK2vOQssM/owLbEXr1TqANnic+8IEq8xWxkJZfirugjXdQYc/Ks89FO52hwKhgYAHO2osT8iIV4Jv6HJh+ASqqCT8MHK+WIvGttwgQTbsvvHg9ZUuMP+QKY3i/5LkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZdZrD1BD6z4f3jtT
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 19:08:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 87E451A058E
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 19:08:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgC3Gl8s4QBoyDT8Jg--.2150S5;
	Thu, 17 Apr 2025 19:08:30 +0800 (CST)
From: Zizhi Wo <wozizhi@huawei.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: yangerkun@huawei.com,
	yukuai3@huawei.com,
	wozizhi@huaweicloud.com,
	ming.lei@redhat.com,
	tj@kernel.org
Subject: [PATCH V2 1/7] blk-throttle: Rename tg_may_dispatch() to tg_dispatch_time()
Date: Thu, 17 Apr 2025 18:58:27 +0800
Message-ID: <20250417105833.1930283-2-wozizhi@huawei.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250417105833.1930283-1-wozizhi@huawei.com>
References: <20250417105833.1930283-1-wozizhi@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC3Gl8s4QBoyDT8Jg--.2150S5
X-Coremail-Antispam: 1UD129KBjvJXoWxGr4rKFy5tw17KFW8Cry5CFg_yoWrArW8pF
	W2kF45Wa18JFsFkr43ZFnrCFyrtws7X3srGrZ3G3ySya1jvr98tFn5ZryFyFWxAF93WFsI
	vrWvy3srG3WjyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmCb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7Iv64x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262
	kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF04k20xvEw4C26cxK6c8Ij28IcwCFx2Iq
	xVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
	106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
	xVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7
	xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_
	Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jb5rcUUUUU=
Sender: wozizhi@huaweicloud.com
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

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

