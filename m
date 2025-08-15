Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECC4245031;
	Fri, 15 Aug 2025 08:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755245413; cv=none; b=QmmcNX0nM/G5hQL8ivxCpoXh+MQS9BovvfkIydpe4f+Nu0CJ7i9O9M/nqm+zmXVAFS9P8emk1o82syjseC5QoYKszcxrUN+id2QN9dNaf0H5eJ2aEsK+uZ5lfsAGxwTGWJXB+JakfzGE/SFjLfVDusgNlQ+vxn3JhJvIzp4vuuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755245413; c=relaxed/simple;
	bh=uwS4uv6TNa9vAE2OG+ULMVRqXVzT2KChvnTDwkVYLe4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xf08ZpBOzZdIAILIGiXkFkbG2kfuYxL+tG0Jvah8+ymr46zjCAamnXjekp1nWyUtRM1ReSZT/2gcqlxYOhscDA7BUog/l0OeE1JOD4nN+Hk0j0rTHaNm83S4yQgsX7kMak2o/bcZsFjIzxD0WA4rQLb3Jg4nJAfQclBhQHbL14o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c3FCP0BsbzKHMl9;
	Fri, 15 Aug 2025 16:10:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 539A91A018D;
	Fri, 15 Aug 2025 16:10:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDHjxBc655o+xX_Dg--.53834S8;
	Fri, 15 Aug 2025 16:10:08 +0800 (CST)
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
Subject: [PATCH 04/10] blk-mq: serialize updating nr_requests with update_nr_hwq_lock
Date: Fri, 15 Aug 2025 16:02:10 +0800
Message-Id: <20250815080216.410665-5-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDHjxBc655o+xX_Dg--.53834S8
X-Coremail-Antispam: 1UD129KBjvJXoW7WFWxZF17AF47tw1fAr1UKFg_yoW8ZF4rpF
	Z8C39Fkw1vq3W8X34UA3W7Ww17J3y0gr13GrWxtF13uFnrta97Zr18KFy7Wr48CrZ3ArsF
	vw4kJFZ5AFyDZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
	vfC2KfnxnUUI43ZEXa7VUbPC7UUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

request_queue->nr_requests can be changed by:

a) switching elevator by update nr_hw_queues
b) switching elevator by elevator sysfs attribute
c) configue queue sysfs attribute nr_requests

Current lock order is:

1) update_nr_hwq_lock, case a,b
- allocate elevator tags
2) freeze_queue
3) elevator_lock, cas a,b,c
- update nr_requests

The update_nr_hwq_lock is not held by case c for now, and we need to check
nr_requests while elevator_lock is held, however, we can't allocate
elevator_tags whih queue freezed.

Hence also require update_nr_hwq_lock and check nr_requests, make it
possible to allocate new elevator_tags without queue freezed, also
prevent nr_requests to be changed concurrently by other contexts.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-sysfs.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index f3d08edcc34f..37eae7927b45 100644
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
+	/* serialize with switching elevator */
+	down_write(&set->update_nr_hwq_lock);
 
 	if (q->nr_requests == nr)
 		goto unlock;
@@ -89,13 +90,17 @@ queue_requests_store(struct gendisk *disk, const char *page, size_t count)
 		goto unlock;
 	}
 
+	memflags = blk_mq_freeze_queue(q);
+	mutex_lock(&q->elevator_lock);
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

