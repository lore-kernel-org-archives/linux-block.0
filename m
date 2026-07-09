Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBC83E3142;
	Thu,  9 Jul 2026 10:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591969; cv=none; b=Edm/9Us0FIrAg35btZrrHsgiT2lL4on2OsQTmFyptpX8gLiW1BN5Mh52pETLYmTXHZQN4uq9mRd4m8l1CNicY/s99zk/b1I9HR6h8LtOMAEx2YFWg4FJHVOVJFDIoat2LHWpLC5EGH3I2TbLWfxD7eCJz8KTvXdNOg9wgA3sHBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591969; c=relaxed/simple;
	bh=nP/UxZvwZnDICegL+X5NP25UhkZBG8VchpxHzmd+Xb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LOH40d4IYMVksEVymfXftplBYkJsJiiGZ70pruneAwEsZUq+y6AResiM/MqmIFq8EQxIARlKL2g3caE7brTCtBfiidpUPhSfQQJjMWbETzRxZJpOz/62qXPbKlqRXyTOj8hubJHElI6BHsLFsJuxHDqj1kwpRXd7HibByehMT94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gwrP16XBVzKHMd0;
	Thu,  9 Jul 2026 18:12:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 564A34056D;
	Thu,  9 Jul 2026 18:12:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgBHV3MadE9qn4RpAg--.38318S10;
	Thu, 09 Jul 2026 18:12:44 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	dlemoal@kernel.org,
	nilay@linux.ibm.com,
	kch@nvidia.com,
	johannes.thumshirn@wdc.com,
	kbusch@kernel.org,
	bvanassche@acm.org,
	linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	wozizhi@huawei.com
Subject: [PATCH V4 6/9] null_blk: clean up null_del_dev() to use cached dev pointer
Date: Thu,  9 Jul 2026 18:04:48 +0800
Message-ID: <20260709100452.3520482-7-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260709100452.3520482-1-wozizhi@huaweicloud.com>
References: <20260709100452.3520482-1-wozizhi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHV3MadE9qn4RpAg--.38318S10
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4kWF45AF1kWry7tw1fJFb_yoW8GFy7pr
	Wjg3WjkF15ZF40vF4DGws7JFy3Jr4DJrW0grWjkasYkr1ayryYyw1qyFy5Wr1UX397Ar4f
	ZFZxXFy7ZayUJ3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
	W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07UZTmfUUUUU=
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

Replace remaining nullb->dev dereferences with the already-cached
local dev variable. No functional change.

Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 drivers/block/null_blk/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index a75989220a2f..6d30591abb28 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1767,11 +1767,11 @@ static void null_del_dev(struct nullb *nullb)
 
 	list_del_init(&nullb->list);
 
 	del_gendisk(nullb->disk);
 
-	if (test_bit(NULLB_DEV_FL_THROTTLED, &nullb->dev->flags)) {
+	if (test_bit(NULLB_DEV_FL_THROTTLED, &dev->flags)) {
 		hrtimer_cancel(&nullb->bw_timer);
 		atomic_long_set(&nullb->cur_bytes, LONG_MAX);
 		blk_mq_start_stopped_hw_queues(nullb->q, true);
 	}
 
@@ -1779,11 +1779,11 @@ static void null_del_dev(struct nullb *nullb)
 	null_free_zoned_dev(dev);
 	if (nullb->tag_set == &nullb->__tag_set)
 		blk_mq_free_tag_set(nullb->tag_set);
 	kfree(nullb->queues);
 	if (null_cache_active(nullb))
-		null_free_device_storage(nullb->dev, true);
+		null_free_device_storage(dev, true);
 	kfree(nullb);
 	dev->nullb = NULL;
 }
 
 static void null_config_discard(struct nullb *nullb, struct queue_limits *lim)
-- 
2.52.0

