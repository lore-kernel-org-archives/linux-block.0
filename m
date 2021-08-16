Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90090C19F35
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 01:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7514B61439
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 01:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbhHPBpn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Aug 2021 21:45:43 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:37268 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbhHPBpl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Aug 2021 21:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629078309; x=1660614309;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vN2oiBTls/J4Y9W2lVbQUymPeVbZdsgb/efvUuqJGVQ=;
  b=Jv1GKwJKfkv5dMeJ/wCdekBqtq0FwoHNTxQzQnR1YrB2VhLtYHZf2Ry8
   NXCdzdG26FnuPIWnBH/3Y+b+88+TzlFV+J56eZuz15OHZlmILCfSwnbKN
   cLJV1MmrhR8ImAHOnT8m8Zjk9hTyYplRpSut2tiVyPzGtqtmeO0UG7qvg
   oS5Z2cQpPFIHm7LUXrMj0CzFzAp3i55arInxtfB6mRne3wmZ6LC8Ij59A
   yp5F7WK5Xax/4U4K1ufSHxxtCedV8B1kun0NscU7TwKeJJr68TS7DpFqK
   NKna2sNdxgiiKAkdNg32V1YRCESGHdvv4tvljfz8XzefnK8aaZqoazkrp
   A==;
X-IronPort-AV: E=Sophos;i="5.84,324,1620662400"; 
   d="scan'208";a="177326718"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2021 09:45:05 +0800
IronPort-SDR: G+JClcilvxvoDmWdbpBCAhGeQEe0Yf/VV9qzrKX09atA/0Erpmpw6or5/PRKbi/woAEEriJRSR
 v9iFiFCCzwqLFEqqWvEyDxVOPREhSeTbG1ljFsRmUGZSXjuMsFu07ADoFunHx0TT0axd3kg12H
 odQcSTZwu5NCl+fDa8hdFhHHb2ORcQOzQ5rntRcyCaXTBRfPkKrJO9yENcuwhOH/BAXRwnUe+v
 8FS7l5rZbWNmmdLJMe1yJTj4clhsq6CRxldHZXKEVPZnAqdM2rTYGEPcTQ0gl5SJcxQy4KMcOJ
 aMe4naImZTLfKXET6FRsAGCD
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2021 18:20:32 -0700
IronPort-SDR: bU9vlPLT98KheDyu1JIU5abwaiD/tqC6DjlOAjkqY93QgxNT5O0WPvbOKHMXgap482+98FPjH6
 yUwcMGgzrz/4ubT1J33549Q3PDc0hZ0Wv0dz8fDxk8+3f1/ahrRVHVx/MtNsyQbxiyFXIGANzF
 9Ql0ks401UrKavI/raor4JP1K5UA3nlpFQqYFu1UFQgqUKhlhbpkv1WTy1LhLImIfV/7ogyn7B
 9p749VFU9zQ7bIUPv7y8G+52Cu9dxv2CkpbbBdeOPdQS/vflClac+cTehuXKk8Eazstx8HP9z2
 2WI=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Aug 2021 18:45:07 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v7 09/11] libata: Introduce ncq_prio_supported sysfs sttribute
Date:   Mon, 16 Aug 2021 10:44:54 +0900
Message-Id: <20210816014456.2191776-10-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210816014456.2191776-1-damien.lemoal@wdc.com>
References: <20210816014456.2191776-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently, the only way a user can determine if a SATA device supports
NCQ priority is to try to enable the use of this feature using the
ncq_prio_enable sysfs device attribute. If enabling the feature fails,
it is because the device does not support NCQ priority. Otherwise, the
feature is enabled and success indicates that the device supports NCQ
priority.

Improve this odd interface by introducing the read-only
ncq_prio_supported sysfs device attribute to indicate if a SATA device
supports NCQ priority. The value of this attribute reflects the status
of device flag ATA_DFLAG_NCQ_PRIO, which is set only for devices
supporting NCQ priority.

Add this new sysfs attribute to the device attributes group of libahci
and libata-sata.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/ata/libahci.c     |  1 +
 drivers/ata/libata-sata.c | 25 +++++++++++++++++++++++++
 include/linux/libata.h    |  1 +
 3 files changed, 27 insertions(+)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index fec2e9754aed..5b3fa2cbe722 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -125,6 +125,7 @@ EXPORT_SYMBOL_GPL(ahci_shost_attrs);
 struct device_attribute *ahci_sdev_attrs[] = {
 	&dev_attr_sw_activity,
 	&dev_attr_unload_heads,
+	&dev_attr_ncq_prio_supported,
 	&dev_attr_ncq_prio_enable,
 	NULL
 };
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index dc397ebda089..8f3ff830ab0c 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -834,6 +834,30 @@ DEVICE_ATTR(link_power_management_policy, S_IRUGO | S_IWUSR,
 	    ata_scsi_lpm_show, ata_scsi_lpm_store);
 EXPORT_SYMBOL_GPL(dev_attr_link_power_management_policy);
 
+static ssize_t ata_ncq_prio_supported_show(struct device *device,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct scsi_device *sdev = to_scsi_device(device);
+	struct ata_port *ap = ata_shost_to_port(sdev->host);
+	struct ata_device *dev;
+	bool ncq_prio_supported;
+	int rc = 0;
+
+	spin_lock_irq(ap->lock);
+	dev = ata_scsi_find_dev(ap, sdev);
+	if (!dev)
+		rc = -ENODEV;
+	else
+		ncq_prio_supported = dev->flags & ATA_DFLAG_NCQ_PRIO;
+	spin_unlock_irq(ap->lock);
+
+	return rc ? rc : sysfs_emit(buf, "%u\n", ncq_prio_supported);
+}
+
+DEVICE_ATTR(ncq_prio_supported, S_IRUGO, ata_ncq_prio_supported_show, NULL);
+EXPORT_SYMBOL_GPL(dev_attr_ncq_prio_supported);
+
 static ssize_t ata_ncq_prio_enable_show(struct device *device,
 					struct device_attribute *attr,
 					char *buf)
@@ -901,6 +925,7 @@ EXPORT_SYMBOL_GPL(dev_attr_ncq_prio_enable);
 struct device_attribute *ata_ncq_sdev_attrs[] = {
 	&dev_attr_unload_heads,
 	&dev_attr_ncq_prio_enable,
+	&dev_attr_ncq_prio_supported,
 	NULL
 };
 EXPORT_SYMBOL_GPL(ata_ncq_sdev_attrs);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index b23f28cfc8e0..a2d1bae7900b 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -539,6 +539,7 @@ typedef void (*ata_postreset_fn_t)(struct ata_link *link, unsigned int *classes)
 extern struct device_attribute dev_attr_unload_heads;
 #ifdef CONFIG_SATA_HOST
 extern struct device_attribute dev_attr_link_power_management_policy;
+extern struct device_attribute dev_attr_ncq_prio_supported;
 extern struct device_attribute dev_attr_ncq_prio_enable;
 extern struct device_attribute dev_attr_em_message_type;
 extern struct device_attribute dev_attr_em_message;
-- 
2.31.1

