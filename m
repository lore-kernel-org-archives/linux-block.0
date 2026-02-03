Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB05392C57
	for <linux-block@vger.kernel.org>; Tue,  3 Feb 2026 08:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770106811; cv=none; b=iiWmLJasxh8VN85sHKXg0CGf2bRZEJspQxFBpKbkMH1gQ6wBT+O6trrmZ2WPF2pyCTQBvCohdjYQ4FOTMJV9MLHtp/u6k8mzRXwVID6/B6GliNxjsPP51Np/Nn56tKDrGXhr5dNKoN1CE5tIYo/+064vE/4a1sRrRJDSxTBtv6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770106811; c=relaxed/simple;
	bh=U5bfGC/ZzgMtHvLDuDUKUc4xPDvI9pmK2EOIrbpCHPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UOAWxwYwgulUTw0KA6sZfzxxoOkBEXkTg0AL8tvs5autgu48To4X08ap/pUUtuBhHgGMpeNMB9YCUsoMQxUc4p1/BK/NJU2NRZS2dX7F9lJnYtYLR4LCYjC1cVpJRLcOLnMgg9wk4FpVl8YjhsIELfr3LI0QsCprgPhxYqO+7ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6377C19422;
	Tue,  3 Feb 2026 08:20:08 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: yukuai@fnnas.com,
	bvanassche@acm.org,
	hare@suse.de
Subject: [PATCH v7 6/8] mq-deadline: covert to use request_queue->async_depth
Date: Tue,  3 Feb 2026 16:19:47 +0800
Message-ID: <20260203081952.732210-7-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260203081952.732210-1-yukuai@fnnas.com>
References: <20260203081952.732210-1-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In downstream kernel, we test with mq-deadline with many fio workloads, and
we found a performance regression after commit 39823b47bbd4
("block/mq-deadline: Fix the tag reservation code") with following test:

[global]
rw=randread
direct=1
ramp_time=1
ioengine=libaio
iodepth=1024
numjobs=24
bs=1024k
group_reporting=1
runtime=60

[job1]
filename=/dev/sda

Root cause is that mq-deadline now support configuring async_depth,
although the default value is nr_request, however the minimal value is
1, hence min_shallow_depth is set to 1, causing wake_batch to be 1. For
consequence, sbitmap_queue will be waken up after each IO instead of
8 IO.

In this test case, sda is HDD and max_sectors is 128k, hence each
submitted 1M io will be splited into 8 sequential 128k requests, however
due to there are 24 jobs and total tags are exhausted, the 8 requests are
unlikely to be dispatched sequentially, and changing wake_batch to 1
will make this much worse, accounting blktrace D stage, the percentage
of sequential io is decreased from 8% to 0.8%.

Fix this problem by converting to request_queue->async_depth, where
min_shallow_depth is set each time async_depth is updated.

Noted elevator attribute async_depth is now removed, queue attribute
with the same name is used instead.

Fixes: 39823b47bbd4 ("block/mq-deadline: Fix the tag reservation code")
Signed-off-by: Yu Kuai <yukuai@fnnas.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 39 +++++----------------------------------
 1 file changed, 5 insertions(+), 34 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 29d00221fbea..95917a88976f 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -98,7 +98,6 @@ struct deadline_data {
 	int fifo_batch;
 	int writes_starved;
 	int front_merges;
-	u32 async_depth;
 	int prio_aging_expire;
 
 	spinlock_t lock;
@@ -486,32 +485,16 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	return rq;
 }
 
-/*
- * Called by __blk_mq_alloc_request(). The shallow_depth value set by this
- * function is used by __blk_mq_get_tag().
- */
 static void dd_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
 {
-	struct deadline_data *dd = data->q->elevator->elevator_data;
-
-	/* Do not throttle synchronous reads. */
-	if (blk_mq_is_sync_read(opf))
-		return;
-
-	/*
-	 * Throttle asynchronous requests and writes such that these requests
-	 * do not block the allocation of synchronous requests.
-	 */
-	data->shallow_depth = dd->async_depth;
+	if (!blk_mq_is_sync_read(opf))
+		data->shallow_depth = data->q->async_depth;
 }
 
-/* Called by blk_mq_update_nr_requests(). */
+/* Called by blk_mq_init_sched() and blk_mq_update_nr_requests(). */
 static void dd_depth_updated(struct request_queue *q)
 {
-	struct deadline_data *dd = q->elevator->elevator_data;
-
-	dd->async_depth = q->nr_requests;
-	blk_mq_set_min_shallow_depth(q, 1);
+	blk_mq_set_min_shallow_depth(q, q->async_depth);
 }
 
 static void dd_exit_sched(struct elevator_queue *e)
@@ -576,6 +559,7 @@ static int dd_init_sched(struct request_queue *q, struct elevator_queue *eq)
 	blk_queue_flag_set(QUEUE_FLAG_SQ_SCHED, q);
 
 	q->elevator = eq;
+	q->async_depth = q->nr_requests;
 	dd_depth_updated(q);
 	return 0;
 }
@@ -763,7 +747,6 @@ SHOW_JIFFIES(deadline_write_expire_show, dd->fifo_expire[DD_WRITE]);
 SHOW_JIFFIES(deadline_prio_aging_expire_show, dd->prio_aging_expire);
 SHOW_INT(deadline_writes_starved_show, dd->writes_starved);
 SHOW_INT(deadline_front_merges_show, dd->front_merges);
-SHOW_INT(deadline_async_depth_show, dd->async_depth);
 SHOW_INT(deadline_fifo_batch_show, dd->fifo_batch);
 #undef SHOW_INT
 #undef SHOW_JIFFIES
@@ -793,7 +776,6 @@ STORE_JIFFIES(deadline_write_expire_store, &dd->fifo_expire[DD_WRITE], 0, INT_MA
 STORE_JIFFIES(deadline_prio_aging_expire_store, &dd->prio_aging_expire, 0, INT_MAX);
 STORE_INT(deadline_writes_starved_store, &dd->writes_starved, INT_MIN, INT_MAX);
 STORE_INT(deadline_front_merges_store, &dd->front_merges, 0, 1);
-STORE_INT(deadline_async_depth_store, &dd->async_depth, 1, INT_MAX);
 STORE_INT(deadline_fifo_batch_store, &dd->fifo_batch, 0, INT_MAX);
 #undef STORE_FUNCTION
 #undef STORE_INT
@@ -807,7 +789,6 @@ static const struct elv_fs_entry deadline_attrs[] = {
 	DD_ATTR(write_expire),
 	DD_ATTR(writes_starved),
 	DD_ATTR(front_merges),
-	DD_ATTR(async_depth),
 	DD_ATTR(fifo_batch),
 	DD_ATTR(prio_aging_expire),
 	__ATTR_NULL
@@ -894,15 +875,6 @@ static int deadline_starved_show(void *data, struct seq_file *m)
 	return 0;
 }
 
-static int dd_async_depth_show(void *data, struct seq_file *m)
-{
-	struct request_queue *q = data;
-	struct deadline_data *dd = q->elevator->elevator_data;
-
-	seq_printf(m, "%u\n", dd->async_depth);
-	return 0;
-}
-
 static int dd_queued_show(void *data, struct seq_file *m)
 {
 	struct request_queue *q = data;
@@ -1002,7 +974,6 @@ static const struct blk_mq_debugfs_attr deadline_queue_debugfs_attrs[] = {
 	DEADLINE_NEXT_RQ_ATTR(write2),
 	{"batching", 0400, deadline_batching_show},
 	{"starved", 0400, deadline_starved_show},
-	{"async_depth", 0400, dd_async_depth_show},
 	{"dispatch", 0400, .seq_ops = &deadline_dispatch_seq_ops},
 	{"owned_by_driver", 0400, dd_owned_by_driver_show},
 	{"queued", 0400, dd_queued_show},
-- 
2.51.0

