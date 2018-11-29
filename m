Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713E7C43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 14:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F9A020673
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 14:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="01nhtLSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F9A020673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbeK3Br2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:47:28 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37974 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732862AbeK3Bdj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 20:33:39 -0500
Received: by mail-lf1-f67.google.com with SMTP id p86so1586402lfg.5
        for <linux-block@vger.kernel.org>; Thu, 29 Nov 2018 06:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v4vz3sbNBH1XzX3GydMDty1pB9dgsxmbyenTp4UEM2g=;
        b=01nhtLSOQ7vb/NXRZVxVKtSkqCHTXr9/A4oQQPr9J9b6WQHNmBDdmdUK0gcHChQAYw
         pWV43ZPZeUtkTT7voJGB19uuIhcc9XipCB4oLE3oNO0QY5T8UxIJxwBYrAIYxGlsFgUC
         MMWu+DnfkCQrBpqkMqwNKhQplbJf7N6Txeyz8QGhrZVXHFPICp1gS+Gh2DFLejviIz9f
         ccifjgqEgiQeHO8GtjNtzWkeE4KT0ZcQe0GaItOSLXMr2sLni36MUYoPzVc+PXwSxnPx
         oWSoG3Zwfj+jFFoocGlziL4zoY13JCWZjLhlGRphuj0VVDDr6Wy9aonK2JPLvN/7CMIw
         dVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v4vz3sbNBH1XzX3GydMDty1pB9dgsxmbyenTp4UEM2g=;
        b=BSrV42GsAOUAh5fJMEatQOjPG8rAhGbQm0xIx3lGvxk3Y89YfeDN2KCg8YwMQldDpb
         JfhMkoQmaFwe6mdSX9M/IMXNYtn2OaKtusoqJMIZ20aajJ0qLyAOZcDbzd4/udKTwCDx
         /ZIpSk72W26XMJ4mbFo6kDRtvTkbiO6Q2X3YQm3Ljd9spcz/eB3hbMXRz7dsY0LiQrI+
         C1eW+NXcmC39gJTJz4xkXQDPMpQdY89jsnhWi+Gd4HzQB5erGDeLNat6R84HTh5YwaOw
         QQQb4m4wrWNW5YrTYLj30vvBBITwVHJKidaU3TT+xiq8t6u/+UZp+8cAl+NKblMU0Aaa
         RPVg==
X-Gm-Message-State: AA+aEWZmlBFeJj/FzzTxMK5gOKkbNCqXF69oX5RJ69Cy0cfcxPpOC7oC
        hHMpCMrJ4x5kWum+IrS2k+w2sg==
X-Google-Smtp-Source: AFSGD/Ub3RUnFyfDx0S48fa+hcgyMzCJcXLKW7ISdSubwlWj/q0PqXbJQjqnB/lHOdEhwYfKtr+ezQ==
X-Received: by 2002:a19:7d42:: with SMTP id y63mr1145504lfc.47.1543501684696;
        Thu, 29 Nov 2018 06:28:04 -0800 (PST)
Received: from skyninja.webspeed.dk (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.gmail.com with ESMTPSA id c19sm326970lfg.86.2018.11.29.06.28.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 06:28:03 -0800 (PST)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        javier@cnexlabs.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, linux-nvme@lists.infradead.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH] lightnvm: simplify geometry enumeration
Date:   Thu, 29 Nov 2018 15:27:38 +0100
Message-Id: <20181129142738.9567-1-mb@lightnvm.io>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently the geometry of an OCSSD is enumerated using a two step
approach:

First, nvm_register is called, the OCSSD identify command is issued,
and second the geometry sos and csecs values are read either from the
OCSSD identify if it is a 1.2 drive, or from the NVMe namespace data
structure if it is a 2.0 device.

This patch recombines it into a single step, such that nvm_register can
use the csecs and sos fields independent of which version is used. This
enables one to dynamically size the lightnvm subsystem dma pool.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/core.c      | 12 +++++-------
 drivers/nvme/host/core.c     | 18 +++++++++---------
 drivers/nvme/host/lightnvm.c | 18 ++++++------------
 drivers/nvme/host/nvme.h     |  2 --
 4 files changed, 20 insertions(+), 30 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 73ab3cf26868..a1d52e934ce4 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -1145,25 +1145,23 @@ int nvm_register(struct nvm_dev *dev)
 	if (!dev->q || !dev->ops)
 		return -EINVAL;
 
+	ret = nvm_init(dev);
+	if (ret)
+		return ret;
+
 	dev->dma_pool = dev->ops->create_dma_pool(dev, "ppalist");
 	if (!dev->dma_pool) {
 		pr_err("nvm: could not create dma pool\n");
+		nvm_free(dev);
 		return -ENOMEM;
 	}
 
-	ret = nvm_init(dev);
-	if (ret)
-		goto err_init;
-
 	/* register device with a supported media manager */
 	down_write(&nvm_lock);
 	list_add(&dev->devices, &nvm_devices);
 	up_write(&nvm_lock);
 
 	return 0;
-err_init:
-	dev->ops->destroy_dma_pool(dev->dma_pool);
-	return ret;
 }
 EXPORT_SYMBOL(nvm_register);
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 65c42448e904..387833b37e38 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1516,8 +1516,6 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	if (ns->noiob)
 		nvme_set_chunk_size(ns);
 	nvme_update_disk_info(disk, ns, id);
-	if (ns->ndev)
-		nvme_nvm_update_nvm_info(ns);
 #ifdef CONFIG_NVME_MULTIPATH
 	if (ns->head->disk)
 		nvme_update_disk_info(ns->head->disk, ns, id);
@@ -3086,13 +3084,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	nvme_setup_streams_ns(ctrl, ns);
 	nvme_set_disk_name(disk_name, ns, ctrl, &flags);
 
-	if ((ctrl->quirks & NVME_QUIRK_LIGHTNVM) && id->vs[0] == 0x1) {
-		if (nvme_nvm_register(ns, disk_name, node)) {
-			dev_warn(ctrl->device, "LightNVM init failure\n");
-			goto out_unlink_ns;
-		}
-	}
-
 	disk = alloc_disk_node(0, node);
 	if (!disk)
 		goto out_unlink_ns;
@@ -3106,6 +3097,13 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	__nvme_revalidate_disk(disk, id);
 
+	if ((ctrl->quirks & NVME_QUIRK_LIGHTNVM) && id->vs[0] == 0x1) {
+		if (nvme_nvm_register(ns, disk_name, node)) {
+			dev_warn(ctrl->device, "LightNVM init failure\n");
+			goto out_put_disk;
+		}
+	}
+
 	down_write(&ctrl->namespaces_rwsem);
 	list_add_tail(&ns->list, &ctrl->namespaces);
 	up_write(&ctrl->namespaces_rwsem);
@@ -3119,6 +3117,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	kfree(id);
 
 	return;
+ out_put_disk:
+	put_disk(ns->disk);
  out_unlink_ns:
 	mutex_lock(&ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index d64805dc8efb..51d957ccf328 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -973,22 +973,11 @@ int nvme_nvm_ioctl(struct nvme_ns *ns, unsigned int cmd, unsigned long arg)
 	}
 }
 
-void nvme_nvm_update_nvm_info(struct nvme_ns *ns)
-{
-	struct nvm_dev *ndev = ns->ndev;
-	struct nvm_geo *geo = &ndev->geo;
-
-	if (geo->version == NVM_OCSSD_SPEC_12)
-		return;
-
-	geo->csecs = 1 << ns->lba_shift;
-	geo->sos = ns->ms;
-}
-
 int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node)
 {
 	struct request_queue *q = ns->queue;
 	struct nvm_dev *dev;
+	struct nvm_geo *geo;
 
 	_nvme_nvm_check_size();
 
@@ -996,6 +985,11 @@ int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node)
 	if (!dev)
 		return -ENOMEM;
 
+	/* Note that csecs and sos will be overridden if it is a 1.2 drive. */
+	geo = &dev->geo;
+	geo->csecs = 1 << ns->lba_shift;
+	geo->sos = ns->ms;
+
 	dev->q = q;
 	memcpy(dev->name, disk_name, DISK_NAME_LEN);
 	dev->ops = &nvme_nvm_dev_ops;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9fefba039d1e..4f5399c8808b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -541,13 +541,11 @@ static inline void nvme_mpath_stop(struct nvme_ctrl *ctrl)
 #endif /* CONFIG_NVME_MULTIPATH */
 
 #ifdef CONFIG_NVM
-void nvme_nvm_update_nvm_info(struct nvme_ns *ns);
 int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node);
 void nvme_nvm_unregister(struct nvme_ns *ns);
 extern const struct attribute_group nvme_nvm_attr_group;
 int nvme_nvm_ioctl(struct nvme_ns *ns, unsigned int cmd, unsigned long arg);
 #else
-static inline void nvme_nvm_update_nvm_info(struct nvme_ns *ns) {};
 static inline int nvme_nvm_register(struct nvme_ns *ns, char *disk_name,
 				    int node)
 {
-- 
2.17.1

