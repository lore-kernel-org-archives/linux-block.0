Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70409346A11
	for <linux-block@vger.kernel.org>; Sat, 25 Jul 2026 02:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784946843; cv=none; b=T6mkb8XEAdYtaWk/vw+6NryWEpV0eNR5zrtli+d8m448Vn84piwql8B2PmUHGS41fQRZb/B7hjfr5mZATzofnBaQ5ruJEXiCbw65bREBBmsHZCsTQzb7ME6HHg2FhJ+Id1ZwjX2LiZArptfn8UJRc5H1Pco4hCSQSOlM+HyOHgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784946843; c=relaxed/simple;
	bh=RMzZKMdwd8Xny1XNsiazqYFktssgoihBMAWAt0PG7H8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okapQ4tzvXZAeRYYSgICV+RjbdcWTir9PoCE5/jk+0Ji+YF4hQxEbb/Nilj1+rjFZY9EUeIT9q/yA+hpVj2GUwadl0frbUKO6M12cALZSmfKDiJTPK5tj6c9BN828FPXjI2DUtAI7RngQ696Jr9qfrEYx1QpVUjo+ozR7HU4lzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h6TS25kcvzYQtwb
	for <linux-block@vger.kernel.org>; Sat, 25 Jul 2026 10:33:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 3F82B40539
	for <linux-block@vger.kernel.org>; Sat, 25 Jul 2026 10:33:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgA3SHSSIGRqCkPTCQ--.40042S9;
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
Subject: [PATCH V6 05/10] null_blk: free zones array on device power-off
Date: Sat, 25 Jul 2026 10:25:04 +0800
Message-ID: <20260725022509.714271-6-wozizhi@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgA3SHSSIGRqCkPTCQ--.40042S9
X-Coremail-Antispam: 1UD129KBjvJXoWxGrWrZF15Ar18GryxJryUGFg_yoW5ZryUpF
	4jga4Ygry8Wr13ZFWq9r4DWF15uw4vyayxCry8J3WS9rW3Ar9Iyr9rAFy5Z3WDJ397AFWf
	XFZ8WFyfC3W7Jw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
	W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUF9NVUUUUU
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

null_init_zoned_dev() allocates dev->zones when a zoned device is powered
on, but null_del_dev() never frees it on power-off; dev->zones is only
freed later in null_free_dev(), when the configfs directory is removed. If
the device is powered off and then on again, null_init_zoned_dev()
allocates a new array and overwrites the dev->zones pointer, leaking the
previous allocation each power cycle.

Free dev->zones in null_del_dev() via null_free_zoned_dev() to solve it.
And calling null_free_zoned_dev() in null_free_dev() is no longer necessary
because every caller already invokes null_del_dev() first: via
nullb_group_drop_item() before nullb_device_release(), in the
null_add_dev() error path of null_create_dev(), and in null_destroy_dev().
Remove the redundant call.

And take &lock around zone_cond_store() in the two store wrappers to
serialize dev->zones check-and-deref against its alloc/free, which already
run under &lock. The reason there was no problem before is that only
nullb_device_release() or null_exit() frees the dev->zones, which
guarantees that subsequent users won't access the configfs interface.

Fixes: ca4b2a011948 ("null_blk: add zone support")
Assisted-by: Claude-Code:GLM-5.2
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/null_blk/main.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index df85189f0b69..e063c931dfca 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -579,8 +579,13 @@ static ssize_t nullb_device_zone_readonly_store(struct config_item *item,
 						const char *page, size_t count)
 {
 	struct nullb_device *dev = to_nullb_device(item);
+	ssize_t ret;
+
+	mutex_lock(&lock);
+	ret = zone_cond_store(dev, page, count, BLK_ZONE_COND_READONLY);
+	mutex_unlock(&lock);
 
-	return zone_cond_store(dev, page, count, BLK_ZONE_COND_READONLY);
+	return ret;
 }
 CONFIGFS_ATTR_WO(nullb_device_, zone_readonly);
 
@@ -588,8 +593,13 @@ static ssize_t nullb_device_zone_offline_store(struct config_item *item,
 					       const char *page, size_t count)
 {
 	struct nullb_device *dev = to_nullb_device(item);
+	ssize_t ret;
 
-	return zone_cond_store(dev, page, count, BLK_ZONE_COND_OFFLINE);
+	mutex_lock(&lock);
+	ret = zone_cond_store(dev, page, count, BLK_ZONE_COND_OFFLINE);
+	mutex_unlock(&lock);
+
+	return ret;
 }
 CONFIGFS_ATTR_WO(nullb_device_, zone_offline);
 
@@ -836,7 +846,6 @@ static void null_free_dev(struct nullb_device *dev)
 	if (!dev)
 		return;
 
-	null_free_zoned_dev(dev);
 	badblocks_exit(&dev->badblocks);
 	kfree(dev);
 }
@@ -1777,6 +1786,7 @@ static void null_del_dev(struct nullb *nullb)
 	}
 
 	put_disk(nullb->disk);
+	null_free_zoned_dev(dev);
 	if (nullb->tag_set == &nullb->__tag_set)
 		blk_mq_free_tag_set(nullb->tag_set);
 	kfree(nullb->queues);
-- 
2.52.0

