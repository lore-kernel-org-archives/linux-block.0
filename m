Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1548AC282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 07:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C985220881
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 07:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nNDwusM0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfA1H4i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 02:56:38 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:28956 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfA1H4i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 02:56:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1548662198; x=1580198198;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HDuxIjlMRVuYy6eF85c05Ox+7kFV7CktsAk2KXQYtSw=;
  b=nNDwusM0Ke8v5zW+63ROSvy3lhfVDXAHH2nWhzVQCkWF0UVu8ZhhHmDI
   X7wZwkwLDNk4uGnmcmDvWImnYZO6ayR/la9b6iD0ewaamGaKf54bzQxaS
   lGhcTQIT7329FiItpHtAPev8XHLvFdGLXeVfINAk6Ozq/tKfM6NCkhoaL
   fupcR1GpKHVhTuByT2K2tqdGg1NJfWc17S1Rkmqxa9i+hK38A1tFwVH1t
   xcGIHzScFfvNnTRWgQ5O/U8HAlyb5STxv9NIMDdX5i9+xEXZquTmNoJLV
   BZQ55oXPoXKLS2FFlqjh19rNL7njvXoegSFpTO3stvezDfNGvqa+d7pwA
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,533,1539619200"; 
   d="scan'208";a="104879491"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2019 15:56:38 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 27 Jan 2019 23:35:41 -0800
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2019 23:56:36 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Matias Bjorling <matias.bjorling@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2] nullb: Prevent use of legacy request queue mode
Date:   Mon, 28 Jan 2019 16:56:34 +0900
Message-Id: <20190128075634.25748-1-damien.lemoal@wdc.com>
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

Finally, remove the "1=rq" value from the list of possible values for
the queue_mode attribute/module argument to make it clear that this is
no longer a valid setting.

Fixes: 49f6613632f9 ("nullb: remove leftover legacy request code")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---

Changes from v1:
* Removed reference to rq mode from queue_mode description

 drivers/block/null_blk_main.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 62c9654b9ce8..155dcef3b21a 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -130,7 +130,7 @@ static const struct kernel_param_ops null_queue_mode_param_ops = {
 };
 
 device_param_cb(queue_mode, &null_queue_mode_param_ops, &g_queue_mode, 0444);
-MODULE_PARM_DESC(queue_mode, "Block interface to use (0=bio,1=rq,2=multiqueue)");
+MODULE_PARM_DESC(queue_mode, "Block interface to use (0=bio,2=multiqueue)");
 
 static int g_gb = 250;
 module_param_named(gb, g_gb, int, 0444);
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

