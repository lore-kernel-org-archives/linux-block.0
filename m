Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F3F3E1CFB
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 07:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785913699; cv=none; b=cuWacNNrju2dvlLdO1dEbSksQVURLqCczTiLXiBVwSwgnWcbWGjbUQPsiedtWOBriFSuFRwS7s80XByV9yK1mstQxFlLc60iAiPqiKRfTMNK0FBbe7EpIlbeCfQfkNbfib4Tx4qVUhY5bWfeiT1VG88xhVQ4YC0aBCt0tkJjeHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785913699; c=relaxed/simple;
	bh=FezIgx41WZa1bAw2SdHkNwLIB/pCLw8H0X7sCDAP0Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cbJbIOgthL8HZJw6lOH+Eir3PW6vvK4tW8w9+7HmyJoddr/0Tu94VtxCy1SMOUK9/59TgXdTxc2EG8dA/1hHoFESGiyiHJuIcIHh6NVcgTAvPqUVNXRYGGhQXP3z9We8i4c0IvhIaBDFaHNfVarf2HMbRh1JKtcZiS3KjberoL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hFM1271hFzYQtyS
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 15:07:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 9F25840570
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 15:08:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP3 (Coremail) with UTF8SMTPSA id _Ch0CgBXR0ZW4XJqGly6BA--.6211S12;
	Wed, 05 Aug 2026 15:08:11 +0800 (CST)
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
	huawei.libin@huawei.com,
	leijitang@huawei.com,
	linux-block@vger.kernel.org,
	nbd@other.debian.org
Subject: [PATCH v7 8/8] nbd: add pre_defined_connections module parameter for pre-created devices
Date: Wed,  5 Aug 2026 14:58:43 +0800
Message-ID: <20260805065843.3332859-9-yangerkun@huawei.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260805065843.3332859-1-yangerkun@huawei.com>
References: <20260805065843.3332859-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBXR0ZW4XJqGly6BA--.6211S12
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1kur4xZFyxWFy7ZFWfGrg_yoW8Kw1xpF
	W3JFZ3KFZrtr43ua1vvFnrWFnrG3WDCa4xWF12qw4j93W5uw1vyFs7tFy5t3yUtF93Aw1U
	X3W5ZF4xuF1UCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
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
	xVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
	Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZyCLUUUUU=
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

blk_mq_update_nr_hw_queues() in nbd_start_device() may cause a queue
freeze.  The previous commit addressed this for newly created nbd
devices by setting the expected nr_hw_queues in nbd_dev_add().  However,
when reusing an old inactive nbd device, the queue freeze can still
occur if the old nbd->tag_set->nr_hw_queues does not match the new
socket connection count.  Inactive nbd devices can originate from two
sources: loading the nbd module with nbds_max, which sets the default
nr_hw_queues to 1, and the netlink method, which sets nr_hw_queues
according to the expected number of socket connections.  For the first
case, add a module parameter so the default nr_hw_queues can be
changed.  Users who know their expected number of connections can then
prevent queue freezes on pre-created devices via nbds_max.

Before this patchset:
real    0m2.195s
user    0m0.005s
sys     0m0.022s

After this patchset:
real    0m0.090s
user    0m0.004s
sys     0m0.018s

Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 drivers/block/nbd.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index b316129b9a17..f8f51df31ada 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -166,6 +166,7 @@ static struct dentry *nbd_dbg_dir;
 
 static unsigned int nbds_max = 16;
 static int max_part = 16;
+static int pre_defined_connections = 1;
 static int part_shift;
 
 static int nbd_dev_dbg_init(struct nbd_device *nbd);
@@ -2733,8 +2734,13 @@ static int __init nbd_init(void)
 	}
 	nbd_dbg_init();
 
+	if (pre_defined_connections < 1)
+		pre_defined_connections = 1;
+	/* Set to the intended connection count so nbd_start_device() can skip
+	 * the queue-freezing blk_mq_update_nr_hw_queues() call.
+	 */
 	for (i = 0; i < nbds_max; i++)
-		nbd_dev_add(i, 1, 1);
+		nbd_dev_add(i, 1, pre_defined_connections);
 	return 0;
 }
 
@@ -2795,3 +2801,6 @@ module_param(nbds_max, int, 0444);
 MODULE_PARM_DESC(nbds_max, "number of network block devices to initialize (default: 16)");
 module_param(max_part, int, 0444);
 MODULE_PARM_DESC(max_part, "number of partitions per device (default: 16)");
+module_param(pre_defined_connections, int, 0444);
+MODULE_PARM_DESC(pre_defined_connections,
+"number of connections for devices pre-created at module load (default: 1)");
-- 
2.52.0

