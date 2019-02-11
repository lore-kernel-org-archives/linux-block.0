Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1FEC169C4
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 23:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 977DB20873
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 23:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Yo63PetL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfBKXrT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 18:47:19 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:14651 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbfBKXrT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 18:47:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549928840; x=1581464840;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xeencaVU0zzDDnuC7Mrp3HNbHWbTnU3Mqs3piQX/xW0=;
  b=Yo63PetLF2KWPIKcbAiQsFkhwevv4009+eTqGYytDxxfS+3OzHfy378F
   YC690d8mvOu0aTU7sMmovdzksx+NlDh+d2BMqBulUExyvzyXQPmbPJTmg
   jLkF7FXVdArcI07YyZsO2jqmXNi68w+fH+fYlE7x4mZgy8b0cFk1fGxOm
   UbUxzUDKwqN+F4RZlU5xtuYYSwNz4WEFnh5RQM+MZ9mW5ryAOJdc9ZqC+
   4ZU+CbaS3J6UJpdueNdh88AN5QNTZ1VxvDRSpWLQecgtMfRdmSr1pBJp1
   chJR44uhwAVKf1ZgQy5+pgg3T0ocz6dXK0HM4Y00Rj2tpU6LO3FmeN1s9
   w==;
X-IronPort-AV: E=Sophos;i="5.58,360,1544457600"; 
   d="scan'208";a="102736660"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2019 07:47:19 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 11 Feb 2019 15:27:56 -0800
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Feb 2019 15:47:17 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Matias Bjorling <matias.bjorling@wdc.com>
Subject: [PATCH v3] nullb: Prevent use of legacy request queue mode
Date:   Tue, 12 Feb 2019 08:47:16 +0900
Message-Id: <20190211234716.18816-1-damien.lemoal@wdc.com>
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
the power attribute of configfs.

Finally, remove the "1=rq" value from the list of possible values of
the queue_mode module argument to make it clear that this is no longer
a valid setting.

Fixes: e50b1e327aeb ("null_blk: remove legacy IO path")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---

Changes from v2:
* Fixed "Fixes" tag
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

