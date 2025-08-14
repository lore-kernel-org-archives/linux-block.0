Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E35270551;
	Thu, 14 Aug 2025 03:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755142999; cv=none; b=nRkfM/94iGhuIzeU4g7RMqg8GYgwFDCYujfX7Uya0uDz2gbzEjyuxLpTTvAFfobc4bz2wea2wzl6OzT710T78w/Hz4/GoA4ruJFtjB33VEVLcynbyLAnKhycKNGcHBraO22dHrBmhKiLK1/hckSzTl6a3QgVXiznmL3hoLlz5ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755142999; c=relaxed/simple;
	bh=85gZwIK6x546CVb930ksOXuGAXPnVm8Y2M/um/VlP5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XUb+jM3+In10Km+lYADSsgHYxnKCiniAoIb4IybcZKgNBhUU1SBEYGICvSarEERBYudbG5ldeS2W1eriAcDyShvY/OduJG/q17C/xyaWG9mfUOCnNvuvxmhagudI+qgDaoH5Z7CGljGuZiCDx0a5nMxV6Nxp44wNe+4urOq/AoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c2WKq19bZzYQv3s;
	Thu, 14 Aug 2025 11:43:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BE01C1A018D;
	Thu, 14 Aug 2025 11:43:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCnIxRKW51ogs93Dg--.15627S7;
	Thu, 14 Aug 2025 11:43:09 +0800 (CST)
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
Subject: [PATCH 03/16] blk-mq: remove useless checkings from blk_mq_update_nr_requests()
Date: Thu, 14 Aug 2025 11:35:09 +0800
Message-Id: <20250814033522.770575-4-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCnIxRKW51ogs93Dg--.15627S7
X-Coremail-Antispam: 1UD129KBjvJXoW7AFy7Wr18CryxtrWkurW3Wrg_yoW8GF4fpF
	W3Ga1ak340gr18Aas7tan7Xa47Gr4DCr1Ikr4aqr1ayry5KFsFvr1rKr4jqr1IyrZ3Aanr
	KFWDJ397Zr1kZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

1) queue_requests_store() is the only caller of
blk_mq_update_nr_requests(), where queue is already freezed, no need to
check mq_freeze_depth;
2) q->tag_set must be set for request_based device, and queue_is_mq() is
already checked in blk_mq_queue_attr_visible(), no need to check
q->tag_set.
3) During initialization, hctx->tags in initialized before queue
kobject, and during del_gendisk, queue kobject is deleted before
exiting hctx, hence checking hctx->tags is useless.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b67d6c02eceb..3a219b7b3688 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4921,24 +4921,15 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 {
 	struct blk_mq_tag_set *set = q->tag_set;
 	struct blk_mq_hw_ctx *hctx;
-	int ret;
+	int ret = 0;
 	unsigned long i;
 
-	if (WARN_ON_ONCE(!q->mq_freeze_depth))
-		return -EINVAL;
-
-	if (!set)
-		return -EINVAL;
-
 	if (q->nr_requests == nr)
 		return 0;
 
 	blk_mq_quiesce_queue(q);
 
-	ret = 0;
 	queue_for_each_hw_ctx(q, hctx, i) {
-		if (!hctx->tags)
-			continue;
 		/*
 		 * If we're using an MQ scheduler, just update the scheduler
 		 * queue depth. This is similar to what the old code would do.
-- 
2.39.2

