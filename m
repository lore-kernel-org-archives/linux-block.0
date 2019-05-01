Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA8AC43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E0E20866
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oLq0DTGx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfEAE3l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 00:29:41 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:27525 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfEAE3k (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 00:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556685066; x=1588221066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KNeqaaprCDiDG1e2U4YFJwk3tWJ7fUPNDMu8AvrqQp4=;
  b=oLq0DTGxZS10UKGA8cbP1Ow4P2DBzW00pR5N5I9kwjdY/+MINOwNMw1s
   UR0l48cZYe4EYxORmIJZ/r58eVYn7HHowEbgnO65Fqvag/GYSdbi/ZTIG
   dCQkYK9XGnKg7OoqsUP/GvNjxMVJwhxRWGCM0hQ0hW5Bzgd8gKLn2m5Cl
   naQW9wGTpWzIsHtGRm7mwwAgOgBypjhYpLNvyY28NvjhHIZtdzkdFTNhK
   v9TmlFhX4tTlb4bB4aOCHyCa8OvCxhPaoWUi+dY34kcQKS7IMNWdMmRLG
   Elmyc+Jw90mbB3zHXMExPs8hOKMkaOnxKqlvzgbYLR8I/BVLr0D9ZiKW0
   w==;
X-IronPort-AV: E=Sophos;i="5.60,416,1549900800"; 
   d="scan'208";a="206432305"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 12:31:06 +0800
IronPort-SDR: 8lG3wfAVYZzXhSZ+ukX0WcTRzRjw1CGqK/vFshxObukeobLc6o7d8SfdNsErjEMzLhIfxYFrx5
 Wt/uIceSRT5qaXrpy7l8JM/TouGCP9t6haNxQ+IuhsMVrgNvuP89xP9l2xYVBwgIIxIZHTc1fW
 b/xgEMlP/xz5R5CIgPIxmcaUu9848sNCU+c+Hheug9qyiQLU2/4CzcwjsX/i1c0pLOdkbKfsCa
 KXB8oeKJmseAeBqkbx+5sSH0GKocFjLXZSXEKAeccr49V/jYwmRkqTEIOd+63CXrrub3m9b9FI
 p4+lwhQls7QvUXk1g5xGZ5U5
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 Apr 2019 21:08:09 -0700
IronPort-SDR: eFOaQKTeo3T9aVl4NNHidliKwFf42YbJqAXWoo1bgdjXK1GsJKUKSxDTrTJjY/EhpodJana0YB
 wKlhWmm7VfLWsCcO7/87ynA1cG6z/P0xOthBUyY4I582IhhbcEMnXbXO5YBegRhE1DBLA5VWYm
 RU/dfpxu4I2oaaLlzUZi6lqM8CCFeVJoKkObvxZNu9HB40o0E8Eq6IgkC/pfJYwrjuJbZnt+nV
 IitgsgAuT2fph245Z1cYgB+htB7ViL/OhsFisrDTNKvix4HPKDnDuVBiiU/PJDjl8F5VTVgMzX
 tEA=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Apr 2019 21:29:41 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 18/18] null_blk: add module param discard/write-zeroes
Date:   Tue, 30 Apr 2019 21:28:31 -0700
Message-Id: <20190501042831.5313-19-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
References: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds a two new module params discard and write-zeroes
in order to test the REQ_OP_DISACRD and REQ_OP_WRITE_ZEROES
operations.

This is needed to test latest blktrace code changes which enables
us to track more request based operations such as write-zeroes.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/null_blk_main.c | 37 +++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index d7ac09c092f2..93fe2c843d03 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -192,6 +192,14 @@ static unsigned int g_zone_nr_conv;
 module_param_named(zone_nr_conv, g_zone_nr_conv, uint, 0444);
 MODULE_PARM_DESC(zone_nr_conv, "Number of conventional zones when block device is zoned. Default: 0");
 
+static bool g_discard;
+module_param_named(discard, g_discard, bool, 0444);
+MODULE_PARM_DESC(discard, "Allow REQ_OP_DISCARD processing. Default: false");
+
+static bool g_write_zeroes;
+module_param_named(write_zeroes, g_write_zeroes, bool, 0444);
+MODULE_PARM_DESC(write_zeroes, "Allow REQ_OP_WRITE_ZEROES processing. Default: false");
+
 static struct nullb_device *null_alloc_dev(void);
 static void null_free_dev(struct nullb_device *dev);
 static void null_del_dev(struct nullb *nullb);
@@ -527,6 +535,12 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->zoned = g_zoned;
 	dev->zone_size = g_zone_size;
 	dev->zone_nr_conv = g_zone_nr_conv;
+	dev->discard = g_discard;
+	dev->write_zeroes = g_write_zeroes;
+	pr_info("null_blk: discard  %s\n",
+			dev->discard == true ? "TRUE" : "FALSE");
+	pr_info("null_blk: write_zeroes %s\n",
+			dev->write_zeroes == true ? "TRUE" : "FALSE");
 	return dev;
 }
 
@@ -1059,7 +1073,11 @@ static int null_handle_rq(struct nullb_cmd *cmd)
 
 	sector = blk_rq_pos(rq);
 
-	if (req_op(rq) == REQ_OP_DISCARD) {
+	/* just discard for write zeroes for now */
+	switch (req_op(rq)) {
+	case REQ_OP_DISCARD:
+		/* fall through */
+	case REQ_OP_WRITE_ZEROES:
 		null_handle_discard(nullb, sector, blk_rq_bytes(rq));
 		return 0;
 	}
@@ -1093,7 +1111,11 @@ static int null_handle_bio(struct nullb_cmd *cmd)
 
 	sector = bio->bi_iter.bi_sector;
 
-	if (bio_op(bio) == REQ_OP_DISCARD) {
+	/* just discard for write zeroes for now */
+	switch (bio_op(bio)) {
+	case REQ_OP_DISCARD:
+		/* fall through */
+	case REQ_OP_WRITE_ZEROES:
 		null_handle_discard(nullb, sector,
 			bio_sectors(bio) << SECTOR_SHIFT);
 		return 0;
@@ -1192,7 +1214,6 @@ static blk_status_t null_handle_cmd(struct nullb_cmd *cmd)
 		}
 	}
 	cmd->error = errno_to_blk_status(err);
-
 	if (!cmd->error && dev->zoned) {
 		sector_t sector;
 		unsigned int nr_sectors;
@@ -1402,7 +1423,7 @@ static void null_del_dev(struct nullb *nullb)
 
 static void null_config_discard(struct nullb *nullb)
 {
-	if (nullb->dev->discard == false)
+	if (!nullb->dev->discard)
 		return;
 	nullb->q->limits.discard_granularity = nullb->dev->blocksize;
 	nullb->q->limits.discard_alignment = nullb->dev->blocksize;
@@ -1410,6 +1431,13 @@ static void null_config_discard(struct nullb *nullb)
 	blk_queue_flag_set(QUEUE_FLAG_DISCARD, nullb->q);
 }
 
+static void null_config_write_zeroes(struct nullb *nullb)
+{
+	if (!nullb->dev->write_zeroes)
+		return;
+	blk_queue_max_write_zeroes_sectors(nullb->q, UINT_MAX >> 9);
+}
+
 static int null_open(struct block_device *bdev, fmode_t mode)
 {
 	return 0;
@@ -1702,6 +1730,7 @@ static int null_add_dev(struct nullb_device *dev)
 	blk_queue_physical_block_size(nullb->q, dev->blocksize);
 
 	null_config_discard(nullb);
+	null_config_write_zeroes(nullb);
 
 	sprintf(nullb->disk_name, "nullb%d", nullb->index);
 
-- 
2.19.1

