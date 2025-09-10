Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9913101A7;
	Wed, 10 Sep 2025 08:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757492059; cv=none; b=Chv8SwWwT+ZcyvzlIJe5VoWEKEq78uGUszC/q0LHZXgVXVgvDKp3TkHCGLRFmKaNoKOoHJ8hPEIethNKLRi9Zl9d1UWrCaReoIj0PoEpt4jVXIOA5W/spax1OfYSJn8XGC1EBQ7GWyu8buOxhPjnTuNMWdynDEWZg3talHfCoaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757492059; c=relaxed/simple;
	bh=gSwTWPopkQU4JAUnjxWAMpL5yo9ttzkR2xc+bRV40ZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JVsQc4h7NfscKRYUZxpusistvgpJMl8fkIbdCJE0XHOPuixis2t5nF/lKIu+yfNbLYxGS1bO3AiJ9iWtdxRv5ooiLiKBlD45V1F/Vp+jHgypG+A8btZKx1xIHBsjyTWLc773IwHLcjox0m/N9Clyp95ibPsROrcLswJfNHaP6LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cMD490CslzYQvjR;
	Wed, 10 Sep 2025 16:14:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 868931A0F10;
	Wed, 10 Sep 2025 16:14:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDnMY5QM8Fo1ggRCA--.52270S12;
	Wed, 10 Sep 2025 16:14:13 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH v2 for-6.18/block 08/10] blk-mq: fix potential deadlock while nr_requests grown
Date: Wed, 10 Sep 2025 16:04:43 +0800
Message-Id: <20250910080445.239096-9-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250910080445.239096-1-yukuai1@huaweicloud.com>
References: <20250910080445.239096-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnMY5QM8Fo1ggRCA--.52270S12
X-Coremail-Antispam: 1UD129KBjvJXoWxAF13tFyDAw4kGry3Xw17trb_yoWrCrWfpF
	W5JanIk3yIqr18XrWxAa17XwnxKws2gr1xGrWft34F9rnrKrs7ZF18CFy8XrW0yrWkCFsr
	Ar4DJrZ8uF97Wa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
	0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZTmfUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Allocate and free sched_tags while queue is freezed can deadlock[1],
this is a long term problem, hence allocate memory before freezing
queue and free memory after queue is unfreezed.

[1] https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/
Fixes: e3a2b3f931f5 ("blk-mq: allow changing of queue depth through sysfs")

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq.c    | 22 +++++++++-------------
 block/blk-mq.h    |  5 ++++-
 block/blk-sysfs.c | 29 +++++++++++++++++++++--------
 3 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 299aac458185..4ccf11cadf8c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4926,11 +4926,13 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
 }
 EXPORT_SYMBOL(blk_mq_free_tag_set);
 
-int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
+struct elevator_tags *blk_mq_update_nr_requests(struct request_queue *q,
+						struct elevator_tags *et,
+						unsigned int nr)
 {
 	struct blk_mq_tag_set *set = q->tag_set;
+	struct elevator_tags *old_et = NULL;
 	struct blk_mq_hw_ctx *hctx;
-	int ret = 0;
 	unsigned long i;
 
 	blk_mq_quiesce_queue(q);
@@ -4965,24 +4967,18 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 		}
 	} else {
 		/* Non-shared sched tags, and tags grow */
-		queue_for_each_hw_ctx(q, hctx, i) {
-			if (!hctx->sched_tags)
-				continue;
-			ret = blk_mq_tag_update_depth(hctx, &hctx->sched_tags,
-						      nr);
-			if (ret)
-				goto out;
-		}
+		queue_for_each_hw_ctx(q, hctx, i)
+			hctx->sched_tags = et->tags[i];
+		old_et =  q->elevator->et;
+		q->elevator->et = et;
 	}
 
 	q->nr_requests = nr;
 	if (q->elevator && q->elevator->type->ops.depth_updated)
 		q->elevator->type->ops.depth_updated(q);
 
-out:
 	blk_mq_unquiesce_queue(q);
-
-	return ret;
+	return old_et;
 }
 
 /*
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 3a1d4c37d1bc..0ef96f510477 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -6,6 +6,7 @@
 #include "blk-stat.h"
 
 struct blk_mq_tag_set;
+struct elevator_tags;
 
 struct blk_mq_ctxs {
 	struct kobject kobj;
@@ -45,7 +46,9 @@ void blk_mq_submit_bio(struct bio *bio);
 int blk_mq_poll(struct request_queue *q, blk_qc_t cookie, struct io_comp_batch *iob,
 		unsigned int flags);
 void blk_mq_exit_queue(struct request_queue *q);
-int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr);
+struct elevator_tags *blk_mq_update_nr_requests(struct request_queue *q,
+						struct elevator_tags *tags,
+						unsigned int nr);
 void blk_mq_wake_waiters(struct request_queue *q);
 bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *,
 			     bool);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index ff66d1b47169..76c47fe9b8d6 100644
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
@@ -99,16 +100,28 @@ queue_requests_store(struct gendisk *disk, const char *page, size_t count)
 		goto unlock;
 	}
 
+	if (!blk_mq_is_shared_tags(set->flags) && q->elevator &&
+	    nr > q->elevator->et->nr_requests) {
+		/*
+		 * Tags will grow, allocate memory before freezing queue to
+		 * prevent deadlock.
+		 */
+		et = blk_mq_alloc_sched_tags(set, q->nr_hw_queues, nr);
+		if (!et) {
+			ret = -ENOMEM;
+			goto unlock;
+		}
+	}
+
 	memflags = blk_mq_freeze_queue(q);
 	mutex_lock(&q->elevator_lock);
-
-	err = blk_mq_update_nr_requests(disk->queue, nr);
-	if (err)
-		ret = err;
-
+	et = blk_mq_update_nr_requests(q, et, nr);
 	mutex_unlock(&q->elevator_lock);
 	blk_mq_unfreeze_queue(q, memflags);
 
+	if (et)
+		blk_mq_free_sched_tags(et, set);
+
 unlock:
 	up_write(&set->update_nr_hwq_lock);
 	return ret;
-- 
2.39.2

