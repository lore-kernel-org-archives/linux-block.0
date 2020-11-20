Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFD2C388F9
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 01:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B90422255
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 01:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="O+s6vqAV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbgKTBzp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Nov 2020 20:55:45 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:6556 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbgKTBzp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Nov 2020 20:55:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605837344; x=1637373344;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=wV+ZxTTT43RQRfdQFWYX1FhlYh0q3loVxxX1Y8tFHFs=;
  b=O+s6vqAVgA9EocqrkLMLjj80efCkc7v3JnlIXltl5k+yAbVvok6AN+k5
   Vmol2gsFRWjN0BJlikLTX5UAwpjlc9EE65y1hy4jOjVWcguFDSsMxBXbR
   GTxRjj+WOX32A5HIE6Ak0ARAmyfyy/x3zkPz3r/NDb+vCGbd8awyNW1ot
   LYfYANJPP4AmZasyuArlYYMJaLM7udeNM+u3zkx1LkfHZA/tMrjSaylPN
   Sbk88KCGjWuPg15TyEMR5jb53tprIw3/Kacr0R5QdN3ibIsKVOSWU2JBd
   3UGckGb2t2jpxMNIS7m4mtD43L7A1wYR4MURGt3hEJ1mbM4RYazZzi39F
   g==;
IronPort-SDR: /+RhlURSidBnIWBFeRSagjv9N7bb8kgH/dF9IuIflM9m0BW0EgVrDwaFXfc40uvG162TK7dXD0
 xn/fEo38jWbb9wwZy0UFJYjbUqueU3MdKWptEDMyZNV0DgDILDm54QRIjVIdAQusAPaT1kl3Bj
 p+GUs0ou1l5EDOuiPD3hg2ARvDpDX1v6TN6wp1F2bW2PzGakEK4zMEEouPCPSdRNptBY37vFDa
 yOWCaJZeqDvEFCZnknClzyLE+jHFYt8QJDl7J3RHkKq0nbim/VN7FsisCjVCyTjG5MVPr0rrbw
 sTk=
X-IronPort-AV: E=Sophos;i="5.78,354,1599494400"; 
   d="scan'208";a="157516404"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2020 09:55:44 +0800
IronPort-SDR: T5KuiDMAb9TZSiVPzO2f0jpbtWdvrOdaKqOTCBhgTrTjsklcLdkdsxbRS4FJfcM7h/vjP1AuZr
 eeVLlAkvBmw3ifEDMWLu2M0eI/gIIyX2WHfhbkZVn5ReQhu7eN7ST9tsirSIL3S05RG9SA8FsO
 HQWheaejuHXBiGaaO2ZHMVVP+02Cz6SC+n4Ewutrlpg58jB47QJs87beecnORM1vJo4hEdKB6I
 57KwxYa/F+rqesIM7IPHcEK1hcVnH/kx2CiXJdJFkCCCQSDop5AsfecC8YSmc1jqWMPXDTbgP+
 5PHlZJ3Wi7g0AWzWzCXLDzZ5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 17:41:34 -0800
IronPort-SDR: K1ka5Ww/69SCewCCKvkX5/5X4sThBOvxklEju/+RgJxcdmfxl+k7F/egtGqGMbiWoxQLw+C2m3
 V3A6N4r8PSs/JXMXi1yhyJEYwhkV7X9preo0OXvCS/DAVj16+JBuqsshgK4RFheNKyBCWZ8R14
 0i1ZwmZXXmGfEDarGO1hh3lzzgwLn0juWOqfALQgIrWNZKWAo30yssIJ1TWaoeuKjEpaLgP6fI
 jFEXkEJEXMkGDt3c1fkbS5h+/VWWmA4J/HqNOSGhtzkT6bjEL+YUK2zQuv+gvOOeVbYM9bq9xC
 sug=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Nov 2020 17:55:44 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v4 5/9] null_blk: Improve implicit zone close
Date:   Fri, 20 Nov 2020 10:55:15 +0900
Message-Id: <20201120015519.276820-6-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201120015519.276820-1-damien.lemoal@wdc.com>
References: <20201120015519.276820-1-damien.lemoal@wdc.com>
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
index 14546ead1d66..29a8817fadfc 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -67,6 +67,7 @@ struct nullb_device {
 	unsigned int nr_zones_imp_open;
 	unsigned int nr_zones_exp_open;
 	unsigned int nr_zones_closed;
+	unsigned int imp_close_zone_no;
 	struct nullb_zone *zones;
 	sector_t zone_size_sects;
 	bool need_zone_res_mgmt;
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index 4d5c0b938618..4dad8748a61d 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -113,6 +113,7 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 		pr_info("zone_max_open limit disabled, limit >= zone count\n");
 	}
 	dev->need_zone_res_mgmt = dev->zone_max_active || dev->zone_max_open;
+	dev->imp_close_zone_no = dev->zone_nr_conv;
 
 	for (i = 0; i <  dev->zone_nr_conv; i++) {
 		zone = &dev->zones[i];
@@ -273,13 +274,24 @@ static blk_status_t __null_close_zone(struct nullb_device *dev,
 	return BLK_STS_OK;
 }
 
-static void null_close_first_imp_zone(struct nullb_device *dev)
+static void null_close_imp_open_zone(struct nullb_device *dev)
 {
-	unsigned int i;
+	struct nullb_zone *zone;
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
@@ -307,7 +319,7 @@ static blk_status_t null_check_open(struct nullb_device *dev)
 
 	if (dev->nr_zones_imp_open) {
 		if (null_check_active(dev) == BLK_STS_OK) {
-			null_close_first_imp_zone(dev);
+			null_close_imp_open_zone(dev);
 			return BLK_STS_OK;
 		}
 	}
-- 
2.28.0

