Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427FE32A6D3
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 02:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746498045; cv=none; b=VM80xlCfCgV398IhXztrRrCyu51Ppq1ubVrpxzdXASv3F1W5cos+OoG099pO9+0aHY+F75tAFuT5zSzYIqjT+q+GzbXtGgVxE3rtLXlBKIJkbd5ngTXLOs53cGUbGlqXzMudj9HbauPdmyTnAH1JLS9gVR2uCNTerQ0ZXU0HlrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746498045; c=relaxed/simple;
	bh=k1agO9QfdLP0+/A1wDuCwB/FX90+t4yaTSuTUIFb1BE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c35QGeA2hH77EDDlziFUnZTLwVqxdUA/PXx1I+U3A1Mn5ZXZZkRSkoOmWRUA3JLaOjRbU2J3SR9rua+1W61evPGkaavVR8zL74iHlBlM2u4YX1XB2q7awDfN4BJxyRJKHdWdY5pm5oYXYjD5E5Gv/6Zs0rW2e64k0Y5VIzWd94o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Zs2DG1zfYz4f3l7B
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 10:20:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B4B0F1A1657
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 10:20:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgBXvGDxcRloS3NDLg--.28694S10;
	Tue, 06 May 2025 10:20:38 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: yangerkun@huawei.com,
	yukuai3@huawei.com,
	wozizhi@huaweicloud.com,
	ming.lei@redhat.com,
	tj@kernel.org
Subject: [PATCH V5 6/7] blk-throttle: Split the service queue
Date: Tue,  6 May 2025 10:09:33 +0800
Message-ID: <20250506020935.655574-7-wozizhi@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgBXvGDxcRloS3NDLg--.28694S10
X-Coremail-Antispam: 1UD129KBjvJXoW3AF13XFWfCw1UZF1UtFW5KFg_yoWfurW3pr
	W7CFsxJw4kJr4vgrW3tr47GFWSqw4xArW7A34fGrWSyrW7X3Z8XF1UZFyrZFWrAF97uF48
	Zryqqrs8W3WUJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAV
	WUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUvYLPUUUUU
	=
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

This patch splits throtl_service_queue->nr_queued into "nr_queued_bps" and
"nr_queued_iops", allowing separate accounting of BPS and IOPS queued bios.
This prepares for future changes that need to check whether the BPS or IOPS
queues are empty.

To facilitate updating the number of IOs in the BPS and IOPS queues, the
addition logic will be moved from throtl_add_bio_tg() to
throtl_qnode_add_bio(), and similarly, the removal logic will be moved from
tg_dispatch_one_bio() to throtl_pop_queued().

And introduce sq_queued() to calculate the total sum of sq->nr_queued.

Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Zizhi Wo <wozizhi@huaweicloud.com>
---
 block/blk-throttle.c | 76 +++++++++++++++++++++++++++-----------------
 block/blk-throttle.h |  3 +-
 2 files changed, 49 insertions(+), 30 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index dc7c6b51c2cd..3129bb83d819 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -152,22 +152,27 @@ static void throtl_qnode_init(struct throtl_qnode *qn, struct throtl_grp *tg)
  * throtl_qnode_add_bio - add a bio to a throtl_qnode and activate it
  * @bio: bio being added
  * @qn: qnode to add bio to
- * @queued: the service_queue->queued[] list @qn belongs to
+ * @sq: the service_queue @qn belongs to
  *
- * Add @bio to @qn and put @qn on @queued if it's not already on.
+ * Add @bio to @qn and put @qn on @sq->queued if it's not already on.
  * @qn->tg's reference count is bumped when @qn is activated.  See the
  * comment on top of throtl_qnode definition for details.
  */
 static void throtl_qnode_add_bio(struct bio *bio, struct throtl_qnode *qn,
-				 struct list_head *queued)
+				 struct throtl_service_queue *sq)
 {
-	if (bio_flagged(bio, BIO_TG_BPS_THROTTLED))
+	bool rw = bio_data_dir(bio);
+
+	if (bio_flagged(bio, BIO_TG_BPS_THROTTLED)) {
 		bio_list_add(&qn->bios_iops, bio);
-	else
+		sq->nr_queued_iops[rw]++;
+	} else {
 		bio_list_add(&qn->bios_bps, bio);
+		sq->nr_queued_bps[rw]++;
+	}
 
 	if (list_empty(&qn->node)) {
-		list_add_tail(&qn->node, queued);
+		list_add_tail(&qn->node, &sq->queued[rw]);
 		blkg_get(tg_to_blkg(qn->tg));
 	}
 }
@@ -198,22 +203,24 @@ static struct bio *throtl_peek_queued(struct list_head *queued)
 
 /**
  * throtl_pop_queued - pop the first bio form a qnode list
- * @queued: the qnode list to pop a bio from
+ * @sq: the service_queue to pop a bio from
  * @tg_to_put: optional out argument for throtl_grp to put
+ * @rw: read/write
  *
- * Pop the first bio from the qnode list @queued. Note that we firstly focus on
- * the iops list because bios are ultimately dispatched from it. After popping,
- * the first qnode is removed from @queued if empty or moved to the end of
- * @queued so that the popping order is round-robin.
+ * Pop the first bio from the qnode list @sq->queued. Note that we firstly
+ * focus on the iops list because bios are ultimately dispatched from it.
+ * After popping, the first qnode is removed from @sq->queued if empty or moved
+ * to the end of @sq->queued so that the popping order is round-robin.
  *
  * When the first qnode is removed, its associated throtl_grp should be put
  * too.  If @tg_to_put is NULL, this function automatically puts it;
  * otherwise, *@tg_to_put is set to the throtl_grp to put and the caller is
  * responsible for putting it.
  */
-static struct bio *throtl_pop_queued(struct list_head *queued,
-				     struct throtl_grp **tg_to_put)
+static struct bio *throtl_pop_queued(struct throtl_service_queue *sq,
+				     struct throtl_grp **tg_to_put, bool rw)
 {
+	struct list_head *queued = &sq->queued[rw];
 	struct throtl_qnode *qn;
 	struct bio *bio;
 
@@ -222,8 +229,13 @@ static struct bio *throtl_pop_queued(struct list_head *queued,
 
 	qn = list_first_entry(queued, struct throtl_qnode, node);
 	bio = bio_list_pop(&qn->bios_iops);
-	if (!bio)
+	if (bio) {
+		sq->nr_queued_iops[rw]--;
+	} else {
 		bio = bio_list_pop(&qn->bios_bps);
+		if (bio)
+			sq->nr_queued_bps[rw]--;
+	}
 	WARN_ON_ONCE(!bio);
 
 	if (bio_list_empty(&qn->bios_bps) && bio_list_empty(&qn->bios_iops)) {
@@ -553,6 +565,11 @@ static bool throtl_slice_used(struct throtl_grp *tg, bool rw)
 	return true;
 }
 
+static unsigned int sq_queued(struct throtl_service_queue *sq, int type)
+{
+	return sq->nr_queued_bps[type] + sq->nr_queued_iops[type];
+}
+
 static unsigned int calculate_io_allowed(u32 iops_limit,
 					 unsigned long jiffy_elapsed)
 {
@@ -700,7 +717,7 @@ static void __tg_update_carryover(struct throtl_grp *tg, bool rw,
 	 * of subsequent bios. The same handling applies when the previous BPS/IOPS
 	 * limit was set to max.
 	 */
-	if (tg->service_queue.nr_queued[rw] == 0) {
+	if (sq_queued(&tg->service_queue, rw) == 0) {
 		tg->bytes_disp[rw] = 0;
 		tg->io_disp[rw] = 0;
 		return;
@@ -827,7 +844,8 @@ static void throtl_charge_iops_bio(struct throtl_grp *tg, struct bio *bio)
  */
 static void tg_update_slice(struct throtl_grp *tg, bool rw)
 {
-	if (throtl_slice_used(tg, rw) && !(tg->service_queue.nr_queued[rw]))
+	if (throtl_slice_used(tg, rw) &&
+	    sq_queued(&tg->service_queue, rw) == 0)
 		throtl_start_new_slice(tg, rw, true);
 	else
 		throtl_extend_slice(tg, rw, jiffies + tg->td->throtl_slice);
@@ -883,7 +901,7 @@ static unsigned long tg_dispatch_time(struct throtl_grp *tg, struct bio *bio)
 	 * this function with a different bio if there are other bios
 	 * queued.
 	 */
-	BUG_ON(tg->service_queue.nr_queued[rw] &&
+	BUG_ON(sq_queued(&tg->service_queue, rw) &&
 	       bio != throtl_peek_queued(&tg->service_queue.queued[rw]));
 
 	wait = tg_dispatch_bps_time(tg, bio);
@@ -923,12 +941,11 @@ static void throtl_add_bio_tg(struct bio *bio, struct throtl_qnode *qn,
 	 * dispatched.  Mark that @tg was empty.  This is automatically
 	 * cleared on the next tg_update_disptime().
 	 */
-	if (!sq->nr_queued[rw])
+	if (sq_queued(sq, rw) == 0)
 		tg->flags |= THROTL_TG_WAS_EMPTY;
 
-	throtl_qnode_add_bio(bio, qn, &sq->queued[rw]);
+	throtl_qnode_add_bio(bio, qn, sq);
 
-	sq->nr_queued[rw]++;
 	throtl_enqueue_tg(tg);
 }
 
@@ -982,8 +999,7 @@ static void tg_dispatch_one_bio(struct throtl_grp *tg, bool rw)
 	 * getting released prematurely.  Remember the tg to put and put it
 	 * after @bio is transferred to @parent_sq.
 	 */
-	bio = throtl_pop_queued(&sq->queued[rw], &tg_to_put);
-	sq->nr_queued[rw]--;
+	bio = throtl_pop_queued(sq, &tg_to_put, rw);
 
 	throtl_charge_iops_bio(tg, bio);
 
@@ -1000,7 +1016,7 @@ static void tg_dispatch_one_bio(struct throtl_grp *tg, bool rw)
 	} else {
 		bio_set_flag(bio, BIO_BPS_THROTTLED);
 		throtl_qnode_add_bio(bio, &tg->qnode_on_parent[rw],
-				     &parent_sq->queued[rw]);
+				     parent_sq);
 		BUG_ON(tg->td->nr_queued[rw] <= 0);
 		tg->td->nr_queued[rw]--;
 	}
@@ -1065,7 +1081,7 @@ static int throtl_select_dispatch(struct throtl_service_queue *parent_sq)
 		nr_disp += throtl_dispatch_tg(tg);
 
 		sq = &tg->service_queue;
-		if (sq->nr_queued[READ] || sq->nr_queued[WRITE])
+		if (sq_queued(sq, READ) || sq_queued(sq, WRITE))
 			tg_update_disptime(tg);
 		else
 			throtl_dequeue_tg(tg);
@@ -1118,9 +1134,11 @@ static void throtl_pending_timer_fn(struct timer_list *t)
 	dispatched = false;
 
 	while (true) {
+		unsigned int bio_cnt_r = sq_queued(sq, READ);
+		unsigned int bio_cnt_w = sq_queued(sq, WRITE);
+
 		throtl_log(sq, "dispatch nr_queued=%u read=%u write=%u",
-			   sq->nr_queued[READ] + sq->nr_queued[WRITE],
-			   sq->nr_queued[READ], sq->nr_queued[WRITE]);
+			   bio_cnt_r + bio_cnt_w, bio_cnt_r, bio_cnt_w);
 
 		ret = throtl_select_dispatch(sq);
 		if (ret) {
@@ -1182,7 +1200,7 @@ static void blk_throtl_dispatch_work_fn(struct work_struct *work)
 
 	spin_lock_irq(&q->queue_lock);
 	for (rw = READ; rw <= WRITE; rw++)
-		while ((bio = throtl_pop_queued(&td_sq->queued[rw], NULL)))
+		while ((bio = throtl_pop_queued(td_sq, NULL, rw)))
 			bio_list_add(&bio_list_on_stack, bio);
 	spin_unlock_irq(&q->queue_lock);
 
@@ -1688,7 +1706,7 @@ void blk_throtl_cancel_bios(struct gendisk *disk)
 static bool tg_within_limit(struct throtl_grp *tg, struct bio *bio, bool rw)
 {
 	/* throtl is FIFO - if bios are already queued, should queue */
-	if (tg->service_queue.nr_queued[rw])
+	if (sq_queued(&tg->service_queue, rw))
 		return false;
 
 	return tg_dispatch_time(tg, bio) == 0;
@@ -1762,7 +1780,7 @@ bool __blk_throtl_bio(struct bio *bio)
 		   tg->bytes_disp[rw], bio->bi_iter.bi_size,
 		   tg_bps_limit(tg, rw),
 		   tg->io_disp[rw], tg_iops_limit(tg, rw),
-		   sq->nr_queued[READ], sq->nr_queued[WRITE]);
+		   sq_queued(sq, READ), sq_queued(sq, WRITE));
 
 	td->nr_queued[rw]++;
 	throtl_add_bio_tg(bio, qn, tg);
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index f21a2a2bf755..ab892c0bd70f 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -42,7 +42,8 @@ struct throtl_service_queue {
 	 * children throtl_grp's.
 	 */
 	struct list_head	queued[2];	/* throtl_qnode [READ/WRITE] */
-	unsigned int		nr_queued[2];	/* number of queued bios */
+	unsigned int		nr_queued_bps[2];	/* number of queued bps bios */
+	unsigned int		nr_queued_iops[2];	/* number of queued iops bios */
 
 	/*
 	 * RB tree of active children throtl_grp's, which are sorted by
-- 
2.46.1

