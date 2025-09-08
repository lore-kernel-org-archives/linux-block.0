Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC5922A4F8;
	Mon,  8 Sep 2025 06:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757313658; cv=none; b=R2xOiHNYYEJ2MHXTtTNCzAEdCHsk/UHNZm0zOYPW9zMCT6vYH6DLJ0zDXynAHKFG4Kp2ju+5Yypqu0PM+7kKs7MLmKhVDbhowuKTSVXV8L6NQmpHbKcCqBUWpKw87Anri3NAPhdN8KZps9WEq9a12EOiAwLm86VZW5Xv0+V65kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757313658; c=relaxed/simple;
	bh=pOPhOP9wjX3l36DHcRZ7tDtU3eF5RQ7aF999x4fzShM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V/25n+FkGmrnFz56y1dqlnRKq0Qii31BpC+cob1i3Z4ejWGwYzprLnzblQZ/dZ1uwASKFoB8BTETwnu7Uu/IyyBhWJvfNzp6NDQBxLhWIb4HVKNY5JrDnyQjoCRIvfA/4b6tnXJ6EDav0uEUQ4Acw7JIlNhao5sclfFYm/mYvdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cKxks3YsZzKHMxf;
	Mon,  8 Sep 2025 14:24:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 91CFF1A0AD9;
	Mon,  8 Sep 2025 14:24:53 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgD3QY6xdr5oCGEjBw--.62066S8;
	Mon, 08 Sep 2025 14:24:53 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: nilay@linux.ibm.com,
	ming.lei@redhat.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH for-6.18/block 04/10] blk-mq: convert to serialize updating nr_requests with update_nr_hwq_lock
Date: Mon,  8 Sep 2025 14:15:27 +0800
Message-Id: <20250908061533.3062917-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250908061533.3062917-1-yukuai1@huaweicloud.com>
References: <20250908061533.3062917-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3QY6xdr5oCGEjBw--.62066S8
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1DKrWfuw13CF47tr1xuFg_yoW8ZrWxpF
	W3Ca9Fkw1vq3W8X34UAw17WwnrJw4Igr17GrWxtF1ayFnrt3Z7ZF18KFy8WF4IkrZ3AFsI
	vFWkXFZ5ZFyDZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
	xhVjvjDU0xZFpf9x0JUQFxUUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

request_queue->nr_requests can be changed by:

a) switching elevator by update nr_hw_queues
b) switching elevator by elevator sysfs attribute
c) configue queue sysfs attribute nr_requests

Current lock order is:

1) update_nr_hwq_lock, case a,b
2) freeze_queue
3) elevator_lock, cas a,b,c

And update nr_requests is seriablized by elevator_lock() already,
however, in the case c), we'll have to allocate new sched_tags if
nr_requests grow, and do this with elevator_lock held and queue
freezed has the risk of deadlock.

Hence use update_nr_hwq_lock instead, make it possible to allocate
memory if tags grow, meanwhile also prevent nr_requests to be changed
concurrently.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-sysfs.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index f99519f7a820..7ea15bf68b4b 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -68,13 +68,14 @@ queue_requests_store(struct gendisk *disk, const char *page, size_t count)
 	int ret, err;
 	unsigned int memflags;
 	struct request_queue *q = disk->queue;
+	struct blk_mq_tag_set *set = q->tag_set;
 
 	ret = queue_var_store(&nr, page, count);
 	if (ret < 0)
 		return ret;
 
-	memflags = blk_mq_freeze_queue(q);
-	mutex_lock(&q->elevator_lock);
+	/* serialize updating nr_requests with switching elevator */
+	down_write(&set->update_nr_hwq_lock);
 
 	if (nr == q->nr_requests)
 		goto unlock;
@@ -89,13 +90,18 @@ queue_requests_store(struct gendisk *disk, const char *page, size_t count)
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

