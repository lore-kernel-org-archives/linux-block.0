Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654EF2356C2
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 11:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744888122; cv=none; b=s94h7FLzGNhdkJGqHrQkUYFw1dUo4yvSlYqgIgHDOp/BjRb57Lv/PXvtXlj19364D0RZACeHP0KaPAKXz+sLHUNH25tewAQ3/9oEKcZw31XSBlA/PCUSCyfuqSQzqQWAWLA5i0dubh0gHWk4OYkRsc+Wp+dCas1sjMbvhVQ2kKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744888122; c=relaxed/simple;
	bh=W+KHsOaae04VA7yN3kiBUvS/M/J98S7B1ss6g2kt+ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6ygRqMEIySQtgmy2rNRASN+Ixbxb2tcSLZJgb81HmW/jiiFXQdvI9uPr6m66mZjFg5ZSUws0UtHvlMbqNKeJSGn8Or4sbrQNylgBDUJ74BWjc16R/0J6koMwXUbYv6oHLCPYJ+6MrEij4ouM/FubLkADNRXGZVNwHTy9N5WPGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZdZr71zzXz4f3lVL
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 19:08:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 890261A17ED
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 19:08:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgC3Gl8s4QBoyDT8Jg--.2150S11;
	Thu, 17 Apr 2025 19:08:32 +0800 (CST)
From: Zizhi Wo <wozizhi@huawei.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: yangerkun@huawei.com,
	yukuai3@huawei.com,
	wozizhi@huaweicloud.com,
	ming.lei@redhat.com,
	tj@kernel.org
Subject: [PATCH V2 7/7] blk-throttle: Prevents the bps restricted io from entering the bps queue again
Date: Thu, 17 Apr 2025 18:58:33 +0800
Message-ID: <20250417105833.1930283-8-wozizhi@huawei.com>
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
X-CM-TRANSID:gCh0CgC3Gl8s4QBoyDT8Jg--.2150S11
X-Coremail-Antispam: 1UD129KBjvJXoW3GF15Ww18Zr43Wr47XryfXrb_yoWxGFyrpF
	WxCF4rJa1ktrsrKr1fXF17JFWSqw4fJry3ArZ3GrySyrW2qr1vgr1qva4rZFWrAF9xCF43
	ZF4UKrZ5C3WUA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQ0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7Iv64x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x
	0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF04k20xvEw4C26cxK6c8Ij28IcwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwKZGDUUUU
Sender: wozizhi@huaweicloud.com
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

[BUG]
There has an issue of io delayed dispatch caused by io splitting. Consider
the following scenario:
1) If we set a BPS limit of 1MB/s and restrict the maximum IO size per
dispatch to 4KB, submitting -two- 1MB IO requests results in completion
times of 1s and 2s, which is expected.
2) However, if we additionally set an IOPS limit of 1,000,000/s with the
same BPS limit of 1MB/s, submitting -two- 1MB IO requests again results in
both completing in 2s, even though the IOPS constraint is being met.

[CAUSE]
This issue arises because BPS and IOPS currently share the same queue in
the blkthrotl mechanism:
1) This issue does not occur when only BPS is limited because the split IOs
return false in blk_should_throtl() and do not go through to throtl again.
2) For split IOs, even if they have been tagged with BIO_BPS_THROTTLED,
they still get queued alternately in the same list due to continuous
splitting and reordering. As a result, the two IO requests are both
completed at the 2-second mark, causing an unintended delay.
3) It is not difficult to imagine that in this scenario, if N 1MB IOs are
issued at once, all IOs will eventually complete together in N seconds.

[FIX]
With the queue separation introduced in the previous patch, we now have
separate BPS and IOPS queues. For IOs that have already passed the BPS
limitation, they do not need to re-enter the BPS queue and can directly
placed to the IOPS queue.

Since we have split the queues, when the IOPS queue is previously empty
and a new bio is added to the first qnode in the service_queue, we also
need to update the disptime. This patch introduces
"THROTL_TG_IOPS_WAS__EMPTY" flag to mark it.

Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 53 +++++++++++++++++++++++++++++++++++++-------
 block/blk-throttle.h |  8 ++++---
 2 files changed, 50 insertions(+), 11 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 6f9f08d7e5fe..29a60ce8a344 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -163,7 +163,12 @@ static void throtl_qnode_add_bio(struct bio *bio, struct throtl_qnode *qn,
 {
 	bool rw = bio_data_dir(bio);
 
-	if (bio_flagged(bio, BIO_TG_BPS_THROTTLED)) {
+	/*
+	 * Split bios have already been throttled by bps, so they are
+	 * directly queued into the iops path.
+	 */
+	if (bio_flagged(bio, BIO_TG_BPS_THROTTLED) ||
+	    bio_flagged(bio, BIO_BPS_THROTTLED)) {
 		bio_list_add(&qn->bios_iops, bio);
 		sq->nr_queued_iops[rw]++;
 	} else {
@@ -894,6 +899,15 @@ static void throtl_add_bio_tg(struct bio *bio, struct throtl_qnode *qn,
 
 	throtl_qnode_add_bio(bio, qn, sq);
 
+	/*
+	 * Since we have split the queues, when the iops queue is
+	 * previously empty and a new @bio is added into the first @qn,
+	 * we also need to update the @tg->disptime.
+	 */
+	if (bio_flagged(bio, BIO_BPS_THROTTLED) &&
+	    bio == throtl_peek_queued(&sq->queued[rw]))
+		tg->flags |= THROTL_TG_IOPS_WAS_EMPTY;
+
 	throtl_enqueue_tg(tg);
 }
 
@@ -921,6 +935,7 @@ static void tg_update_disptime(struct throtl_grp *tg)
 
 	/* see throtl_add_bio_tg() */
 	tg->flags &= ~THROTL_TG_WAS_EMPTY;
+	tg->flags &= ~THROTL_TG_IOPS_WAS_EMPTY;
 }
 
 static void start_parent_slice_with_credit(struct throtl_grp *child_tg,
@@ -1108,7 +1123,8 @@ static void throtl_pending_timer_fn(struct timer_list *t)
 
 	if (parent_sq) {
 		/* @parent_sq is another throl_grp, propagate dispatch */
-		if (tg->flags & THROTL_TG_WAS_EMPTY) {
+		if (tg->flags & THROTL_TG_WAS_EMPTY ||
+		    tg->flags & THROTL_TG_IOPS_WAS_EMPTY) {
 			tg_update_disptime(tg);
 			if (!throtl_schedule_next_dispatch(parent_sq, false)) {
 				/* window is already open, repeat dispatching */
@@ -1653,9 +1669,28 @@ void blk_throtl_cancel_bios(struct gendisk *disk)
 
 static bool tg_within_limit(struct throtl_grp *tg, struct bio *bio, bool rw)
 {
-	/* throtl is FIFO - if bios are already queued, should queue */
-	if (sq_queued(&tg->service_queue, rw))
+	struct throtl_service_queue *sq = &tg->service_queue;
+
+	/*
+	 * For a split bio, we need to specifically distinguish whether the
+	 * iops queue is empty.
+	 */
+	if (bio_flagged(bio, BIO_BPS_THROTTLED))
+		return sq->nr_queued_iops[rw] == 0 &&
+				tg_dispatch_iops_time(tg, bio) == 0;
+
+	/*
+	 * Throtl is FIFO - if bios are already queued, should queue.
+	 * If the bps queue is empty and @bio is within the bps limit, charge
+	 * bps here for direct placement into the iops queue.
+	 */
+	if (sq_queued(&tg->service_queue, rw)) {
+		if (sq->nr_queued_bps[rw] == 0 &&
+		    tg_dispatch_bps_time(tg, bio) == 0)
+			throtl_charge_bps_bio(tg, bio);
+
 		return false;
+	}
 
 	return tg_dispatch_time(tg, bio) == 0;
 }
@@ -1736,11 +1771,13 @@ bool __blk_throtl_bio(struct bio *bio)
 
 	/*
 	 * Update @tg's dispatch time and force schedule dispatch if @tg
-	 * was empty before @bio.  The forced scheduling isn't likely to
-	 * cause undue delay as @bio is likely to be dispatched directly if
-	 * its @tg's disptime is not in the future.
+	 * was empty before @bio, or the iops queue is empty and @bio will
+	 * add to.  The forced scheduling isn't likely to cause undue
+	 * delay as @bio is likely to be dispatched directly if its @tg's
+	 * disptime is not in the future.
 	 */
-	if (tg->flags & THROTL_TG_WAS_EMPTY) {
+	if (tg->flags & THROTL_TG_WAS_EMPTY ||
+	    tg->flags & THROTL_TG_IOPS_WAS_EMPTY) {
 		tg_update_disptime(tg);
 		throtl_schedule_next_dispatch(tg->service_queue.parent_sq, true);
 	}
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index 04e92cfd0ab1..6f11aaabe7e7 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -55,9 +55,11 @@ struct throtl_service_queue {
 };
 
 enum tg_state_flags {
-	THROTL_TG_PENDING	= 1 << 0,	/* on parent's pending tree */
-	THROTL_TG_WAS_EMPTY	= 1 << 1,	/* bio_lists[] became non-empty */
-	THROTL_TG_CANCELING	= 1 << 2,	/* starts to cancel bio */
+	THROTL_TG_PENDING		= 1 << 0,	/* on parent's pending tree */
+	THROTL_TG_WAS_EMPTY		= 1 << 1,	/* bio_lists[] became non-empty */
+	/* iops queue is empty, and a bio is about to be enqueued to the first qnode. */
+	THROTL_TG_IOPS_WAS_EMPTY	= 1 << 2,
+	THROTL_TG_CANCELING		= 1 << 3,	/* starts to cancel bio */
 };
 
 struct throtl_grp {
-- 
2.46.1

