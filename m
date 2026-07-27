Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551CF3DDB1C
	for <linux-block@vger.kernel.org>; Mon, 27 Jul 2026 07:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785138980; cv=none; b=dm85gjOxTDNW3AWGLAHOCcVMsmJkAoa9TnaJoCD8CNnBACGfdosijQsVMXKe+3RHnfRXHys1hjhdhtvBOwrCm4H4Kn9TFxDMjFAq5hLRLI+Evuk4080yw0E9r1SWqCy7g3fENOvVOG0qhYQS7eo7WCoxEKg2eOwioYlphmWq0W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785138980; c=relaxed/simple;
	bh=wQxO6V4o5fhiNV7U3NNc1GtLhQXlKUUUNBqCImJsS/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t6GB5fm6orf9v8rtErtdqOBu2p1KYH5xghayFDTV1KJepz9n0yqv5hmodEaVvDWCTeCk61UkO5kfM4+gy8GjBlfrqL8SrNNpuxutZ3lyq1qIffBZHvMaTqYkT5YfpFxXoURiii1nMwJV5zhoEmtrt9pY8WcaBapJV86osFfaUkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h7rVh0Gk1zKHMYX
	for <linux-block@vger.kernel.org>; Mon, 27 Jul 2026 15:55:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 85A0640570
	for <linux-block@vger.kernel.org>; Mon, 27 Jul 2026 15:56:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP3 (Coremail) with UTF8SMTPSA id _Ch0CgC3pkUbD2dqjEJ1AA--.26468S10;
	Mon, 27 Jul 2026 15:56:15 +0800 (CST)
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
Subject: [PATCH v4 6/7] nbd: remove queue freeze for newly created nbd from netlink path
Date: Mon, 27 Jul 2026 15:47:17 +0800
Message-ID: <20260727074718.414868-7-yangerkun@huawei.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260727074718.414868-1-yangerkun@huawei.com>
References: <20260727074718.414868-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgC3pkUbD2dqjEJ1AA--.26468S10
X-Coremail-Antispam: 1UD129KBjvJXoWxJF45XF4DuFW5Xr48Ww17Wrg_yoW5Gry8pF
	Z8KayktrWktr4xWa4UJFs7WF9xG3W8J3srW347G3yqkrn5XrZavrW0qa45Aa1UXF98CFWa
	yFs8XF4vva1UJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmGb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E
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

Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 drivers/block/nbd.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 4b9f0349877e..2bb98e41b99b 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1937,7 +1937,8 @@ static const struct blk_mq_ops nbd_mq_ops = {
 	.timeout	= nbd_xmit_timeout,
 };
 
-static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
+static struct nbd_device *nbd_dev_add(int index, unsigned int refs,
+				       int nr_hw_queues)
 {
 	struct queue_limits lim = {
 		.max_hw_sectors		= 65536,
@@ -1954,7 +1955,7 @@ static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
 		goto out;
 
 	nbd->tag_set.ops = &nbd_mq_ops;
-	nbd->tag_set.nr_hw_queues = 1;
+	nbd->tag_set.nr_hw_queues = nr_hw_queues;
 	nbd->tag_set.queue_depth = 128;
 	nbd->tag_set.numa_node = NUMA_NO_NODE;
 	nbd->tag_set.cmd_size = sizeof(struct nbd_cmd);
@@ -2208,7 +2209,11 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
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

