Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E873546C9
	for <linux-block@vger.kernel.org>; Mon, 13 Jul 2026 07:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783926307; cv=none; b=DlddlAQsZWvdcanAH2sVdIbYqaOBGEE5Uc0Hy/EqSvM4hdX0r7knLBHl40L6qDK0p0di7X/yy14JVFsC77Xcb5W07z6Unznyy3TcEvCitcXyJA4F+a726cMgeUiOhNkwVuRSWid1iZ18Fpz1g5j4gj/sPluXaDxjj4rREmEEo2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783926307; c=relaxed/simple;
	bh=8t00DEHBQpjdaRCYh1LE9lqm3nNezifiK1ZqTD83A/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M1k/DUemDcp4OeSuuJjG39Lch7IozBDS8ROHXwA1u/IS1Xzso9RQBU4JgQsnmfmCge8hs3FvbBYrHrWwIx+s7c+dAPpA1fxlkncfda2Ii9o8sgmEw0GCzqL/2cKoRDCxJZo2N2ufRs/4uX6MHjzNGRJHJV23/m6OHrKdgOEBFX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gzD2g6yrpzYQtll
	for <linux-block@vger.kernel.org>; Mon, 13 Jul 2026 15:04:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2F6894058F
	for <linux-block@vger.kernel.org>; Mon, 13 Jul 2026 15:04:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgD3B3QQjlRq9dc7BA--.38720S8;
	Mon, 13 Jul 2026 15:04:56 +0800 (CST)
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
Subject: [PATCH v3 4/6] nbd: set nr_hw_queues at device creation to skip queue freeze
Date: Mon, 13 Jul 2026 14:56:42 +0800
Message-ID: <20260713065644.1637594-5-yangerkun@huawei.com>
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
X-CM-TRANSID:cCh0CgD3B3QQjlRq9dc7BA--.38720S8
X-Coremail-Antispam: 1UD129KBjvJXoWxCF1rWry3Xr43ZF15Jr45GFg_yoW5ZFy3pF
	45Ka95KrWDtr42gay3Aa1DuFy3KF18C34ag347J3yFkrnIqr93urWrtFyrCF1rJF98CFsI
	van8Zr4I9w4UXFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmCb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVAKzI0EY4vE52x082I5MxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7
	xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_
	Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZyCLUUUUU=
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

There still be queue freeze call when nbd_start_device invoking
blk_mq_update_nr_hw_queues. For netlink path, we can obtain the actual
number of connections before calling nbd_dev_add in nbd_genl_connect,
which can helps remove this queue freeze.

However, nbd devices created with a fixed nbds_max may still require
this freezing because the real connection count is unknown.

Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 drivers/block/nbd.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 0755b7046ed4..400f638e832e 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1930,7 +1930,8 @@ static const struct blk_mq_ops nbd_mq_ops = {
 	.timeout	= nbd_xmit_timeout,
 };
 
-static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
+static struct nbd_device *nbd_dev_add(int index, unsigned int refs,
+				       int nr_hw_queues)
 {
 	struct queue_limits lim = {
 		.max_hw_sectors		= 65536,
@@ -1947,7 +1948,7 @@ static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
 		goto out;
 
 	nbd->tag_set.ops = &nbd_mq_ops;
-	nbd->tag_set.nr_hw_queues = 1;
+	nbd->tag_set.nr_hw_queues = nr_hw_queues;
 	nbd->tag_set.queue_depth = 128;
 	nbd->tag_set.numa_node = NUMA_NO_NODE;
 	nbd->tag_set.cmd_size = sizeof(struct nbd_cmd);
@@ -2070,6 +2071,35 @@ static const struct nla_policy nbd_sock_policy[NBD_SOCK_MAX + 1] = {
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
@@ -2101,6 +2131,7 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 	struct nbd_device *nbd;
 	struct nbd_config *config;
 	int index = -1;
+	int num_connections = nbd_genl_count_sockets(info);
 	int ret;
 	bool put_dev = false;
 
@@ -2148,7 +2179,7 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 	mutex_unlock(&nbd_index_mutex);
 
 	if (!nbd) {
-		nbd = nbd_dev_add(index, 2);
+		nbd = nbd_dev_add(index, 2, num_connections);
 		if (IS_ERR(nbd)) {
 			pr_err("failed to add new device\n");
 			return PTR_ERR(nbd);
@@ -2715,7 +2746,7 @@ static int __init nbd_init(void)
 	nbd_dbg_init();
 
 	for (i = 0; i < nbds_max; i++)
-		nbd_dev_add(i, 1);
+		nbd_dev_add(i, 1, 1);
 	return 0;
 }
 
-- 
2.52.0

