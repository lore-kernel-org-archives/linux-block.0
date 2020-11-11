Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A021C55ABD
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 05:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 343482075A
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 05:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="boIdhBBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgKKFQ4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 00:16:56 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:43931 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgKKFQz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 00:16:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605071814; x=1636607814;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=t4Xwaz5VtFq8OwY6FsYgFH9L9GIA4CHcYM8RcV1DIyA=;
  b=boIdhBBObdQ9IpwzuFewYjjkUdnah7VbZq/AC1YFZ+KFD5rMZQDwcdRl
   UgnDBy+1sffupjCNbGnIk+QXq4mcIJnqI28+T7u+Sni5x5DVG0CpxSfnD
   EiFZImojwennKrMWx5iaXCLKNy7aB50mmkm2l6XFT+LUNYTO709BfTZ67
   1/aT3dpsdnaLx4+ggSK9Rx4M5k4xRpOiIj3fFsLppNdylAFI4/hyVRGjw
   PUo+SZtEwedrzdLMLc4Z355wDWDODc+XJJDp7WgfNFNYgBE/h1pTxLn6M
   GTak1lGHV7UuDDml4CLH0WI+naWzyhxsqDwJudbvV2cIjWnrrBC9Omtdo
   Q==;
IronPort-SDR: pYz8tL04t86IS/VDCiT7kK119zBhY5hzOP+kWtPN9MpL4i2NbulZsu55T1RJOT24unq2S1nRmt
 b0Vl8XRklTIbLrXAsyzBjLZ24grRvvZFFjK5vlDhzgA4a9BfRGfXO7RckEdkgsX5uBwv8RtntF
 O0/VGSflBQT73OYVC4p4QMKGDBoOwHWAyPJ8ujyGkS1iSoX7VrSYva+2F9XI4bTltm0xL2QL0I
 oj+1Dp33Xc8Up9QTc8Ee2qZjS84ZLpKJPT/8hbihBltT7huqWcHY0d9uJLmmOoeSC/tY2NipRq
 dn0=
X-IronPort-AV: E=Sophos;i="5.77,468,1596470400"; 
   d="scan'208";a="152254638"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2020 13:16:54 +0800
IronPort-SDR: 7Vkl6XIYymegOxM9dCDockc5QfRqqCnVMqJrVgwRIZrXWiCTP9GKB4IxZmjMAbQCKS1juKayxI
 /dMi8RFVcuMfcEB0gfpNXg62QJWOVpT9XJiel/CAv4UteDiDKMjj5DNHEl//s9vmCJkS/Nm7V7
 LPuKxDu0ii3ucBWXFBs9k5IKxDzmH3anuDn31XSjC/NDaJKVS+Zqc+qsB+aNHDylgnUZdVwdqX
 YkV+KGn8ssjeCNtSMRJZZqy65q2iLgaR6+aiwb/biRjhsOytxvfeRBJ2QQMcXSPwF3VPe9a1aJ
 oM8spuAx/eEZBdeExAJmNxNS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 21:01:41 -0800
IronPort-SDR: 80O9bqDreuD63d0kajkYS4u3RLA4hr5YcEQV39uCFvRPhAw6KrRsdcjMHmYsJUPf8Sa3B0mKR0
 SiaLcP4r6tPsm2dYUS6bxNPU4C8aL+QlYK/zF5Z/3VypAbt0PFUZpm0CcbvS52VHyyyyhqTJGF
 H4XVnXA8MqqZbYcIvMryJKsw7SBunpSgb/bA6YAsGproQaX/mHT2bnUdFpJz99qdbQz1dhMgdo
 xxv89XoPCczg8luYipS1olZ4LPieMg12JLoHi4kkgVVBRquvG8A+B4jYWv3zZmRV8D+cyRHM3P
 V/4=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Nov 2020 21:16:54 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 5/9] null_blk: Improve implicit zone close
Date:   Wed, 11 Nov 2020 14:16:44 +0900
Message-Id: <20201111051648.635300-6-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201111051648.635300-1-damien.lemoal@wdc.com>
References: <20201111051648.635300-1-damien.lemoal@wdc.com>
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
index 2630aeda757d..905cab12ee3c 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -89,6 +89,7 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 		pr_info("zone_max_open limit disabled, limit >= zone count\n");
 	}
 	dev->need_zone_res_mgmt = dev->zone_max_active || dev->zone_max_open;
+	dev->imp_close_zone_no = dev->zone_nr_conv;
 
 	for (i = 0; i <  dev->zone_nr_conv; i++) {
 		struct blk_zone *zone = &dev->zones[i];
@@ -280,13 +281,24 @@ static blk_status_t __null_close_zone(struct nullb_device *dev,
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
@@ -314,7 +326,7 @@ static blk_status_t null_check_open(struct nullb_device *dev)
 
 	if (dev->nr_zones_imp_open) {
 		if (null_check_active(dev) == BLK_STS_OK) {
-			null_close_first_imp_zone(dev);
+			null_close_imp_open_zone(dev);
 			return BLK_STS_OK;
 		}
 	}
-- 
2.26.2

