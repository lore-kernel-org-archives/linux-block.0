Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5535B2D5937;
	Tue, 14 Jul 2026 04:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784003179; cv=none; b=SXgWQuPO4uBQnrxl1ge685ZJdqVrPDM7+zgk+I/Nw0mkdNh0SX9KF4tzKobaw2L7J+9axFxJRIe81CctM/Ufw7B3GNcIE96ELL2Fn4rmEUTNQXsct3bWkXnFXSets5XbS2WO7OxmIrE40qcD5SYcZfECw405wDZrYtx+xK58XlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784003179; c=relaxed/simple;
	bh=14sk9lk252YpBnggfKTx4JsZCMkURgvSmixBe0PG4oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fbTnz4Bh8TpYLVEcVXDCTXHrcempfwReZFjJrx/0LCSxZR7xbnJo5SawCsmx365j1cOJHH8i7Y9lxpdCs/x8B2AwDnni0EBpGLAFzgP6UxX3MxmKyQEDSfShdlzKF6IyYrKsSYZoi6FRfGvy6Pwr8qJ1aLENYBP7e0yZQ1J3l40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gzmT32swdzYQtkG;
	Tue, 14 Jul 2026 12:25:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2239140539;
	Tue, 14 Jul 2026 12:26:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgBHWHRkulVq2zKnBA--.54416S10;
	Tue, 14 Jul 2026 12:26:13 +0800 (CST)
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
Subject: [PATCH V5 6/9] null_blk: clean up null_del_dev() to use cached dev pointer
Date: Tue, 14 Jul 2026 12:18:02 +0800
Message-ID: <20260714041805.1088702-7-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260714041805.1088702-1-wozizhi@huaweicloud.com>
References: <20260714041805.1088702-1-wozizhi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHWHRkulVq2zKnBA--.54416S10
X-Coremail-Antispam: 1UD129KBjvJXoW7GF18CFWUAFy8tw4fAr15twb_yoW8JF15pr
	WjgF1jkF48AF1UZF4DCws7XFy5Ja1Dt3y0grWjyasY9ryayry5Ar4qyFy5WF1UX397Ar4f
	ZFnxZFyxGay8J3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7Cj
	xVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
	kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw
	0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUF9NVUUUUU
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

Replace remaining nullb->dev dereferences with the already-cached
local dev variable. No functional change.

Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
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

