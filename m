Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559162FF2AA
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 02:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746498042; cv=none; b=CvoqdjsTWyqd3eN33DcvFoO6dp4doX3I69sBRLmQo7keU5uLBGFo0EzUzkVSsAVcBPEkcjL37g+MlBSRJ7SqU84zUBBEpK/vwcGu9gGP8TO2LA4ahyluup0XYinYfuQihoPb1OPvJL02Yn70z+dSULFt8U8H9zusjUPUvgms8Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746498042; c=relaxed/simple;
	bh=Wuua4fGDSWTD3IIOu0XSzWS5P6YCeUnX1G5eXp3F2bM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lk2LLAsMz0eOJcmm0N53rz2+Rqyr3mneHjgDQmXSwJZ/Jdps9FV1ExARe8tX23+3BhTsYysnywkUfW150i/3VeSTnknz3ys615u+iCl8b39fOTj+DhZgYjav9cEPsmSqrQdMiOAHSK3XOyiAqcoZofrAKeNIeDCDXLlogvr9JNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zs2DL0nMDz4f3jq5
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 10:20:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 517F01A13DF
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 10:20:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgBXvGDxcRloS3NDLg--.28694S6;
	Tue, 06 May 2025 10:20:37 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: yangerkun@huawei.com,
	yukuai3@huawei.com,
	wozizhi@huaweicloud.com,
	ming.lei@redhat.com,
	tj@kernel.org
Subject: [PATCH V5 2/7] blk-throttle: Refactor tg_dispatch_time by extracting tg_dispatch_bps/iops_time
Date: Tue,  6 May 2025 10:09:29 +0800
Message-ID: <20250506020935.655574-3-wozizhi@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgBXvGDxcRloS3NDLg--.28694S6
X-Coremail-Antispam: 1UD129KBjvJXoW3WF4fKFWDGr4kAFykuF15Jwb_yoW7tFyfpr
	W3Ca1jqF4rXFn7KFW3Z3s8GayYkws7Ar9rJa9rGr9rAF4YvFyDKF1kZryYvFW5AF929a17
	Aryqv347Ca1qyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r126r1DMx
	AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
	Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwI
	xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWx
	JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
	C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUUApnJUUUUU==
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

tg_dispatch_time() contained both bps and iops throttling logic. We now
split its internal logic into tg_dispatch_bps/iops_time() to improve code
consistency for future separation of the bps and iops queues.

Besides, merge time_before() from caller into throtl_extend_slice() to make
code cleaner.

Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Zizhi Wo <wozizhi@huaweicloud.com>
---
 block/blk-throttle.c | 98 +++++++++++++++++++++++++-------------------
 1 file changed, 55 insertions(+), 43 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 55596eb9aa08..24bc1a850581 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -520,6 +520,9 @@ static inline void throtl_set_slice_end(struct throtl_grp *tg, bool rw,
 static inline void throtl_extend_slice(struct throtl_grp *tg, bool rw,
 				       unsigned long jiffy_end)
 {
+	if (!time_before(tg->slice_end[rw], jiffy_end))
+		return;
+
 	throtl_set_slice_end(tg, rw, jiffy_end);
 	throtl_log(&tg->service_queue,
 		   "[%c] extend slice start=%lu end=%lu jiffies=%lu",
@@ -731,10 +734,6 @@ static unsigned long tg_within_iops_limit(struct throtl_grp *tg, struct bio *bio
 	int io_allowed;
 	unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
 
-	if (iops_limit == UINT_MAX) {
-		return 0;
-	}
-
 	jiffy_elapsed = jiffies - tg->slice_start[rw];
 
 	/* Round up to the next throttle slice, wait time must be nonzero */
@@ -760,11 +759,6 @@ static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
 	unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
 	unsigned int bio_size = throtl_bio_data_size(bio);
 
-	/* no need to throttle if this bio's bytes have been accounted */
-	if (bps_limit == U64_MAX || bio_flagged(bio, BIO_BPS_THROTTLED)) {
-		return 0;
-	}
-
 	jiffy_elapsed = jiffy_elapsed_rnd = jiffies - tg->slice_start[rw];
 
 	/* Slice has just started. Consider one slice interval */
@@ -793,6 +787,54 @@ static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
 	return jiffy_wait;
 }
 
+/*
+ * If previous slice expired, start a new one otherwise renew/extend existing
+ * slice to make sure it is at least throtl_slice interval long since now. New
+ * slice is started only for empty throttle group. If there is queued bio, that
+ * means there should be an active slice and it should be extended instead.
+ */
+static void tg_update_slice(struct throtl_grp *tg, bool rw)
+{
+	if (throtl_slice_used(tg, rw) && !(tg->service_queue.nr_queued[rw]))
+		throtl_start_new_slice(tg, rw, true);
+	else
+		throtl_extend_slice(tg, rw, jiffies + tg->td->throtl_slice);
+}
+
+static unsigned long tg_dispatch_bps_time(struct throtl_grp *tg, struct bio *bio)
+{
+	bool rw = bio_data_dir(bio);
+	u64 bps_limit = tg_bps_limit(tg, rw);
+	unsigned long bps_wait;
+
+	/* no need to throttle if this bio's bytes have been accounted */
+	if (bps_limit == U64_MAX || tg->flags & THROTL_TG_CANCELING ||
+	    bio_flagged(bio, BIO_BPS_THROTTLED))
+		return 0;
+
+	tg_update_slice(tg, rw);
+	bps_wait = tg_within_bps_limit(tg, bio, bps_limit);
+	throtl_extend_slice(tg, rw, jiffies + bps_wait);
+
+	return bps_wait;
+}
+
+static unsigned long tg_dispatch_iops_time(struct throtl_grp *tg, struct bio *bio)
+{
+	bool rw = bio_data_dir(bio);
+	u32 iops_limit = tg_iops_limit(tg, rw);
+	unsigned long iops_wait;
+
+	if (iops_limit == UINT_MAX || tg->flags & THROTL_TG_CANCELING)
+		return 0;
+
+	tg_update_slice(tg, rw);
+	iops_wait = tg_within_iops_limit(tg, bio, iops_limit);
+	throtl_extend_slice(tg, rw, jiffies + iops_wait);
+
+	return iops_wait;
+}
+
 /*
  * Returns approx number of jiffies to wait before this bio is with-in IO rate
  * and can be dispatched.
@@ -800,9 +842,7 @@ static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
 static unsigned long tg_dispatch_time(struct throtl_grp *tg, struct bio *bio)
 {
 	bool rw = bio_data_dir(bio);
-	unsigned long bps_wait, iops_wait, max_wait;
-	u64 bps_limit = tg_bps_limit(tg, rw);
-	u32 iops_limit = tg_iops_limit(tg, rw);
+	unsigned long bps_wait, iops_wait;
 
 	/*
  	 * Currently whole state machine of group depends on first bio
@@ -813,38 +853,10 @@ static unsigned long tg_dispatch_time(struct throtl_grp *tg, struct bio *bio)
 	BUG_ON(tg->service_queue.nr_queued[rw] &&
 	       bio != throtl_peek_queued(&tg->service_queue.queued[rw]));
 
-	/* If tg->bps = -1, then BW is unlimited */
-	if ((bps_limit == U64_MAX && iops_limit == UINT_MAX) ||
-	    tg->flags & THROTL_TG_CANCELING)
-		return 0;
-
-	/*
-	 * If previous slice expired, start a new one otherwise renew/extend
-	 * existing slice to make sure it is at least throtl_slice interval
-	 * long since now. New slice is started only for empty throttle group.
-	 * If there is queued bio, that means there should be an active
-	 * slice and it should be extended instead.
-	 */
-	if (throtl_slice_used(tg, rw) && !(tg->service_queue.nr_queued[rw]))
-		throtl_start_new_slice(tg, rw, true);
-	else {
-		if (time_before(tg->slice_end[rw],
-		    jiffies + tg->td->throtl_slice))
-			throtl_extend_slice(tg, rw,
-				jiffies + tg->td->throtl_slice);
-	}
-
-	bps_wait = tg_within_bps_limit(tg, bio, bps_limit);
-	iops_wait = tg_within_iops_limit(tg, bio, iops_limit);
-	if (bps_wait + iops_wait == 0)
-		return 0;
-
-	max_wait = max(bps_wait, iops_wait);
-
-	if (time_before(tg->slice_end[rw], jiffies + max_wait))
-		throtl_extend_slice(tg, rw, jiffies + max_wait);
+	bps_wait = tg_dispatch_bps_time(tg, bio);
+	iops_wait = tg_dispatch_iops_time(tg, bio);
 
-	return max_wait;
+	return max(bps_wait, iops_wait);
 }
 
 static void throtl_charge_bio(struct throtl_grp *tg, struct bio *bio)
-- 
2.46.1

