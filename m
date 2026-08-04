Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2321E43C05E
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 08:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785833345; cv=none; b=kNq1o5ROfPGWdEr4jIZ1w7Kr9K1/uVIWji3gbo+2FCvKvM3V3D+p1dd3ngAJVcA1bEbjdqm9le4bI9ZUAksPA8FVVAHfvzXCNUafre3FL2QsmTdtQzmASXVRVgxu+M8F3Wcy/h+GU8ZzdpFgYyon8TUIhWUxFMAHj5QuKpD5+Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785833345; c=relaxed/simple;
	bh=MhnI+hiL9rAwcbI3OQ/2Ru1RZHOgG0sqdG64QRCuKTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWqFUdapbnJr9DCB7Y8UTiK6PU4swpBHd4PE3LYrpB92sz2g+M0kVl06WBcMr0x6RUY4ZHyOw6G4WmyMPDjDd+o6ZFRwlp8tZcKZ2JArSG8kPyPad9+NqQRDIwVQ9ibG7ASPCwMt/YFquXm0aeNmHYL/OcCWW3iOrdR9dOUuoOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hDnHd1hljzYQv3R
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 16:47:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 4A6B440AA8
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 16:48:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP3 (Coremail) with UTF8SMTPSA id _Ch0CgD35kVrp3Fq71VIBA--.52677S12;
	Tue, 04 Aug 2026 16:48:48 +0800 (CST)
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
Subject: [PATCH v6 8/8] nbd: add pre_defined_connections module parameter for pre-created devices
Date: Tue,  4 Aug 2026 16:39:22 +0800
Message-ID: <20260804083922.1927105-9-yangerkun@huawei.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260804083922.1927105-1-yangerkun@huawei.com>
References: <20260804083922.1927105-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgD35kVrp3Fq71VIBA--.52677S12
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1kur4xZFyxWFy7ZFWfGrg_yoW8Kw1xpF
	W3JFZ3KFZrtr43Ca1vvF1DWFnrG3WDCa4fWF12qw409a15uw1vyFn7tFy5t3yUtF93Aw4U
	X3W5ZF4xuF1UCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmEb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVAKzI0EY4vE52x082I5MxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4U
	JVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1-zstUUUUU==
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
index 481911c5ac50..eec14617fa15 100644
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

