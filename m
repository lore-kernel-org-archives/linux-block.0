Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A78C432BE
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 05:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 994EB61052
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 05:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237699AbhHJFuQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Aug 2021 01:50:16 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:9548 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237684AbhHJFuL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Aug 2021 01:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628574589; x=1660110589;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OJ59U610saF7sinR8ywqJVyZtYWG4GXw2CO3nDPQcQA=;
  b=Dud1aaDnmHmknXoIWXw8aYDJ14FSrizi6A++Vns+u0efY88+kVM2ihZI
   Nf57H28ZSHp7qcLXiBbxQFOe2QqiK7kHMqtvEaNGSG2eSVpbtxzjGlFbF
   U981dAjW8mqlQKlghrHXbKL4UNtuZf/+Ur5X6EByX02RSyx+nrs6asOQY
   wTxjjxEAzCJgfbnU7vZhdeiTd5W+bHzGXm1XmMhR2B3rAqLRpAQWG3Igy
   LKAeUyHbHtdiBt0DTnEVyT4LjDLYlpvh8AolqtdJ9wBIUbjEDxjyIU1LM
   Y31sepUGJizQ0ifgWdSVnOfkNZh9AUYnoTfav1bqQQKQXODZV6c09l/J/
   w==;
X-IronPort-AV: E=Sophos;i="5.84,309,1620662400"; 
   d="scan'208";a="288340189"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Aug 2021 13:49:49 +0800
IronPort-SDR: YGt6sIJzpR9aNSoChHDqThxGiYQyvsccvECFumg3CLk4Z5EIddtB9qiEPFKs1Q2gJN/4EhQPqd
 cC7Yan7aDtuhnoM27FNoA/GzYcGNjEycjBfSnwNwOD5ZudxRNg9nTWA2z4pXdIhIIfOZGmg5UP
 fl9/lKWhHDs0CdGX86qRSKeWlx5FyUIxWCewhxvb3eUVAnsGMXUL+kKzMhEmU3MBS65/fyrSrN
 GyNKkEpZkmeHFpryiqD+Q0uAxUQGJ9ADuIwYq+nRUWUEIRKN14LYI0XvNnb45xrYayWrhQSx1b
 Sk9QlpAph0fquEmvfPNYeb2Q
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2021 22:27:11 -0700
IronPort-SDR: ZcxXFJssi5+IZfsRiXSNI36Zilm4XWArcevRpFzdPInTjmVaes9HvDc3VSVwh0KC7MKblejZz5
 iWkhhCSH+cDOGAdzRqzcRX2G+KzytCPKRmTd/nqGRUQY2lx0coxGHw9VISAStxreuoFfeVJOC7
 92RupLIrJ63Xg73HJXPsK+nFtlpLw7vlio0TM8FWqIC7SzoppZACF1M8lUv3i8kL80FQjwO2gU
 jv+NqvdJMAGKhFPd9OrE71Udlo2knuVjIt/iq32G5KkdtnNUOARnqf1yYMG3bBxOL1bbJ/EAKC
 M5g=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Aug 2021 22:49:48 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v5 4/9] libata: cleanup device sleep capability detection
Date:   Tue, 10 Aug 2021 14:49:34 +0900
Message-Id: <20210810054939.30760-5-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210810054939.30760-1-damien.lemoal@wdc.com>
References: <20210810054939.30760-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move the code to retrieve the device sleep capability and timings out of
ata_dev_configure() into the helper function ata_dev_config_devslp().
While at it, mark the device as supporting the device sleep capability
only if the sata settings page was retrieved successfully to ensure that
the timing information is correctly initialized.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-core.c | 55 +++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d3f7830bda2e..499ec1380676 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2363,6 +2363,37 @@ static void ata_dev_config_trusted(struct ata_device *dev)
 		dev->flags |= ATA_DFLAG_TRUSTED;
 }
 
+static void ata_dev_config_devslp(struct ata_device *dev)
+{
+	u8 *sata_setting = dev->link->ap->sector_buf;
+	unsigned int err_mask;
+	int i, j;
+
+	/*
+	 * Check device sleep capability. Get DevSlp timing variables
+	 * from SATA Settings page of Identify Device Data Log.
+	 */
+	if (!ata_id_has_devslp(dev->id))
+		return;
+
+	err_mask = ata_read_log_page(dev,
+				     ATA_LOG_IDENTIFY_DEVICE,
+				     ATA_LOG_SATA_SETTINGS,
+				     sata_setting, 1);
+	if (err_mask) {
+		ata_dev_dbg(dev,
+			    "failed to get SATA Settings Log, Emask 0x%x\n",
+			    err_mask);
+		return;
+	}
+
+	dev->flags |= ATA_DFLAG_DEVSLP;
+	for (i = 0; i < ATA_LOG_DEVSLP_SIZE; i++) {
+		j = ATA_LOG_DEVSLP_OFFSET + i;
+		dev->devslp_timing[i] = sata_setting[j];
+	}
+}
+
 /**
  *	ata_dev_configure - Configure the specified ATA/ATAPI device
  *	@dev: Target device to configure
@@ -2565,29 +2596,7 @@ int ata_dev_configure(struct ata_device *dev)
 			}
 		}
 
-		/* Check and mark DevSlp capability. Get DevSlp timing variables
-		 * from SATA Settings page of Identify Device Data Log.
-		 */
-		if (ata_id_has_devslp(dev->id)) {
-			u8 *sata_setting = ap->sector_buf;
-			int i, j;
-
-			dev->flags |= ATA_DFLAG_DEVSLP;
-			err_mask = ata_read_log_page(dev,
-						     ATA_LOG_IDENTIFY_DEVICE,
-						     ATA_LOG_SATA_SETTINGS,
-						     sata_setting,
-						     1);
-			if (err_mask)
-				ata_dev_dbg(dev,
-					    "failed to get Identify Device Data, Emask 0x%x\n",
-					    err_mask);
-			else
-				for (i = 0; i < ATA_LOG_DEVSLP_SIZE; i++) {
-					j = ATA_LOG_DEVSLP_OFFSET + i;
-					dev->devslp_timing[i] = sata_setting[j];
-				}
-		}
+		ata_dev_config_devslp(dev);
 		ata_dev_config_sense_reporting(dev);
 		ata_dev_config_zac(dev);
 		ata_dev_config_trusted(dev);
-- 
2.31.1

