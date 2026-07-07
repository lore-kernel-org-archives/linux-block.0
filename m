Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF32537DEAF;
	Tue,  7 Jul 2026 03:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783393411; cv=none; b=Q772PxvsncFUB4YOzPwMjWogaIO+YLYs+yT9KS2vokr9ll2e/n5Yw7E3MwdIEkfpCJPU61klVaKLXkIJ5SR0guTbk8JRs39E+dhK71lkLr50vGW9wJAF7CaXjswrJXWCcCqN3sFLE+3C6lODscLAZ3EICj7MRFAdXCT2MJPJJfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783393411; c=relaxed/simple;
	bh=EBimzj8Ww2a7zqmAx5myurPgLZr2qQ9ifNY4XLEZ+30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AB1bs2ml8lIcwi5YketsUtiYKbf0F9EkC1WCXHwEBPs3P35gmo4TI7VLPAta6ZCRQztQas/cy5hKxsn+GUbyVNfzntJnFlRAuPN/u/7DurGFPmtMaMhI+JiCkBvZMFKZmE0qAoai380ly/8rSOStoI7K7cEnfD1NOlxqSBQwVSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gvQyz4w9CzYQtk2;
	Tue,  7 Jul 2026 11:03:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 51D474056D;
	Tue,  7 Jul 2026 11:03:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgA3SHR8bExq6ahUAQ--.61638S8;
	Tue, 07 Jul 2026 11:03:26 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	dlemoal@kernel.org,
	nilay@linux.ibm.com,
	linux-block@vger.kernel.org,
	kch@nvidia.com,
	johannes.thumshirn@wdc.com,
	kbusch@kernel.org,
	bvanassche@acm.org
Cc: linux-kernel@vger.kernel.org,
	yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	wozizhi@huawei.com
Subject: [PATCH V2 4/6] null_blk: move unregister_blkdev() after destroying dev in null_exit()
Date: Tue,  7 Jul 2026 10:55:40 +0800
Message-ID: <20260707025542.1299859-5-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260707025542.1299859-1-wozizhi@huaweicloud.com>
References: <20260707025542.1299859-1-wozizhi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3SHR8bExq6ahUAQ--.61638S8
X-Coremail-Antispam: 1UD129KBjvJXoW7Xr48Cw1UKFW3GF4kAFWUJwb_yoW8Jr43pr
	45W340kr1jyF47Zr4UAa1xKFy5tan5tryj9rWUCa9YvrZ8Ary29w1Dtas8WF1UKw4xAr4S
	vFyvqa4fJayDAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7I
	U1aLvJUUUUU==
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

In null_exit(), unregister_blkdev() was called before the null_blk
instances were destroyed, which is inconsistent with the cleanup order in
null_init(). Move it after null_destroy_dev() so that teardown happens in
the reverse order of initialization.

No functional change intended.

Suggested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Zizhi Wo <wozizhi@huaweicloud.com>
---
 drivers/block/null_blk/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 024c89b36ddc..cab51301560e 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -2194,8 +2194,6 @@ static void __exit null_exit(void)
 
 	configfs_unregister_subsystem(&nullb_subsys);
 
-	unregister_blkdev(null_major, "nullb");
-
 	mutex_lock(&nullb_global_lock);
 	while (!list_empty(&nullb_list)) {
 		nullb = list_entry(nullb_list.next, struct nullb, list);
@@ -2203,6 +2201,8 @@ static void __exit null_exit(void)
 	}
 	mutex_unlock(&nullb_global_lock);
 
+	unregister_blkdev(null_major, "nullb");
+
 	if (tag_set.ops)
 		blk_mq_free_tag_set(&tag_set);
 
-- 
2.52.0

