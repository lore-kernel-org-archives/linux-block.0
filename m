Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6458FC388F9
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 13:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0F4A2074B
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 13:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hXh/XRHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgKKNA5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 08:00:57 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32526 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgKKNA4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 08:00:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605099656; x=1636635656;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=febnZMc+ZcEATUd+fQ+StiriaPbiiTsmXj9REODG4hE=;
  b=hXh/XRHUSiA0VQ50zS8Ee/aWyjYTwmlcjBWPHxVGwym2SDzCAEi1heap
   G9LVV2NfFG8yFy/WYsF2GumnVXqiLbiC8cMAkO0+CknQH/rv5RjwfCTgl
   R+kwKic+k5zpVQMGKA/l9REvU/+jToyWd03RQ9sRjEBmdTT4xaYgQeLka
   wzg6/zXiO28Yu02DiOdk76YET76KcYB0nUNZqomXUknSVcOM4aoWUKz5o
   SQloQ1b1JTW8+r7xsPEWsSjWpJVtcay0zPWDsMSNmiYyVQu9q6jipZjSq
   Xg5mToj1p0MQELdJij6gDCicLhCfFb1YAYytxeGSh6sy5uBxMDdiKhrg2
   g==;
IronPort-SDR: 3N7zaaq5JWdkoUNIQSU2fXFiXnAQZI+PUubTCsP0wJ14Afkl8FE51z3IjdOPmNlgTMmmtmk8Zc
 tVYDWAuPDcnJXwHzeRXTg9GbqFtDEBuZ2faZcHDVKtDWmcjGK/KrU2Vrc2K9KvSKv1zYlw92Pp
 bh/xpULL7j+Fz48Ja892hAZ/emX0G6bK7yRlCVThHhR/bx8ishe00c+u2hx2B3cmvj2CDAVXnJ
 Ry+N6JXBGB1AGFaJ1AIb0198kQPnMb7nPjmrlvB9ZuqYNdCZfj5AodgMPiZBUG0ZuNlSJhwRR8
 008=
X-IronPort-AV: E=Sophos;i="5.77,469,1596470400"; 
   d="scan'208";a="152283545"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2020 21:00:56 +0800
IronPort-SDR: 2X/3HP7IiZZLgD7HnkDVw1jGYtSzIujzSme0EhLzZOKXbAIvA/o7fWHvnlnyfInfecqkw1f4G8
 sHkLos3mfcAzCcLC9fg8DSIpfcXvQ8h4NuKWv2c+o1pm1wMy7tJ3j8ehkH6kE6Qa5AcRxAiqKg
 ZR/jHC5g52AQEp7pa5sRF0wwSCUu+X6n6NldhFmGkHc5atWPx+p8WCFURGnVrxCFxGkzm4qS7Q
 QCpO/HpqWCQzTIK2tSktK4oW1blJ+IQSJxQrkqCfsSmZUUOlxQOd8YTmqlrsveIlcWGjOIuoyg
 b03NcaXcd9eYhDFx72/Zx2wS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 04:45:38 -0800
IronPort-SDR: 5d5UY53nodr3tK2Z8hP9kYZ4+UD9/G81vEw5Tt9CF5xkEDvtAWq4konzt2bPDafgVcglQMDZt5
 +Ysg8jEPNZefSvaNxWRCy3TrBlz3YBAqyR92o8CjdbuankIt1Mg7LaPnG5tSmPqLvYb+MA+2ef
 gBFmofSNy4VpLhhXCnnvtisqOutGOf1VWWfKWbpa6QJQEv8BtNLAOpC1xni65+41iikMlURUKd
 NQSyTGN3PXwDSNqvGkuYxu6p00k3GIVDBfcwcPRFF9kYqLVXCI/7mjHS30E6brg/W2pXttn9Dr
 UXo=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Nov 2020 05:00:56 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3 5/9] null_blk: Improve implicit zone close
Date:   Wed, 11 Nov 2020 22:00:45 +0900
Message-Id: <20201111130049.967902-6-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201111130049.967902-1-damien.lemoal@wdc.com>
References: <20201111130049.967902-1-damien.lemoal@wdc.com>
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
index 2c746221e8e6..cd773af5f186 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -115,6 +115,7 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 		pr_info("zone_max_open limit disabled, limit >= zone count\n");
 	}
 	dev->need_zone_res_mgmt = dev->zone_max_active || dev->zone_max_open;
+	dev->imp_close_zone_no = dev->zone_nr_conv;
 
 	for (i = 0; i <  dev->zone_nr_conv; i++) {
 		zone = &dev->zones[i];
@@ -275,13 +276,24 @@ static blk_status_t __null_close_zone(struct nullb_device *dev,
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
@@ -309,7 +321,7 @@ static blk_status_t null_check_open(struct nullb_device *dev)
 
 	if (dev->nr_zones_imp_open) {
 		if (null_check_active(dev) == BLK_STS_OK) {
-			null_close_first_imp_zone(dev);
+			null_close_imp_open_zone(dev);
 			return BLK_STS_OK;
 		}
 	}
-- 
2.26.2

