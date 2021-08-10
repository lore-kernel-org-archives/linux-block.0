Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC44C4320A
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 05:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01AB66101E
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 05:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237277AbhHJFwE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Aug 2021 01:52:04 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:9554 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237693AbhHJFuS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Aug 2021 01:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628574597; x=1660110597;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PaQ6Zl6aq899pRIUCn+Us/+eg+Mn4yjWtQ689aYZ9Us=;
  b=JjWwnn+PD4fPNO35QrS2OW/8qUd5vZbyMhph37ziaF1EQ6lvY5dDLEyH
   xQUdi2b0ZtW12KNKTlkinMlh46u6acqcmgYBwMCtIIz/mz8/APnc5W5zY
   CQl+SUqhtkhdIsMw+jJNurUCldEVf6e3Gf4iiXkCFnkm4bJ1t2qDOkvKq
   J1VfWndw+kxxbFNToBGxTjnwYMu8s0NNIgJFKIlFqvDJRBt4SNPgNUzA3
   DplJKZaKscjmId4sBHPHHPJTNNZhfxiJLUGVecFE6YkIbKYNL+8yMWfS0
   54e7cl5b2KpQSGXMxAA86PZt8uXYO1FtiJzv1UUv2EbumfjV3rt1na+cO
   w==;
X-IronPort-AV: E=Sophos;i="5.84,309,1620662400"; 
   d="scan'208";a="288340204"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Aug 2021 13:49:57 +0800
IronPort-SDR: x30euQLS5YCPljHgV1rgmTp9B3v87AJ3iOnK3Sc7zlnsC+L9wNBm+pHdkWnKKIBk+UZ6MX0NgQ
 oKh6Z2gisDI3X0rVDtvE+ZNlxukpT5Pw7qP2ey8h9FWAaHEEScl6xPlBDNAIYpJNTjuO4MWRtS
 /9ywJOUftOpqqv0oE6e9HQbLolz+W4WpuDra++l7Y2fuxPkh1pR4P3QvFRVJO85hOJ8hJ02Rou
 NAId60EILd7Zc8FXsL+phaOj0b3jhHz9DYlG5gVRhdZtSXEf5Hh2oyYzZ10Pt3wPUvIV/fvp2R
 ACMKiqrbbKusr+KYwVPcmz17
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2021 22:27:19 -0700
IronPort-SDR: sb9i6YE5JTUumSZ6lN5WizaVfpdEtP+H058mvhPp2sbUqqgH09igT+xBVSmqqz+hf7ActuKzas
 VRXMLXx1OOcv77kifu1G2VP+jLb7IpNnQ04nY2TxluMas4CjeBMA7Qazp+JCuw5nfGxoKd6lUu
 exe3XFnlA7EgTW15M1SPW2osP8+nJ3+hcAIppcFubOUMWICGhQLko40rxaabw223wVyFAq2vAk
 diHFeJ3r1+NXjmEj590NVlRDVKwVmTD6Udu1XOUFK1jGRxhGtuUVjWlTAc+g9La+P2yxRBIFru
 +Jc=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Aug 2021 22:49:56 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v5 9/9] libahci: Introduce ncq_prio_supported sysfs sttribute
Date:   Tue, 10 Aug 2021 14:49:39 +0900
Message-Id: <20210810054939.30760-10-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210810054939.30760-1-damien.lemoal@wdc.com>
References: <20210810054939.30760-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently, the only way a user can determine if a SATA device supports
NCQ priority is to try to enable the use of this feature using the
ncq_prio_enable sysfs device attribute. If enabling the feature fails,
it is because the device does not support NCQ priority. Otherwise, the
feature is enabled and indicates that the device supports NCQ priority.

Improve this odd interface by introducing the read-only
ncq_prio_supported sysfs device attribute to indicate if a SATA device
supports NCQ priority. The value of this attribute reflects if the
device flag ATA_DFLAG_NCQ_PRIO is set or cleared.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libahci.c     |  1 +
 drivers/ata/libata-sata.c | 24 ++++++++++++++++++++++++
 include/linux/libata.h    |  1 +
 3 files changed, 26 insertions(+)

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
index dc397ebda089..5566fd4bb38f 100644
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

