Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4069C19F33
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 02:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FB2A610A3
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 02:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbhHLCoe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Aug 2021 22:44:34 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:60785 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhHLCod (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Aug 2021 22:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628736248; x=1660272248;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OJ59U610saF7sinR8ywqJVyZtYWG4GXw2CO3nDPQcQA=;
  b=c3ZqIF1rlLyY+cQLUGkGnRA9v1OrgHZY3oc79h/Azx5k7vINLYkEj2Wv
   dHBBMf/YFnvS9XjyrH5xO208VecIu5+zCC4EZcstY0b+ijFZeqNEPIsni
   DV1BMguUOOJVd/mEm2Zrvb5AQT8jHkRZb97CQ1nHGl6bMdQpTlbTlxqrQ
   L0M3nILCSx33kedSxvFk93oockyL+xn4zNiYwWOrF1Pk/bui+JtiaO/rk
   cwoLwpZOTHxzCIBLqxDDN4whp7jDuP9COvN4NXUVZwv1bb0t0oVtY8ai3
   SYnz+2N4bjwA1uJyyJa0xWJK1lFaQ5GVocRi3GxtoD7sR2gIq8jPBOoxx
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,314,1620662400"; 
   d="scan'208";a="176999876"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Aug 2021 10:44:07 +0800
IronPort-SDR: /f8k3drYvPLgy0ASW7fRUkPsLKkMNRPHK/pXluNywYbEXiZ3SOvp7RH9fF2TsK5IKo1lgJbfxR
 kKdZXU8VCLM7T4+0Q6vuIVNK5zpStHie4ASnxoHRwVtg8+w7zhLv+fIJlp0xxmbvVs6/38EhUo
 i8wHtaYn+4a+RuSUvSnAPLoyO2QIHBNa+BnV5TDkUXqtz9JGH/QJuTNQaZcNSrWgAgP6TRwKqT
 Xv+NuilI54PcoLZ+nRoNHIaB7xMOnDFgXCM700Kyr7euigNwrGZxjDNcQprpye8FMZN2IoB8hw
 5+0RWxy/rBUizen5olgqAHfb
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 19:19:38 -0700
IronPort-SDR: k5d4/GWMFPbhH2pXf4oR6NfSoTwbgo5EZ3Wtm/Os0oJjj7ZD7OS7806eqoBAiO4hs2HO7NV7J8
 hQ0cXI/rdiNgoyERdL4EsO3aKWag5gVnFWq+Iz+0Tke6UbUrHRynadsaZqVteOt6EBgEAfYmhG
 3QjvTH9Xd8Krbya14UP+ZkfmaEfoPbu2SJA3Ndaw8aoxPjKP9zdjGZUPSP86nqB1c5kXMht4lx
 iubtpun26PXC+kKdsWtl0RJRvHI+V/iYuZ6HAxOelwqn7XSWj6JZy6LoCMOfdGgvXolOWZWZ4I
 eGs=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Aug 2021 19:44:08 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v6 4/9] libata: cleanup device sleep capability detection
Date:   Thu, 12 Aug 2021 11:43:58 +0900
Message-Id: <20210812024403.765819-5-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210812024403.765819-1-damien.lemoal@wdc.com>
References: <20210812024403.765819-1-damien.lemoal@wdc.com>
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

