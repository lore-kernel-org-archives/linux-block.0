Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2758253B60
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 04:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744949970; cv=none; b=mt05on5sfvnbXqF6neODp4AshXqqCyJvJCasbplcqa5CeNkdqrAEyhgQIrmtzV+03pYmRPEM7UJq5+99r0hyzYHywnpgXJwpoWIcCiO317WHsBGIWq2WjT1p1PJPvuaP46ZxWl5UMxqbX5ntOq60fzEY+SE0a3qwbd+D+s6GOXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744949970; c=relaxed/simple;
	bh=T7R+1OU0UwW+f4gTt4REXIM3VTST3OyL0Pc7ZrBFl2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P29H3dBVFOLamDC+JcGksax4yaSkDxQ961JPIsFjPGj+8DL3fC1cqBm/HEapOJicb2jDzgNwisWsDiXfs6En2BO4Gi+3T6WoQ7Cly82M9ScdT+NYEBfEl+4MkpervMeWKLKf+6bVY3YNBGm0zxWyA+cenT9KOkea0B6zeCWAN5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zf1jl3W1fz4f3jYl
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 12:19:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DFAA11A12D9
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 12:19:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgBXul7K0gFoPDtDJw--.14109S11;
	Fri, 18 Apr 2025 12:19:25 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: yangerkun@huawei.com,
	yukuai3@huawei.com,
	wozizhi@huaweicloud.com,
	ming.lei@redhat.com,
	tj@kernel.org
Subject: [PATCH V3 7/7] blk-throttle: Prevents the bps restricted io from entering the bps queue again
Date: Fri, 18 Apr 2025 12:09:24 +0800
Message-ID: <20250418040924.486324-8-wozizhi@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgBXul7K0gFoPDtDJw--.14109S11
X-Coremail-Antispam: 1UD129KBjvJXoW3GF15Ww18Zr43Wr4rtw48tFb_yoWxGw4xpF
	WxCF4rJa1ktrsrKr1fXF17GFySqw4fJrW3ArZ3GrySy3y2qr10gr1qvFyrZFWrAF9xCr43
	ZF4DKrZ5C3WUA3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAV
	WUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoL05UUUU
	U
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

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
index 0f113b2441aa..6b53eb5270be 100644
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
@@ -895,6 +900,15 @@ static void throtl_add_bio_tg(struct bio *bio, struct throtl_qnode *qn,
 
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
 
@@ -922,6 +936,7 @@ static void tg_update_disptime(struct throtl_grp *tg)
 
 	/* see throtl_add_bio_tg() */
 	tg->flags &= ~THROTL_TG_WAS_EMPTY;
+	tg->flags &= ~THROTL_TG_IOPS_WAS_EMPTY;
 }
 
 static void start_parent_slice_with_credit(struct throtl_grp *child_tg,
@@ -1109,7 +1124,8 @@ static void throtl_pending_timer_fn(struct timer_list *t)
 
 	if (parent_sq) {
 		/* @parent_sq is another throl_grp, propagate dispatch */
-		if (tg->flags & THROTL_TG_WAS_EMPTY) {
+		if (tg->flags & THROTL_TG_WAS_EMPTY ||
+		    tg->flags & THROTL_TG_IOPS_WAS_EMPTY) {
 			tg_update_disptime(tg);
 			if (!throtl_schedule_next_dispatch(parent_sq, false)) {
 				/* window is already open, repeat dispatching */
@@ -1654,9 +1670,28 @@ void blk_throtl_cancel_bios(struct gendisk *disk)
 
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
@@ -1737,11 +1772,13 @@ bool __blk_throtl_bio(struct bio *bio)
 
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

