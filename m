Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2025A331EC1
	for <linux-block@vger.kernel.org>; Sat, 25 Jul 2026 02:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784946841; cv=none; b=pK16NX7Vv/1R/5sPhbOw2MFZaMs/Yta5Uoi1tIsL99ZFnAGiM4FnB+0yWmG1wBGIum70j7kt1jQMoCxb/cUIcKMGUKAMu12XNraq32eebjtAIU/PiR6rifhWzkw/ui638aKkL1Q3xS4LzHXtopaXwPuqchOAzNX6mN08BepMA50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784946841; c=relaxed/simple;
	bh=7jDL0oIxqBlTqI7qrQ0kTFI0Bd3+Z1QaSd0iisfOBz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MBk8pIP7zdGluDnn598xbCqxiFhSSjhL2vnqyBmS5sNVrmGvqNamkLPxxVg+0tZQ6YTMWEg88jBp3MBFV+wLDgra1mHPHjVuRnPKszhiojdVTXXzCwmlsqXr4H7KG4fRDscqnlwCKvsXadckk0DVvgo0ViX4mppXaeOyo8Yj4R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h6TRm1lVMzKHMXf
	for <linux-block@vger.kernel.org>; Sat, 25 Jul 2026 10:33:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1FF6C4082E
	for <linux-block@vger.kernel.org>; Sat, 25 Jul 2026 10:33:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgA3SHSSIGRqCkPTCQ--.40042S7;
	Sat, 25 Jul 2026 10:33:55 +0800 (CST)
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
Subject: [PATCH V6 03/10] null_blk: move unregister_blkdev() after destroying dev in null_exit()
Date: Sat, 25 Jul 2026 10:25:02 +0800
Message-ID: <20260725022509.714271-4-wozizhi@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgA3SHSSIGRqCkPTCQ--.40042S7
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw47ZF4xKFWrurW8Jr4UCFg_yoW8GF1DpF
	45W3Wjkr10kF1UZF4UC3WxAFy5Gan7GrWI9rWUCa4Fv398Zry29wnrta4rXF1Dt3yxCF4S
	vF1vva4SqayDArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14
	v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU14x
	RDUUUUU==
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

In null_exit(), unregister_blkdev() is called before the null_blk instances
are destroyed, which is inconsistent with the cleanup order in null_init().
Move it after null_destroy_dev() so that teardown happens in the reverse
order of initialization.

No functional change intended.

Suggested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/block/null_blk/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 4613035222cd..6cb213779cc5 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -2194,8 +2194,6 @@ static void __exit null_exit(void)
 
 	configfs_unregister_subsystem(&nullb_subsys);
 
-	unregister_blkdev(null_major, "nullb");
-
 	mutex_lock(&lock);
 	while (!list_empty(&nullb_list)) {
 		nullb = list_entry(nullb_list.next, struct nullb, list);
@@ -2203,6 +2201,8 @@ static void __exit null_exit(void)
 	}
 	mutex_unlock(&lock);
 
+	unregister_blkdev(null_major, "nullb");
+
 	if (tag_set.ops)
 		blk_mq_free_tag_set(&tag_set);
 
-- 
2.52.0

