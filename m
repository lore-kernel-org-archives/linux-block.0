Return-Path: <SRS0=RRdq=EE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093B2C55179
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 11:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A636A20759
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 11:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="As/mwph0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgJ2LFE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Oct 2020 07:05:04 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:48833 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgJ2LFD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Oct 2020 07:05:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603969502; x=1635505502;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+Nm55pLDVzBs6OpCSEygrb1kFFSDZ3Kj2mA/toSevQc=;
  b=As/mwph0mdSHyZrh3Ve+AlbewUbxpkj/h+Vev94VjRBtjhl4uAJqoYU5
   mPNId79jmDgNnHuiG8C3WhLPsvHlAIOMUN7F3UPYpnZ5XnMe+mm1Cegxz
   ReWzY0JLBSCOGJhv8J5pUNoz+m70xSf8IruPFxZpJdfGxomAAXyiF/HP9
   x8pZvPTjELazZ8vfIsU4x/O3GhhvQESUiktwILbN1wOWe+XD84T0yblyD
   AAIDGXEVQ8cAnWTtJJsGxpqSHZucVa8OKxc3Z5Ee5hGFesQXH3P21I2FK
   vUHkqvGMVNaoF4AQ8Bqa4sx8YlGGVVNh4ubDUoeV25T2r5zKt3R8Pg45f
   w==;
IronPort-SDR: wjruBxwZCV1pkQY3kXL3Yb70z87Zn1hCgE1BHI14lDL9JHTESgCyNrBOdNXcwivEWtZgJUsnCD
 OnDZY5VSYgQSSajGhSeOvNRYkE4QmiZ6roc7bAsOIhbHap7vbPQDWG0vCLTWxGRdAUcFfiFvOk
 SJ4ggr2XNnnk0BEDKPADHCxKqOhhJ8fSF0WJF/HS7xK+thCDtsCQ/4IkkzmqnK/Hgk62xtFKkQ
 OWsOE1SIgB+LCdLdcOQYA5G5jcUDMsiUxvoMgkr8Q1FoT78mAB50kbPa+vqiH6szuErWpPB2Yy
 /1Y=
X-IronPort-AV: E=Sophos;i="5.77,429,1596470400"; 
   d="scan'208";a="151134627"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Oct 2020 19:05:02 +0800
IronPort-SDR: 8EH+2J7cpvJwYY5YVZLWW0svWWlziVJe7nIIuw7NBo162Ba3uxtpj0G6X5uBxPV79wbizqXbbl
 Sa0yuXGs3LEwqACeTiwA0waU1QUXhwsmHDthLslnjXs2VMLPNN0tqPmADkjZjzrleu8gkz9ldK
 Ugk1FwfSnybYtDA3Pjf9zSXqyWINn9w1XsU5Kebm5SNSpFVwUX7S2PKrOLMKU5suBDVSXUqU74
 0lWO32POgToiuZKaBnVobITV0/HLxXzPC5AYbFQDd9Z3Y43rUjpUMzC1filmMftzckMf+JwfEA
 QMSF/R0wRHDu1XKwP8wVuelx
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 03:50:07 -0700
IronPort-SDR: TYftZifIQkyOkmw8xifHnfy8rK4pobZVyQ3kaipogo/1oeQvwi3tNlC9whyTIxKfPSn3rK7ZUI
 y/wAS/qPvKno7xr6AC9LUAvgcymyamfq3TvfSf3Uu7Bam8q5IRVrg7fA1nrurBflkF9qBHbjY4
 GK1vrBDgnw0ye7K4EXqo9LWEPhKkzl9FbkAySFKFm1lXAdQntgMwZu4lUCozYp1wlu9vtDAtRi
 G7xM273zbzfLowV1obTWF0+pOevoejN4sheSYUf3zcOzjOZZbrQd0V6/efDP4zuvrFx6bdn0tz
 +Cw=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Oct 2020 04:05:03 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH 1/2] null_blk: Fix zone reset all tracing
Date:   Thu, 29 Oct 2020 20:04:59 +0900
Message-Id: <20201029110500.803451-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201029110500.803451-1-damien.lemoal@wdc.com>
References: <20201029110500.803451-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In the cae of the REQ_OP_ZONE_RESET_ALL operation, the command sector is
ignored and the operation is applied to all sequential zones. For these
commands, tracing the effect of the command using the command sector to
determine the target zone is thus incorrect.

Fix null_zone_mgmt() zone condition tracing in the case of
REQ_OP_ZONE_RESET_ALL to apply tracing to all sequential zones that are
not already empty.

Fixes: 766c3297d7e1 ("null_blk: add trace in null_blk_zoned.c")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/block/null_blk_zoned.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index 98056c88926b..b637b16a5f54 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -475,9 +475,14 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf op,
 
 	switch (op) {
 	case REQ_OP_ZONE_RESET_ALL:
-		for (i = dev->zone_nr_conv; i < dev->nr_zones; i++)
-			null_reset_zone(dev, &dev->zones[i]);
-		break;
+		for (i = dev->zone_nr_conv; i < dev->nr_zones; i++) {
+			zone = &dev->zones[i];
+			if (zone->cond != BLK_ZONE_COND_EMPTY) {
+				null_reset_zone(dev, zone);
+				trace_nullb_zone_op(cmd, i, zone->cond);
+			}
+		}
+		return BLK_STS_OK;
 	case REQ_OP_ZONE_RESET:
 		ret = null_reset_zone(dev, zone);
 		break;
-- 
2.26.2

