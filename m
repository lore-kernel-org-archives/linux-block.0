Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147022222B6;
	Mon,  8 Sep 2025 06:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757312697; cv=none; b=ssR09aXIFbXp/jbtqIzplq0EMwJXYhkAWUeRZbE49tg3T6jCHu1aXXWxP07MM3KWpdms58FB4qM7L+wNqUiWQodwz02TrKW9ZIig0wdV6Kr2/fY60MkZIcgQdG364JlV6WUyWUrhziEmNsUxr/6ydTfv34PibqtNea5a1RZHotM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757312697; c=relaxed/simple;
	bh=8oYUvGC6wX9Iiy7ea2U0oxPOZ4z8fV4YueFX3XnHVk0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jYVcByT82r2pww05YIjUEPKJmDlLfr5TMk9OOoNcZgBux0eY2cwUzUin2MV8qwf1iepnjh/T/oMIU/rRE4GhOk8LG6VmvoNfT4w/7sFT+aWklCPRQBvCHUKpcDhYwRcuYf+JaJ6bqqC2HgdkPLAo6n2Zag4PoZuG5OnBGrxLX/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cKxks5clbzYQv07;
	Mon,  8 Sep 2025 14:24:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4724B1A0AE2;
	Mon,  8 Sep 2025 14:24:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgD3QY6xdr5oCGEjBw--.62066S5;
	Mon, 08 Sep 2025 14:24:52 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: nilay@linux.ibm.com,
	ming.lei@redhat.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH for-6.18/block 01/10] blk-mq: remove useless checking in queue_requests_store()
Date: Mon,  8 Sep 2025 14:15:24 +0800
Message-Id: <20250908061533.3062917-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250908061533.3062917-1-yukuai1@huaweicloud.com>
References: <20250908061533.3062917-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3QY6xdr5oCGEjBw--.62066S5
X-Coremail-Antispam: 1UD129KBjvdXoW7JrWxurW3KF13Aw47ZFy8Grg_yoWxtFg_GF
	yUKr9FqFsakr4xZr47Ar10qF4xCw4rJF45WFWDJas5AFyfJas3K3y8Xr1rAr47ua9rGa1r
	Gw1xG34xCF40vjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbkxFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY02
	0Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
	wVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
	nUUI43ZEXa7VUbn2-7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

blk_mq_queue_attr_visible() already checked queue_is_mq(), no need to
check this again in queue_requests_store().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
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

