Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2C4293B5C;
	Fri, 25 Jul 2025 07:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753427547; cv=none; b=M9iHSkMZMAr55Q90Fgb0j0Up4FfBCxVe0HBAkeOZVuwRk5r+h/1RvV2sSlJL+hFFAZSAEaKa2NdLRjNO6aFw559mh7TyztpMIru5GHVfVfYbcrXImtM5FCFTtQGaIllGKEVhgcS2X87UZW6uoCt56v/ynYiL3LvhaHyInxxqQeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753427547; c=relaxed/simple;
	bh=bEDstxq6BkdpzQQ3dDSbj2qY8nAOSf0Fe4DnLSore8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jrwgO9wzomiQPpHs5V32Ym6oEZhmvR3b8cxj8+P881DJTu1HupTpkvY3gjxmmwzhdN69TB4ie8lMY3l5hqd7YvLr+AW0tUkoFqebimVvT4uTQJ2kbYCZyxgWWibs0aXw8k2VfidRyDshDVfC2am3g4zsS6w4P90g20KJB5l71L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bpJwS0gp7zKHMc8;
	Fri, 25 Jul 2025 15:12:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D452C1A0DDC;
	Fri, 25 Jul 2025 15:12:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgB3QBFRLoNonnivBQ--.56345S6;
	Fri, 25 Jul 2025 15:12:22 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: jack@suse.cz,
	dlemoal@kernel.org,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH 2/3] block, bfq: convert to use ioc_lookup_icq_rcu()
Date: Fri, 25 Jul 2025 15:05:46 +0800
Message-Id: <20250725070547.3953398-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250725070547.3953398-1-yukuai1@huaweicloud.com>
References: <20250725070547.3953398-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3QBFRLoNonnivBQ--.56345S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw17XFyktF1UKry3trWUJwb_yoW8WFy5pF
	sIganIyr10gr1fur1jy3WDtFn3uan3WrW7KanIqw4FyryIyrnIq3Wjya4SvFySvrWxArsF
	vF1UK3ykAr4UJ3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
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
	vjDU0xZFpf9x0JUczV8UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

ioc_lookup_icq() are all called from IO issue path with queue_lock held,
convert to use ioc_lookup_icq_rcu() to get rid of the disk level spin
lock.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 0cb1e9873aab..b3b9dbbc16d2 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -454,17 +454,13 @@ static struct bfq_io_cq *icq_to_bic(struct io_cq *icq)
  */
 static struct bfq_io_cq *bfq_bic_lookup(struct request_queue *q)
 {
-	struct bfq_io_cq *icq;
-	unsigned long flags;
-
-	if (!current->io_context)
-		return NULL;
+	struct io_cq *icq;
 
-	spin_lock_irqsave(&q->queue_lock, flags);
-	icq = icq_to_bic(ioc_lookup_icq(q));
-	spin_unlock_irqrestore(&q->queue_lock, flags);
+	rcu_read_lock();
+	icq = ioc_lookup_icq_rcu(q);
+	rcu_read_unlock();
 
-	return icq;
+	return icq_to_bic(icq);
 }
 
 /*
@@ -2457,15 +2453,8 @@ static bool bfq_bio_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs)
 {
 	struct bfq_data *bfqd = q->elevator->elevator_data;
-	struct request *free = NULL;
-	/*
-	 * bfq_bic_lookup grabs the queue_lock: invoke it now and
-	 * store its return value for later use, to avoid nesting
-	 * queue_lock inside the bfqd->lock. We assume that the bic
-	 * returned by bfq_bic_lookup does not go away before
-	 * bfqd->lock is taken.
-	 */
 	struct bfq_io_cq *bic = bfq_bic_lookup(q);
+	struct request *free = NULL;
 	bool ret;
 
 	spin_lock_irq(&bfqd->lock);
-- 
2.39.2

