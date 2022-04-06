Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DDCC433EF
	for <linux-block@archiver.kernel.org>; Wed,  6 Apr 2022 14:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbiDFOoX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Apr 2022 10:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbiDFOnq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Apr 2022 10:43:46 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CB35D0D3E;
        Wed,  6 Apr 2022 04:10:13 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KYMDm6WYWz4wmT;
        Wed,  6 Apr 2022 19:07:52 +0800 (CST)
Received: from localhost.localdomain (10.175.127.227) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Apr 2022 19:10:11 +0800
From:   Zhang Wensheng <zhangwensheng5@huawei.com>
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nbd@other.debian.org>
Subject: [PATCH -next] nbd: fix possible overflow on 'first_minor' in nbd_dev_add()
Date:   Wed, 6 Apr 2022 19:24:49 +0800
Message-ID: <20220406112449.2203191-1-zhangwensheng5@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When 'index' is a big numbers, it may become negative which forced
to 'int'. then 'index << part_shift' might overflow to a positive
value that is not greater than '0xfffff', then sysfs might complains
about duplicate creation. Because of this, move the 'index' judgment
to the front will fix it and be better.

Fixes: b0d9111a2d53 ("nbd: use an idr to keep track of nbd devices")
Fixes: 940c264984fd ("nbd: fix possible overflow for 'first_minor' in nbd_dev_add()")
Signed-off-by: Zhang Wensheng <zhangwensheng5@huawei.com>
---
 drivers/block/nbd.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 5a1f98494ddd..9448aacbcf0f 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1800,17 +1800,7 @@ static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
 	refcount_set(&nbd->refs, 0);
 	INIT_LIST_HEAD(&nbd->list);
 	disk->major = NBD_MAJOR;
-
-	/* Too big first_minor can cause duplicate creation of
-	 * sysfs files/links, since index << part_shift might overflow, or
-	 * MKDEV() expect that the max bits of first_minor is 20.
-	 */
 	disk->first_minor = index << part_shift;
-	if (disk->first_minor < index || disk->first_minor > MINORMASK) {
-		err = -EINVAL;
-		goto out_free_work;
-	}
-
 	disk->minors = 1 << part_shift;
 	disk->fops = &nbd_fops;
 	disk->private_data = nbd;
@@ -1915,8 +1905,19 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 	if (!netlink_capable(skb, CAP_SYS_ADMIN))
 		return -EPERM;
 
-	if (info->attrs[NBD_ATTR_INDEX])
+	if (info->attrs[NBD_ATTR_INDEX]) {
 		index = nla_get_u32(info->attrs[NBD_ATTR_INDEX]);
+
+		/*
+		 * Too big first_minor can cause duplicate creation of
+		 * sysfs files/links, since index << part_shift might overflow, or
+		 * MKDEV() expect that the max bits of first_minor is 20.
+		 */
+		if (index < 0 || index > MINORMASK >> part_shift) {
+			printk(KERN_ERR "nbd: illegal input index %d\n", index);
+			return -EINVAL;
+		}
+	}
 	if (!info->attrs[NBD_ATTR_SOCKETS]) {
 		printk(KERN_ERR "nbd: must specify at least one socket\n");
 		return -EINVAL;
-- 
2.31.1

