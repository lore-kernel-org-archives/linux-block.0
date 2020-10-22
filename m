Return-Path: <SRS0=SOzO=D5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BECAC388F7
	for <linux-block@archiver.kernel.org>; Thu, 22 Oct 2020 15:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0949724640
	for <linux-block@archiver.kernel.org>; Thu, 22 Oct 2020 15:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603381664;
	bh=20wsqZg/HJFdugGmWP+Vgtwp2p4oxDR+X8oYeupogSg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=NO2o2UqzqMnS1leD7U4NFULYXLQf/NTFo3Lbcd6NoH1gA7HJdX66ucLTn42p1eP+G
	 VqESpclslpABaDKsctF1A5r+HEuu53Ql9VfKzW1tCI6kkdV644qiEGzLlcmNv66WJM
	 u9OQeIQ40i+c91Vj+ZwDLuuOw9qYEQZzP76IuLAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368725AbgJVPrn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Oct 2020 11:47:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S368724AbgJVPrn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Oct 2020 11:47:43 -0400
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 758342463D;
        Thu, 22 Oct 2020 15:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603381662;
        bh=20wsqZg/HJFdugGmWP+Vgtwp2p4oxDR+X8oYeupogSg=;
        h=From:To:Cc:Subject:Date:From;
        b=BoWsrhvsgyb4qGkk5Fn0XpvWNK1WXeld7qDHr4TpEDLHxadGrmdXV//6LkR9drirn
         qbAebLMOwglEd8o9aW1DgqXDXUlTLJfFoc989gjlwF4zK+O9eA7NjODHpq5mzNn/64
         VmsnUtZE5oAAhMRd1aQgKDlM3YTa5ffsSFDDHuIA=
From:   Keith Busch <kbusch@kernel.org>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCHv2] null_blk: use zone status for max active/open
Date:   Thu, 22 Oct 2020 08:47:39 -0700
Message-Id: <20201022154739.1694152-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The block layer provides special status codes when requests go beyond
the zone resource limits. Use these codes instead of the generic IOERR
for requests that exceed the max active or open limits the null_blk
device was configured with so that applications know how these special
conditions should be handled.

Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Niklas Cassel <niklas.cassel@wdc.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2:
  Change the return criteria for "null_check_open()" so that it only can
  return the OPEN_RESOURCE error (Niklas).

 drivers/block/null_blk_zoned.c | 69 +++++++++++++++++++++-------------
 1 file changed, 43 insertions(+), 26 deletions(-)

diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index fa0cc70f05e6..7d94f2d47a6a 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -220,29 +220,34 @@ static void null_close_first_imp_zone(struct nullb_device *dev)
 	}
 }
 
-static bool null_can_set_active(struct nullb_device *dev)
+static blk_status_t null_check_active(struct nullb_device *dev)
 {
 	if (!dev->zone_max_active)
-		return true;
+		return BLK_STS_OK;
+
+	if (dev->nr_zones_exp_open + dev->nr_zones_imp_open +
+			dev->nr_zones_closed < dev->zone_max_active)
+		return BLK_STS_OK;
 
-	return dev->nr_zones_exp_open + dev->nr_zones_imp_open +
-	       dev->nr_zones_closed < dev->zone_max_active;
+	return BLK_STS_ZONE_ACTIVE_RESOURCE;
 }
 
-static bool null_can_open(struct nullb_device *dev)
+static blk_status_t null_check_open(struct nullb_device *dev)
 {
 	if (!dev->zone_max_open)
-		return true;
+		return BLK_STS_OK;
 
 	if (dev->nr_zones_exp_open + dev->nr_zones_imp_open < dev->zone_max_open)
-		return true;
+		return BLK_STS_OK;
 
-	if (dev->nr_zones_imp_open && null_can_set_active(dev)) {
-		null_close_first_imp_zone(dev);
-		return true;
+	if (dev->nr_zones_imp_open) {
+		if (null_check_active(dev) == BLK_STS_OK) {
+			null_close_first_imp_zone(dev);
+			return BLK_STS_OK;
+		}
 	}
 
-	return false;
+	return BLK_STS_ZONE_OPEN_RESOURCE;
 }
 
 /*
@@ -258,19 +263,22 @@ static bool null_can_open(struct nullb_device *dev)
  * it is not certain that closing an implicit open zone will allow a new zone
  * to be opened, since we might already be at the active limit capacity.
  */
-static bool null_has_zone_resources(struct nullb_device *dev, struct blk_zone *zone)
+static blk_status_t null_check_zone_resources(struct nullb_device *dev, struct blk_zone *zone)
 {
+	blk_status_t ret;
+
 	switch (zone->cond) {
 	case BLK_ZONE_COND_EMPTY:
-		if (!null_can_set_active(dev))
-			return false;
+		ret = null_check_active(dev);
+		if (ret != BLK_STS_OK)
+			return ret;
 		fallthrough;
 	case BLK_ZONE_COND_CLOSED:
-		return null_can_open(dev);
+		return null_check_open(dev);
 	default:
 		/* Should never be called for other states */
 		WARN_ON(1);
-		return false;
+		return BLK_STS_IOERR;
 	}
 }
 
@@ -293,8 +301,9 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 		return BLK_STS_IOERR;
 	case BLK_ZONE_COND_EMPTY:
 	case BLK_ZONE_COND_CLOSED:
-		if (!null_has_zone_resources(dev, zone))
-			return BLK_STS_IOERR;
+		ret = null_check_zone_resources(dev, zone);
+		if (ret != BLK_STS_OK)
+			return ret;
 		break;
 	case BLK_ZONE_COND_IMP_OPEN:
 	case BLK_ZONE_COND_EXP_OPEN:
@@ -349,6 +358,8 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 
 static blk_status_t null_open_zone(struct nullb_device *dev, struct blk_zone *zone)
 {
+	blk_status_t ret;
+
 	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
 		return BLK_STS_IOERR;
 
@@ -357,15 +368,17 @@ static blk_status_t null_open_zone(struct nullb_device *dev, struct blk_zone *zo
 		/* open operation on exp open is not an error */
 		return BLK_STS_OK;
 	case BLK_ZONE_COND_EMPTY:
-		if (!null_has_zone_resources(dev, zone))
-			return BLK_STS_IOERR;
+		ret = null_check_zone_resources(dev, zone);
+		if (ret != BLK_STS_OK)
+			return ret;
 		break;
 	case BLK_ZONE_COND_IMP_OPEN:
 		dev->nr_zones_imp_open--;
 		break;
 	case BLK_ZONE_COND_CLOSED:
-		if (!null_has_zone_resources(dev, zone))
-			return BLK_STS_IOERR;
+		ret = null_check_zone_resources(dev, zone);
+		if (ret != BLK_STS_OK)
+			return ret;
 		dev->nr_zones_closed--;
 		break;
 	case BLK_ZONE_COND_FULL:
@@ -381,6 +394,8 @@ static blk_status_t null_open_zone(struct nullb_device *dev, struct blk_zone *zo
 
 static blk_status_t null_finish_zone(struct nullb_device *dev, struct blk_zone *zone)
 {
+	blk_status_t ret;
+
 	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
 		return BLK_STS_IOERR;
 
@@ -389,8 +404,9 @@ static blk_status_t null_finish_zone(struct nullb_device *dev, struct blk_zone *
 		/* finish operation on full is not an error */
 		return BLK_STS_OK;
 	case BLK_ZONE_COND_EMPTY:
-		if (!null_has_zone_resources(dev, zone))
-			return BLK_STS_IOERR;
+		ret = null_check_zone_resources(dev, zone);
+		if (ret != BLK_STS_OK)
+			return ret;
 		break;
 	case BLK_ZONE_COND_IMP_OPEN:
 		dev->nr_zones_imp_open--;
@@ -399,8 +415,9 @@ static blk_status_t null_finish_zone(struct nullb_device *dev, struct blk_zone *
 		dev->nr_zones_exp_open--;
 		break;
 	case BLK_ZONE_COND_CLOSED:
-		if (!null_has_zone_resources(dev, zone))
-			return BLK_STS_IOERR;
+		ret = null_check_zone_resources(dev, zone);
+		if (ret != BLK_STS_OK)
+			return ret;
 		dev->nr_zones_closed--;
 		break;
 	default:
-- 
2.24.1

