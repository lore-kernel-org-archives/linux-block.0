Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952E2385D88
	for <linux-block@vger.kernel.org>; Thu, 25 Jun 2026 08:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782377539; cv=none; b=nPiwIR4YxuwQL3MQqBplkaHGYIKkC0Lts8W7NZyG3G8kaPjfvywAXNZx5OLXsWXA2ZEwmCOsb+Cy4vScIfp7cppqqsd/41ay3FnZJriSC9wptAWEWJ82yp2mVkh6eev6KrAurDzVksKkZhZvA1hus8l0g7YzT1cdRGU/qI5zrNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782377539; c=relaxed/simple;
	bh=/P48uYXzeSZ8qS+g6OJhb2xjNsm2/ESX6wDtKIhfsJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MONNNHeWY53/22fj5/sdWBGkNWsw2i3aX1u183N4cBGMne8Fc8uIvX4iOQBUJrCMjKh6yzu8agizcHrMryAQzKCuQLD+QY3ZKm10cY6t13ropeuILP4lNvPmChqQQoFrOQR7SeSdXWpOEFkiim2YciSADCf9WHXZYkniGK1Bzzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gmCG2506jzYQth2
	for <linux-block@vger.kernel.org>; Thu, 25 Jun 2026 16:51:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 9F54D40B59
	for <linux-block@vger.kernel.org>; Thu, 25 Jun 2026 16:52:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP2 (Coremail) with SMTP id Syh0CgA3rYIw7DxqlmUxDA--.39891S9;
	Thu, 25 Jun 2026 16:52:06 +0800 (CST)
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
	linux-block@vger.kernel.org,
	nbd@other.debian.org
Subject: [PATCH v2 5/5] nbd: set nr_hw_queues at device creation to skip queue freeze
Date: Thu, 25 Jun 2026 16:44:58 +0800
Message-ID: <20260625084458.4171890-6-yangerkun@huawei.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260625084458.4171890-1-yangerkun@huawei.com>
References: <20260625084458.4171890-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgA3rYIw7DxqlmUxDA--.39891S9
X-Coremail-Antispam: 1UD129KBjvJXoWxAF13Aw1fWryxJF1xCFyxAFb_yoWruw17pF
	Wrta95GrWktr42ga95Aw4DuF9xtF18Aa43Ww17t3yFkFn0v3s3u3y8KF1rCr48JF95Ar4a
	v3Z8Zr409a1UZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmGb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l42xK82IY64kExVAvwVAq07x20xyl4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
	JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbWxR3UUUUU==
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

The preceding patches in this series removed the blk_mq_freeze_queue()
call from nbd_add_socket(), eliminating the freeze/unfreeze overhead
during socket insertion.  However, nbd_start_device() still calls
blk_mq_update_nr_hw_queues() when the hardware queue count differs
from the actual number of connections, which introduce freeze too.

There are two reasons nr_hw_queues may not match num_connections:

1. Reusing an existing nbd device (e.g. one pre-created at module
   load which nr_hw_queues always set as 1) that was originally
   configured with a different connection count.  This case genuinely
   requires blk_mq_update_nr_hw_queues() to adjust the hardware
   queue count.

2. Creating a new nbd device via the netlink connect path
   (nbd_genl_connect), where we know the exact number of connections
   upfront from the NBD_ATTR_SOCKETS attribute.  In this case, there
   is no need to default to nr_hw_queues=1 and then update.

This patch optimizes case 2 by setting nr_hw_queues correctly at
device creation time, so that nbd_start_device() can skip
blk_mq_update_nr_hw_queues() entirely when the count already matches.
Two changes are made:

1. Add a nr_hw_queues parameter to nbd_dev_add() so callers can
   specify the desired queue count instead of the hardcoded 1.

2. Add nbd_genl_count_sockets() to count socket FDs from the netlink
   NBD_ATTR_SOCKETS attribute before the device is created, and pass
   the count as nr_hw_queues when creating a new nbd device via
   netlink.

The ioctl path (NBD_SET_SOCK + NBD_DO_IT) remains fully functional:
pre-created devices with nbds_max>0 default to nr_hw_queues=1, and
nbd_start_device() still calls blk_mq_update_nr_hw_queues() when
needed.

Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 drivers/block/nbd.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 953146c85f17..2b6f896037ad 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1952,7 +1952,8 @@ static const struct blk_mq_ops nbd_mq_ops = {
 	.timeout	= nbd_xmit_timeout,
 };
 
-static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
+static struct nbd_device *nbd_dev_add(int index, unsigned int refs,
+				       int nr_hw_queues)
 {
 	struct queue_limits lim = {
 		.max_hw_sectors		= 65536,
@@ -1969,7 +1970,7 @@ static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
 		goto out;
 
 	nbd->tag_set.ops = &nbd_mq_ops;
-	nbd->tag_set.nr_hw_queues = 1;
+	nbd->tag_set.nr_hw_queues = nr_hw_queues;
 	nbd->tag_set.queue_depth = 128;
 	nbd->tag_set.numa_node = NUMA_NO_NODE;
 	nbd->tag_set.cmd_size = sizeof(struct nbd_cmd);
@@ -2092,6 +2093,35 @@ static const struct nla_policy nbd_sock_policy[NBD_SOCK_MAX + 1] = {
 	[NBD_SOCK_FD]			=	{ .type = NLA_U32 },
 };
 
+/*
+ * Count the number of socket FDs in the NBD_ATTR_SOCKETS netlink attribute.
+ * This is used to determine the correct nr_hw_queues before creating the
+ * nbd device, so that blk_mq_update_nr_hw_queues (and its RCU grace period
+ * overhead) can be avoided entirely.
+ */
+static int nbd_genl_count_sockets(struct genl_info *info)
+{
+	struct nlattr *attr;
+	int rem, count = 0;
+
+	if (!info->attrs[NBD_ATTR_SOCKETS])
+		return 0;
+
+	nla_for_each_nested(attr, info->attrs[NBD_ATTR_SOCKETS], rem) {
+		struct nlattr *socks[NBD_SOCK_MAX + 1];
+
+		if (nla_type(attr) != NBD_SOCK_ITEM)
+			continue;
+		if (nla_parse_nested_deprecated(socks, NBD_SOCK_MAX,
+						  attr, nbd_sock_policy,
+						  info->extack) != 0)
+			continue;
+		if (socks[NBD_SOCK_FD])
+			count++;
+	}
+	return count;
+}
+
 /* We don't use this right now since we don't parse the incoming list, but we
  * still want it here so userspace knows what to expect.
  */
@@ -2123,6 +2153,7 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 	struct nbd_device *nbd;
 	struct nbd_config *config;
 	int index = -1;
+	int num_connections = nbd_genl_count_sockets(info);
 	int ret;
 	bool put_dev = false;
 
@@ -2170,7 +2201,7 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 	mutex_unlock(&nbd_index_mutex);
 
 	if (!nbd) {
-		nbd = nbd_dev_add(index, 2);
+		nbd = nbd_dev_add(index, 2, num_connections);
 		if (IS_ERR(nbd)) {
 			pr_err("failed to add new device\n");
 			return PTR_ERR(nbd);
@@ -2737,7 +2768,7 @@ static int __init nbd_init(void)
 	nbd_dbg_init();
 
 	for (i = 0; i < nbds_max; i++)
-		nbd_dev_add(i, 1);
+		nbd_dev_add(i, 1, 1);
 	return 0;
 }
 
-- 
2.52.0

