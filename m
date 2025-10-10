Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FE7258EE8;
	Fri, 10 Oct 2025 02:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760063317; cv=none; b=dppcpDCIYdcmVDNfa4bm29q1ZusYOAobHKDuu+xt7P6wxqIY1VKQy5pV2H5dRpNlwr5K/Ur0Tn2aVzV1rFE/DUNzuJf2L+lYCJ7YN/BheIphOdaJqLjjmKNI2EdnSF0U/lnZ/BFusH5/ilZLDTMQoP9nKCA2hQh9R7bajGm6BrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760063317; c=relaxed/simple;
	bh=/mAxT00KI2ghSwm4SaZ4d2nka0Re3OeQKZg+SA5dhJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hLfYhASv6PH1/suTYVj1pXGrq/R3aiCnw+CJcNw0sqG+9X+nkUUVAzID0ahANeFh7Lx4yyf1wXLUGLNKCZP7bGEDqCk8/5TRy3xDwoOZtT8Ip4J6CUIiSVEwO3Uy/LlKDISRnzedfcF+/G8rAfC6ZYuIe4J2vQDuB0S6uAOYPCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+ffXItH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+ffXItH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B0AC4CEE7;
	Fri, 10 Oct 2025 02:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760063316;
	bh=/mAxT00KI2ghSwm4SaZ4d2nka0Re3OeQKZg+SA5dhJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p+ffXItHEPmhxVkHDv4E4DyHyvygf7n+60bvAwHJmTU1CKvQRfusVuJu1gRtcgddB
	 VqV9BaVgHa7c6wNd0iR2MxPwYKvVUyc5HIg/SXPmdPsATHRRAwbbRWGgBWnSPm20jZ
	 utFpW4r9Wf6oNQ7mlcC9IgF+OB3p7nUUVIss1Gn62itUmjQybxqJwmQmMDwF7EMgyJ
	 FhoHECZBxgPXRkZr4dZidwQj850LSzbXw5q3r6Pj0RVpapDDlTZjstgKgPiTQojr4G
	 vofuIspYp3b4UkezgsafXpZ7BK+wQkMLXYplmZvzwNjUsvMV2XHUfis5DUWqkj4qur
	 vevNxWmCelNWg==
From: Yu Kuai <yukuai@kernel.org>
To: axboe@kernel.dk,
	bvanassche@acm.org,
	nilay@linux.ibm.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH v3 5/7] mq-deadline: covert to use request_queue->async_depth
Date: Fri, 10 Oct 2025 10:28:07 +0800
Message-ID: <20251010022812.2985286-6-yukuai@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010022812.2985286-1-yukuai@kernel.org>
References: <20251010022812.2985286-1-yukuai@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yu Kuai <yukuai3@huawei.com>

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
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 39 +++++----------------------------------
 1 file changed, 5 insertions(+), 34 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 592dd853f6e5..87c7b7378397 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -98,7 +98,6 @@ struct deadline_data {
 	int fifo_batch;
 	int writes_starved;
 	int front_merges;
-	u32 async_depth;
 	int prio_aging_expire;
 
 	spinlock_t lock;
@@ -483,32 +482,16 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
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
-	if (blk_mq_sched_sync_request(opf))
-		return;
-
-	/*
-	 * Throttle asynchronous requests and writes such that these requests
-	 * do not block the allocation of synchronous requests.
-	 */
-	data->shallow_depth = dd->async_depth;
+	if (!blk_mq_sched_sync_request(opf))
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
@@ -573,6 +556,7 @@ static int dd_init_sched(struct request_queue *q, struct elevator_queue *eq)
 	blk_queue_flag_set(QUEUE_FLAG_SQ_SCHED, q);
 
 	q->elevator = eq;
+	q->async_depth = q->nr_requests;
 	dd_depth_updated(q);
 	return 0;
 }
@@ -758,7 +742,6 @@ SHOW_JIFFIES(deadline_write_expire_show, dd->fifo_expire[DD_WRITE]);
 SHOW_JIFFIES(deadline_prio_aging_expire_show, dd->prio_aging_expire);
 SHOW_INT(deadline_writes_starved_show, dd->writes_starved);
 SHOW_INT(deadline_front_merges_show, dd->front_merges);
-SHOW_INT(deadline_async_depth_show, dd->async_depth);
 SHOW_INT(deadline_fifo_batch_show, dd->fifo_batch);
 #undef SHOW_INT
 #undef SHOW_JIFFIES
@@ -788,7 +771,6 @@ STORE_JIFFIES(deadline_write_expire_store, &dd->fifo_expire[DD_WRITE], 0, INT_MA
 STORE_JIFFIES(deadline_prio_aging_expire_store, &dd->prio_aging_expire, 0, INT_MAX);
 STORE_INT(deadline_writes_starved_store, &dd->writes_starved, INT_MIN, INT_MAX);
 STORE_INT(deadline_front_merges_store, &dd->front_merges, 0, 1);
-STORE_INT(deadline_async_depth_store, &dd->async_depth, 1, INT_MAX);
 STORE_INT(deadline_fifo_batch_store, &dd->fifo_batch, 0, INT_MAX);
 #undef STORE_FUNCTION
 #undef STORE_INT
@@ -802,7 +784,6 @@ static const struct elv_fs_entry deadline_attrs[] = {
 	DD_ATTR(write_expire),
 	DD_ATTR(writes_starved),
 	DD_ATTR(front_merges),
-	DD_ATTR(async_depth),
 	DD_ATTR(fifo_batch),
 	DD_ATTR(prio_aging_expire),
 	__ATTR_NULL
@@ -889,15 +870,6 @@ static int deadline_starved_show(void *data, struct seq_file *m)
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
@@ -1007,7 +979,6 @@ static const struct blk_mq_debugfs_attr deadline_queue_debugfs_attrs[] = {
 	DEADLINE_NEXT_RQ_ATTR(write2),
 	{"batching", 0400, deadline_batching_show},
 	{"starved", 0400, deadline_starved_show},
-	{"async_depth", 0400, dd_async_depth_show},
 	{"dispatch0", 0400, .seq_ops = &deadline_dispatch0_seq_ops},
 	{"dispatch1", 0400, .seq_ops = &deadline_dispatch1_seq_ops},
 	{"dispatch2", 0400, .seq_ops = &deadline_dispatch2_seq_ops},
-- 
2.51.0

