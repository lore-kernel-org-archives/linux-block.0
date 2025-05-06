Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C152FF2B4
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 02:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746498043; cv=none; b=cJxoHzPrYLbqqiTPZUfAvux0K/FnEdc/jlZ9bA3daRCkzNKeeHHLpoU7gCQsZHieGSAZc9AnHLy9vBgOGayZ/+2pXkaBXWKU7SdL9MndfhEDNGqQIwSeePIP3Ci9Y7g+fiByVI0WcxBiHq7SgG5dg57XvrKf8E6TQrkKLG0gGr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746498043; c=relaxed/simple;
	bh=+ykYjiOJa9pS7RXzHKek2OiLLuEEoOrvpjAm0Xy6wjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVCiFZLfxIC22M5WmWxlDYv5rpi4i5aBTdU06Td7Lhsn0Au56jJCralGuS4Z5W+uJVmRUfmgOJuDE01kCdpuLn8Jg8oj/ky/23VzxwKVypXTOrvlqkIyQR2CD5cmw/RxY0cQsvlEIz7CV/Pi2KmfX/nbwxPYfyN3fOaCrWzijhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zs2DC0FPyz4f3lDK
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 10:20:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id F37D71A0D63
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 10:20:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgBXvGDxcRloS3NDLg--.28694S5;
	Tue, 06 May 2025 10:20:36 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: yangerkun@huawei.com,
	yukuai3@huawei.com,
	wozizhi@huaweicloud.com,
	ming.lei@redhat.com,
	tj@kernel.org
Subject: [PATCH V5 1/7] blk-throttle: Rename tg_may_dispatch() to tg_dispatch_time()
Date: Tue,  6 May 2025 10:09:28 +0800
Message-ID: <20250506020935.655574-2-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250506020935.655574-1-wozizhi@huaweicloud.com>
References: <20250506020935.655574-1-wozizhi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXvGDxcRloS3NDLg--.28694S5
X-Coremail-Antispam: 1UD129KBjvJXoWxGr4rKFy5tw1xJF45JF4xJFb_yoWrCr4UpF
	W7CF45Wa1kJFsFkr43ZFnrCFy5tws7X3srGrZ3G3ySya1jvr9xKFn5ZryFyFWxZF93WFsI
	vrWvy347G3WjyrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r126r1DMx
	AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
	Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwI
	xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWx
	JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
	C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjX18JUUUUU==
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

tg_may_dispatch() can directly indicate whether bio can be dispatched by
returning the time to wait, without the need for the redundant "wait"
parameter. Remove it and modify the function's return type accordingly.

Since we have determined by the return time whether bio can be dispatched,
rename tg_may_dispatch() to tg_dispatch_time().

Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Zizhi Wo <wozizhi@huaweicloud.com>
---
 block/blk-throttle.c | 40 +++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 5263609ebd95..55596eb9aa08 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -794,14 +794,13 @@ static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
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
 
@@ -816,11 +815,8 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
 
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
@@ -840,21 +836,15 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
 
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
@@ -905,16 +895,16 @@ static void throtl_add_bio_tg(struct bio *bio, struct throtl_qnode *qn,
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
@@ -992,7 +982,7 @@ static int throtl_dispatch_tg(struct throtl_grp *tg)
 	/* Try to dispatch 75% READS and 25% WRITES */
 
 	while ((bio = throtl_peek_queued(&sq->queued[READ])) &&
-	       tg_may_dispatch(tg, bio, NULL)) {
+	       tg_dispatch_time(tg, bio) == 0) {
 
 		tg_dispatch_one_bio(tg, READ);
 		nr_reads++;
@@ -1002,7 +992,7 @@ static int throtl_dispatch_tg(struct throtl_grp *tg)
 	}
 
 	while ((bio = throtl_peek_queued(&sq->queued[WRITE])) &&
-	       tg_may_dispatch(tg, bio, NULL)) {
+	       tg_dispatch_time(tg, bio) == 0) {
 
 		tg_dispatch_one_bio(tg, WRITE);
 		nr_writes++;
@@ -1661,7 +1651,7 @@ static bool tg_within_limit(struct throtl_grp *tg, struct bio *bio, bool rw)
 	if (tg->service_queue.nr_queued[rw])
 		return false;
 
-	return tg_may_dispatch(tg, bio, NULL);
+	return tg_dispatch_time(tg, bio) == 0;
 }
 
 bool __blk_throtl_bio(struct bio *bio)
-- 
2.46.1

