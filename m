Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2C1C433DB
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 03:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18D5122795
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 03:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbhALDqA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Jan 2021 22:46:00 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:20956 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbhALDqA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Jan 2021 22:46:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610423849; x=1641959849;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NC9kAw9cwGljayUDt8KPJwpZKgyyJpvwAhvSVZDqZTE=;
  b=L0pxZOcL+T/xtJvta7H3yYzadSYPx+skUvQGDYLNookFWgmrFXDHaP1V
   7hOLvxMFpy6Aacki+5PBraXnQSC/rsJQtaZeKbvV6aj/YlUYyiXrZ6wAI
   J7dLHa1PiAuR5rwntb5DIF3DfIoVfsQJ22500Vv489K5XV5eVTVeE3PKh
   4ZZPPrV2S7Y9etd4rLHWrEK+V1QhBqpTT2OvGN3YYVEv1z6rhgTdZIq/I
   TJJajdxNGz5INHifdddQXbCf+gYzDn/pfvUzgHk+ERdMiLit2dcaLy6RC
   bHUlQYFPh9TI5I9Q6MOOAnTdJicxno7wYjbdSa13Y3YOnynmfsVU7lb98
   g==;
IronPort-SDR: ywn9bAI+iGnS4uFRE1kzTn15cnVb0VhQ7lk/zFVR2z19cyV/UOxJjakqbeD5M6/12rx1y0LztE
 zQiFt2eeOb2TMpcsXYEAtmLeKLfU/Rp6LC0wdaIcWZDu/cDZxSotQNmANSaBu0B+Rg5FbjC4TG
 zIRxOfdSTmjtfqId7XdpoyfXeQnmT+mDwO6eFTd1H0iSSDpbomQqFeljA+7zQ8IgsglFomqbX8
 LQ+Wq9WYCR5UWpe0KR38s9FCEI8ki/4UeuZrDGxRDYzZMSFotLSWn3SMrG90sPBxI+669UyKlE
 W5w=
X-IronPort-AV: E=Sophos;i="5.79,340,1602518400"; 
   d="scan'208";a="261097817"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 11:55:51 +0800
IronPort-SDR: y5FowKYLmm/36w21lpWOYlNt+8CUH6PLT0dmgWCA29BxAassjlWJI38TdKMaoRDZnWZCPKcbBg
 P7sJWGrkrQ0/uAMkU3SysiVtL0ct3SyR0/0wRa5zeystUpVRT/lMHacAC1/z2oOliDs0cXvOeO
 CI6DKiBSp9y1swMSnqY5C1XD5wwgXCs8fGbEmolD+j2EdZiiiBMPjeZNq+45VPaD4RMzy9D1JW
 V6KEneP0Qvr3fWb7Ub02V0dCQP9ASP0fz44vbdGaP+I3vkFuqcklYiZFeBZ1sTvthxKeYXA+i9
 C0iH/7hmCYqOLg29WYhhNjJ4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 19:27:48 -0800
IronPort-SDR: 1esBO0q3flcp0TWHGIUOGSpllB5kCleg8Z0JNgtLS0EtxAL7xKuEvTWy9yczvStATaUs7nyiiP
 9RG7qjPGloeSIHhvktI+LdgN8IPGXoCD+14hiVbTQsB3XpjiQt/w9Uw+rEs9MPk8mVwDvT69dV
 PVc5cHX/5lOe3Qzz+ciqCrcyj13kFebU9ZjBLbm4f2DPn9nI1aPllq3HPiXbvmKwrFYlfjvAIs
 Loull+rlLEOSNz7wzBH7pdb/Fr07YVERwZLJlk4Wi5pay3qvrwvh/egXlxX7/VAudFc4eF+Dpu
 Ohs=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Jan 2021 19:44:54 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] null_blk: cleanup zoned mode initialization
Date:   Tue, 12 Jan 2021 12:44:53 +0900
Message-Id: <20210112034453.1220131-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To avoid potential compilation problems, replaced the badly written
MB_TO_SECTS macro (missing parenthesis around the argument use) with
the inline function mb_to_sects(). And while at it, use DIV_ROUND_UP()
to calculate the total number of zones of a zoned device, simplifying
the code.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/block/null_blk/zoned.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 148b871f263b..535351570bb2 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -6,7 +6,10 @@
 #define CREATE_TRACE_POINTS
 #include "trace.h"
 
-#define MB_TO_SECTS(mb) (((sector_t)mb * SZ_1M) >> SECTOR_SHIFT)
+static inline sector_t mb_to_sects(unsigned long mb)
+{
+	return ((sector_t)mb * SZ_1M) >> SECTOR_SHIFT;
+}
 
 static inline unsigned int null_zone_no(struct nullb_device *dev, sector_t sect)
 {
@@ -77,12 +80,10 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 		return -EINVAL;
 	}
 
-	zone_capacity_sects = MB_TO_SECTS(dev->zone_capacity);
-	dev_capacity_sects = MB_TO_SECTS(dev->size);
-	dev->zone_size_sects = MB_TO_SECTS(dev->zone_size);
-	dev->nr_zones = dev_capacity_sects >> ilog2(dev->zone_size_sects);
-	if (dev_capacity_sects & (dev->zone_size_sects - 1))
-		dev->nr_zones++;
+	zone_capacity_sects = mb_to_sects(dev->zone_capacity);
+	dev_capacity_sects = mb_to_sects(dev->size);
+	dev->zone_size_sects = mb_to_sects(dev->zone_size);
+	dev->nr_zones = DIV_ROUND_UP(dev_capacity_sects, dev->zone_size_sects);
 
 	dev->zones = kvmalloc_array(dev->nr_zones, sizeof(struct nullb_zone),
 				    GFP_KERNEL | __GFP_ZERO);
-- 
2.29.2

