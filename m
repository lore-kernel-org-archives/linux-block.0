Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB45D368D4B
	for <linux-block@vger.kernel.org>; Mon, 13 Jul 2026 07:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783926306; cv=none; b=q13T/9i5vn4CmOQ795PQ6/DxxARovIg7aKCDyNikEr7W/1OQduMe24xBDwlpFyMUloNen2HuAq+bAA94tkZRa3LzIFxJ+RsJT1Ta7WSTTj2RH+L8bEF7fYzlnVvI45CyrbTK/G9HY+zlTeGsf3a+/6cbopX4LR+5Fw40LW1uZzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783926306; c=relaxed/simple;
	bh=+NJRUCIsFFqwqUzpYtQUOYNzJKrwrV2P9PCWORjMkhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HjlKqsEEvnX6enLePlE84zum+i1JoWORPiN4OW+YGYX9aH6YejruMJqfMSHKFeVy5MZjz/Ab6QGbCrzHYdmiL73xrX6+kUFJLGgVb7hS6IWwhNR5ya/RX6Zs25dmK7xjXrlNhBMNUKXljXv9zFLmSsb9B3L2vj70F0xMSTTnvTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gzD2N4LZDzKHMPK
	for <linux-block@vger.kernel.org>; Mon, 13 Jul 2026 15:04:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 4F9F44056D
	for <linux-block@vger.kernel.org>; Mon, 13 Jul 2026 15:04:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgD3B3QQjlRq9dc7BA--.38720S10;
	Mon, 13 Jul 2026 15:04:57 +0800 (CST)
From: Yang Erkun <yangerkun@huawei.com>
To: josef@toxicpanda.com,
	axboe@kernel.dk,
	hch@lst.de,
	yukuai@kernel.org
Cc: yi.zhang@huawei.com,
	chengzhihao1@huawei.com,
	echo.chenlin@huawei.com,
	leo.lilong@huaweicloud.com,
	wangkefeng.wang@huawei.com,
	yangerkun@huawei.com,
	linux-block@vger.kernel.org,
	nbd@other.debian.org
Subject: [PATCH v3 6/6] nbd: add nr_hw_queues module parameter for pre-created devices
Date: Mon, 13 Jul 2026 14:56:44 +0800
Message-ID: <20260713065644.1637594-7-yangerkun@huawei.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260713065644.1637594-1-yangerkun@huawei.com>
References: <20260713065644.1637594-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgD3B3QQjlRq9dc7BA--.38720S10
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy7WFyxtw4kXrW3Xry3CFg_yoW8ArWUpF
	W5tFZrKFWxKr43uaykXwnrWFn8Ga4kC34fWF1xt34xuFy5Zwnavr97ta4Yqr1UtF9xAF4Y
	v3WDZF48GF4UCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmKb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7Cj
	xVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
	kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF04k20xvEw4C26cxK6c8Ij28IcwCFx2Iq
	xVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
	106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
	xVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
	6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFPETDUUUU
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

Previous commit can help remove all freeze for netlink newly created nbd
device. But for the devices pre-created at module load(nbds_max default
as 16), the nr_hw_queues was setting default as 1, then ioctl/netlink
path will set the real connection count, and blk_mq_update_nr_hw_queues
in nbd_start_device will introduce freeze.

Add an nr_hw_queues module parameter so that users who know their
expected connection count can pre-created devices with the right queue
count to avoid this freeze too.

Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 drivers/block/nbd.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 2c7b09c70da2..f918c9efa9b2 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -166,6 +166,7 @@ static struct dentry *nbd_dbg_dir;
 
 static unsigned int nbds_max = 16;
 static int max_part = 16;
+static int nr_hw_queues = 1;
 static int part_shift;
 
 static int nbd_dev_dbg_init(struct nbd_device *nbd);
@@ -2752,8 +2753,10 @@ static int __init nbd_init(void)
 	}
 	nbd_dbg_init();
 
+	if (nr_hw_queues < 1)
+		nr_hw_queues = 1;
 	for (i = 0; i < nbds_max; i++)
-		nbd_dev_add(i, 1, 1);
+		nbd_dev_add(i, 1, nr_hw_queues);
 	return 0;
 }
 
@@ -2814,3 +2817,6 @@ module_param(nbds_max, int, 0444);
 MODULE_PARM_DESC(nbds_max, "number of network block devices to initialize (default: 16)");
 module_param(max_part, int, 0444);
 MODULE_PARM_DESC(max_part, "number of partitions per device (default: 16)");
+module_param(nr_hw_queues, int, 0444);
+MODULE_PARM_DESC(nr_hw_queues,
+"number of hardware queues for devices pre-created at module load (default: 1). ");
-- 
2.52.0

