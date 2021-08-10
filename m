Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C829C43214
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 05:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CECB61073
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 05:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237696AbhHJFuW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Aug 2021 01:50:22 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:9551 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237697AbhHJFuQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Aug 2021 01:50:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628574595; x=1660110595;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QxLawA2FoU92rg8+3N60ckeNjg2itVghvmelVKXdIyI=;
  b=jrYGqtpIez/JZYQbBQYruWdPksglYVVmge7fKURAc5/Nh8aRpXaIzyZo
   UGnwhyZlRSJD7HjOMLoG0WGcgJfN9zxKaEM6AJ+Jqp6jdWkFfoCffNKhw
   SZlpcAwoaRR71SpYnkW7/s7VCvb/jEAVehU3sP7Phx5xadWpJqbAQ75y6
   0Bffc1yFjUjIi1FyFcnZRNusnxST8slZSZExstBAGifIfSlxCDjn4qN2P
   g2B132cbDl0V09qjcLFhkYH4ioxxShkYpeMUZCVxlO+6BnviEJCekZzHl
   rYa9m/JpMA0/LfarMb6gIwtk3Z5K/NMdmt9YV0fflOjlEzP7L8XLfRfxA
   A==;
X-IronPort-AV: E=Sophos;i="5.84,309,1620662400"; 
   d="scan'208";a="288340200"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Aug 2021 13:49:55 +0800
IronPort-SDR: tlQY5Y9UZP0GAOdnEisnh5Sm7fqv3HyMgoA8nZoK/61O35dEIrvHvmM5f8WIPE1QJx32n4UuYs
 aCFXA4085IqoGkaitm0eTRyX8acjn7xO7TaKl7uJlkb4QTeWQIWKlfextE7siEFxSbT+mhRXMS
 oQkZmYju+TKzLvjp/StHrUQmSQwaYAmffoPNYDWEUa4K+BlNhohM2X4zWHEZkVewPfs0ibxLev
 7jL0UGWdl7UTDgvpv6SibmGezZc4Av6wvSV4IZXM9vq5c4al88N0lvJynInsTee45Nnet4xVAy
 TOXwrlhYTyLLkDox3xFkAD/G
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2021 22:27:17 -0700
IronPort-SDR: hqn9Um6buocNEBzLnoseqFiJIKKJfQjWRztbg7EWBKXmPV7U06BVGmhfWQORM3801Z8+dLM73Z
 +zryrBgbQy+VehS/ib4o6oxF5NqwSeZQ9IKwPIwLJ4aLD4oB1cKRw8DHANSQP0KFUf0Usuw/MX
 /CXmkmoTLje4XTIqZnq3ggVQiCVvXH20fRDWwwTOrx9wKO0oi3bQ9tmtksO81qjNMMkaqgaWQs
 xFM8TVLSY3iQis3O2dcIytXsS+I5+2Z2ajJ8DeBA+D6ihhy3167pZDmZN+yIrdCPiiZqkc14Ah
 oXY=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Aug 2021 22:49:54 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v5 8/9] libata: print feature list on device scan
Date:   Tue, 10 Aug 2021 14:49:38 +0900
Message-Id: <20210810054939.30760-9-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210810054939.30760-1-damien.lemoal@wdc.com>
References: <20210810054939.30760-1-damien.lemoal@wdc.com>
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

