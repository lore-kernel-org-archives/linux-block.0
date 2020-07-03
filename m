Return-Path: <SRS0=jyL6=AO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB90C433DF
	for <linux-block@archiver.kernel.org>; Fri,  3 Jul 2020 01:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08EB7208FE
	for <linux-block@archiver.kernel.org>; Fri,  3 Jul 2020 01:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Taudftuq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgGCBbc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 21:31:32 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:45738 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgGCBbc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 21:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593739891; x=1625275891;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oNqcmZrtEmu9Wy8TBwR2XSQ4H1EtlfsqqB5FtxCHgPI=;
  b=TaudftuqsLjVWGyMpbbrpVC5+TZyrK9t9l2VZYGfupvsk8M/FI9rvBr/
   BbIQfHQrP03MEUCSibw9oaA/tVFxu7rLEq6xqTd6gnPNh6EiwpWcfSVae
   JC8b3YSQN6/FipwtGgd6fnbt+AhYo7Ab7OJa7J/p/AnEeyLcAeJKH8KRA
   CXZkKzNrcRg2EpV8gxvUSsx8KBc/Z8O7K6/MU/RRAwzwpkIJ3pO+dPKG7
   Y2hiBTBLfYtChSba0hIzeZNdpSfxv+fG07zhgMaCsd5OSyBw6CRHL3Htf
   6KvNNolnDXQPNa5DHSepvvFjY9T1MvswyMeuvdslO4LUHK/8yPgVPJQjo
   A==;
IronPort-SDR: le/HWtO0qBxx9Wio92LVJoiw5khFT5zD+vdFmeqJ0b/aVnJSnWuKftZ73gH5ZIdhAehxwa+SY3
 29Pp9vlIFo7yCzZyV/CEdEAXSLGjNN3BQIK1w0PxeoQqCZ4uhxPXkWOZh9JpXnltXOBh3836h8
 smHLDPjw6sgGOE1Cr3g5yc77M1ryT8Tr/8AeADlt3tCHS5yWCnPbZrWmvUQWDFVVkL+xsQ0m5G
 LYGe6hg+AX+uuuHXA995vXbd9TwCkr1iM95NKf2DjI/sLYPXfl1usd22PkYoH711X+M06A6rpJ
 I7M=
X-IronPort-AV: E=Sophos;i="5.75,306,1589212800"; 
   d="scan'208";a="250770972"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 09:31:31 +0800
IronPort-SDR: pnqM3bmzYee1jOBdCtynw3JGj0ufqKw1t/KiIeCAMKdrjNl865jMY+pgj3iBXnoIJVOWB5z9LD
 wJb8jHRMXtNcYL8tw5m3/2gg6RR8TC3a4=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 18:19:46 -0700
IronPort-SDR: 21JL95z5Mid7uaJxEEzv+8ivQwzPxNMpcyml+z60S0LYrAnRm6BFe6uwjL1qLS8uc3AnesXINT
 d+X1VYsjtppA==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Jul 2020 18:31:32 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH V2] null_blk: add helper for deleting the nullb_list
Date:   Thu,  2 Jul 2020 18:31:30 -0700
Message-Id: <20200703013130.18712-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The nullb_list is destroyed when error occurs in the null_init() and
when removing the module in null_exit(). The identical code is repeated
in those functions which can be a part of helper function. This also
removes the extra variable struct nullb *nullb in the both functions.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---

* Changes from V1:-

1. Add reviewed-by and missing signoff.
2. Replace list_entry() with list_first_entry() in nullb_list
   deletion sequence.

---
 drivers/block/null_blk_main.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 907c6858aec0..5095942d9b53 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1868,11 +1868,23 @@ static int null_add_dev(struct nullb_device *dev)
 	return rv;
 }
 
+static void null_delete_nullb_list(void)
+{
+	struct nullb_device *dev;
+	struct nullb *nullb;
+
+	while (!list_empty(&nullb_list)) {
+		nullb = list_first_entry(nullb_list.next, struct nullb, list);
+		dev = nullb->dev;
+		null_del_dev(nullb);
+		null_free_dev(dev);
+	}
+}
+
 static int __init null_init(void)
 {
 	int ret = 0;
 	unsigned int i;
-	struct nullb *nullb;
 	struct nullb_device *dev;
 
 	if (g_bs > PAGE_SIZE) {
@@ -1939,12 +1951,7 @@ static int __init null_init(void)
 	return 0;
 
 err_dev:
-	while (!list_empty(&nullb_list)) {
-		nullb = list_entry(nullb_list.next, struct nullb, list);
-		dev = nullb->dev;
-		null_del_dev(nullb);
-		null_free_dev(dev);
-	}
+	null_delete_nullb_list();
 	unregister_blkdev(null_major, "nullb");
 err_conf:
 	configfs_unregister_subsystem(&nullb_subsys);
@@ -1956,21 +1963,12 @@ static int __init null_init(void)
 
 static void __exit null_exit(void)
 {
-	struct nullb *nullb;
-
 	configfs_unregister_subsystem(&nullb_subsys);
 
 	unregister_blkdev(null_major, "nullb");
 
 	mutex_lock(&lock);
-	while (!list_empty(&nullb_list)) {
-		struct nullb_device *dev;
-
-		nullb = list_entry(nullb_list.next, struct nullb, list);
-		dev = nullb->dev;
-		null_del_dev(nullb);
-		null_free_dev(dev);
-	}
+	null_delete_nullb_list();
 	mutex_unlock(&lock);
 
 	if (g_queue_mode == NULL_Q_MQ && shared_tags)
-- 
2.26.0

