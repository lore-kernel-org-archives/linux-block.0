Return-Path: <SRS0=Ui87=EP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7686BC4741F
	for <linux-block@archiver.kernel.org>; Mon,  9 Nov 2020 12:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11DA320789
	for <linux-block@archiver.kernel.org>; Mon,  9 Nov 2020 12:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="O5FBzsmu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbgKIMvc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Nov 2020 07:51:32 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:43846 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729673AbgKIMvV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Nov 2020 07:51:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604926281; x=1636462281;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=t3J9BSpdpmukqpsDr084sd8dljMOfuJUKhBo9IZmVgc=;
  b=O5FBzsmuyNpzkEJB/91lUTuzk0IIjK5GTrO0AMvwX9SKUu8NUHooeUbg
   tFqR8E/8N9DCLKQ4uPRNh4yPRbftWP/VhkaWgKhy6BSwmYF6occgn1hFv
   lbUyDbiClOJOI89GvFAyflQi/bsA7GRaLLsbpabcnNZlRsklCBfk4k+6b
   AxZPRTEX0M0MJooUTd66F0B1HRS1o3s9WjQmVYH53A8Uzi1zvDpBzJ2CN
   mtuzKIGQni2DL8kQCvbz1ULHy1t54ERQ/OcUiwZPQD5+0lwwIFUsjO7VU
   kLzEGJy9Y3IdpetwrSnXNXiUQXoLbJB1vgABASrlcxTFuLnU+WeLU/sUw
   g==;
IronPort-SDR: zQVuRx048lTp4jYjJElT5Au37bAbN04E/fh9IzJrV4ebZgf9AKDIBnLNGVZY+Hdw5707OQ4KgC
 /VBp7BJLFeFIPgfxINFO3okOWM9roOLG+XCybNRSzSUKuVRO0o0kc7W9iZUxgjvY+4YcqxgxRW
 FmEUoMyu5asnbfLVN5r6IDTwLB3COrHBlMONg65mhKNB9pFTr/adHGPmGXnt8A9knXfFL19tEF
 +QmFt91n/JyGwprDBlvou5F/K4CJEf4tNbLsLDbM97mBxxaBZfBCHnqkLP5Y467Az6Nncbfo5c
 gNg=
X-IronPort-AV: E=Sophos;i="5.77,463,1596470400"; 
   d="scan'208";a="156668402"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Nov 2020 20:51:11 +0800
IronPort-SDR: s2nlFwKvAZWxOEY1EMHMMhyOBmuf/VOVixvmQbQc2aKRHdruQZ7vjAnbiuERs6zM1RB4IwzdjA
 SeHRS1bQEl6mkRIWl+DOdDiaDQdB23eIjnhWLzWV8nD+xUVLJpNnHwLA+LQibBwiU93bEuVG8R
 lU6CSyLL3T1vDHbl9zQRL7h7akaow9O8VQvgvL4fra68pHPKMgJIDAU3QlK61T9kgTj7g14Atl
 Xp82whz4y91ALrOcfnknbJcnRc1a5nbr5POCP3/9Li3g/1ccaOZ3ygmsoZgSWrAQX/YUHerRJJ
 yhe1lGFjQrPzcnzAZk3HIhw5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 04:37:13 -0800
IronPort-SDR: PmaatJAMDasfmulYQAgj84EDIBB0PAaIyBzMEEiAyymEDyQY2s24zOUrxOvKXFKRTM4fBaTklX
 F6Y4J5cGzU5jIIP1kNGDoDADU9cLP9b2gWEY4kNUO3bJfpR7jCrsySqjd+hoXYZTGie7Kvwr6c
 l8yuSty+eEQuGrDc1EAwQjb/xXsh2e/IXI/g40Ra1aUhCoC1ZWv8fHSWbFUfgYN3YWgZe4mU4M
 EPlYz8aBcgJ97NcyHJeM9F5j+bo/jsMKrS8clorrPZg3qHF/chFTi9ObTx7TJoKsOOVACCtfnR
 IAA=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Nov 2020 04:51:11 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/6] null_blk: Improve implicit zone close
Date:   Mon,  9 Nov 2020 21:51:02 +0900
Message-Id: <20201109125105.551734-4-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201109125105.551734-1-damien.lemoal@wdc.com>
References: <20201109125105.551734-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When open zone resource management is enabled, that is, when a null_blk
zoned device is created with zone_max_open different than 0, implicitly
or explicitly opening a zone may require implicitly closing a zone
that is already implicitly open. This operation is done using the
function null_close_first_imp_zone(), which search for an implicitly
open zone to close starting from the first sequential zone. This
implementation is simple but may result in the same being constantly
implicitly closed and then implicitly reopened on write, namely, the
lowest numbered zone that is being written.

Avoid this by starting the search for an implicitly open zone starting
from the zone following the last zone that was implicitly closed. The
function null_close_first_imp_zone() is renamed
null_close_imp_open_zone().

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/block/null_blk.h       |  1 +
 drivers/block/null_blk_zoned.c | 22 +++++++++++++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
index 4c101c39c3d1..683b573b7e14 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -45,6 +45,7 @@ struct nullb_device {
 	unsigned int nr_zones_imp_open;
 	unsigned int nr_zones_exp_open;
 	unsigned int nr_zones_closed;
+	unsigned int imp_close_zone_no;
 	struct blk_zone *zones;
 	sector_t zone_size_sects;
 	bool need_zone_res_mgmt;
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index b2812ee01d3d..6f2ad14ef213 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -91,6 +91,7 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 		pr_info("zone_max_open limit disabled, limit >= zone count\n");
 	}
 	dev->need_zone_res_mgmt = dev->zone_max_active || dev->zone_max_open;
+	dev->imp_close_zone_no = dev->zone_nr_conv;
 
 	for (i = 0; i <  dev->zone_nr_conv; i++) {
 		struct blk_zone *zone = &dev->zones[i];
@@ -282,13 +283,24 @@ static blk_status_t __null_close_zone(struct nullb_device *dev,
 	return BLK_STS_OK;
 }
 
-static void null_close_first_imp_zone(struct nullb_device *dev)
+static void null_close_imp_open_zone(struct nullb_device *dev)
 {
-	unsigned int i;
+	struct blk_zone *zone;
+	unsigned int zno, i;
+
+	zno = dev->imp_close_zone_no;
+	if (zno >= dev->nr_zones)
+		zno = dev->zone_nr_conv;
 
 	for (i = dev->zone_nr_conv; i < dev->nr_zones; i++) {
-		if (dev->zones[i].cond == BLK_ZONE_COND_IMP_OPEN) {
-			__null_close_zone(dev, &dev->zones[i]);
+		zone = &dev->zones[zno];
+		zno++;
+		if (zno >= dev->nr_zones)
+			zno = dev->zone_nr_conv;
+
+		if (zone->cond == BLK_ZONE_COND_IMP_OPEN) {
+			__null_close_zone(dev, zone);
+			dev->imp_close_zone_no = zno;
 			return;
 		}
 	}
@@ -316,7 +328,7 @@ static blk_status_t null_check_open(struct nullb_device *dev)
 
 	if (dev->nr_zones_imp_open) {
 		if (null_check_active(dev) == BLK_STS_OK) {
-			null_close_first_imp_zone(dev);
+			null_close_imp_open_zone(dev);
 			return BLK_STS_OK;
 		}
 	}
-- 
2.26.2

