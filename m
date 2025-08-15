Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A2B27713;
	Fri, 15 Aug 2025 08:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755245411; cv=none; b=kXAbzvcvFGFt/vBFqWtxHEZY9NS3I0ETmf9/PxPISh0adDAlx9xTUIDJFAICfUIb1g0i+QMMnWryetb0fGpzFVYzVCcRatPkNPU2ualBFBjQqNIEVBFOMoHUsaTrY6HhkwtwzXwYg1UcUq1+hO1MgLxtVjkyZn0jDFkPw1BTeok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755245411; c=relaxed/simple;
	bh=n6vReAJVtwzVAOe+TgrKwM2LSZah4lupyvFThnDLfB4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=etX7B9NSHPzYYrZ7k8vnxWclQifWQj9x8GGWzfsONV57CwRYuv1FIOoBMjoVDHScFAR+znEDnugNlQfLqG+CnBSpYZNcgGPjOv3O0YfgvCC9QP802+iUINLbHMFs7fCwa3dvnJJPlLuF+uYVBZeeD9eBA5PPpx0Z1+LO/+2qcBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c3FCN20P6zYQv9D;
	Fri, 15 Aug 2025 16:10:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DA08E1A0944;
	Fri, 15 Aug 2025 16:10:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDHjxBc655o+xX_Dg--.53834S5;
	Fri, 15 Aug 2025 16:10:06 +0800 (CST)
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
Subject: [PATCH 01/10] blk-mq: remove useless checking from queue_requests_store()
Date: Fri, 15 Aug 2025 16:02:07 +0800
Message-Id: <20250815080216.410665-2-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDHjxBc655o+xX_Dg--.53834S5
X-Coremail-Antispam: 1UD129KBjvdXoW7JrWxurW3KF13Aw47ZFy8Grg_yoWxtFg_GF
	y8Kry2qrsakF48Zr47Ar10qF4Ikw1rGF45WFWDJas5AFyfJa4fKrWrXryrAr43ua9rGa1r
	C3WxG34xGr40vjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbkxFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY02
	0Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
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
	nUUI43ZEXa7VUjnXo7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

blk_mq_queue_attr_visible() already checked queue_is_mq(), no need to
check this again in queue_requests_store().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-sysfs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index c5cf79a20842..1086f7b9da28 100644
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

