Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A047329CE1;
	Fri, 15 Aug 2025 08:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755245412; cv=none; b=I6fcOW3tIXRpL7WV5WgN8K3aZHxoujarFEGo/fOilLBy8ZdQ8ep4vcltF+Xds9GT+TPnL1Me0K3bN/uOG7rGbPsT0Hx1qVMQzmgpRXbZlsqJncVH0b3HUUnChJk0yVN61j/w3htORo0O2tH9QqfCFH1HS5C5r86Oj6IYKReWjg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755245412; c=relaxed/simple;
	bh=R18nirD9dQXB8+w06HH8waupCvAqpHeMtq644QFOOm4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y55S1awIbN8pkzxfDmL1cIetkwGK3jYs2YzjM85UFVELR6omP2UE3Vio5W73Rv+KCtMydZaceFHPym58QcNpkWYppuzTg2HvMUsK9ePWq0nNzgLMUZ+noP7WogJhoNFRkzxomlxS1Y2/hvvTdzYGZcvy1ooK4udxq9ERxdSYFpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c3FCN0cLmzKHMTP;
	Fri, 15 Aug 2025 16:10:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 62A3B1A0B00;
	Fri, 15 Aug 2025 16:10:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDHjxBc655o+xX_Dg--.53834S6;
	Fri, 15 Aug 2025 16:10:07 +0800 (CST)
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
Subject: [PATCH 02/10] blk-mq: remove useless checkings from blk_mq_update_nr_requests()
Date: Fri, 15 Aug 2025 16:02:08 +0800
Message-Id: <20250815080216.410665-3-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDHjxBc655o+xX_Dg--.53834S6
X-Coremail-Antispam: 1UD129KBjvdXoWrtw13XF4fZrW8XFyrtw17trb_yoWDKrX_CF
	y0kF92qrs5Jr4SvwsFk3WYvFy8Gw1DJF4fGas8tr9rXr1kGFsxJrWDGr15WFsrW3y3C3Z7
	u3WUWw43Jw4SvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbkkFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY02
	0Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
	wVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUQXo7UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

1) queue_requests_store() is the only caller of
blk_mq_update_nr_requests(), where queue is already freezed, no need to
check mq_freeze_depth;
2) q->tag_set must be set for request_based device, and queue_is_mq() is
already checked in blk_mq_queue_attr_visible(), no need to check
q->tag_set.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9c68749124c6..ea2995d4a917 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4921,21 +4921,14 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 {
 	struct blk_mq_tag_set *set = q->tag_set;
 	struct blk_mq_hw_ctx *hctx;
-	int ret;
 	unsigned long i;
-
-	if (WARN_ON_ONCE(!q->mq_freeze_depth))
-		return -EINVAL;
-
-	if (!set)
-		return -EINVAL;
+	int ret = 0;
 
 	if (q->nr_requests == nr)
 		return 0;
 
 	blk_mq_quiesce_queue(q);
 
-	ret = 0;
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (!hctx->tags)
 			continue;
-- 
2.39.2

