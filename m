Return-Path: <SRS0=x5xE=3G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89860C33CB1
	for <linux-block@archiver.kernel.org>; Fri, 17 Jan 2020 11:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E742083E
	for <linux-block@archiver.kernel.org>; Fri, 17 Jan 2020 11:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgAQLvH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jan 2020 06:51:07 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:35410 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726689AbgAQLvG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jan 2020 06:51:06 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A345CB9D861EFE57526B;
        Fri, 17 Jan 2020 19:51:03 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Fri, 17 Jan 2020
 19:50:54 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>, <sunke32@huawei.com>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] nbd: fix potential NULL pointer fault in connect and disconnect process
Date:   Fri, 17 Jan 2020 19:50:05 +0800
Message-ID: <20200117115005.37006-1-sunke32@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Connect and disconnect a nbd device repeatedly, will cause
NULL pointer fault.

It will appear by the steps:
1. Connect the nbd device and disconnect it, but now nbd device
   is not disconnected totally.
2. Connect the same nbd device again immediately, it will fail
   in nbd_start_device with a EBUSY return value.
3. Wait a second to make sure the last config_refs is reduced
   and run nbd_config_put to disconnect the nbd device totally.
4. Start another process to open the nbd_device, config_refs
   will increase and at the same time disconnect it.

To fix it, add a NBD_HAS_STARTED flag. Set it in nbd_start_device_ioctl
and nbd_genl_connect if nbd device is started successfully.
Clear it in nbd_config_put. Test it in nbd_genl_disconnect and
nbd_genl_reconfigure.

Signed-off-by: Sun Ke <sunke32@huawei.com>
---
 drivers/block/nbd.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index b4607dd96185..ddd364e208ab 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -83,6 +83,7 @@ struct link_dead_args {
 
 #define NBD_DESTROY_ON_DISCONNECT	0
 #define NBD_DISCONNECT_REQUESTED	1
+#define NBD_HAS_STARTED				2
 
 struct nbd_config {
 	u32 flags;
@@ -1215,6 +1216,7 @@ static void nbd_config_put(struct nbd_device *nbd)
 		nbd->disk->queue->limits.discard_alignment = 0;
 		blk_queue_max_discard_sectors(nbd->disk->queue, UINT_MAX);
 		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, nbd->disk->queue);
+		clear_bit(NBD_HAS_STARTED, &nbd->flags);
 
 		mutex_unlock(&nbd->config_lock);
 		nbd_put(nbd);
@@ -1290,6 +1292,8 @@ static int nbd_start_device_ioctl(struct nbd_device *nbd, struct block_device *b
 	ret = nbd_start_device(nbd);
 	if (ret)
 		return ret;
+	else
+		set_bit(NBD_HAS_STARTED, &nbd->flags);
 
 	if (max_part)
 		bdev->bd_invalidated = 1;
@@ -1961,6 +1965,7 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 	mutex_unlock(&nbd->config_lock);
 	if (!ret) {
 		set_bit(NBD_RT_HAS_CONFIG_REF, &config->runtime_flags);
+		set_bit(NBD_HAS_STARTED, &nbd->flags);
 		refcount_inc(&nbd->config_refs);
 		nbd_connect_reply(info, nbd->index);
 	}
@@ -2008,6 +2013,14 @@ static int nbd_genl_disconnect(struct sk_buff *skb, struct genl_info *info)
 		       index);
 		return -EINVAL;
 	}
+
+	if (!test_bit(NBD_HAS_STARTED, &nbd->flags)) {
+		mutex_unlock(&nbd_index_mutex);
+		printk(KERN_ERR "nbd: device at index %d failed to start\n",
+		       index);
+		return -EBUSY;
+	}
+
 	if (!refcount_inc_not_zero(&nbd->refs)) {
 		mutex_unlock(&nbd_index_mutex);
 		printk(KERN_ERR "nbd: device at index %d is going down\n",
@@ -2049,6 +2062,14 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 		       index);
 		return -EINVAL;
 	}
+
+	if (!test_bit(NBD_HAS_STARTED, &nbd->flags)) {
+		mutex_unlock(&nbd_index_mutex);
+		printk(KERN_ERR "nbd: device at index %d failed to start\n",
+		       index);
+		return -EBUSY;
+	}
+
 	if (!refcount_inc_not_zero(&nbd->refs)) {
 		mutex_unlock(&nbd_index_mutex);
 		printk(KERN_ERR "nbd: device at index %d is going down\n",
-- 
2.17.2

