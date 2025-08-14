Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD15026CE1A;
	Thu, 14 Aug 2025 03:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755142999; cv=none; b=sXxxOTU4l+grqC4nomtDpRBVpHpWN1u09TjD1r9yhBp9mRgWfEZ+q7BccM7AkrGjnQQ9wcbuZSOliWCCy15UahwznVdgADQscUmrqrY0fEXmuXok1elNUqaYtYJRt5637T/i88jRYsF8U0+kYXw8YW16oTWsqEVZE6t2vA1m8aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755142999; c=relaxed/simple;
	bh=49dd3k2uOhNsqUa1AxTb+jCQ1g7RZ+Wk2EQCin/MhFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ez126COYaSEXY3/BeUEyZTIcbhXHTExG8+hcKXfE9KiJeeztOgPEcnul0CksgOw+GX7rtyWOzKZ2vdpFAIteG0JXoG3xQwgYIXM6kRKBdhfKmmnD9IMdBM/k9tebhwkx33UZt7DwwWuRitHWP7PauPcFoaD3PJl88ivNKEOYOqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c2WKp0szQzYQv4t;
	Thu, 14 Aug 2025 11:43:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B8D101A1A7C;
	Thu, 14 Aug 2025 11:43:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCnIxRKW51ogs93Dg--.15627S5;
	Thu, 14 Aug 2025 11:43:08 +0800 (CST)
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
Subject: [PATCH 01/16] blk-mq-sched: add new parameter nr_requests in blk_mq_alloc_sched_tags()
Date: Thu, 14 Aug 2025 11:35:07 +0800
Message-Id: <20250814033522.770575-2-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCnIxRKW51ogs93Dg--.15627S5
X-Coremail-Antispam: 1UD129KBjvJXoWxJw4UtFWUAw45Jr1rJF18Xwb_yoW5AFWDpF
	s8Xa1qk3yYqr4kXay7A3yxZw17Kws29FyxJrWft3yYyr1vqws3u3W09r43XrW0yrs5AFsI
	yr1Dtay5XrsFq3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
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
	vjDU0xZFpf9x0JU4OJ5UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

This helper only support to iallocate the default number of requests,
add a new parameter to support specific number of requests.

Prepare to fix tags double free problem if nr_requests is grown by
queue sysfs attribute nr_requests.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-sched.c | 11 +++++++----
 block/blk-mq-sched.h |  2 +-
 block/elevator.c     |  2 +-
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index e2ce4a28e6c9..9a8a0b5e04a9 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -454,7 +454,7 @@ void blk_mq_free_sched_tags_batch(struct xarray *et_table,
 }
 
 struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
-		unsigned int nr_hw_queues)
+		unsigned int nr_hw_queues, unsigned int nr_requests)
 {
 	unsigned int nr_tags;
 	int i;
@@ -475,8 +475,11 @@ struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
 	 * 128, since we don't split into sync/async like the old code
 	 * did. Additionally, this is a per-hw queue depth.
 	 */
-	et->nr_requests = 2 * min_t(unsigned int, set->queue_depth,
-			BLKDEV_DEFAULT_RQ);
+	if (nr_requests)
+		et->nr_requests = nr_requests;
+	else
+		et->nr_requests = 2 * min_t(unsigned int, set->queue_depth,
+				BLKDEV_DEFAULT_RQ);
 	et->nr_hw_queues = nr_hw_queues;
 
 	if (blk_mq_is_shared_tags(set->flags)) {
@@ -521,7 +524,7 @@ int blk_mq_alloc_sched_tags_batch(struct xarray *et_table,
 		 * concurrently.
 		 */
 		if (q->elevator) {
-			et = blk_mq_alloc_sched_tags(set, nr_hw_queues);
+			et = blk_mq_alloc_sched_tags(set, nr_hw_queues, 0);
 			if (!et)
 				goto out_unwind;
 			if (xa_insert(et_table, q->id, et, gfp))
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index b554e1d55950..0582d4bc3987 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -24,7 +24,7 @@ void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e);
 void blk_mq_sched_free_rqs(struct request_queue *q);
 
 struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
-		unsigned int nr_hw_queues);
+		unsigned int nr_hw_queues, unsigned int nr_requests);
 int blk_mq_alloc_sched_tags_batch(struct xarray *et_table,
 		struct blk_mq_tag_set *set, unsigned int nr_hw_queues);
 void blk_mq_free_sched_tags(struct elevator_tags *et,
diff --git a/block/elevator.c b/block/elevator.c
index fe96c6f4753c..f8a04f32cbcf 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -669,7 +669,7 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
 	lockdep_assert_held(&set->update_nr_hwq_lock);
 
 	if (strncmp(ctx->name, "none", 4)) {
-		ctx->et = blk_mq_alloc_sched_tags(set, set->nr_hw_queues);
+		ctx->et = blk_mq_alloc_sched_tags(set, set->nr_hw_queues, 0);
 		if (!ctx->et)
 			return -ENOMEM;
 	}
-- 
2.39.2

