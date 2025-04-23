Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DCD7F9
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 02:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745375605; cv=none; b=edAFXY5ZNN2TNCpiRsZ5fPjxORlcitKa7jOzKCJN/pFueH9qbhswAYAWrGk+3GHaaYp4hExm2G48Sha8Ymv0PSw8H2x1a9zxz5xszJTR60vAhWebokWtJVbQuQHWz+l/3e+yFYhUfJAtvY36VuRciRyPRdsIaZfRnc8/5wzVJu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745375605; c=relaxed/simple;
	bh=Dn40j7CegTDN/INKZBVLf/lAG+2TGSzvPcRQHzn/Zv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X8f7/dc0buvJghga+KzaxYTkCc4xWDWXRs2w5gL7Dz0Sl5AWDiJE+n8v1jRN07ybEH1np3UPjIWK2ZJl0m+sN/gG4mTVB/IPNRlH8vOmRDtjWW5RSmO2xjibP8twN90x1Qf8hD3LTKD72JyRLzNr41HwVUnnxHv2ARzOa9WTxyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zj3716KXkz4f3jqb
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 10:33:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 811A51A058E
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 10:33:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgB3219rUQhoCGcsKQ--.37591S6;
	Wed, 23 Apr 2025 10:33:20 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: yangerkun@huawei.com,
	yukuai3@huawei.com,
	wozizhi@huaweicloud.com,
	ming.lei@redhat.com,
	tj@kernel.org
Subject: [PATCH V4 2/7] blk-throttle: Refactor tg_dispatch_time by extracting tg_dispatch_bps/iops_time
Date: Wed, 23 Apr 2025 10:22:56 +0800
Message-ID: <20250423022301.3354136-3-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250423022301.3354136-1-wozizhi@huaweicloud.com>
References: <20250423022301.3354136-1-wozizhi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3219rUQhoCGcsKQ--.37591S6
X-Coremail-Antispam: 1UD129KBjvJXoW3WF4fKFWDGr4kAFykuF15Jwb_yoW7try8pr
	W3Ca1jqF48XFn7KFW3Zwn8GayYkws7Ar9rJa9rGr9rAF4YvFyDKF1kZryYvFW5AF97ua17
	Aryqv347Ca1qyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBG14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWUtw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUFoGdUUUUU=
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

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
index dc23c961c028..00f99c417647 100644
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

