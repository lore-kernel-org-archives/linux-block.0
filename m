Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775A141D109
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 08:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785833345; cv=none; b=VFbIfkfShzuR+UAhajNEYoKj6sp4eoMvCVQ6ObzhpsemHp8XW/rG7UoSdi7Kywr//QkeJKMlvcwEqUbYczLzjPQTiVZ8Cn/Oy8EUpWJ7whyVfm0lDDaDt5+TFB8i2AQPR3/EYNHNnglSRacOYt/0gzbXZBGqB4Xsjw6vKaZGLYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785833345; c=relaxed/simple;
	bh=tBhJJnMe9LT6vGhqEZAQ7bbr0qqoSfQdFkKmPW+XNLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S3n8TD/4Z63AlfVGblRj+HorY9R96NCPJeK59XddhNecJ+g3KODjnewwlvX01eGAXlyHeVpIvO1cI8sI5G+AJgZJMiDoJep/Je4OiDf1uurlL1zcRx3BANqw4x7X94VW0wBp54mp6aMjPqdKRtGb6bWRbE0GeXodYqDil2HnsL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hDnHd1MHQzYQv7S
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 16:47:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 3EE5040A97
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 16:48:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP3 (Coremail) with UTF8SMTPSA id _Ch0CgD35kVrp3Fq71VIBA--.52677S11;
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
Subject: [PATCH v6 7/8] nbd: remove queue freeze for newly created nbd from netlink path
Date: Tue,  4 Aug 2026 16:39:21 +0800
Message-ID: <20260804083922.1927105-8-yangerkun@huawei.com>
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
X-CM-TRANSID:_Ch0CgD35kVrp3Fq71VIBA--.52677S11
X-Coremail-Antispam: 1UD129KBjvJXoWxJF45XF4DuFW5Xr48Ww17Wrg_yoW5GF4xpF
	45Kay8trW8tr4xWa4DJFs7WFn8G3W8J3srWry7G34jkrnxXrZavrW0qFy5Aa1UZF9YyFWa
	yFs8XF4vva1UJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Previous commits has removed the queue freeze in nbd_add_socket and
nbd_set_size during nbd device setup. However, a queue freeze can still
occur when nbd_start_device calls blk_mq_update_nr_hw_queues if the
socket connection count does not match nbd->tag_set->nr_hw_queues.

The nbd_start_device function can be invoked through either the ioctl or
netlink paths. The ioctl path only allows reusing an existing inactivate
nbd device, there is nothing more we can do to prevent the queue freeze
since the old nbd->tag_set->nr_hw_queues may not match the new socket
connection count. Similarly, the netlink path can reuse a preferred
inactivate nbd device, and again, we cannot do more in this scenario.
However, the netlink path can also add a new nbd device using
nbd_dev_add. In this case, we can obtain the new number of socket
connections, and by adding a new argument representing the expected
nr_hw_queues in nbd_dev_add, we can ensure the queue freeze is avoided
for this situation.

Reviewed-by: Yu Kuai <yukuai@fygo.io>
Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 drivers/block/nbd.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index c080bb95653b..481911c5ac50 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1944,7 +1944,8 @@ static const struct blk_mq_ops nbd_mq_ops = {
 	.timeout	= nbd_xmit_timeout,
 };
 
-static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
+static struct nbd_device *nbd_dev_add(int index, unsigned int refs,
+				       int nr_hw_queues)
 {
 	struct queue_limits lim = {
 		.max_hw_sectors		= 65536,
@@ -1961,7 +1962,7 @@ static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
 		goto out;
 
 	nbd->tag_set.ops = &nbd_mq_ops;
-	nbd->tag_set.nr_hw_queues = 1;
+	nbd->tag_set.nr_hw_queues = nr_hw_queues;
 	nbd->tag_set.queue_depth = 128;
 	nbd->tag_set.numa_node = NUMA_NO_NODE;
 	nbd->tag_set.cmd_size = sizeof(struct nbd_cmd);
@@ -2214,7 +2215,11 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 	mutex_unlock(&nbd_index_mutex);
 
 	if (!nbd) {
-		nbd = nbd_dev_add(index, 2);
+		ret = nbd_genl_foreach_sock(info, NULL, NULL);
+		if (ret < 0)
+			return ret;
+
+		nbd = nbd_dev_add(index, 2, ret > 0 ? ret : 1);
 		if (IS_ERR(nbd)) {
 			pr_err("failed to add new device\n");
 			return PTR_ERR(nbd);
@@ -2729,7 +2734,7 @@ static int __init nbd_init(void)
 	nbd_dbg_init();
 
 	for (i = 0; i < nbds_max; i++)
-		nbd_dev_add(i, 1);
+		nbd_dev_add(i, 1, 1);
 	return 0;
 }
 
-- 
2.52.0

