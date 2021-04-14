Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1197C433ED
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 18:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD2DD611AD
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 18:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352363AbhDNS2r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Apr 2021 14:28:47 -0400
Received: from mail-pj1-f48.google.com ([209.85.216.48]:52831 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352047AbhDNS2m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Apr 2021 14:28:42 -0400
Received: by mail-pj1-f48.google.com with SMTP id r13so6920675pjf.2
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 11:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KeUodSNZ7ixhYW0SoN6jGIMOqBf1K8msD6bkng8nruQ=;
        b=jY1H6sHV/fZLtl052ONnP0q1+kziH/hmCA+GnRUtm5JNeC9Xm1vwKed0Vl7Ty7ydAY
         5QP3OB7rq9tcaGiCMx75Osq38vDDAtyGMpxRasDZAsWCfQ/tKvnPNEH2tc3IHHsnLYuA
         rBZRFV8ZKeOHWOc2bDvtdPkksnAbf6J/ikdP75RFl225q1afaYQlR9mVQpTUWLUvUF3g
         V36kPtRhLQCoFoC6lZJfXQTyTadLeQJSs7XOc8t6h3CZnvbPihZF3MQlxgzBIF/R0bkb
         hl3bEtxtQiC4v/KfiaaSGWd/3qdvcOsh/PHwUxwbbA3yew5AGIlt51TLlfzdt5OvDvLW
         wuwg==
X-Gm-Message-State: AOAM5302O3CX1Z265bXZuo6EpEFV3aGTzV/gDPHd4kBsaX0hBYe8A8KL
        no4Dx1HqKSgzavZ5Zw4E8c8=
X-Google-Smtp-Source: ABdhPJw5Rgtq+Ji9BBQS3mdz/+BJdHgPhlDaQsRSrgux3SGTSH9+EG2B++qiqz9uhVBS+UsKKKf6jQ==
X-Received: by 2002:a17:902:c404:b029:ea:f0a9:6060 with SMTP id k4-20020a170902c404b02900eaf0a96060mr19084513plk.9.1618424900381;
        Wed, 14 Apr 2021 11:28:20 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:6906:3c2c:a534:ef9])
        by smtp.gmail.com with ESMTPSA id w16sm137312pfj.87.2021.04.14.11.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:28:19 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH] ata: Fix several kernel-doc headers
Date:   Wed, 14 Apr 2021 11:28:14 -0700
Message-Id: <20210414182814.18065-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix the kernel-doc warnings that are reported when building the ATA code
with W=1. This patch only modifies source code comments.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ata/ata_generic.c      | 2 +-
 drivers/ata/libata-acpi.c      | 3 ++-
 drivers/ata/libata-pmp.c       | 2 +-
 drivers/ata/libata-sata.c      | 4 ++--
 drivers/ata/libata-transport.c | 6 +++---
 drivers/ata/pata_acpi.c        | 6 +++---
 drivers/ata/pata_marvell.c     | 2 +-
 7 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
index 9ff545ce8da3..77dd764e6936 100644
--- a/drivers/ata/ata_generic.c
+++ b/drivers/ata/ata_generic.c
@@ -151,7 +151,7 @@ static int is_intel_ider(struct pci_dev *dev)
 }
 
 /**
- *	ata_generic_init		-	attach generic IDE
+ *	ata_generic_init_one - attach generic IDE
  *	@dev: PCI device found
  *	@id: match entry
  *
diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 224e3486e9a5..553bfdcfa311 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -476,7 +476,7 @@ static int ata_dev_get_GTF(struct ata_device *dev, struct ata_acpi_gtf **gtf)
 }
 
 /**
- * ata_acpi_gtm_xfermode - determine xfermode from GTM parameter
+ * ata_acpi_gtm_xfermask - determine xfermode from GTM parameter
  * @dev: target device
  * @gtm: GTM parameter to use
  *
@@ -624,6 +624,7 @@ static int ata_acpi_filter_tf(struct ata_device *dev,
  * ata_acpi_run_tf - send taskfile registers to host controller
  * @dev: target ATA device
  * @gtf: raw ATA taskfile register set (0x1f1 - 0x1f7)
+ * @prev_gtf: previous taskfile register set
  *
  * Outputs ATA taskfile to standard ATA host controller.
  * Writes the control, feature, nsect, lbal, lbam, and lbah registers.
diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 79f2aeeb482a..ba7be3f38617 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -62,7 +62,7 @@ static unsigned int sata_pmp_read(struct ata_link *link, int reg, u32 *r_val)
  *	sata_pmp_write - write PMP register
  *	@link: link to write PMP register for
  *	@reg: register to write
- *	@r_val: value to write
+ *	@val: value to write
  *
  *	Write PMP register.
  *
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index c16423e44525..8adeab76dd38 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1067,7 +1067,7 @@ int ata_scsi_change_queue_depth(struct scsi_device *sdev, int queue_depth)
 EXPORT_SYMBOL_GPL(ata_scsi_change_queue_depth);
 
 /**
- *	port_alloc - Allocate port for a SAS attached SATA device
+ *	ata_sas_port_alloc - Allocate port for a SAS attached SATA device
  *	@host: ATA host container for all SAS ports
  *	@port_info: Information from low-level host driver
  *	@shost: SCSI host that the scsi device is attached to
@@ -1127,7 +1127,7 @@ int ata_sas_port_start(struct ata_port *ap)
 EXPORT_SYMBOL_GPL(ata_sas_port_start);
 
 /**
- *	ata_port_stop - Undo ata_sas_port_start()
+ *	ata_sas_port_stop - Undo ata_sas_port_start()
  *	@ap: Port to shut down
  *
  *	May be used as the port_stop() entry in ata_port_operations.
diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index 6a40e3c6cf49..26586b8adfb9 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -250,7 +250,7 @@ static int ata_tport_match(struct attribute_container *cont,
 
 /**
  * ata_tport_delete  --  remove ATA PORT
- * @port:	ATA PORT to remove
+ * @ap:	ATA PORT to remove
  *
  * Removes the specified ATA PORT.  Remove the associated link as well.
  */
@@ -376,7 +376,7 @@ static int ata_tlink_match(struct attribute_container *cont,
 
 /**
  * ata_tlink_delete  --  remove ATA LINK
- * @port:	ATA LINK to remove
+ * @link:	ATA LINK to remove
  *
  * Removes the specified ATA LINK.  remove associated ATA device(s) as well.
  */
@@ -632,7 +632,7 @@ static void ata_tdev_free(struct ata_device *dev)
 
 /**
  * ata_tdev_delete  --  remove ATA device
- * @port:	ATA PORT to remove
+ * @ata_dev:	ATA PORT to remove
  *
  * Removes the specified ATA device.
  */
diff --git a/drivers/ata/pata_acpi.c b/drivers/ata/pata_acpi.c
index fa2bfc344a97..2014a974a59a 100644
--- a/drivers/ata/pata_acpi.c
+++ b/drivers/ata/pata_acpi.c
@@ -28,7 +28,7 @@ struct pata_acpi {
 
 /**
  *	pacpi_pre_reset	-	check for 40/80 pin
- *	@ap: Port
+ *	@link: Port
  *	@deadline: deadline jiffies for the operation
  *
  *	Perform the PATA port setup we need.
@@ -63,8 +63,8 @@ static int pacpi_cable_detect(struct ata_port *ap)
 
 /**
  *	pacpi_discover_modes	-	filter non ACPI modes
+ *	@ap: ATA interface
  *	@adev: ATA device
- *	@mask: proposed modes
  *
  *	Try the modes available and see which ones the ACPI method will
  *	set up sensibly. From this we get a mask of ACPI modes we can use
@@ -224,7 +224,7 @@ static struct ata_port_operations pacpi_ops = {
 /**
  *	pacpi_init_one - Register ACPI ATA PCI device with kernel services
  *	@pdev: PCI device to register
- *	@ent: Entry in pacpi_pci_tbl matching with @pdev
+ *	@id: PCI device ID
  *
  *	Called from kernel PCI layer.
  *
diff --git a/drivers/ata/pata_marvell.c b/drivers/ata/pata_marvell.c
index b066809ba9a1..602e5c2baa4b 100644
--- a/drivers/ata/pata_marvell.c
+++ b/drivers/ata/pata_marvell.c
@@ -110,7 +110,7 @@ static struct ata_port_operations marvell_ops = {
 /**
  *	marvell_init_one - Register Marvell ATA PCI device with kernel services
  *	@pdev: PCI device to register
- *	@ent: Entry in marvell_pci_tbl matching with @pdev
+ *	@id: Entry in marvell_pci_tbl matching with @pdev
  *
  *	Called from kernel PCI layer.
  *
