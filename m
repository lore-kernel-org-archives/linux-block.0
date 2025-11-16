Received: from sg-1-19.ptr.blmpb.com (sg-1-19.ptr.blmpb.com [118.26.132.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF529242D87
	for <linux-block@vger.kernel.org>; Sun, 16 Nov 2025 03:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763263273; cv=none; b=A5P5h6OKbms7MqMUwe7MXKyZgzCe3uKRf+KwkLTzdKtpxN2Ug7brqdcX7Huh96FQjHdLEt/Voi/bZ9jd4VICadNa2S8lbqLTCUiVseJODRmVBNZ3ggxYnkD0uybB+tNAjZwWgo7MApAew2JsfZk4FRs00aN02QbJdqRHiJlwDA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763263273; c=relaxed/simple;
	bh=KtPfpcQla/g0eBcfeAGya2GDX9RNo3p9+Jn6/Xzs7PY=;
	h=Content-Type:Subject:Mime-Version:Date:Message-Id:To:Cc:From; b=OitnkMU2gaN+rN1aPuy2U1/U+flFboj7G3PMhH0+MpbUdaelTPEZJ1QzXu8SyESpIkL5bBDW32rGxpYKlFcYGJ3GcEdkw4BOwkGvRP9YMt/BC2+9o2ziY/viOqg4atlJy2QirmgkOxRfp/wg8i5xbO/3uQ6lVYyytMo3Fe4HJBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=LtLkEaPn; arc=none smtp.client-ip=118.26.132.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="LtLkEaPn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1763263263;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=nPAgwxi4ytd3vAGI02kc1nYRIrnOPRiZnXlvemWIyEs=;
 b=LtLkEaPnjwSlXorbElySLI9ijlqWurqbZrpCdqqNVnjX7u2maJnNQHTT1ZSROyzkxEYXsk
 a/EcEDLs3htsZ1ZsDmagfHlxZH1UxYhTtWXPIXIOBQuJbtWrXVWJGpJwfZJAV8hp6jsIiZ
 3yqzRA/73mxvcz30Xm4+HhYZy2Rw6cTkY8w8dTqgGdWMBVJ55O1SnTulmsNe8LACLFeIHP
 vircwVs+61/4DcWv9in/ABs69U5mIzyJRZW+MyzacSeRgXwCJk5YJWT7MxTwgqAuaEew2y
 /oerEqQKbtazJhEPePk0y0idya7mfwv4ufm0o1olHzY7naNaVay0ePuikn9WoA==
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH RESEND v4 5/7] mq-deadline: covert to use request_queue->async_depth
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26919431d+55160a+vger.kernel.org+yukuai@fnnas.com>
Received: from localhost.localdomain ([39.182.0.135]) by smtp.feishu.cn with ESMTPS; Sun, 16 Nov 2025 11:21:01 +0800
Date: Sun, 16 Nov 2025 11:20:39 +0800
Message-Id: <20251116032044.118664-6-yukuai@fnnas.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>
Cc: <yukuai@fnnas.com>, <nilay@linux.ibm.com>, <bvanassche@acm.org>
From: "Yu Kuai" <yukuai@fnnas.com>

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
index 1aef6ce2e78e..37ae75fda8cb 100644
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
