Return-Path: <SRS0=2dDp=UK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63666C31E44
	for <linux-block@archiver.kernel.org>; Tue, 11 Jun 2019 22:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2967F2086D
	for <linux-block@archiver.kernel.org>; Tue, 11 Jun 2019 22:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ObJ+sjuE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436708AbfFKWKU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jun 2019 18:10:20 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:62318 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405693AbfFKWKU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jun 2019 18:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560291020; x=1591827020;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FwNrFS19gZBpiQUVxfbKuN9J31C+dx/u6l8+/JpPrc8=;
  b=ObJ+sjuEcZ6olVDQchIvNP8Pa2G9z0H5oQQWQgfK6t6vXSXB7cjZbzln
   dzbppetAnu+wYAKcKdUpW1Q1RM6q2/xC3DQ4tuicXfblqv8y3roxtvjUZ
   GanEUQK/gPoywYgrb9NvYU++nb6WTxvm39dEDDJ2hCfVQQ/l3npXFxpDS
   ePKlw3wC+EEBhvD2xFGOvaWy/tI6tY4KJ/RiF6EmrTFMQputK7geaWEIe
   ZWiL8I31IMRgg+tNYHKeahLsdGc1MuNTlGUG9GwlV8aSDpCt6Qons4EIK
   kePyZwWxfw1BBcac6/7wN6uhVDdW+NEQyDhuYpDmlt4Z43OkfwEvzhkRp
   A==;
X-IronPort-AV: E=Sophos;i="5.63,363,1557158400"; 
   d="scan'208";a="111591004"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jun 2019 06:10:20 +0800
IronPort-SDR: vjBiReD1cZSeTTa2N7TbScKkOE5FhbP6WKXk7l1KAfEYZAZGCxgcvhxlNc1LhQowY+8v5u8oST
 RdAa4N+gkroYpVuwE8GzruvrBK2i9AlGTGAyClxmxgZT89BaLAqVKPE+8ZS1KWfvfWE3gBtD5o
 tsUpTG10QQahpd6xNThLHgcLoz/d86Xy0N7r/luAQ+8BFKOJPzXEuBkRWiItKDudXXSpc/PUka
 wAnK9AC98vMLh7JKZ6UvfzrkTRZ2+wIHDw6XUjqCJ5IyJSSKLBGjWJv1AaVjdGODBSj8J3bzzR
 Tu+6gmSYWODx623sgztx1c31
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 11 Jun 2019 15:10:08 -0700
IronPort-SDR: wR1R8VpOo18iBQBzFSyeOd/51iPIFmwJmRBPldcZz9aPqNh2uRt3Fu2yce+tsq313WuubWidlC
 2uWaUJs7VRIJ5IkxCMzUGBPEJdWR5iFiGRyiyzH975h/xKE8QCU1m3NS61h2n9TpM6MTKBQuv2
 v1rG5xFj1vmhDWv9+jqzUFUyudCUA2YFty8izzT7V/W5//iEls6rd2jNYl4QZKFgnlqlCHI9qW
 Z82NfaPRslLTt+hJA8uz4LHv9wOuhL+iRLfGnk5TZcrbHLf6fhK72ClckygOO3/jCyPqVaX8OR
 ebw=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Jun 2019 15:10:19 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH] null_blk: remove duplicate check for report zone
Date:   Tue, 11 Jun 2019 15:10:17 -0700
Message-Id: <20190611221017.10264-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch removes the check in the null_blk_zoned for report zone
command, where it checks for the dev-,>zoned before executing the report
zone.

The null_zone_report() function is a block_device operation callback
which is initialized in the null_blk_main.c and gets called as a part
of blkdev for report zone IOCTL (BLKREPORTZONE).

blkdev_ioctl()
blkdev_report_zones_ioctl()
        blkdev_report_zones()
                blk_report_zones()
                        disk->fops->report_zones()
                                nullb_zone_report();

The null_zone_report() will never get executed on the non-zoned block
device, in the non zoned block device blk_queue_is_zoned() will always
be false which is first check the blkdev_report_zones_ioctl()
before actual low level driver report zone callback is executed.

Here is the detailed scenario:-

1. modprobe null_blk
null_init
null_alloc_dev
        dev->zoned = 0 
null_add_dev
        dev->zoned == 0
                so we don't set the q->limits.zoned = BLK_ZONED_HR

2. blkzone report /dev/nullb0

blkdev_ioctl()
blkdev_report_zones_ioctl()
        blk_queue_is_zoned()
                blk_queue_is_zoned
                        q->limits.zoned == 0
                        return false
        if (!blk_queue_is_zoned(q)) <--- true
                return -ENOTTY;              
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/null_blk_zoned.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index 5d1c261a2cfd..fca0c97ff1aa 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -74,10 +74,6 @@ int null_zone_report(struct gendisk *disk, sector_t sector,
 	struct nullb_device *dev = nullb->dev;
 	unsigned int zno, nrz = 0;
 
-	if (!dev->zoned)
-		/* Not a zoned null device */
-		return -EOPNOTSUPP;
-
 	zno = null_zone_no(dev, sector);
 	if (zno < dev->nr_zones) {
 		nrz = min_t(unsigned int, *nr_zones, dev->nr_zones - zno);
-- 
2.19.1

