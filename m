Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D20C282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 06:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE28720989
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 06:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Woino3um"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfA1GKw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 01:10:52 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:20978 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfA1GKw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 01:10:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1548655852; x=1580191852;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AtISQlgux7TuxeKz2+oiQSdEHjM7pEZHAcul/JM6PWQ=;
  b=Woino3um7dLZVs+IC4+xcnyY03UPiwBOrXP8KvYzwaaqMvqoBMyK8KCt
   6aAvTtCoEWaPgIfOJHQcWRsOFA7ZgegTgsY2+J/cAHQjEIiqBDWKvMURO
   2W6PQ3d/RUni2p+vHW3DDHNsmwHVMj7iJfyEmC7nU7q7XeWN7g+GnaYTe
   Ri5hgwD2hwZGzoFReRNGh9hfjOsFnG59IPlFLLINltk8IShjHzuH4eMfT
   x3IHyYQ/TJ2Dk1hT9KKU64BFifn0vCXC1p9X8LkA6EsM6I/6MlfFhTkFo
   yRb78U2nqrgbRyuxAPSEJJrbdaB/YoLdd8e7WAFXNMjbSaYBvvcGGzT1l
   g==;
X-IronPort-AV: E=Sophos;i="5.56,533,1539619200"; 
   d="scan'208";a="101170523"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2019 14:10:52 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 27 Jan 2019 21:49:55 -0800
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2019 22:10:50 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Matias Bjorling <matias.bjorling@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] nullb: Prevent use of legacy request queue mode
Date:   Mon, 28 Jan 2019 15:10:48 +0900
Message-Id: <20190128061048.20778-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When null_blk queue mode is specified together with modprobe/insmod, a
check to prevent setting the nullb device queue mode to 1 (NULL_Q_RQ) is
done. However, the same check is not performed when setting up a nullb
device through configfs, resulting in a oops (NULL pointer dereference
for the device request queue).

Fix this problem by checking for an invalid queue mode value in
null_validate_conf(), propagating -EINVAL to null_add_dev() if the queue
mode is NULL_Q_RQ. While at it, also fix the propagation to user space
of null_add_dev() return value when a nullb device is created through
configfs power attribute.

Fixes: 49f6613632f9 ("nullb: remove leftover legacy request code")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/block/null_blk_main.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 62c9654b9ce8..5570d0da59b4 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -318,9 +318,10 @@ static ssize_t nullb_device_power_store(struct config_item *item,
 	if (!dev->power && newp) {
 		if (test_and_set_bit(NULLB_DEV_FL_UP, &dev->flags))
 			return count;
-		if (null_add_dev(dev)) {
+		ret = null_add_dev(dev);
+		if (ret) {
 			clear_bit(NULLB_DEV_FL_UP, &dev->flags);
-			return -ENOMEM;
+			return ret;
 		}
 
 		set_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags);
@@ -1561,8 +1562,13 @@ static int null_init_tag_set(struct nullb *nullb, struct blk_mq_tag_set *set)
 	return blk_mq_alloc_tag_set(set);
 }
 
-static void null_validate_conf(struct nullb_device *dev)
+static int null_validate_conf(struct nullb_device *dev)
 {
+	if (dev->queue_mode == NULL_Q_RQ) {
+		pr_err("null_blk: legacy IO path no longer available\n");
+		return -EINVAL;
+	}
+
 	dev->blocksize = round_down(dev->blocksize, 512);
 	dev->blocksize = clamp_t(unsigned int, dev->blocksize, 512, 4096);
 
@@ -1588,6 +1594,8 @@ static void null_validate_conf(struct nullb_device *dev)
 	/* can not stop a queue */
 	if (dev->queue_mode == NULL_Q_BIO)
 		dev->mbps = 0;
+
+	return 0;
 }
 
 #ifdef CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION
@@ -1620,7 +1628,9 @@ static int null_add_dev(struct nullb_device *dev)
 	struct nullb *nullb;
 	int rv;
 
-	null_validate_conf(dev);
+	rv = null_validate_conf(dev);
+	if (rv)
+		goto out;
 
 	nullb = kzalloc_node(sizeof(*nullb), GFP_KERNEL, dev->home_node);
 	if (!nullb) {
@@ -1648,8 +1658,10 @@ static int null_add_dev(struct nullb_device *dev)
 		if (rv)
 			goto out_cleanup_queues;
 
-		if (!null_setup_fault())
+		if (!null_setup_fault()) {
+			rv = -EINVAL;
 			goto out_cleanup_queues;
+		}
 
 		nullb->tag_set->timeout = 5 * HZ;
 		nullb->q = blk_mq_init_queue(nullb->tag_set);
-- 
2.20.1

