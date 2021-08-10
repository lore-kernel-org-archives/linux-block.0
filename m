Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3167C4320E
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 05:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D13EB61058
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 05:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237687AbhHJFuR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Aug 2021 01:50:17 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:9551 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237686AbhHJFuM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Aug 2021 01:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628574591; x=1660110591;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UnaVB6KDNNEpWf+5iF0GJ2TeYxp+J3L7FRn55Pjn1Ak=;
  b=VzCxKQA0GqoxTIbeFrBHDgdbsBql5zST61pKuDXistYfYNT2h/StCNt9
   fbNmU73zJK/Mh+jaNl/LzkYE3ehb5bn/tQ7ZFnQGul5nbaiLQKPYWfy3M
   G0T0BGwcyEjmf7pAe2dWteV/cGns4xVTzNXtLjr6l4wAuLpfapH64+WUF
   vOiIne/mr4/0y3seC1agnDXcGaAnOouYqFN0NGnikM0jqtGo1fII5nz8v
   N45WjbDhiWbJR2baRvX821HKDLT6MwnHw7jxrf2tQL/H98qDxbYZBb4TQ
   hU8+4yS/X3G4nI9mhOLo/bEfMOLcyW/GBpKk57KbQOaYp4uy2xJYqJ7jy
   A==;
X-IronPort-AV: E=Sophos;i="5.84,309,1620662400"; 
   d="scan'208";a="288340191"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Aug 2021 13:49:50 +0800
IronPort-SDR: 7gfGImA60NAujunwKAsrN5YocX6cSCTlus+hXt9wb6Kh96ClayNwlMtuwAHJKiPvNpxW/lka6f
 IHG68IQBQ9/X1d8+oT1wN8jqmDwc7uFKvVG7fxgKoDZgyrTdDFj5hiYUF9ZCj19zQCpiONliaS
 qaGSsDiyl68zKujSodwRrifTu3HrF87hZK4Eu+XtYxgv6auIpAYtVmyS4BTRP8Lc1Si9fNNG7i
 KoAkKG6wA5ZhkiXutkuuoh/b9NUwg0fzulYUMX7++OHpKsbpRldWqoLVlq/HcYraD063h5S6Y7
 dAMBoIGBWbfe8tyfIQ9Z+uwd
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2021 22:27:13 -0700
IronPort-SDR: RSQ5kvYf1blmWidA4bmn9q2FjrZU+y2wk80r5LEkIiATXG1xgMqUWwu3PsRxQjwk8Sm80yPaR3
 h4/6jJIwzCjpl3Y1gmnTfU3mxIHx6mh5gRZeQb0neZil1/w22txFOWTytgwKhuCC+P2qfP1x9/
 XQ2blQJ9Y7BH4SQ6zbPJxNR8VxITj+bGd4+UV2w1x2K2810q+4B9UqRpDrdix+icZjC6H98PGU
 XHsQyHLm8dRx3RtB1TrFsXXRGtdoNQTNetROIu/3CopgV1w6CNiOzNRXEXghPudx1aC/k2rbCZ
 g8E=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Aug 2021 22:49:50 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v5 5/9] libata: cleanup ata_dev_configure()
Date:   Tue, 10 Aug 2021 14:49:35 +0900
Message-Id: <20210810054939.30760-6-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210810054939.30760-1-damien.lemoal@wdc.com>
References: <20210810054939.30760-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce the helper functions ata_dev_config_lba() and
ata_dev_config_chs() to configure the addressing capabilities of a
device. To control message printing in these new helpers, as well as
in ata_dev_configure() and in ata_hpa_resize(), add the helper function
ata_dev_print_info() to avoid open coding for the eh context
ATA_EHI_PRINTINFO flag in multiple functions.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-core.c | 131 ++++++++++++++++++++++----------------
 1 file changed, 75 insertions(+), 56 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 499ec1380676..660b450bc498 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -159,6 +159,12 @@ MODULE_DESCRIPTION("Library module for ATA devices");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
 
+static inline bool ata_dev_print_info(struct ata_device *dev)
+{
+	struct ata_eh_context *ehc = &dev->link->eh_context;
+
+	return ehc->i.flags & ATA_EHI_PRINTINFO;
+}
 
 static bool ata_sstatus_online(u32 sstatus)
 {
@@ -1266,8 +1272,7 @@ static int ata_set_max_sectors(struct ata_device *dev, u64 new_sectors)
  */
 static int ata_hpa_resize(struct ata_device *dev)
 {
-	struct ata_eh_context *ehc = &dev->link->eh_context;
-	int print_info = ehc->i.flags & ATA_EHI_PRINTINFO;
+	bool print_info = ata_dev_print_info(dev);
 	bool unlock_hpa = ata_ignore_hpa || dev->flags & ATA_DFLAG_UNLOCK_HPA;
 	u64 sectors = ata_id_n_sectors(dev->id);
 	u64 native_sectors;
@@ -2363,6 +2368,65 @@ static void ata_dev_config_trusted(struct ata_device *dev)
 		dev->flags |= ATA_DFLAG_TRUSTED;
 }
 
+static int ata_dev_config_lba(struct ata_device *dev)
+{
+	struct ata_port *ap = dev->link->ap;
+	const u16 *id = dev->id;
+	const char *lba_desc;
+	char ncq_desc[24];
+	int ret;
+
+	dev->flags |= ATA_DFLAG_LBA;
+
+	if (ata_id_has_lba48(id)) {
+		lba_desc = "LBA48";
+		dev->flags |= ATA_DFLAG_LBA48;
+		if (dev->n_sectors >= (1UL << 28) &&
+		    ata_id_has_flush_ext(id))
+			dev->flags |= ATA_DFLAG_FLUSH_EXT;
+	} else {
+		lba_desc = "LBA";
+	}
+
+	/* config NCQ */
+	ret = ata_dev_config_ncq(dev, ncq_desc, sizeof(ncq_desc));
+
+	/* print device info to dmesg */
+	if (ata_msg_drv(ap) && ata_dev_print_info(dev))
+		ata_dev_info(dev,
+			     "%llu sectors, multi %u: %s %s\n",
+			     (unsigned long long)dev->n_sectors,
+			     dev->multi_count, lba_desc, ncq_desc);
+
+	return ret;
+}
+
+static void ata_dev_config_chs(struct ata_device *dev)
+{
+	struct ata_port *ap = dev->link->ap;
+	const u16 *id = dev->id;
+
+	if (ata_id_current_chs_valid(id)) {
+		/* Current CHS translation is valid. */
+		dev->cylinders = id[54];
+		dev->heads     = id[55];
+		dev->sectors   = id[56];
+	} else {
+		/* Default translation */
+		dev->cylinders	= id[1];
+		dev->heads	= id[3];
+		dev->sectors	= id[6];
+	}
+
+	/* print device info to dmesg */
+	if (ata_msg_drv(ap) && ata_dev_print_info(dev))
+		ata_dev_info(dev,
+			     "%llu sectors, multi %u, CHS %u/%u/%u\n",
+			     (unsigned long long)dev->n_sectors,
+			     dev->multi_count, dev->cylinders,
+			     dev->heads, dev->sectors);
+}
+
 static void ata_dev_config_devslp(struct ata_device *dev)
 {
 	u8 *sata_setting = dev->link->ap->sector_buf;
@@ -2410,8 +2474,7 @@ static void ata_dev_config_devslp(struct ata_device *dev)
 int ata_dev_configure(struct ata_device *dev)
 {
 	struct ata_port *ap = dev->link->ap;
-	struct ata_eh_context *ehc = &dev->link->eh_context;
-	int print_info = ehc->i.flags & ATA_EHI_PRINTINFO;
+	bool print_info = ata_dev_print_info(dev);
 	const u16 *id = dev->id;
 	unsigned long xfer_mask;
 	unsigned int err_mask;
@@ -2538,62 +2601,18 @@ int ata_dev_configure(struct ata_device *dev)
 					dev->multi_count = cnt;
 		}
 
-		if (ata_id_has_lba(id)) {
-			const char *lba_desc;
-			char ncq_desc[24];
-
-			lba_desc = "LBA";
-			dev->flags |= ATA_DFLAG_LBA;
-			if (ata_id_has_lba48(id)) {
-				dev->flags |= ATA_DFLAG_LBA48;
-				lba_desc = "LBA48";
-
-				if (dev->n_sectors >= (1UL << 28) &&
-				    ata_id_has_flush_ext(id))
-					dev->flags |= ATA_DFLAG_FLUSH_EXT;
-			}
+		/* print device info to dmesg */
+		if (ata_msg_drv(ap) && print_info)
+			ata_dev_info(dev, "%s: %s, %s, max %s\n",
+				     revbuf, modelbuf, fwrevbuf,
+				     ata_mode_string(xfer_mask));
 
-			/* config NCQ */
-			rc = ata_dev_config_ncq(dev, ncq_desc, sizeof(ncq_desc));
+		if (ata_id_has_lba(id)) {
+			rc = ata_dev_config_lba(dev);
 			if (rc)
 				return rc;
-
-			/* print device info to dmesg */
-			if (ata_msg_drv(ap) && print_info) {
-				ata_dev_info(dev, "%s: %s, %s, max %s\n",
-					     revbuf, modelbuf, fwrevbuf,
-					     ata_mode_string(xfer_mask));
-				ata_dev_info(dev,
-					     "%llu sectors, multi %u: %s %s\n",
-					(unsigned long long)dev->n_sectors,
-					dev->multi_count, lba_desc, ncq_desc);
-			}
 		} else {
-			/* CHS */
-
-			/* Default translation */
-			dev->cylinders	= id[1];
-			dev->heads	= id[3];
-			dev->sectors	= id[6];
-
-			if (ata_id_current_chs_valid(id)) {
-				/* Current CHS translation is valid. */
-				dev->cylinders = id[54];
-				dev->heads     = id[55];
-				dev->sectors   = id[56];
-			}
-
-			/* print device info to dmesg */
-			if (ata_msg_drv(ap) && print_info) {
-				ata_dev_info(dev, "%s: %s, %s, max %s\n",
-					     revbuf,	modelbuf, fwrevbuf,
-					     ata_mode_string(xfer_mask));
-				ata_dev_info(dev,
-					     "%llu sectors, multi %u, CHS %u/%u/%u\n",
-					     (unsigned long long)dev->n_sectors,
-					     dev->multi_count, dev->cylinders,
-					     dev->heads, dev->sectors);
-			}
+			ata_dev_config_chs(dev);
 		}
 
 		ata_dev_config_devslp(dev);
-- 
2.31.1

