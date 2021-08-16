Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD63C43216
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 01:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 790236140D
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 01:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhHPBpm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Aug 2021 21:45:42 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:37276 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbhHPBpi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Aug 2021 21:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629078306; x=1660614306;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QxLawA2FoU92rg8+3N60ckeNjg2itVghvmelVKXdIyI=;
  b=AEN/KbKRW2Qc8FOcHJKUECncdxX/2z7mYIVLelSejbdmApbTSEOlEC2Z
   VAKTWIthr/A1r2e42phFR0eHE7V4/I6uni3Nm2sBegLjzgZ+O1lIGD8dX
   +jYEBVK6vfyAncmHed6/AMTgT6pe6PBfQ/tqcpPIDFEmoG4mSxZ1oGsuf
   r7khdTyhBufV5q13qgyZgh9cwwXvrUTKJueN+snHdsYGHMnVmYFGGGcb0
   asmkSit6ueY1XtKge1RQ3pOqXbXE159+3f3bDfQaD7dVc9h+pDbfTNu7A
   svH457qi091DZaM2eBuY9eXbY8VVr9NbUfhDzPLn2X3UUErDZ0Y6lgMrg
   w==;
X-IronPort-AV: E=Sophos;i="5.84,324,1620662400"; 
   d="scan'208";a="177326713"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2021 09:45:05 +0800
IronPort-SDR: c/qaqMjKS7wxFOlj4nsnCq/C3rytx+AG8NVhojTRpMdr0kEVDjzavnIGvYg88mk4bj0ubw//PN
 iOCA+rjt7/gXA9+wh0fRIXlBbWGS69NXnTno7cTmpdQJUtR4bckspSPmowLDnx6dvH0fIPR46W
 wpV6i7/qcLTQdbAAoHuaJ54IWwU31AO4FPYQYCO1+vPjDv3z6HZIn2iPCDl0sDINM1nRWTTq0K
 qpqVnW9cyKJlxYBL6Ul1tfTtjrUOjPvTN9sQ/z75ZW6E+FwHi4bQomYSLCCSLMhK1yQ2+7qgSP
 7/e27zpFsdOizCpNCzbe45FH
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2021 18:20:31 -0700
IronPort-SDR: olo9Grpn1QHqiaXEfCuRGX17u5dvPgmBITQpGmLhEKLV9jfcaQm4aDYR5z+I/h6OPlUonDncCH
 jslXCpdKF75mqFH4V0fKrbNLsTxQ5Wajkpg/rchjakK0zxZrGNizuXSNM+rBdHdwQgO1SlBfYE
 eGMVXUiKJ/B7qJj4DahVmJbnrWcRGcpA2JoC4/sEp3hM5W03dPUbVY+Q+BG9vogcfSRkj5c7+T
 T+iWmm2CXEX0CmrHi5BwG/qT1mUan7Zi//H4emt8NCBBd/ATHm0QvDaVFzjpcRoDgNFjDLLE7T
 h0g=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Aug 2021 18:45:06 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v7 08/11] libata: print feature list on device scan
Date:   Mon, 16 Aug 2021 10:44:53 +0900
Message-Id: <20210816014456.2191776-9-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210816014456.2191776-1-damien.lemoal@wdc.com>
References: <20210816014456.2191776-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Print a list of features supported by a drive when it is configured in
ata_dev_configure() using the new function ata_dev_print_features().
The features printed are not already advertized and are: trusted
send-recev support, device attention support, device sleep support,
NCQ send-recv support and NCQ priority support.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-core.c | 17 +++++++++++++++++
 include/linux/libata.h    |  4 ++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index bad577dbbc0d..68a55d3e977a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2433,6 +2433,20 @@ static void ata_dev_config_devslp(struct ata_device *dev)
 	}
 }
 
+static void ata_dev_print_features(struct ata_device *dev)
+{
+	if (!(dev->flags & ATA_DFLAG_FEATURES_MASK))
+		return;
+
+	ata_dev_info(dev,
+		     "Features:%s%s%s%s%s\n",
+		     dev->flags & ATA_DFLAG_TRUSTED ? " Trust" : "",
+		     dev->flags & ATA_DFLAG_DA ? " Dev-Attention" : "",
+		     dev->flags & ATA_DFLAG_DEVSLP ? " Dev-Sleep" : "",
+		     dev->flags & ATA_DFLAG_NCQ_SEND_RECV ? " NCQ-sndrcv" : "",
+		     dev->flags & ATA_DFLAG_NCQ_PRIO ? " NCQ-prio" : "");
+}
+
 /**
  *	ata_dev_configure - Configure the specified ATA/ATAPI device
  *	@dev: Target device to configure
@@ -2595,6 +2609,9 @@ int ata_dev_configure(struct ata_device *dev)
 		ata_dev_config_zac(dev);
 		ata_dev_config_trusted(dev);
 		dev->cdb_len = 32;
+
+		if (ata_msg_drv(ap) && print_info)
+			ata_dev_print_features(dev);
 	}
 
 	/* ATAPI-specific feature tests */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 3fcd24236793..b23f28cfc8e0 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -161,6 +161,10 @@ enum {
 	ATA_DFLAG_D_SENSE	= (1 << 29), /* Descriptor sense requested */
 	ATA_DFLAG_ZAC		= (1 << 30), /* ZAC device */
 
+	ATA_DFLAG_FEATURES_MASK	= ATA_DFLAG_TRUSTED | ATA_DFLAG_DA | \
+				  ATA_DFLAG_DEVSLP | ATA_DFLAG_NCQ_SEND_RECV | \
+				  ATA_DFLAG_NCQ_PRIO,
+
 	ATA_DEV_UNKNOWN		= 0,	/* unknown device */
 	ATA_DEV_ATA		= 1,	/* ATA device */
 	ATA_DEV_ATA_UNSUP	= 2,	/* ATA device (unsupported) */
-- 
2.31.1

