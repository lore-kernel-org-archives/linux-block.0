Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481E33B8D75
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 08:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785400204; cv=none; b=gz20x1h0EhGbCboAS4hWH8CJDS+3ewdQZ2Zp5Svw3q96tKNJrYRLkxgqKP4gRDxwwwx7F8u5RNPEump8UXpV0HJzzy/YwrYOZMxVPeUN/CxEj28jR+REyaAho+2ZtKf3GjoOCsEwSDFlZgwW2UuMYhsm2epw10RbSSPDo4EgiWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785400204; c=relaxed/simple;
	bh=+Eqb96YjxjzQqSKoHvZ8G85ZVQ72ozLrMHmkNgWtbzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nMvw/93mke+2hl7iwnkFaTpBaS5WcGBkNdR3gJM/bekzKYs6IPDtyXXKjZP/6cDIPoY1gg5nRAyCn225Bvf+xtM5zWIenqZZSP76ffOtHt6zggSQejVCVZ7L9qh6KasAfHsPYT6KowZdBv3oTGiEFe6Xmln4KlJbHfFQGVNjMtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h9j624TBczKHMh9
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 16:28:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 0BFA540590
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 16:29:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP3 (Coremail) with UTF8SMTPSA id _Ch0CgCnlkV9C2tqwObjAQ--.20420S11;
	Thu, 30 Jul 2026 16:29:54 +0800 (CST)
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
Subject: [PATCH v5 7/8] nbd: remove queue freeze for newly created nbd from netlink path
Date: Thu, 30 Jul 2026 16:20:45 +0800
Message-ID: <20260730082046.3459239-8-yangerkun@huawei.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260730082046.3459239-1-yangerkun@huawei.com>
References: <20260730082046.3459239-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCnlkV9C2tqwObjAQ--.20420S11
X-Coremail-Antispam: 1UD129KBjvJXoWxJF45XF4DuFW5Xr48Ww17Wrg_yoW5Gry8pF
	Z8Ka95trW8tF4Iga4UJFs3WFn8G3W8J3srW347G3yjkrnxZrZavrW0qa45Aa1UZF9YyF4a
	yan8XF4vva1UArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7Cj
	xVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
	kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF04k20xvEw4C26cxK6c8Ij28IcwCFx2Iq
	xVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
	106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
	xVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8
	Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZyCLUUUUU=
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
index 34b84fc1c61f..6369a409e10c 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1942,7 +1942,8 @@ static const struct blk_mq_ops nbd_mq_ops = {
 	.timeout	= nbd_xmit_timeout,
 };
 
-static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
+static struct nbd_device *nbd_dev_add(int index, unsigned int refs,
+				       int nr_hw_queues)
 {
 	struct queue_limits lim = {
 		.max_hw_sectors		= 65536,
@@ -1959,7 +1960,7 @@ static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
 		goto out;
 
 	nbd->tag_set.ops = &nbd_mq_ops;
-	nbd->tag_set.nr_hw_queues = 1;
+	nbd->tag_set.nr_hw_queues = nr_hw_queues;
 	nbd->tag_set.queue_depth = 128;
 	nbd->tag_set.numa_node = NUMA_NO_NODE;
 	nbd->tag_set.cmd_size = sizeof(struct nbd_cmd);
@@ -2212,7 +2213,11 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
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
@@ -2736,7 +2741,7 @@ static int __init nbd_init(void)
 	nbd_dbg_init();
 
 	for (i = 0; i < nbds_max; i++)
-		nbd_dev_add(i, 1);
+		nbd_dev_add(i, 1, 1);
 	return 0;
 }
 
-- 
2.52.0

