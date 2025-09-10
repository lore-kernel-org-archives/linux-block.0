Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7677E309DC1;
	Wed, 10 Sep 2025 08:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757492055; cv=none; b=Jkdfif9dlL8ECzamKcASFGQ20q+o1Arq3r+IeDdsyCPhljdNW58EQjhWIO2BATDDlaoOFZdoVmz3VITx0JRrVUdUtzHPyP7ssVH7/0u9/CaAckrdxRUwZmqUhiRmVNLaRPzgnUJp01A7nnByaSEQ/9ste4liVCCLZttoKD8gBLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757492055; c=relaxed/simple;
	bh=xmcrIaTYHDDwJzAJy5TTXK90LlnmWv4lbCk1CcQQ5/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EspwoObO9nqKx3VfDvEdpclXSkYB4Rlhr/Ahr7r1caJJApX0q2oW1T/HmOgaMpB3S1GN8iqTxriZp44dNdM6ki0mJjKeiKyVm+dBv3ILfyv3hIkSy9WZB3UDu7eg+AghT7Plme3fiEIlig1xgd3+gvvQHm/xvwru+Ll5dVp7jwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cMD4454QGzYQvht;
	Wed, 10 Sep 2025 16:14:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 38D9E1A19D1;
	Wed, 10 Sep 2025 16:14:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDnMY5QM8Fo1ggRCA--.52270S5;
	Wed, 10 Sep 2025 16:14:11 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH v2 for-6.18/block 01/10] blk-mq: remove useless checking in queue_requests_store()
Date: Wed, 10 Sep 2025 16:04:36 +0800
Message-Id: <20250910080445.239096-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250910080445.239096-1-yukuai1@huaweicloud.com>
References: <20250910080445.239096-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnMY5QM8Fo1ggRCA--.52270S5
X-Coremail-Antispam: 1UD129KBjvdXoW7JrWxurW3KF47Cr1UJr18Xwb_yoW3Wrb_GF
	yjkry2qFsIyr4xZr43Ary0qF4xCw4fJF45WFWDJas5AFyfJas3K3yvqr1Fyr47ua97uF4r
	Cw1xGayxCr40vjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbTAYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r18M2
	8IrcIa0xkI8VCY1x0267AKxVWUCVW8JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
	021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r
	4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUzGYLUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

blk_mq_queue_attr_visible() already checked queue_is_mq(), no need to
check this again in queue_requests_store().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-sysfs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index c94b8b6ab024..1ffa65feca4f 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -69,9 +69,6 @@ queue_requests_store(struct gendisk *disk, const char *page, size_t count)
 	unsigned int memflags;
 	struct request_queue *q = disk->queue;
 
-	if (!queue_is_mq(q))
-		return -EINVAL;
-
 	ret = queue_var_store(&nr, page, count);
 	if (ret < 0)
 		return ret;
-- 
2.39.2

