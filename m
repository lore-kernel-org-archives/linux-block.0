Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFBB2C325D;
	Fri, 15 Aug 2025 08:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755245414; cv=none; b=kPZgcfha4fEXbb982qdDaUSmJlgyb4CroWfxJm9JxYHSf/k2vslyvuIYqWhJ8xWXJjoOI3UYe9rrRwS0tVToXome5PE79m7LeP+V0W3lPcs/G44P/vt3vbAYF2IgocK/RiQyV6DaZdRY0SYtrAaURrMLyw567hAuyHRUMvlWEDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755245414; c=relaxed/simple;
	bh=69KDuGrzUyZNj6ODPR9SX7N9kGmMJpK+24z+Dbca4L0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wd99uKNEMh43BwPgzTODCF7cG4r7FU4D8Q5zR39W5It9wLjulkEfCD5ZggEXIQ5Obk8YJydD4lVdcBNbTCzbCh/Un4nDn6LEPgsDDVAuXBDFpfOUoxLSKqEpiqaOUFgU6JzD672YR1jULy4BheHQuE7znr6asy5VCyoliDywjS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c3FCR4npxzYQv9C;
	Fri, 15 Aug 2025 16:10:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 456251A07BB;
	Fri, 15 Aug 2025 16:10:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDHjxBc655o+xX_Dg--.53834S12;
	Fri, 15 Aug 2025 16:10:10 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	hare@suse.de,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH 08/10] blk-mq: fix blk_mq_tags double free while nr_requests grown
Date: Fri, 15 Aug 2025 16:02:14 +0800
Message-Id: <20250815080216.410665-9-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250815080216.410665-1-yukuai1@huaweicloud.com>
References: <20250815080216.410665-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHjxBc655o+xX_Dg--.53834S12
X-Coremail-Antispam: 1UD129KBjvJXoWxur13Xr1ruF1rZFy3Xr1kXwb_yoWrtF1xpF
	W5Ga1ak3yFqr18Za4UAw47XwnxKw4vgr17GrWft34F9rnrKr4xZF18GF48XFWIyrWkCFsF
	kr1DJrZ8ZrZ7Xa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
	vfC2KfnxnUUI43ZEXa7VUbPC7UUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

In the case user trigger tags grow by queue sysfs attribute nr_requests,
hctx->sched_tags will be freed directly and replaced with a new
allocated tags, see blk_mq_tag_update_depth().

The problem is that hctx->sched_tags is from elevator->et->tags, while
et->tags is still the freed tags, hence later elevator exist will try to
free the tags again, causing kernel panic.

Fix this problem by using new allocated elevator_tags, also convert
blk_mq_update_nr_requests to void since this helper will never fail now.

Meanwhile, there is a longterm problem can be fixed as well:

If blk_mq_tag_update_depth() succeed for previous hctx, then bitmap depth
is updated, however, if following hctx failed, q->nr_requests is not
updated and the previous hctx->sched_tags endup bigger than q->nr_requests.

Fixes: f5a6604f7a44 ("block: fix lockdep warning caused by lock dependency in elv_iosched_store")
Fixes: e3a2b3f931f5 ("blk-mq: allow changing of queue depth through sysfs")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq.c    | 19 ++++++-------------
 block/blk-mq.h    |  4 +++-
 block/blk-sysfs.c | 21 ++++++++++++++-------
 3 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 11c8baebb9a0..e9f037a25fe3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4917,12 +4917,12 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
 }
 EXPORT_SYMBOL(blk_mq_free_tag_set);
 
-int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
+void blk_mq_update_nr_requests(struct request_queue *q,
+			       struct elevator_tags *et, unsigned int nr)
 {
 	struct blk_mq_tag_set *set = q->tag_set;
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i;
-	int ret = 0;
 
 	blk_mq_quiesce_queue(q);
 
@@ -4946,24 +4946,17 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 				nr - hctx->sched_tags->nr_reserved_tags);
 		}
 	} else {
-		queue_for_each_hw_ctx(q, hctx, i) {
-			if (!hctx->tags)
-				continue;
-			ret = blk_mq_tag_update_depth(hctx, &hctx->sched_tags,
-						      nr);
-			if (ret)
-				goto out;
-		}
+		blk_mq_free_sched_tags(q->elevator->et, set);
+		queue_for_each_hw_ctx(q, hctx, i)
+			hctx->sched_tags = et->tags[i];
+		q->elevator->et = et;
 	}
 
 	q->nr_requests = nr;
 	if (q->elevator && q->elevator->type->ops.depth_updated)
 		q->elevator->type->ops.depth_updated(q);
 
-out:
 	blk_mq_unquiesce_queue(q);
-
-	return ret;
 }
 
 /*
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 731f4578d9a8..98740f9c204e 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -6,6 +6,7 @@
 #include "blk-stat.h"
 
 struct blk_mq_tag_set;
+struct elevator_tags;
 
 struct blk_mq_ctxs {
 	struct kobject kobj;
@@ -45,7 +46,8 @@ void blk_mq_submit_bio(struct bio *bio);
 int blk_mq_poll(struct request_queue *q, blk_qc_t cookie, struct io_comp_batch *iob,
 		unsigned int flags);
 void blk_mq_exit_queue(struct request_queue *q);
-int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr);
+void blk_mq_update_nr_requests(struct request_queue *q,
+			       struct elevator_tags *et, unsigned int nr);
 void blk_mq_wake_waiters(struct request_queue *q);
 bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *,
 			     bool);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 37eae7927b45..848648456255 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -64,11 +64,12 @@ static ssize_t queue_requests_show(struct gendisk *disk, char *page)
 static ssize_t
 queue_requests_store(struct gendisk *disk, const char *page, size_t count)
 {
-	unsigned long nr;
-	int ret, err;
-	unsigned int memflags;
 	struct request_queue *q = disk->queue;
 	struct blk_mq_tag_set *set = q->tag_set;
+	struct elevator_tags *et = NULL;
+	unsigned int memflags;
+	unsigned long nr;
+	int ret;
 
 	ret = queue_var_store(&nr, page, count);
 	if (ret < 0)
@@ -90,12 +91,18 @@ queue_requests_store(struct gendisk *disk, const char *page, size_t count)
 		goto unlock;
 	}
 
+	if (q->elevator && nr > q->elevator->et->nr_requests) {
+		/* allocate memory before freezing queue to prevent deadlock */
+		et = blk_mq_alloc_sched_tags(set, q->nr_hw_queues, nr);
+		if (!et) {
+			ret = -ENOMEM;
+			goto unlock;
+		}
+	}
+
 	memflags = blk_mq_freeze_queue(q);
 	mutex_lock(&q->elevator_lock);
-	err = blk_mq_update_nr_requests(disk->queue, nr);
-	if (err)
-		ret = err;
-
+	blk_mq_update_nr_requests(disk->queue, et, nr);
 	mutex_unlock(&q->elevator_lock);
 	blk_mq_unfreeze_queue(q, memflags);
 
-- 
2.39.2

