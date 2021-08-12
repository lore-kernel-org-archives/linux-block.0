Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1A6C432BE
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 02:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC2FF61077
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 02:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhHLCoe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Aug 2021 22:44:34 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:60785 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbhHLCoe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Aug 2021 22:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628736249; x=1660272249;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UnaVB6KDNNEpWf+5iF0GJ2TeYxp+J3L7FRn55Pjn1Ak=;
  b=DQ3kstj0rvIuW+0Ww+SC4uaLV7grE2ELz+Uw0buq9qTSc6RTa38FP83k
   IcBv78azSjtb8/GpWDvS+16aOQaJyrFAfb8rFrma0V2tCJUTsV/ZX7Y4h
   4ekfTulCw5/FFT8tkv0gRmhyf05PPnIn3PBpGt6oYGZVUaZP66DIMfKQ6
   qXeNlUO3V8vFtLEROWVwRmAqZMgaJV/pRlC9+8oEd2cGk9aU/1xDMVRA4
   3o4jlirKqBOcV6xJwb0KcYvAFkgKXjRFncPnykzf9XqymIpD3Hgdd0SpD
   +yYgFThpfuLFcAv2ekMfcxmSw0JQdEJsGFyM0TcAcsQLgwdrLu0Je/TZe
   g==;
X-IronPort-AV: E=Sophos;i="5.84,314,1620662400"; 
   d="scan'208";a="176999884"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Aug 2021 10:44:08 +0800
IronPort-SDR: aQdHTsuo0Q5McAgUZMasXyDHIlbisaFsTHr7l0+8gf1TCWnGHPmPUxrUrBNaiGOpK95UCy/Go2
 DWnd/Y5mlq8p0TXObsDpc9dCSPHAsp6bh4QPVhkG8Kvu8l2gMa2XZp9wjlv+ucZu+vNapoAy+5
 f9GCQhowJxelFATMIPPecJ8ZU2698rjYRiH9TBhdXNuCr+vx1DvnOpbqe+MwOWNcxPoYqegiGH
 /dIcolCgh5eFyIhTFSZkx2d9oicwamokMB/VY3k1H3EQG5xuOPt4Mm9lr8T1f9jHMmr66zlWCa
 dCn0tC1OzjcUiWghXzcvwo/w
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 19:19:39 -0700
IronPort-SDR: WSlbdD97QFoUjM7kXc7dItdFBmklD7MoyoHuEA8vdmLLN1Jx7GPoEVvApiO7fnqPqtKrJQBQqX
 l2dPd85NC5nrqAbPLPm7W+NZsJBafh5K8Psfu/TSMm7IJ6B/fJekMiBM8l+T1lVBeAo1PmGVKh
 kNf6rdmsDurTEWl5kdFVKNKMlQ2aQGb6f/djEggXdGUaqJuKAxJW1U5QcZBg0u5diFl1IezWPY
 +QLzdxuwSgGQEyMCTTVd7E9VdrDdtaEWt/ZnaUpNk431eH6RmuyxA/VGV/a7KOaXNR5XJCOU2W
 HeI=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Aug 2021 19:44:09 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v6 5/9] libata: cleanup ata_dev_configure()
Date:   Thu, 12 Aug 2021 11:43:59 +0900
Message-Id: <20210812024403.765819-6-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210812024403.765819-1-damien.lemoal@wdc.com>
References: <20210812024403.765819-1-damien.lemoal@wdc.com>
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

