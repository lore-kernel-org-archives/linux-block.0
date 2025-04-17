Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681B82356CA
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 11:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744888122; cv=none; b=fSY6mGbOIMSTF96mPEOkcmgR2sY+7ITI7EG7t32dFpGk+JUBEx6iLEBhesZPQXXa3Rm3R2PYYtvgCfB9+McTINX0HFWNt8dRwgMizOpB41OXFsqgikOhYmDwL1d2OdWay9m5/nVYbjbPI53hbUirN3ORrjPOAtLMz8HG+9kwSb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744888122; c=relaxed/simple;
	bh=rq2nzB6AGN+njRKRrRXGx+qRmOmuKYg6BXl3Ej5JXxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fqKdeaLgGLnKrhpkcjG9am2VqI3Cv4qUiS5ZwEKWMyhrERCIg2oEufiCFTy6pE5FaWZl40NrDyoUi28xe8v8dB5CqJ+UVzkX7AUVoX8n6+/5wspiQyha4lhrh72htpfYdJ6xRizNz9EY4wqQKkIHSXKjOIZ3AHQYPV/QDl4JzfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZdZr549GPz4f3m7D
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 19:08:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D5B0B1A06D7
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 19:08:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgC3Gl8s4QBoyDT8Jg--.2150S6;
	Thu, 17 Apr 2025 19:08:30 +0800 (CST)
From: Zizhi Wo <wozizhi@huawei.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: yangerkun@huawei.com,
	yukuai3@huawei.com,
	wozizhi@huaweicloud.com,
	ming.lei@redhat.com,
	tj@kernel.org
Subject: [PATCH V2 2/7] blk-throttle: Refactor tg_dispatch_time by extracting tg_dispatch_bps/iops_time
Date: Thu, 17 Apr 2025 18:58:28 +0800
Message-ID: <20250417105833.1930283-3-wozizhi@huawei.com>
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
X-CM-TRANSID:gCh0CgC3Gl8s4QBoyDT8Jg--.2150S6
X-Coremail-Antispam: 1UD129KBjvJXoW3WF4fKFWDGr4kAFykuF15Jwb_yoW7uw1kpr
	W3Ca1jqF48XFn7KFW3Zrn8GayFkws7Ar9rJa9rGryDAF4YvFyDKF1kZryYvFW5AF97ua17
	AFyqv347Ca1qyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmCb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
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
	Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jYXdbUUUUU=
Sender: wozizhi@huaweicloud.com
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

tg_dispatch_time() contained both bps and iops throttling logic. We now
split its internal logic into tg_dispatch_bps/iops_time() to improve code
consistency for future separation of the bps and iops queues.

Besides, merge time_before() from caller into throtl_extend_slice() to make
code cleaner.

Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 98 +++++++++++++++++++++++++-------------------
 1 file changed, 55 insertions(+), 43 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index dc23c961c028..0633ae0cce90 100644
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
@@ -682,10 +685,6 @@ static unsigned long tg_within_iops_limit(struct throtl_grp *tg, struct bio *bio
 	int io_allowed;
 	unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
 
-	if (iops_limit == UINT_MAX) {
-		return 0;
-	}
-
 	jiffy_elapsed = jiffies - tg->slice_start[rw];
 
 	/* Round up to the next throttle slice, wait time must be nonzero */
@@ -711,11 +710,6 @@ static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
 	unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
 	unsigned int bio_size = throtl_bio_data_size(bio);
 
-	/* no need to throttle if this bio's bytes have been accounted */
-	if (bps_limit == U64_MAX || bio_flagged(bio, BIO_BPS_THROTTLED)) {
-		return 0;
-	}
-
 	jiffy_elapsed = jiffy_elapsed_rnd = jiffies - tg->slice_start[rw];
 
 	/* Slice has just started. Consider one slice interval */
@@ -742,6 +736,54 @@ static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
 	return jiffy_wait;
 }
 
+/*
+ * If previous slice expired, start a new one otherwise renew/extend existing
+ * slice to make sure it is at least throtl_slice interval long since now.
+ * New slice is started only for empty throttle group. If there is queued bio,
+ * that means there should be an active slice and it should be extended instead.
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
@@ -749,9 +791,7 @@ static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
 static unsigned long tg_dispatch_time(struct throtl_grp *tg, struct bio *bio)
 {
 	bool rw = bio_data_dir(bio);
-	unsigned long bps_wait, iops_wait, max_wait;
-	u64 bps_limit = tg_bps_limit(tg, rw);
-	u32 iops_limit = tg_iops_limit(tg, rw);
+	unsigned long bps_wait, iops_wait;
 
 	/*
  	 * Currently whole state machine of group depends on first bio
@@ -762,38 +802,10 @@ static unsigned long tg_dispatch_time(struct throtl_grp *tg, struct bio *bio)
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

