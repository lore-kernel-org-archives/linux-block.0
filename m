Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1420D238C0D;
	Thu, 14 Aug 2025 03:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755143003; cv=none; b=jgplzgqwceWqLsTMWkfH1t/Xj0Sa2APlZcsTvw8FrZzYGJshfRFDTODDVCSblCnLYqYZWUFq6ha9dZhYa1XanZ4QcGj2Dxp8gHyudsF2UYaepU0EYhEIRE7UwwGuMtCAZyvS61RK6HN4pRzdQ06ekAzK3AWyHo0Jw5yoQxMqq90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755143003; c=relaxed/simple;
	bh=cC14FkZGZjFZZFqnFpTKNL9aUyjZkBSlQU3VZfQUWqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lDeg5eMLJsS7IUngFKI5lwoQO1KbTIdXILLxdVSY9QTKfP1mpMDCFS8l2xBVATPlINU7xUl1yGBk3tpgcJNtfCuR5lY80agUJ4LgDe9uiEqqkWW6XKrfbiTVlQ27EQ/VR1b6RLiQGnv77EO/PksZVbr6a1/kKphj8jwMiXuJZtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c2WKw0M5SzYQtwj;
	Thu, 14 Aug 2025 11:43:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A3D8A1A1672;
	Thu, 14 Aug 2025 11:43:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCnIxRKW51ogs93Dg--.15627S17;
	Thu, 14 Aug 2025 11:43:14 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	yukuai3@huawei.com,
	bvanassche@acm.org,
	nilay@linux.ibm.com,
	hare@suse.de,
	ming.lei@redhat.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH 13/16] mq-deadline: covert to use request_queue->async_depth
Date: Thu, 14 Aug 2025 11:35:19 +0800
Message-Id: <20250814033522.770575-14-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250814033522.770575-1-yukuai1@huaweicloud.com>
References: <20250814033522.770575-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnIxRKW51ogs93Dg--.15627S17
X-Coremail-Antispam: 1UD129KBjvJXoW3JF1UJw47CF15JF1fCr48JFb_yoW7uFWUpF
	W3Janrtr1UtF4UurW8Aw43Zr1xWw4fC3sxKFyrKw4fGFn0yFsxtFyFyF1fZF93JrWfCw47
	Kr1ktas5X347taDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0JUQFxUUUUUU=
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

Fixes: 39823b47bbd4 ("block/mq-deadline: Fix the tag reservation code")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/mq-deadline.c | 42 +++---------------------------------------
 1 file changed, 3 insertions(+), 39 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 1825173d82a6..970e1541b7b7 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -98,7 +98,6 @@ struct deadline_data {
 	int fifo_batch;
 	int writes_starved;
 	int front_merges;
-	u32 async_depth;
 	int prio_aging_expire;
 
 	spinlock_t lock;
@@ -487,32 +486,10 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	return rq;
 }
 
-/*
- * Called by __blk_mq_alloc_request(). The shallow_depth value set by this
- * function is used by __blk_mq_get_tag().
- */
-static void dd_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
-{
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
-}
-
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
@@ -577,6 +554,7 @@ static int dd_init_sched(struct request_queue *q, struct elevator_queue *eq)
 	blk_queue_flag_set(QUEUE_FLAG_SQ_SCHED, q);
 
 	q->elevator = eq;
+	q->async_depth = q->nr_requests;
 	return 0;
 }
 
@@ -761,7 +739,6 @@ SHOW_JIFFIES(deadline_write_expire_show, dd->fifo_expire[DD_WRITE]);
 SHOW_JIFFIES(deadline_prio_aging_expire_show, dd->prio_aging_expire);
 SHOW_INT(deadline_writes_starved_show, dd->writes_starved);
 SHOW_INT(deadline_front_merges_show, dd->front_merges);
-SHOW_INT(deadline_async_depth_show, dd->async_depth);
 SHOW_INT(deadline_fifo_batch_show, dd->fifo_batch);
 #undef SHOW_INT
 #undef SHOW_JIFFIES
@@ -791,7 +768,6 @@ STORE_JIFFIES(deadline_write_expire_store, &dd->fifo_expire[DD_WRITE], 0, INT_MA
 STORE_JIFFIES(deadline_prio_aging_expire_store, &dd->prio_aging_expire, 0, INT_MAX);
 STORE_INT(deadline_writes_starved_store, &dd->writes_starved, INT_MIN, INT_MAX);
 STORE_INT(deadline_front_merges_store, &dd->front_merges, 0, 1);
-STORE_INT(deadline_async_depth_store, &dd->async_depth, 1, INT_MAX);
 STORE_INT(deadline_fifo_batch_store, &dd->fifo_batch, 0, INT_MAX);
 #undef STORE_FUNCTION
 #undef STORE_INT
@@ -805,7 +781,6 @@ static const struct elv_fs_entry deadline_attrs[] = {
 	DD_ATTR(write_expire),
 	DD_ATTR(writes_starved),
 	DD_ATTR(front_merges),
-	DD_ATTR(async_depth),
 	DD_ATTR(fifo_batch),
 	DD_ATTR(prio_aging_expire),
 	__ATTR_NULL
@@ -892,15 +867,6 @@ static int deadline_starved_show(void *data, struct seq_file *m)
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
@@ -1010,7 +976,6 @@ static const struct blk_mq_debugfs_attr deadline_queue_debugfs_attrs[] = {
 	DEADLINE_NEXT_RQ_ATTR(write2),
 	{"batching", 0400, deadline_batching_show},
 	{"starved", 0400, deadline_starved_show},
-	{"async_depth", 0400, dd_async_depth_show},
 	{"dispatch0", 0400, .seq_ops = &deadline_dispatch0_seq_ops},
 	{"dispatch1", 0400, .seq_ops = &deadline_dispatch1_seq_ops},
 	{"dispatch2", 0400, .seq_ops = &deadline_dispatch2_seq_ops},
@@ -1024,7 +989,6 @@ static const struct blk_mq_debugfs_attr deadline_queue_debugfs_attrs[] = {
 static struct elevator_type mq_deadline = {
 	.ops = {
 		.depth_updated		= dd_depth_updated,
-		.limit_depth		= dd_limit_depth,
 		.insert_requests	= dd_insert_requests,
 		.dispatch_request	= dd_dispatch_request,
 		.prepare_request	= dd_prepare_request,
-- 
2.39.2

