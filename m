Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461A822DFA5;
	Tue, 30 Sep 2025 07:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759216915; cv=none; b=ZAdo51fLYIaDYaShF13jfY8GgdilhhYsgEifqngvwS6huvoGtgWFN47GugEDYA6w54t7WDx1WmEFY4GqnRVkgqqgOS6rSVZhhY/bDOyhaP9dqd76uwG2NmplrxFSA26vBFWbfJcIi3hszq9Vjb/MRkEJFlppvzxRMm14hr4LSRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759216915; c=relaxed/simple;
	bh=A8Kl5rwmz/RnKo2UqZS6CiPlWYdsidfm2cbfbrP9a0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pZEz0cp4u8w3oBL2+vFOipSQmp7UKRiz02AYAlNwXdAAsrx/HYkcLwTr/ond/wvxfAA4AJZCZOStuZNlo9mxm597feSyg51BnYCk9sWeg5ZXrMQrYGqnew9b1cL0paxJvNUxs8pZOb7sBkHy+TqWU6sHFskAcUZy6eoLjljEYE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cbTy61VMXzYQttC;
	Tue, 30 Sep 2025 15:21:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6AACB1A1AEE;
	Tue, 30 Sep 2025 15:21:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDHjGQLhdtoC9s4BQ--.44849S7;
	Tue, 30 Sep 2025 15:21:51 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	bvanassche@acm.org,
	ming.lei@redhat.com,
	nilay@linux.ibm.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH 3/7] blk-mq: add a new queue sysfs attribute async_depth
Date: Tue, 30 Sep 2025 15:11:07 +0800
Message-Id: <20250930071111.1218494-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250930071111.1218494-1-yukuai1@huaweicloud.com>
References: <20250930071111.1218494-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHjGQLhdtoC9s4BQ--.44849S7
X-Coremail-Antispam: 1UD129KBjvJXoWxZF15uw45ZF1kZrykAw4ruFg_yoWrKw17pF
	s8Ja1Ykw10qF4xWa4fJw13Zw13J3sagr13GFWay34akry2qFsrXF1rGFyUXFs2vrZ5AFsr
	Wr4kJa98uFy7X3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUHWlkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Add a new field async_depth to request_queue and related APIs, this is
currently not used, following patches will convert elevators to use
this instead of internal async_depth.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-core.c       |  1 +
 block/blk-mq.c         |  4 ++++
 block/blk-sysfs.c      | 47 ++++++++++++++++++++++++++++++++++++++++++
 block/elevator.c       |  1 +
 include/linux/blkdev.h |  1 +
 5 files changed, 54 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index dd39ff651095..76df70cfc103 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -463,6 +463,7 @@ struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id)
 	fs_reclaim_release(GFP_KERNEL);
 
 	q->nr_requests = BLKDEV_DEFAULT_RQ;
+	q->async_depth = BLKDEV_DEFAULT_RQ;
 
 	return q;
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 09f579414161..260e54fa48f0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -529,6 +529,8 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 			data->rq_flags |= RQF_USE_SCHED;
 			if (ops->limit_depth)
 				ops->limit_depth(data->cmd_flags, data);
+			else if (!blk_mq_sched_sync_request(data->cmd_flags))
+				data->shallow_depth = q->async_depth;
 		}
 	} else {
 		blk_mq_tag_busy(data->hctx);
@@ -4605,6 +4607,7 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	spin_lock_init(&q->requeue_lock);
 
 	q->nr_requests = set->queue_depth;
+	q->async_depth = set->queue_depth;
 
 	blk_mq_init_cpu_queues(q, set->nr_hw_queues);
 	blk_mq_map_swqueue(q);
@@ -4972,6 +4975,7 @@ struct elevator_tags *blk_mq_update_nr_requests(struct request_queue *q,
 	}
 
 	q->nr_requests = nr;
+	q->async_depth = nr;
 	if (q->elevator && q->elevator->type->ops.depth_updated)
 		q->elevator->type->ops.depth_updated(q);
 
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 76c47fe9b8d6..9553cc022c7e 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -127,6 +127,51 @@ queue_requests_store(struct gendisk *disk, const char *page, size_t count)
 	return ret;
 }
 
+static ssize_t queue_async_depth_show(struct gendisk *disk, char *page)
+{
+	ssize_t ret;
+
+	mutex_lock(&disk->queue->elevator_lock);
+	ret = queue_var_show(disk->queue->async_depth, page);
+	mutex_unlock(&disk->queue->elevator_lock);
+	return ret;
+}
+
+static ssize_t
+queue_async_depth_store(struct gendisk *disk, const char *page, size_t count)
+{
+	struct request_queue *q = disk->queue;
+	unsigned int memflags;
+	unsigned long nr;
+	int ret;
+
+	if (!queue_is_mq(q))
+		return -EINVAL;
+
+	ret = queue_var_store(&nr, page, count);
+	if (ret < 0)
+		return ret;
+
+	if (nr == 0)
+		return -EINVAL;
+
+	memflags = blk_mq_freeze_queue(q);
+	mutex_lock(&q->elevator_lock);
+
+	if (q->elevator) {
+		q->async_depth = min(q->nr_requests, nr);
+		if (q->elevator->type->ops.depth_updated)
+			q->elevator->type->ops.depth_updated(q);
+	} else {
+		ret = -EINVAL;
+	}
+
+	mutex_unlock(&q->elevator_lock);
+	blk_mq_unfreeze_queue(q, memflags);
+
+	return ret;
+}
+
 static ssize_t queue_ra_show(struct gendisk *disk, char *page)
 {
 	ssize_t ret;
@@ -542,6 +587,7 @@ static struct queue_sysfs_entry _prefix##_entry = {	\
 }
 
 QUEUE_RW_ENTRY(queue_requests, "nr_requests");
+QUEUE_RW_ENTRY(queue_async_depth, "async_depth");
 QUEUE_RW_ENTRY(queue_ra, "read_ahead_kb");
 QUEUE_LIM_RW_ENTRY(queue_max_sectors, "max_sectors_kb");
 QUEUE_LIM_RO_ENTRY(queue_max_hw_sectors, "max_hw_sectors_kb");
@@ -764,6 +810,7 @@ static struct attribute *blk_mq_queue_attrs[] = {
 	 */
 	&elv_iosched_entry.attr,
 	&queue_requests_entry.attr,
+	&queue_async_depth_entry.attr,
 #ifdef CONFIG_BLK_WBT
 	&queue_wb_lat_entry.attr,
 #endif
diff --git a/block/elevator.c b/block/elevator.c
index e2ebfbf107b3..8f510cb881ba 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -601,6 +601,7 @@ static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
 		blk_queue_flag_clear(QUEUE_FLAG_SQ_SCHED, q);
 		q->elevator = NULL;
 		q->nr_requests = q->tag_set->queue_depth;
+		q->async_depth = q->tag_set->queue_depth;
 	}
 	blk_add_trace_msg(q, "elv switch: %s", ctx->name);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 02c006fb94c5..1d470ac71c64 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -542,6 +542,7 @@ struct request_queue {
 	 * queue settings
 	 */
 	unsigned int		nr_requests;	/* Max # of requests */
+	unsigned int		async_depth;	/* Max # of async requests */
 
 #ifdef CONFIG_BLK_INLINE_ENCRYPTION
 	struct blk_crypto_profile *crypto_profile;
-- 
2.39.2

