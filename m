Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C3D2D0639;
	Thu,  9 Oct 2025 07:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996400; cv=none; b=EUwao0nECm4rCG238/qspt9FwxWzPoCnrrX/Nbg/M4QUgdgPxlHrGoHNJebcUWMkBbi22xnzCCe3pkqZnkdi/896xs/2QtW7zsyz36T3+H55st2LPVYgM3n5odFGl5G7FDEb0/f3BeRgdAmNRqIHJ4kmHcK5/KHHEFMRWqiIWpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996400; c=relaxed/simple;
	bh=edBtZcttbU5t4YiXkGqgsqzAbSZiqAaGnMWydZ4ZTPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W7/sp9orEDXHXBArFMllUoPfqVIZlWe3iXx7fZmbL3QrMB+dFrZYwkPJ0lUGI8Ij5pxUR5eo2mR5Bjxr9oCI4uz3IvRUlnvPyaxMLkl3eUxUDobuyFYRFKeKmWze6Cj49V1yG1hDzNq+FwoXgTq/h08STS1jhYl5c56Vj5pd6o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cj2Cz5J33zKHMh1;
	Thu,  9 Oct 2025 15:52:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4789A1A1518;
	Thu,  9 Oct 2025 15:53:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.159.234])
	by APP4 (Coremail) with SMTP id gCh0CgA3+mHqaedo7Fo7CQ--.38248S9;
	Thu, 09 Oct 2025 15:53:16 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	bvanassche@acm.org,
	ming.lei@redhat.com,
	nilay@linux.ibm.com,
	jmoyer@redhat.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [patch v2 5/7] mq-deadline: covert to use request_queue->async_depth
Date: Thu,  9 Oct 2025 15:46:32 +0800
Message-Id: <20251009074634.527661-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20251009074634.527661-1-yukuai1@huaweicloud.com>
References: <20251009074634.527661-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3+mHqaedo7Fo7CQ--.38248S9
X-Coremail-Antispam: 1UD129KBjvJXoW3JF1UJw47CF18Kr4ruFyDKFg_yoW7ZF4UpF
	W3Janrtr1Utr48urW8Jw43Zr18Ww4fC3sxKFyrK3yfGFnYvFsrJF1FyF1fZFZ3JrZ3Cw47
	Kr1ktas5J34Ut3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUma14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
	vfC2KfnxnUUI43ZEXa7VUbPC7UUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

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
2.39.2

