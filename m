Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB9BC56201
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 13:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3531420795
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 13:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LHmyRSG7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgKKNA7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 08:00:59 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32534 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgKKNA6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 08:00:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605099658; x=1636635658;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=y3e4ZFya6DkOkgL7LvEcCQhBPogsum+cpdPQulZCH40=;
  b=LHmyRSG7BfmaWHOsYoArLxOrREK8YX3xog24JwSDHVq5M6vAywBhacPQ
   HVtvC834wX7YGWhGYdCrkMPqrADtMoaYMZ6hxY5GObdCc60ocTWsTpm1o
   8+yXSXlbB1xJBPZjfLbJnDukNciMZgH7UWgAG6TzJJ5DoNQ0ybPU9bV3J
   /zwJ0VRGTSmB7g+KNgHvNU1aSCwx+SbAHmSUZjY8mI2Ls3WfvmdIzBUfJ
   ilWR61vDKjPwQNx8sQoZf289cWcwno2EO1c1VaLiPCYRJbIPLWCzvg65j
   vdXTghheWle1/tUhU1vyhZYGfPz7a72RywqYM2lBgeM4tGJYDhjYva/hI
   g==;
IronPort-SDR: 4jgAu75nQFHZuhSZ98JP+7Bx0KPY1gsPlx6rMhGjv67PKbzuelWsVu/8M3Xk0DTL6QUxyo92MG
 3Hpz/AjEf3Era81biqDzGBXgl1EqNrb0Eb2Dof8ShgmU4hWxL9AeajiCnU57K3ucrY1+9czcWt
 SOpLwlD/8J29evvYPU5V4ExuknKkvGkUrvmzsw5zhcumE/vwkFeEw6U1W05IZh87NevYnF++st
 3bt5pcHx1Ayr1lJ9AA5VyzaRHLd2NFoVEPoPrtiMivvfQL55/idIMy0yvAw3QnOD9dXB/YRFgi
 yAs=
X-IronPort-AV: E=Sophos;i="5.77,469,1596470400"; 
   d="scan'208";a="152283549"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2020 21:00:57 +0800
IronPort-SDR: JQsRuS6AmoeqcdQgAtMEOZSDg6apMHckEYZmeaoh1grFxGgT1OVFzdPgXaTck6SX/lMDxhpSfI
 osvWnaztR+gDjRyKSkEZ6wWm1Z3RtkuxQACppXNmZh2Tf3i04uLQ79QMLvD/ryl0LMGVuex1Fr
 OwkIqi48ByiZvykZQeBgdEq8drFkIAHazMoqzO6NXeWASS85sb7yogFTEM7y3qp1BhfCDfZ2Ur
 yY4xYqQYvajPM1gLc34vPR3WoivhtWFCKOpbmqjQjHnjXXEikJmxN8Rr+ToVd9fYY7xbv35OYc
 OPOkLetjeL741tJ/7/RVsEfO
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 04:45:40 -0800
IronPort-SDR: b3rJdRpdMFy4q7yRurxmhxQmTRz88yzEftl0/vWrf4ZEEZQNO683X7/pcslifYq3fATAYoO1SY
 WuaqlMndPVvRGdS29HHIRaQRohUx095ghPoQzv/Q7a8BaNs5IZKfmX/2j0yC/dtq5MjYDxH8mx
 BYkQdNmDkm0B6BjuM9/65/OCNXx+3C/xUvXTQeqwoRbRQPoZrC1Ct9aa5bvEhXzvVHS5jwBaJ+
 iJWo/poR83hi/sJNik3EAfC11uQBmjvdAJYwvFWnlkXpWkozLxr6ThpkHurF1dTjV9bhdEc8Ga
 9vE=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Nov 2020 05:00:58 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3 7/9] null_blk: discard zones on reset
Date:   Wed, 11 Nov 2020 22:00:47 +0900
Message-Id: <20201111130049.967902-8-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201111130049.967902-1-damien.lemoal@wdc.com>
References: <20201111130049.967902-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When memory backing is enabled, use null_handle_discard() to free the
backing memory used by a zone when the zone is being reset.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/block/null_blk.h       | 2 ++
 drivers/block/null_blk_main.c  | 4 ++--
 drivers/block/null_blk_zoned.c | 3 +++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
index 29a8817fadfc..63000aeeb2f3 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -116,6 +116,8 @@ struct nullb {
 	char disk_name[DISK_NAME_LEN];
 };
 
+blk_status_t null_handle_discard(struct nullb_device *dev, sector_t sector,
+				 sector_t nr_sectors);
 blk_status_t null_process_cmd(struct nullb_cmd *cmd,
 			      enum req_opf op, sector_t sector,
 			      unsigned int nr_sectors);
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index a223bee24e76..b758b9366630 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1076,8 +1076,8 @@ static void nullb_fill_pattern(struct nullb *nullb, struct page *page,
 	kunmap_atomic(dst);
 }
 
-static blk_status_t null_handle_discard(struct nullb_device *dev,
-					sector_t sector, sector_t nr_sectors)
+blk_status_t null_handle_discard(struct nullb_device *dev,
+				 sector_t sector, sector_t nr_sectors)
 {
 	struct nullb *nullb = dev->nullb;
 	size_t n = nr_sectors << SECTOR_SHIFT;
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index cd773af5f186..2fd8c825d70b 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -596,6 +596,9 @@ static blk_status_t null_reset_zone(struct nullb_device *dev,
 
 	null_unlock_zone_res(dev, flags);
 
+	if (dev->memory_backed)
+		return null_handle_discard(dev, zone->start, zone->len);
+
 	return BLK_STS_OK;
 }
 
-- 
2.26.2

