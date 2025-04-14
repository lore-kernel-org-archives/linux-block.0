Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9A32750F5
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 13:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637864; cv=none; b=ECRhMH1kR/STwYgYH6Dh5Ka67rJ6QDLxKp6dZ2152YsouP8BE5lDoxIwNSTRm9b/RAOO5WDxRNUBBUt50dSw43EYL7n8rxFFtR1fKaBShsrgIx0ygAwLEZy2ugV0sI5oCDVeqMqo3b5pK7RTzLCkgCLxnPT3Gf4XAIZkNsdhpRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637864; c=relaxed/simple;
	bh=B33Nj6fjon1eZr5vx5WpSgKUK3bUej6tmHY9XcrnjdI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mJaLi83eDiwFKdRN6R2kvw7ClK3G1kakCj5EUyq3DnF7IIbiEUR1EljMY+6+5qGfWfb/8wBINBborHJZQKTzwaHLuZ7B2zctChzJtXMxM9+m5D0xI1lxrsh2nekttMt/wPiECYjl1NfLOhMRl6+9lbxxet7MYCDIhNTpvXT7bCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZbpC166FZzvWtM;
	Mon, 14 Apr 2025 21:33:17 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 1C6011402EA;
	Mon, 14 Apr 2025 21:37:23 +0800 (CST)
Received: from localhost.localdomain (10.175.112.188) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 14 Apr 2025 21:37:22 +0800
From: Zizhi Wo <wozizhi@huawei.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC: <yangerkun@huawei.com>, <yukuai3@huawei.com>, <wozizhi@huawei.com>,
	<ming.lei@redhat.com>, <tj@kernel.org>
Subject: [PATCH 7/7] blk-throttle: Prevents the bps restricted io from entering the bps queue again
Date: Mon, 14 Apr 2025 21:27:31 +0800
Message-ID: <20250414132731.167620-8-wozizhi@huawei.com>
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
---
 block/blk-throttle.c | 53 +++++++++++++++++++++++++++++++++++++-------
 block/blk-throttle.h |  8 ++++---
 2 files changed, 50 insertions(+), 11 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index faae10e2e6e3..b82ce8e927d3 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -165,7 +165,12 @@ static void throtl_qnode_add_bio(struct bio *bio, struct throtl_qnode *qn,
 	struct throtl_service_queue *sq = container_of(queued,
 				struct throtl_service_queue, queued[rw]);
 
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
@@ -897,6 +902,15 @@ static void throtl_add_bio_tg(struct bio *bio, struct throtl_qnode *qn,
 
 	throtl_qnode_add_bio(bio, qn, &sq->queued[rw]);
 
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
 
@@ -924,6 +938,7 @@ static void tg_update_disptime(struct throtl_grp *tg)
 
 	/* see throtl_add_bio_tg() */
 	tg->flags &= ~THROTL_TG_WAS_EMPTY;
+	tg->flags &= ~THROTL_TG_IOPS_WAS_EMPTY;
 }
 
 static void start_parent_slice_with_credit(struct throtl_grp *child_tg,
@@ -1111,7 +1126,8 @@ static void throtl_pending_timer_fn(struct timer_list *t)
 
 	if (parent_sq) {
 		/* @parent_sq is another throl_grp, propagate dispatch */
-		if (tg->flags & THROTL_TG_WAS_EMPTY) {
+		if (tg->flags & THROTL_TG_WAS_EMPTY ||
+		    tg->flags & THROTL_TG_IOPS_WAS_EMPTY) {
 			tg_update_disptime(tg);
 			if (!throtl_schedule_next_dispatch(parent_sq, false)) {
 				/* window is already open, repeat dispatching */
@@ -1656,9 +1672,28 @@ void blk_throtl_cancel_bios(struct gendisk *disk)
 
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
@@ -1739,11 +1774,13 @@ bool __blk_throtl_bio(struct bio *bio)
 
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

