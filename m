Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BAB3C1D5E
	for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 11:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788174493; cv=none; b=uF6kVxrooLCtRVvn7HvRuj368gh00VPLrJvI9MVkGrKAAvTz5CP8bIjMnUZsr6WBlU/wgNV52Oiev3cLdimN1IR+c+HD6ohZBR55D146o5vsTpMg93eTSmZV8H+I96VbrkLpSmf/MX2fBrFOqEV7Pow5RxM72GELfI/iEAk/T8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788174493; c=relaxed/simple;
	bh=hEK9j+nO3wq3Vn6PDjv6viUN/TShQN9YBBtFXG3Vr50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pzi9gMuow9j0NUffaylnspinlGJTwMiUZOxdXfj3XeAy8zVk366YwwyYS/NMo0vL8QLkWxBjgnVbui3i2o72x9iZZB9CibVms1LkUIfGmX3u29OBHwflP88c49C0O5TKPG5Xgey560UPPCAuWjEdaD0UdZaz4l9Z12sRywoXTPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hYR5r1GmKzKHMln
	for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 19:07:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id CDCE040586
	for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 19:08:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.132])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgBHMAuPYJVqZo_vAA--.44034S6;
	Mon, 31 Aug 2026 19:08:00 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: ming.lei@redhat.com
Subject: [PATCH v2 2/4] block/mq-deadline: add prio_enable switch for I/O priority control
Date: Mon, 31 Aug 2026 19:01:42 +0800
Message-Id: <20260831110144.2648156-3-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260831110144.2648156-1-yebin@huaweicloud.com>
References: <20260831110144.2648156-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHMAuPYJVqZo_vAA--.44034S6
X-Coremail-Antispam: 1UD129KBjvJXoW3GFy3XrWUJrW7Zw13Cr4UJwb_yoWftFW5pF
	45XF4Ykr48XF4xW348CF15Zr1S9w4xAry7tryfK3yIkFnrAr1DuF10kF1FvFs3Ar4kurnx
	KF1vva4kuF12qFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvmb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnU
	UI43ZEXa7IU1ZmRUUUUUU==
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

Since mq-deadline introduced support for I/O priorities, processes
without an explicit I/O priority are bound to their scheduling
priority.  This forces applications to plan their I/O priorities,
but many applications do not care about I/O priorities and have no
way to disable the distinction.

Add a per-queue prio_enable boolean to control whether I/O priority
(RT/BE/IDLE) support is active.  When disabled, every request is
filed in the best-effort bucket and the priority aging path is
bypassed.

To avoid priority inversion while toggling the switch at runtime,
the sysfs store follows the same sequence as elevator_switch():
freeze the queue, quiesce, flip the flag, then unquiesce and
unfreeze.  This drains in-flight I/O so that requests already queued
in RT or IDLE buckets complete before the mode changes.

Since requests may now be filed in a bucket that does not match
their ioprio, update dd_start_request(), dd_request_merged() and
dd_merged_requests() to look up the per-priority bucket from
rq->elv.priv[0] instead of recomputing it from the request ioprio.
Remove the now-unused dd_rq_ioclass() helper.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 block/mq-deadline.c | 109 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 82 insertions(+), 27 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index a4358625cfc8..276ce249d326 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -86,6 +86,7 @@ struct deadline_data {
 	 * run time data
 	 */
 
+	struct request_queue *q;	/* associated request queue */
 	struct list_head dispatch;
 	struct dd_per_prio per_prio[DD_PRIO_COUNT];
 
@@ -102,6 +103,7 @@ struct deadline_data {
 	int writes_starved;
 	int front_merges;
 	int prio_aging_expire;
+	bool prio_enable;
 
 	spinlock_t lock;
 };
@@ -120,15 +122,6 @@ deadline_rb_root(struct dd_per_prio *per_prio, struct request *rq)
 	return &per_prio->sort_list[rq_data_dir(rq)];
 }
 
-/*
- * Returns the I/O priority class (IOPRIO_CLASS_*) that has been assigned to a
- * request.
- */
-static u8 dd_rq_ioclass(struct request *rq)
-{
-	return IOPRIO_PRIO_CLASS(req_get_ioprio(rq));
-}
-
 /*
  * Return the first request for which blk_rq_pos() >= @pos.
  */
@@ -187,10 +180,7 @@ static void deadline_remove_request(struct request_queue *q,
 static void dd_request_merged(struct request_queue *q, struct request *req,
 			      enum elv_merge type)
 {
-	struct deadline_data *dd = q->elevator->elevator_data;
-	const u8 ioprio_class = dd_rq_ioclass(req);
-	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
-	struct dd_per_prio *per_prio = &dd->per_prio[prio];
+	struct dd_per_prio *per_prio = req->elv.priv[0];
 
 	/*
 	 * if the merge was a front merge, we need to reposition request
@@ -208,12 +198,11 @@ static void dd_merged_requests(struct request_queue *q, struct request *req,
 			       struct request *next)
 {
 	struct deadline_data *dd = q->elevator->elevator_data;
-	const u8 ioprio_class = dd_rq_ioclass(next);
-	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
+	struct dd_per_prio *per_prio = next->elv.priv[0];
 
 	lockdep_assert_held(&dd->lock);
 
-	dd->per_prio[prio].stats.merged++;
+	per_prio->stats.merged++;
 
 	/*
 	 * if next expires before rq, assign its expire time to rq
@@ -230,7 +219,7 @@ static void dd_merged_requests(struct request_queue *q, struct request *req,
 	/*
 	 * kill knowledge of next, this one is a goner
 	 */
-	deadline_remove_request(q, &dd->per_prio[prio], next);
+	deadline_remove_request(q, per_prio, next);
 }
 
 /*
@@ -305,15 +294,13 @@ static bool started_after(struct deadline_data *dd, struct request *rq,
 	return time_after(start_time, latest_start);
 }
 
-static struct request *dd_start_request(struct deadline_data *dd,
-					enum dd_data_dir data_dir,
+static struct request *dd_start_request(enum dd_data_dir data_dir,
 					struct request *rq)
 {
-	u8 ioprio_class = dd_rq_ioclass(rq);
-	enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
+	struct dd_per_prio *per_prio = rq->elv.priv[0];
 
-	dd->per_prio[prio].latest_pos[data_dir] = blk_rq_pos(rq);
-	dd->per_prio[prio].stats.dispatched++;
+	per_prio->latest_pos[data_dir] = blk_rq_pos(rq);
+	per_prio->stats.dispatched++;
 	rq->rq_flags |= RQF_STARTED;
 	return rq;
 }
@@ -410,7 +397,7 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	 */
 	dd->batching++;
 	deadline_move_request(per_prio, rq);
-	return dd_start_request(dd, data_dir, rq);
+	return dd_start_request(data_dir, rq);
 }
 
 /*
@@ -426,6 +413,16 @@ static struct request *dd_dispatch_prio_aged_requests(struct deadline_data *dd,
 
 	lockdep_assert_held(&dd->lock);
 
+	/*
+	 * When I/O priority is disabled every request is filed in the
+	 * DD_BE_PRIO bucket, so the priority aging path must be bypassed to
+	 * avoid dispatching best-effort (or idle) requests ahead of pending
+	 * real-time requests through "now - prio_aging_expire", which would
+	 * cause priority inversion.
+	 */
+	if (!dd->prio_enable)
+		return NULL;
+
 	prio_cnt = !!dd_queued(dd, DD_RT_PRIO) + !!dd_queued(dd, DD_BE_PRIO) +
 		   !!dd_queued(dd, DD_IDLE_PRIO);
 	if (prio_cnt < 2)
@@ -461,7 +458,17 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	if (!list_empty(&dd->dispatch)) {
 		rq = list_first_entry(&dd->dispatch, struct request, queuelist);
 		list_del_init(&rq->queuelist);
-		dd_start_request(dd, rq_data_dir(rq), rq);
+		dd_start_request(rq_data_dir(rq), rq);
+		goto unlock;
+	}
+
+	/*
+	 * When I/O priority is disabled every request is filed in the
+	 * best-effort bucket, so skip the priority aging path and the
+	 * multi-priority loop and dispatch directly from that single bucket.
+	 */
+	if (!dd->prio_enable) {
+		rq = __dd_dispatch_request(dd, &dd->per_prio[DD_BE_PRIO], now);
 		goto unlock;
 	}
 
@@ -536,6 +543,7 @@ static int dd_init_sched(struct request_queue *q, struct elevator_queue *eq)
 		return -ENOMEM;
 
 	eq->elevator_data = dd;
+	dd->q = q;
 
 	INIT_LIST_HEAD(&dd->dispatch);
 	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
@@ -553,6 +561,7 @@ static int dd_init_sched(struct request_queue *q, struct elevator_queue *eq)
 	dd->last_dir = DD_WRITE;
 	dd->fifo_batch = fifo_batch;
 	dd->prio_aging_expire = prio_aging_expire;
+	dd->prio_enable = true;
 	spin_lock_init(&dd->lock);
 
 	/* We dispatch from request queue wide instead of hw queue */
@@ -573,7 +582,8 @@ static int dd_request_merge(struct request_queue *q, struct request **rq,
 {
 	struct deadline_data *dd = q->elevator->elevator_data;
 	const u8 ioprio_class = IOPRIO_PRIO_CLASS(bio->bi_ioprio);
-	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
+	const enum dd_prio prio = !dd->prio_enable ? DD_BE_PRIO :
+					  ioprio_class_to_prio[ioprio_class];
 	struct dd_per_prio *per_prio = &dd->per_prio[prio];
 	sector_t sector = bio_end_sector(bio);
 	struct request *__rq;
@@ -633,7 +643,15 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 
 	lockdep_assert_held(&dd->lock);
 
-	prio = ioprio_class_to_prio[ioprio_class];
+	/*
+	 * When I/O priority is disabled, file every request in the best-effort
+	 * bucket so that the dispatch path no longer distinguishes between RT,
+	 * BE and IDLE classes.
+	 */
+	if (!dd->prio_enable)
+		prio = DD_BE_PRIO;
+	else
+		prio = ioprio_class_to_prio[ioprio_class];
 	per_prio = &dd->per_prio[prio];
 	if (!rq->elv.priv[0])
 		per_prio->stats.inserted++;
@@ -748,6 +766,7 @@ SHOW_JIFFIES(deadline_prio_aging_expire_show, dd->prio_aging_expire);
 SHOW_INT(deadline_writes_starved_show, dd->writes_starved);
 SHOW_INT(deadline_front_merges_show, dd->front_merges);
 SHOW_INT(deadline_fifo_batch_show, dd->fifo_batch);
+SHOW_INT(deadline_prio_enable_show, dd->prio_enable);
 #undef SHOW_INT
 #undef SHOW_JIFFIES
 
@@ -802,6 +821,41 @@ static ssize_t deadline_prio_aging_expire_store(struct elevator_queue *e,
 	return count;
 }
 
+/*
+ * Writing zero to prio_enable disables I/O priority: all requests are
+ * treated as best-effort. To avoid priority inversion while the mode is
+ * being switched, first drain all in-flight I/O by following the same
+ * sequence used by elevator_switch(): freeze the queue so that new
+ * upper-layer I/O is blocked and all outstanding requests complete,
+ * quiesce the queue so that no dispatch is in progress, then flip
+ * prio_enable to false. New I/O queued after the switch lands in the
+ * best-effort bucket.
+ */
+static ssize_t deadline_prio_enable_store(struct elevator_queue *e,
+					 const char *page, size_t count)
+{
+	struct deadline_data *dd = e->elevator_data;
+	int val, ret;
+
+	ret = kstrtoint(page, 0, &val);
+	if (ret < 0)
+		return ret;
+	if (val < 0)
+		val = 0;
+
+	if (!!val != dd->prio_enable) {
+		unsigned int memflags;
+
+		memflags = blk_mq_freeze_queue(dd->q);
+		blk_mq_quiesce_queue(dd->q);
+		dd->prio_enable = !!val;
+		blk_mq_unquiesce_queue(dd->q);
+		blk_mq_unfreeze_queue(dd->q, memflags);
+	}
+
+	return count;
+}
+
 #define DD_ATTR(name) \
 	__ATTR(name, 0644, deadline_##name##_show, deadline_##name##_store)
 
@@ -812,6 +866,7 @@ static const struct elv_fs_entry deadline_attrs[] = {
 	DD_ATTR(front_merges),
 	DD_ATTR(fifo_batch),
 	DD_ATTR(prio_aging_expire),
+	DD_ATTR(prio_enable),
 	__ATTR_NULL
 };
 
-- 
2.34.1

