Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4BC2D6E68;
	Wed, 10 Sep 2025 08:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757492056; cv=none; b=YlH2rGkiPjCP3qAtpyfTeM81By0D9KRp51rw+GowSE4abHCvcWSGVj1AYp04VTIzspIvrlcUkjGt7mY9U++3RfyfhuK79ATI+/aIdWp/DbvhVTe333OG/ge12/ebY9rCoWNoaQx00MpLVYfF35bvIoyw4Y948oMSssvYgOurEbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757492056; c=relaxed/simple;
	bh=yY9kuKHuIlT+20dhHKpn7eapHLWcQd4WEoaNcQ6t5DA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t36XlIGCPk5RsOuxJqT100iEdmQOLly9bcD7ggp6JNdpUX6LH469ATEwHNVmRAlDvS+tHC9dc94s0V/7/N/wyhoEzNm4xt1Ow9UF5qdDvNJAL0PCKVkITo9cA9rtbWMWbXlxpqzckZC0jLmBokuuUPncDbZQfxQyqd2oQJASkbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cMD456qfjzYQvjN;
	Wed, 10 Sep 2025 16:14:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 706661A0843;
	Wed, 10 Sep 2025 16:14:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDnMY5QM8Fo1ggRCA--.52270S8;
	Wed, 10 Sep 2025 16:14:12 +0800 (CST)
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
Subject: [PATCH v2 for-6.18/block 04/10] blk-mq: convert to serialize updating nr_requests with update_nr_hwq_lock
Date: Wed, 10 Sep 2025 16:04:39 +0800
Message-Id: <20250910080445.239096-5-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDnMY5QM8Fo1ggRCA--.52270S8
X-Coremail-Antispam: 1UD129KBjvJXoWxurW7GFy3uF18ZrWxXw45GFg_yoW5Gr4rpF
	WfCa9Ikw10qw18W34UAw17WwnxG3yFgr13GrWxtF13CFnrtan3Zw10kFyrWF40yrZ3AFsF
	vr4kJFZ5uFyqvFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
	0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1aLvJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

request_queue->nr_requests can be changed by:

a) switch elevator by updating nr_hw_queues
b) switch elevator by elevator sysfs attribute
c) configue queue sysfs attribute nr_requests

Current lock order is:

1) update_nr_hwq_lock, case a,b
2) freeze_queue
3) elevator_lock, case a,b,c

And update nr_requests is seriablized by elevator_lock() already,
however, in the case c, we'll have to allocate new sched_tags if
nr_requests grow, and do this with elevator_lock held and queue
freezed has the risk of deadlock.

Hence use update_nr_hwq_lock instead, make it possible to allocate
memory if tags grow, meanwhile also prevent nr_requests to be changed
concurrently.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-sysfs.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index f99519f7a820..ff66d1b47169 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -68,13 +68,17 @@ queue_requests_store(struct gendisk *disk, const char *page, size_t count)
 	int ret, err;
 	unsigned int memflags;
 	struct request_queue *q = disk->queue;
+	struct blk_mq_tag_set *set = q->tag_set;
 
 	ret = queue_var_store(&nr, page, count);
 	if (ret < 0)
 		return ret;
 
-	memflags = blk_mq_freeze_queue(q);
-	mutex_lock(&q->elevator_lock);
+	/*
+	 * Serialize updating nr_requests with concurrent queue_requests_store()
+	 * and switching elevator.
+	 */
+	down_write(&set->update_nr_hwq_lock);
 
 	if (nr == q->nr_requests)
 		goto unlock;
@@ -82,20 +86,31 @@ queue_requests_store(struct gendisk *disk, const char *page, size_t count)
 	if (nr < BLKDEV_MIN_RQ)
 		nr = BLKDEV_MIN_RQ;
 
-	if (nr <= q->tag_set->reserved_tags ||
+	/*
+	 * Switching elevator is protected by update_nr_hwq_lock:
+	 *  - read lock is held from elevator sysfs attribute;
+	 *  - write lock is held from updating nr_hw_queues;
+	 * Hence it's safe to access q->elevator here with write lock held.
+	 */
+	if (nr <= set->reserved_tags ||
 	    (q->elevator && nr > MAX_SCHED_RQ) ||
-	    (!q->elevator && nr > q->tag_set->queue_depth)) {
+	    (!q->elevator && nr > set->queue_depth)) {
 		ret = -EINVAL;
 		goto unlock;
 	}
 
+	memflags = blk_mq_freeze_queue(q);
+	mutex_lock(&q->elevator_lock);
+
 	err = blk_mq_update_nr_requests(disk->queue, nr);
 	if (err)
 		ret = err;
 
-unlock:
 	mutex_unlock(&q->elevator_lock);
 	blk_mq_unfreeze_queue(q, memflags);
+
+unlock:
+	up_write(&set->update_nr_hwq_lock);
 	return ret;
 }
 
-- 
2.39.2

