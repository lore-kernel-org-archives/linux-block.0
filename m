Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CFA394785;
	Wed,  8 Jul 2026 07:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783496843; cv=none; b=g76ilJxCQUujKCMG78QFkcJlS6KRNEDdkNzMJ6SnsA/lzR08rdm354XgMdvGGmPd6u0JWiEm32gREWOGFVHYfQEFowOpc4mJf7l4glZ9WsoLjnTCJnTdBQNmOCcyL5qY4RLQdwygbcyOdy4y2Z/nclLnr+BDV7x1A10/z2a5Gn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783496843; c=relaxed/simple;
	bh=155/od/jSl9VXMHVjFYxEHQg4sc2ZRImFShmj+O7nXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bsOsp4UVRLVvHQGsG+sy30QM11ubxtyCxX/MvyVO41BZkj4E9KmAWA2JPKFwmH3BFOPHeikj8g8J3AgZwV9PEtA8IojCgS7KDATRB+0rXQbOYsoJmny3EmkwKPtK1sWQLPhv2uZo0sNPitapUdghsEcyOvWgMm2VAGp/ba1FceY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gw9CT2Y5xzKHMN4;
	Wed,  8 Jul 2026 15:46:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 021CC4056E;
	Wed,  8 Jul 2026 15:47:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgCnt3N4AE5qQOTkAQ--.19577S9;
	Wed, 08 Jul 2026 15:47:05 +0800 (CST)
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
Subject: [PATCH V3 5/6] null_blk: serialize configfs attribute stores with device setup
Date: Wed,  8 Jul 2026 15:39:16 +0800
Message-ID: <20260708073917.2172392-6-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260708073917.2172392-1-wozizhi@huaweicloud.com>
References: <20260708073917.2172392-1-wozizhi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCnt3N4AE5qQOTkAQ--.19577S9
X-Coremail-Antispam: 1UD129KBjvJXoWxAFWrurW3uFyDuw4fGrWfKrg_yoW5CF48pF
	Z5Kay3G348GF4fX3yDCw1UWFy3Aw1UZ3y3KrWfJa48C34UZrn2vryvyF4FqFW8Ja9xCay3
	Za9rWFZYyFWUWFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7I
	U1aLvJUUUUU==
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

The NULLB_DEVICE_ATTR _store takes no lock: apply_fn attributes
(submit_queues, poll_queues) get dev->NAME written again after apply_fn
returns, outside its lock; APPLY=NULL attributes are entirely lockless.
configfs only serializes stores per-open-file, so concurrent stores on
separate fds race.

For apply_fn attributes the loser can overwrite dev->NAME after the
winner's apply_fn reconfigured hardware, mismatching dev->submit_queues
with the live queue count (null_map_queues WARN_ON_ONCE). For APPLY=NULL
attributes, a store during power_store's null_add_dev() (validates and
builds the device under "lock" but sets CONFIGURED only afterwards) can
change a field mid-setup -- e.g. zone_nr_conv pushed above nr_zones after
clamping, causing out-of-bounds dev->zones[] access.

Take "lock" in the macro around the apply_fn call, the CONFIGURED test and
the field write, and move it out of nullb_apply_submit_queues()/
nullb_apply_poll_queues() so both paths are covered once. This serializes
stores with power_store's setup and with each other.

_show still takes no lock; its data races are handled by READ_ONCE/
WRITE_ONCE in a follow-up.

Fixes: 45919fbfe1c4 ("null_blk: Enable modifying 'submit_queues' after an instance has been configured")
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 drivers/block/null_blk/main.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index df85189f0b69..9e0002e4aeec 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -360,13 +360,16 @@ nullb_device_##NAME##_store(struct config_item *item, const char *page,	\
 	ret = nullb_device_##TYPE##_attr_store(&new_value, page, count);\
 	if (ret < 0)							\
 		return ret;						\
+	mutex_lock(&lock);						\
 	if (apply_fn)							\
 		ret = apply_fn(dev, new_value);				\
 	else if (test_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags)) 	\
 		ret = -EBUSY;						\
+	if (!ret)							\
+		dev->NAME = new_value;					\
+	mutex_unlock(&lock);						\
 	if (ret < 0)							\
 		return ret;						\
-	dev->NAME = new_value;						\
 	return count;							\
 }									\
 CONFIGFS_ATTR(nullb_device_, NAME);
@@ -421,25 +424,13 @@ static int nullb_update_nr_hw_queues(struct nullb_device *dev,
 static int nullb_apply_submit_queues(struct nullb_device *dev,
 				     unsigned int submit_queues)
 {
-	int ret;
-
-	mutex_lock(&lock);
-	ret = nullb_update_nr_hw_queues(dev, submit_queues, dev->poll_queues);
-	mutex_unlock(&lock);
-
-	return ret;
+	return nullb_update_nr_hw_queues(dev, submit_queues, dev->poll_queues);
 }
 
 static int nullb_apply_poll_queues(struct nullb_device *dev,
 				   unsigned int poll_queues)
 {
-	int ret;
-
-	mutex_lock(&lock);
-	ret = nullb_update_nr_hw_queues(dev, dev->submit_queues, poll_queues);
-	mutex_unlock(&lock);
-
-	return ret;
+	return nullb_update_nr_hw_queues(dev, dev->submit_queues, poll_queues);
 }
 
 NULLB_DEVICE_ATTR(size, ulong, NULL);
-- 
2.52.0

