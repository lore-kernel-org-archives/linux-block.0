Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5F8C19F35
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 01:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0EB26142A
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 01:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhHPBpe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Aug 2021 21:45:34 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:37268 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbhHPBpe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Aug 2021 21:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629078301; x=1660614301;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OJ59U610saF7sinR8ywqJVyZtYWG4GXw2CO3nDPQcQA=;
  b=ZnNAh7hgLCVJHBLoOoXGIfdLIG5v3h3ts/u7Ns9Efss5CkxTTvNrsykA
   JNqrwalMDDF2gqdoSgEvYWS1NHbbVazWd35IjxzlSWkyXxeIqlVGfWZnp
   DcSevaN6WtReTfZSsn9gziQqEqBjngQxtQAPZZHe//+B7mrunhygCl3Sn
   hrPm8bJHqbAsZOcjKNWDTqA+5IP7akz9TlQJZq0o7ze29jkNVMhW4wBur
   GYLRx+v4GInGz9hwYQUSfnMVTzgGx0EegnevYn88cpg3c7Di/oKPwp7Kj
   P3GrSuXvM7QzaSVcHMbGuhKofTqWVUB4hBXSVQwaj7bhNo14/VvrW2jtp
   g==;
X-IronPort-AV: E=Sophos;i="5.84,324,1620662400"; 
   d="scan'208";a="177326699"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2021 09:45:01 +0800
IronPort-SDR: wFKy/LVGuSPGjVIh+TUsVK/LE2FWMZm0kVQwKD49CwDw3HIczYXCga+M/O7ypz3oW+XYWg961u
 VkZrghbeK1sCThxtLYb27Y9bn9ZJhRbVv6uPlFIIHZxAMD13AsoD/z6k2Y0/Kbx3rEwOeaEZFj
 vCHhbk3V6K1KFCkjaG+0F9JgNIXZAR8nfhN1lV6KVvOUFXNiz1KXeljBExc7E7PYXsPQmutIOV
 deHtccz36iMjMHGSRwNSh3Mbxwk3LJtsqj6U64BNXs791Ovh0BxfvKKmACznVY1H7vYYhPLEy+
 r2aE6Ib/StB30kRIUqi+Yz6V
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2021 18:20:28 -0700
IronPort-SDR: B264OnKFl7opOEEJDtzNvIncxOoV+50sq8A/hUzIgbZnIzsHC5RWT7va3lZbrNo95pWtqlrs7/
 U4qCXikic8KwMJTjxx+sMS5waje7dZTFd4GrSZT+SmFBoVGHO/jPyDvXbVbxXASg+IxIY2Occy
 cyc5VD1/Dy0iYUpIae0/K5gJp50+NBEKbQf9u+U3GVpZ6W7EwurBlsDzLZEfI7VY0dO4TLEUIu
 AXWUz6KI9vwa4M5ZGD/Qrc1PZPEHFKBo7XX6cxQq+6lCBH6Q6Y1X4cXjUFabJJHxEn2mkHw1Hb
 bWM=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Aug 2021 18:45:02 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v7 04/11] libata: cleanup device sleep capability detection
Date:   Mon, 16 Aug 2021 10:44:49 +0900
Message-Id: <20210816014456.2191776-5-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210816014456.2191776-1-damien.lemoal@wdc.com>
References: <20210816014456.2191776-1-damien.lemoal@wdc.com>
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

