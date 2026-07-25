Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7048E346A1D
	for <linux-block@vger.kernel.org>; Sat, 25 Jul 2026 02:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784946841; cv=none; b=INeC5QSAR4K9DbVWs6J2yFxmhkdH2W5zTuwQ9qNfJHGU5mdsdchBWLicf055UR4Uh7lELiUG8FPs4yrmOHZmDjkIYIHRJswsVFT6iXa5iclxMSmzigyt92pro1Gb7muaEA8g1g0ZobCuj9NSDwKS6e45NFQRh8SXU6PYQ8xSM9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784946841; c=relaxed/simple;
	bh=wdt4FTwzz4gr4HU3vHsJdydu/S+y7AMUgSJc+hyysWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+9kbXpnf573Z6X/QUKFzkyvtw1Kz94u6SQQa5BQtuv1VPzeme8vvDR8zO43yGVPnisCz8P2TbekJK/VtwIFFwXXK7Bo5679nnxucNpHFr3UFuZlsLDMgvXXlroFT18JZZ4lDTsSqRQbOLePov0HW+O11ChzcCo1I0U6Wr5JxxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h6TS261X1zYQtwh
	for <linux-block@vger.kernel.org>; Sat, 25 Jul 2026 10:33:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 4B8764056D
	for <linux-block@vger.kernel.org>; Sat, 25 Jul 2026 10:33:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgA3SHSSIGRqCkPTCQ--.40042S10;
	Sat, 25 Jul 2026 10:33:56 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	dlemoal@kernel.org,
	nilay@linux.ibm.com,
	bvanassche@acm.org,
	yukuai@fygo.io,
	kch@nvidia.com,
	johannes.thumshirn@wdc.com,
	kbusch@kernel.org,
	linux-block@vger.kernel.org
Cc: yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	wozizhi@huawei.com
Subject: [PATCH V6 06/10] null_blk: clean up null_del_dev() to use cached dev pointer
Date: Sat, 25 Jul 2026 10:25:05 +0800
Message-ID: <20260725022509.714271-7-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260725022509.714271-1-wozizhi@huaweicloud.com>
References: <20260725022509.714271-1-wozizhi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3SHSSIGRqCkPTCQ--.40042S10
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw47WryxXrWxJrykCFWUCFg_yoW8Jw1fpr
	WjgF1jkFW8AF1UZF4qkws7XFy5Ja1Dt3y0grWjyasY9ryayryYyrsFyFy5WF1UX397Ar43
	ZFnxZFWxWay8J3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
	W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUF9NVUUUUU
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

Replace remaining nullb->dev dereferences with the already-cached
local dev variable. No functional change.

Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/null_blk/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index e063c931dfca..249caaf6ce89 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1779,7 +1779,7 @@ static void null_del_dev(struct nullb *nullb)
 
 	del_gendisk(nullb->disk);
 
-	if (test_bit(NULLB_DEV_FL_THROTTLED, &nullb->dev->flags)) {
+	if (test_bit(NULLB_DEV_FL_THROTTLED, &dev->flags)) {
 		hrtimer_cancel(&nullb->bw_timer);
 		atomic_long_set(&nullb->cur_bytes, LONG_MAX);
 		blk_mq_start_stopped_hw_queues(nullb->q, true);
@@ -1791,7 +1791,7 @@ static void null_del_dev(struct nullb *nullb)
 		blk_mq_free_tag_set(nullb->tag_set);
 	kfree(nullb->queues);
 	if (null_cache_active(nullb))
-		null_free_device_storage(nullb->dev, true);
+		null_free_device_storage(dev, true);
 	kfree(nullb);
 	dev->nullb = NULL;
 }
-- 
2.52.0

