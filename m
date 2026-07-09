Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0197E40F8D6;
	Thu,  9 Jul 2026 10:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591974; cv=none; b=EMFpGbONHbvokr1jLaeKNZUkj3yM5zeqWNBUr+n0LEjpRfOolxYQAfot8qasLq4XpS0GBG4RjzYcam+d6pGzABLy5w0MLsKzvolduOV87rm+XkCfM1i2WX1emHWgsCKEGRnZzZ9FNrw3Je1iHzpvqTpmNAeDfvrH/WKrBiDW97k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591974; c=relaxed/simple;
	bh=C+jgCRMZ04gMzNu2IDOOaJ97ekW6pF79k4d7SpxysuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHxyZwOii0WshWVu8rIV7YdeoSz5p/uscKmpok/Q5U3KT6fdtTP25AioXVL1T8Id7xAdXCnchNvKgoC4YM2Zql+FL6AspoQxPHoz6SYKhOXry6nVIyw6dGrsNfR+uoJXTNJ7mlISC2dlNTp8SRGNu6eJKp8NPliM1TzKRsMgy3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gwrPK57ykzYQtyd;
	Thu,  9 Jul 2026 18:12:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 4965D40B8E;
	Thu,  9 Jul 2026 18:12:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgBHV3MadE9qn4RpAg--.38318S9;
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
Subject: [PATCH V4 5/9] null_blk: free zones array on device power-off
Date: Thu,  9 Jul 2026 18:04:47 +0800
Message-ID: <20260709100452.3520482-6-wozizhi@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBHV3MadE9qn4RpAg--.38318S9
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4UuF1DCFy5GFyUXw48tFb_yoW8ZFW5pF
	4jg3WrKFy5XF18XFWDZan7WFy5Cw1DJ3y8Gry3Ca4F9ry3Ar90yFnrAFyrCF4UJ3yxAr4f
	XFZ8XFyfZ3WUWaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
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

null_init_zoned_dev() allocates dev->zones when a zoned device is powered
on, but null_del_dev() never frees it on power-off; dev->zones is only
freed later in null_free_dev(), when the configfs directory is removed. If
the device is powered off and then on again, null_init_zoned_dev()
allocates a new array and overwrites the dev->zones pointer, leaking the
previous allocation each power cycle.

Free dev->zones in null_del_dev() via null_free_zoned_dev() to solve it.
And calling null_del_dev() in null_free_dev() is no longer necessary
because every caller already invokes null_del_dev() first: via
nullb_group_drop_item() before nullb_device_release(), in the
null_add_dev() error path of null_create_dev(), and in null_destroy_dev().
Remove the redundant call.

Fixes: ca4b2a011948 ("null_blk: add zone support")
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 drivers/block/null_blk/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index df85189f0b69..a75989220a2f 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -834,11 +834,10 @@ static struct nullb_device *null_alloc_dev(void)
 static void null_free_dev(struct nullb_device *dev)
 {
 	if (!dev)
 		return;
 
-	null_free_zoned_dev(dev);
 	badblocks_exit(&dev->badblocks);
 	kfree(dev);
 }
 
 static enum hrtimer_restart null_cmd_timer_expired(struct hrtimer *timer)
@@ -1775,10 +1774,11 @@ static void null_del_dev(struct nullb *nullb)
 		atomic_long_set(&nullb->cur_bytes, LONG_MAX);
 		blk_mq_start_stopped_hw_queues(nullb->q, true);
 	}
 
 	put_disk(nullb->disk);
+	null_free_zoned_dev(dev);
 	if (nullb->tag_set == &nullb->__tag_set)
 		blk_mq_free_tag_set(nullb->tag_set);
 	kfree(nullb->queues);
 	if (null_cache_active(nullb))
 		null_free_device_storage(nullb->dev, true);
-- 
2.52.0

