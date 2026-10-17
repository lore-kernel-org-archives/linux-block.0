Received: from mta1.migadu.com (out-70.mta1.migadu.com [95.215.58.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1565B348463
	for <linux-block@vger.kernel.org>; Sat, 17 Oct 2026 10:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792234460; cv=none; b=pNeCgd5tSVswAQDa8QOvXqOka4JypAqtBlXRmQLBN+mgZUlX1YooZ8WNKcrm53YatvbRnOIeqO76ttFOe7QLvUFeZtxgl6L7ZDZLn0dMStukdCAzB6fiqbBHYxXAjDYeAbmW+ezy6Nxb014pXYNvomZW7z/F4MryAfvQYa40Awg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792234460; c=relaxed/simple;
	bh=2N9BQKz6AnVfddAOlxhaAFtPmyMyrlSN/sFqe0szwXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GdqTacNfIkMEBhrX0SVvwGoIxfYGOlcQe8LHnOk5MJPzeiPvEhgz3nYORbxS9/GnsL4rEKM8WnmMDfyXg/RMfRuR3igVUOH4K3juP1dgI2URYddwn45FMVSp79KOFG9An2Np8aiduwuw5ud3VafGKwu2lPXdYPiAcp82LGErNnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xqm5loDr; arc=none smtp.client-ip=95.215.58.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xqm5loDr"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2N9BQKz6AnVfddAOlxhaAFtPmyMyrlSN/sFqe0szwXI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792234454; v=1; x=1792839254;
 b=Xqm5loDrTqvvBVVVoUKDVyg8AWU7oFll7Z1LCNmxsDQFEhTESbTLuSowRt8V8AYu/LH0Lhyo
 U8yOpNOjpa3a/Rtq64RQhZfcpKcMBqgCDC3EZkkTzgbp5TE1tw5VygWcqxKq3DjrfolSkxZ+UZ+
 3lmZD70weD3fff5dW7fEtYW0=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id bbef089e09e1860e;
	Sat, 17 Oct 2026 10:54:14 +0000
X-Mizu-Trace-ID: bbef089e09e1860e
X-Migadu-Flow: FLOW_OUT
From: Kaitao Cheng <kaitao.cheng@linux.dev>
To: Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kaitao Cheng <chengkaitao@kylinos.cn>
Subject: [PATCH] blk-mq: add direct dispatch support for mq-deadline
Date: Sat, 17 Oct 2026 18:54:00 +0800
Message-ID: <20261017105400.95967-1-kaitao.cheng@linux.dev>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaitao Cheng <chengkaitao@kylinos.cn>

On fast devices such as NVMe SSDs with spare capacity, scheduler insertion,
sorting and merging may add CPU overhead with little benefit. Allowing new
requests to reach the driver directly can reduce submission latency and
improve bandwidth when this overhead limits performance.

Add a skip_request elevator callback to support direct dispatch for
unplugged submissions and plug flushes outside the scheduling path.
Implement it in mq-deadline with request accounting preserved across
reinsertion and retries.

Expose a dispatch_direct tunable, enabled by default. Directly dispatched
requests may bypass queued requests, including higher priority or expired
requests. Setting dispatch_direct to 0 restores normal scheduler insertion.

Test sequential writes on an NVMe SSD with fio, comparing none, unmodified
mq-deadline, and mq-deadline with this patch and dispatch_direct enabled.

test A:
fio -name=jobs1-4k -direct=1 -iodepth=16 -numjobs=1 -filename=fiolog.txt
    -ioengine=libaio -blocksize=4k -size=10GB -rw=write -runtime=120
    -time_based -ramp_time=30
test B:
fio -name=jobs10-4k -direct=1 -iodepth=16 -numjobs=10 -filename=fiolog.txt
    -ioengine=libaio -blocksize=4k -size=10GB -rw=write -runtime=120
    -time_based -ramp_time=30
test C:
fio -name=jobs1-32k -direct=1 -iodepth=16 -numjobs=1 -filename=fiolog.txt
    -ioengine=libaio -blocksize=32k -size=10GB -rw=write -runtime=120
    -time_based -ramp_time=30

Bandwidth in MiB/s:

  Workload        none    mq-deadline    my-patch
  jobs1-4k        1209           1047        1174
  jobs10-4k       2458            946        2349
  jobs1-32k       2568           2565        2562

Direct dispatch improves bandwidth over unmodified mq-deadline by 12.1%
with one job and 148.3% with multiple jobs for the 4 KiB workloads,
reaching 97.1% and 95.6% of the bandwidth achieved with none, respectively.
All three configurations achieve the same maximum bandwidth.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 Documentation/block/deadline-iosched.rst | 14 +++++++
 block/blk-mq.c                           | 40 ++++++++++++++-----
 block/elevator.h                         |  1 +
 block/mq-deadline.c                      | 50 +++++++++++++++++++++++-
 4 files changed, 94 insertions(+), 11 deletions(-)

diff --git a/Documentation/block/deadline-iosched.rst b/Documentation/block/deadline-iosched.rst
index 9f5c5a4c370e..3d0900b4546c 100644
--- a/Documentation/block/deadline-iosched.rst
+++ b/Documentation/block/deadline-iosched.rst
@@ -69,4 +69,18 @@ that comes at basically 0 cost we leave that on. We simply disable the
 rbtree front sector lookup when the io scheduler merge function is called.
 
 
+dispatch_direct (bool)
+----------------------
+
+Enabled by default. Allows new requests to bypass the scheduler's sort tree,
+FIFO and merge hash when the hardware context is not congested, stopped or
+quiesced. On fast devices such as NVMe SSDs with spare capacity, sorting and
+merging may offer little benefit while adding CPU overhead and limiting
+bandwidth. Direct dispatch can reduce this overhead and submission latency.
+
+Direct dispatch reduces opportunities for merging and sorting, and may bypass
+queued requests, including higher priority or expired requests. Set
+dispatch_direct to 0 to restore normal scheduler insertion.
+
+
 Nov 11 2002, Jens Axboe <jens.axboe@oracle.com>
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1b7f8cbbda8b..615ecacba1ed 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2751,17 +2751,26 @@ static bool blk_mq_get_budget_and_tag(struct request *rq)
 static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 		struct request *rq)
 {
+	bool use_sched = rq->rq_flags & RQF_USE_SCHED;
+	bool run_queue_async = use_sched || (rq->cmd_flags & REQ_NOWAIT);
 	blk_status_t ret;
 
 	if (blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(rq->q)) {
 		blk_mq_insert_request(rq, 0);
-		blk_mq_run_hw_queue(hctx, false);
+		blk_mq_run_hw_queue(hctx, use_sched);
 		return;
 	}
 
-	if ((rq->rq_flags & RQF_USE_SCHED) || !blk_mq_get_budget_and_tag(rq)) {
+	if (use_sched) {
+		struct elevator_mq_ops *ops = &rq->q->elevator->type->ops;
+
+		if (ops->skip_request)
+			use_sched = !ops->skip_request(rq);
+	}
+
+	if (use_sched || !blk_mq_get_budget_and_tag(rq)) {
 		blk_mq_insert_request(rq, 0);
-		blk_mq_run_hw_queue(hctx, rq->cmd_flags & REQ_NOWAIT);
+		blk_mq_run_hw_queue(hctx, run_queue_async);
 		return;
 	}
 
@@ -2927,9 +2936,14 @@ static void blk_mq_dispatch_list(struct rq_list *rqs, bool from_sched)
 		spin_unlock(&this_hctx->lock);
 		blk_mq_run_hw_queue(this_hctx, from_sched);
 	} else if (this_hctx->queue->elevator) {
-		this_hctx->queue->elevator->type->ops.insert_requests(this_hctx,
-				&list, 0);
-		blk_mq_run_hw_queue(this_hctx, from_sched);
+		if (!this_hctx->dispatch_busy && !from_sched)
+			blk_mq_run_dispatch_ops(this_hctx->queue,
+				blk_mq_try_issue_list_directly(this_hctx, &list));
+		if (!list_empty(&list)) {
+			this_hctx->queue->elevator->type->ops.insert_requests(
+					this_hctx, &list, 0);
+			blk_mq_run_hw_queue(this_hctx, from_sched);
+		}
 	} else {
 		blk_mq_insert_requests(this_hctx, this_ctx, &list, from_sched);
 	}
@@ -2984,6 +2998,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 static void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 		struct list_head *list)
 {
+	struct elevator_queue *e = hctx->queue->elevator;
 	int queued = 0;
 	blk_status_t ret = BLK_STS_OK;
 
@@ -2991,6 +3006,14 @@ static void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 		struct request *rq = list_first_entry(list, struct request,
 				queuelist);
 
+		/* Scheduler requests need approval and dispatch accounting. */
+		if (e && (READ_ONCE(hctx->dispatch_busy) ||
+			  blk_mq_hctx_stopped(hctx) ||
+			  blk_queue_quiesced(hctx->queue) ||
+			  !e->type->ops.skip_request ||
+			  !e->type->ops.skip_request(rq)))
+			break;
+
 		list_del_init(&rq->queuelist);
 		ret = blk_mq_request_issue_directly(rq, list_empty(list));
 		switch (ret) {
@@ -3010,7 +3033,7 @@ static void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 	}
 
 out:
-	if (ret != BLK_STS_OK)
+	if (ret != BLK_STS_OK || !list_empty(list))
 		blk_mq_commit_rqs(hctx, queued, false);
 }
 
@@ -3218,8 +3241,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	}
 
 	hctx = rq->mq_hctx;
-	if ((rq->rq_flags & RQF_USE_SCHED) ||
-	    (hctx->dispatch_busy && (q->nr_hw_queues == 1 || !is_sync))) {
+	if (hctx->dispatch_busy && (q->nr_hw_queues == 1 || !is_sync)) {
 		blk_mq_insert_request(rq, 0);
 		blk_mq_run_hw_queue(hctx, true);
 	} else {
diff --git a/block/elevator.h b/block/elevator.h
index 3eb32516be0b..871d166eaf25 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -74,6 +74,7 @@ struct elevator_mq_ops {
 	void (*insert_requests)(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 			blk_insert_t flags);
 	struct request *(*dispatch_request)(struct blk_mq_hw_ctx *);
+	bool (*skip_request)(struct request *rq);
 	bool (*has_work)(struct blk_mq_hw_ctx *);
 	void (*completed_request)(struct request *, u64);
 	void (*requeue_request)(struct request *);
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index e5db1ee097c3..c4cc482000f0 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -99,6 +99,7 @@ struct deadline_data {
 	int writes_starved;
 	int front_merges;
 	int prio_aging_expire;
+	bool dispatch_direct;
 
 	spinlock_t lock;
 };
@@ -310,8 +311,11 @@ static struct request *dd_start_request(struct deadline_data *dd,
 	enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
 
 	dd->per_prio[prio].latest_pos[data_dir] = blk_rq_pos(rq);
-	dd->per_prio[prio].stats.dispatched++;
-	rq->rq_flags |= RQF_STARTED;
+	/* Count each request once, including direct dispatch followed by requeue. */
+	if (!(rq->rq_flags & RQF_STARTED)) {
+		dd->per_prio[prio].stats.dispatched++;
+		rq->rq_flags |= RQF_STARTED;
+	}
 	return rq;
 }
 
@@ -550,6 +554,7 @@ static int dd_init_sched(struct request_queue *q, struct elevator_queue *eq)
 	dd->last_dir = DD_WRITE;
 	dd->fifo_batch = fifo_batch;
 	dd->prio_aging_expire = prio_aging_expire;
+	dd->dispatch_direct = true;
 	spin_lock_init(&dd->lock);
 
 	/* We dispatch from request queue wide instead of hw queue */
@@ -728,6 +733,29 @@ static bool dd_has_work(struct blk_mq_hw_ctx *hctx)
 	return false;
 }
 
+/*
+ * When blk-mq finds the hctx uncongested, let new requests skip the sort tree,
+ * FIFO and merge hash
+ */
+static bool dd_skip_request(struct request *rq)
+{
+	struct deadline_data *dd = rq->q->elevator->elevator_data;
+	const enum dd_data_dir data_dir = rq_data_dir(rq);
+	const enum dd_prio prio = ioprio_class_to_prio[dd_rq_ioclass(rq)];
+	struct dd_per_prio *per_prio = &dd->per_prio[prio];
+
+	if (!READ_ONCE(dd->dispatch_direct) || rq->elv.priv[0] ||
+	    READ_ONCE(rq->mq_hctx->dispatch_busy))
+		return false;
+
+	spin_lock(&dd->lock);
+	per_prio->stats.inserted++;
+	rq->elv.priv[0] = per_prio;
+	dd_start_request(dd, data_dir, rq);
+	spin_unlock(&dd->lock);
+	return true;
+}
+
 /*
  * sysfs parts below
  */
@@ -745,6 +773,7 @@ SHOW_JIFFIES(deadline_prio_aging_expire_show, dd->prio_aging_expire);
 SHOW_INT(deadline_writes_starved_show, dd->writes_starved);
 SHOW_INT(deadline_front_merges_show, dd->front_merges);
 SHOW_INT(deadline_fifo_batch_show, dd->fifo_batch);
+SHOW_INT(deadline_dispatch_direct_show, READ_ONCE(dd->dispatch_direct));
 #undef SHOW_INT
 #undef SHOW_JIFFIES
 
@@ -778,6 +807,21 @@ STORE_INT(deadline_fifo_batch_store, &dd->fifo_batch, 0, INT_MAX);
 #undef STORE_INT
 #undef STORE_JIFFIES
 
+static ssize_t deadline_dispatch_direct_store(struct elevator_queue *e,
+					     const char *page, size_t count)
+{
+	struct deadline_data *dd = e->elevator_data;
+	bool enabled;
+	int ret;
+
+	ret = kstrtobool(page, &enabled);
+	if (ret)
+		return ret;
+
+	WRITE_ONCE(dd->dispatch_direct, enabled);
+	return count;
+}
+
 #define DD_ATTR(name) \
 	__ATTR(name, 0644, deadline_##name##_show, deadline_##name##_store)
 
@@ -788,6 +832,7 @@ static const struct elv_fs_entry deadline_attrs[] = {
 	DD_ATTR(front_merges),
 	DD_ATTR(fifo_batch),
 	DD_ATTR(prio_aging_expire),
+	DD_ATTR(dispatch_direct),
 	__ATTR_NULL
 };
 
@@ -989,6 +1034,7 @@ static struct elevator_type mq_deadline = {
 		.limit_depth		= dd_limit_depth,
 		.insert_requests	= dd_insert_requests,
 		.dispatch_request	= dd_dispatch_request,
+		.skip_request		= dd_skip_request,
 		.prepare_request	= dd_prepare_request,
 		.finish_request		= dd_finish_request,
 		.next_request		= elv_rb_latter_request,
-- 
2.54.0 (Apple Git-157)

