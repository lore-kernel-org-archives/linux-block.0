Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E674C4338F
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 02:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 006EC6101E
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 02:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbhHLCoj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Aug 2021 22:44:39 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:60785 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233733AbhHLCoh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Aug 2021 22:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628736253; x=1660272253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QxLawA2FoU92rg8+3N60ckeNjg2itVghvmelVKXdIyI=;
  b=Z6ksMTWJzlWKJZg0F7H0nU/g17r/1pdnSWS4oxj1qR5Cg9bAehcvZwgj
   keSljUpqON93eEtt2iFrQssk09aR7twoLQ0VgH72k1g+yhAMci5yVzt6m
   usOcXhj0PWfjR0VE2sn0xmQLpNdQ9fCPDr3gPLZS6OZ3PMLANMtGPuDoY
   qiYFE/IPq3780hiLWJ6nf9vOShaz9M6InUDtjUkfJd9nmtIcjOUYHrbpw
   KehDdBkDNYO0ZF+cTg7R+eTTpgMYzbUrRaUolJll2FMUvBNgmSB0CBtvt
   dR0V1Xq92pPT/+vsmujhFGp+K4aWDTYrPYjhO826oIBqAImujxYudVVXv
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,314,1620662400"; 
   d="scan'208";a="176999902"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Aug 2021 10:44:12 +0800
IronPort-SDR: Nl994DRrmXxrQjAQesDuScbw7sYyAx4Jf29b4uEU2DWSHiq48oqGKvyH8NsEDzHaKdR58DPyN3
 cq8Ex9pv9uyUTfSKiU7BcSDqB/K3CYQhPj3Jhu1EkOdRT1cigAKx4CZRhb633q6xiPMaMw7V+w
 CPt9/O/DbmAokwlFarwHpXF0QnIzdjHjtit3cQe4KPlBQHKFf3xz2xSFkPzxjRMtszIyqFRPmo
 7KISlc2QMZKjGfqjnHpAPaZGqSLvWyoP1mH0nBjP8Gi61yMA4Fdu/9KlABFoAoXVcW3DEPHbV9
 g5b9ZUGUpH+mtUBn1qYScaMi
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 19:19:42 -0700
IronPort-SDR: 4JMrYB64WMalT4y1XH7bd7XH6Rwf7neJoc3uXlt2+8rn3iCKU1emckI23PtLLfrk8eudQPL3MK
 WFrHUMVoN26NEj6FYqLDKwClqt0yN6Vc8BmEwnvX7ToN6LB03Pj2AYNZR9uo+2BSUunAamjixr
 LGrK5uDtUV5wbfgq+DqbFvvKS+WpfhAsTsmFLUtFb97LFp86sF1OGhHjzrZOvH0ZvWwj/ue4qO
 IwlBsQyih1les24lvyH5tcKtOKZgKSBulNsD/gPmyItPWx/0eVt7uKUeRTWoLABaDa5YwhaaEr
 iXs=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Aug 2021 19:44:12 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v6 8/9] libata: print feature list on device scan
Date:   Thu, 12 Aug 2021 11:44:02 +0900
Message-Id: <20210812024403.765819-9-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210812024403.765819-1-damien.lemoal@wdc.com>
References: <20210812024403.765819-1-damien.lemoal@wdc.com>
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

