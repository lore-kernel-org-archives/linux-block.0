Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0361EE7D5;
	Sat, 21 Dec 2024 09:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734774068; cv=none; b=hchZueAh74E++LJCOjROJN7TxcoLykE+8wJvErSPgst0aVGQR5Fs7Lmi+qRULWos/hgV8lPVXhu54eH1lpJM7GdPjD9GXvrySaU5Sbzxh53hmTm1wiYvDNdoF0/OSNIg+ohX5WeCUu9niccnESkUq2qzZBBeFAnvNSwHS82OgK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734774068; c=relaxed/simple;
	bh=auDQOmzN/8glV/hnqw71Pbcb0GXidQj4If4WC3ey1Jg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fs95eLv36EhiR5nY43YjhJfIHyz6OILWmmAWJfW5owWdsGUJIe2zt4aFHNEHJxoCQsvrwA0nlzo3KM8afbxoXf2bC/QG9K3gTg6kjW0uV+1kGU4DMoc+66ckX5wV5qFT6NPh2VDGIRmnGgt66vCFqjm1ngMfK6lr1/v9IaABAR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YFfRH5lrWz4f3jcj;
	Sat, 21 Dec 2024 17:40:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 678BC1A0194;
	Sat, 21 Dec 2024 17:41:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBHIoYqjWZnocfeFA--.21383S10;
	Sat, 21 Dec 2024 17:41:03 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	akpm@linux-foundation.org,
	ming.lei@redhat.com,
	yang.yang@vivo.com,
	yukuai3@huawei.com,
	bvanassche@acm.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH RFC v3 6/7] block/mq-deadline: switch to use queue async_depth
Date: Sat, 21 Dec 2024 17:37:09 +0800
Message-Id: <20241221093710.926309-7-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241221093710.926309-1-yukuai1@huaweicloud.com>
References: <20241221093710.926309-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHIoYqjWZnocfeFA--.21383S10
X-Coremail-Antispam: 1UD129KBjvJXoW3Ww15Gr17tF1DKrWUAr4kXrb_yoW7AFy5pF
	W5tanrtr1UtF4j9FW8AwsxZr1xWw4xC3srKa4rK3yfKFyqyFsrJF1rtFyfZr93JrZ3Cw47
	Kr4ktas5Jr47t3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUOyIUUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

min_shallow_depth must be less or equal to any shallow_depth value, and
it's 1 currently, and this will change default wake_batch to 1, causing
performance degradation for fast disk with high concurrency.

Fix the problem by using queue async_depth, so that min_shallow_depth
can be updated if user set new value, hence it's not necessary to use 1
anymore.

Fixes: 39823b47bbd4 ("block/mq-deadline: Fix the tag reservation code")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/mq-deadline.c | 43 ++++++++++---------------------------------
 1 file changed, 10 insertions(+), 33 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 853985bd13d4..8d19685cce3e 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -98,7 +98,6 @@ struct deadline_data {
 	int fifo_batch;
 	int writes_starved;
 	int front_merges;
-	u32 async_depth;
 	int prio_aging_expire;
 
 	spinlock_t lock;
@@ -493,8 +492,6 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
  */
 static void dd_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
 {
-	struct deadline_data *dd = data->q->elevator->elevator_data;
-
 	/* Do not throttle synchronous reads. */
 	if (op_is_sync(opf) && !op_is_write(opf))
 		return;
@@ -503,25 +500,19 @@ static void dd_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
 	 * Throttle asynchronous requests and writes such that these requests
 	 * do not block the allocation of synchronous requests.
 	 */
-	data->shallow_depth = dd->async_depth;
+	data->shallow_depth = data->q->async_depth;
 }
 
-/* Called by blk_mq_update_nr_requests(). */
-static void dd_depth_updated(struct blk_mq_hw_ctx *hctx)
+static int dd_async_depth_updated(struct request_queue *q,
+				  unsigned int async_depth)
 {
-	struct request_queue *q = hctx->queue;
-	struct deadline_data *dd = q->elevator->elevator_data;
-	struct blk_mq_tags *tags = hctx->sched_tags;
-
-	dd->async_depth = q->nr_requests;
+	struct blk_mq_hw_ctx *hctx;
+	unsigned long i;
 
-	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, 1);
-}
-
-/* Called by blk_mq_init_hctx() and blk_mq_init_sched(). */
-static int dd_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
-{
-	dd_depth_updated(hctx);
+	q->async_depth = async_depth;
+	queue_for_each_hw_ctx(q, hctx, i)
+		sbitmap_queue_min_shallow_depth(&hctx->sched_tags->bitmap_tags,
+					async_depth ? async_depth : UINT_MAX);
 	return 0;
 }
 
@@ -781,7 +772,6 @@ SHOW_JIFFIES(deadline_write_expire_show, dd->fifo_expire[DD_WRITE]);
 SHOW_JIFFIES(deadline_prio_aging_expire_show, dd->prio_aging_expire);
 SHOW_INT(deadline_writes_starved_show, dd->writes_starved);
 SHOW_INT(deadline_front_merges_show, dd->front_merges);
-SHOW_INT(deadline_async_depth_show, dd->async_depth);
 SHOW_INT(deadline_fifo_batch_show, dd->fifo_batch);
 #undef SHOW_INT
 #undef SHOW_JIFFIES
@@ -811,7 +801,6 @@ STORE_JIFFIES(deadline_write_expire_store, &dd->fifo_expire[DD_WRITE], 0, INT_MA
 STORE_JIFFIES(deadline_prio_aging_expire_store, &dd->prio_aging_expire, 0, INT_MAX);
 STORE_INT(deadline_writes_starved_store, &dd->writes_starved, INT_MIN, INT_MAX);
 STORE_INT(deadline_front_merges_store, &dd->front_merges, 0, 1);
-STORE_INT(deadline_async_depth_store, &dd->async_depth, 1, INT_MAX);
 STORE_INT(deadline_fifo_batch_store, &dd->fifo_batch, 0, INT_MAX);
 #undef STORE_FUNCTION
 #undef STORE_INT
@@ -825,7 +814,6 @@ static struct elv_fs_entry deadline_attrs[] = {
 	DD_ATTR(write_expire),
 	DD_ATTR(writes_starved),
 	DD_ATTR(front_merges),
-	DD_ATTR(async_depth),
 	DD_ATTR(fifo_batch),
 	DD_ATTR(prio_aging_expire),
 	__ATTR_NULL
@@ -912,15 +900,6 @@ static int deadline_starved_show(void *data, struct seq_file *m)
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
@@ -1030,7 +1009,6 @@ static const struct blk_mq_debugfs_attr deadline_queue_debugfs_attrs[] = {
 	DEADLINE_NEXT_RQ_ATTR(write2),
 	{"batching", 0400, deadline_batching_show},
 	{"starved", 0400, deadline_starved_show},
-	{"async_depth", 0400, dd_async_depth_show},
 	{"dispatch0", 0400, .seq_ops = &deadline_dispatch0_seq_ops},
 	{"dispatch1", 0400, .seq_ops = &deadline_dispatch1_seq_ops},
 	{"dispatch2", 0400, .seq_ops = &deadline_dispatch2_seq_ops},
@@ -1043,7 +1021,6 @@ static const struct blk_mq_debugfs_attr deadline_queue_debugfs_attrs[] = {
 
 static struct elevator_type mq_deadline = {
 	.ops = {
-		.depth_updated		= dd_depth_updated,
 		.limit_depth		= dd_limit_depth,
 		.insert_requests	= dd_insert_requests,
 		.dispatch_request	= dd_dispatch_request,
@@ -1058,7 +1035,7 @@ static struct elevator_type mq_deadline = {
 		.has_work		= dd_has_work,
 		.init_sched		= dd_init_sched,
 		.exit_sched		= dd_exit_sched,
-		.init_hctx		= dd_init_hctx,
+		.async_depth_updated	= dd_async_depth_updated,
 	},
 
 #ifdef CONFIG_BLK_DEBUG_FS
-- 
2.39.2

