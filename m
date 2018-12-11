Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCFCC67839
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 19:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17BE20880
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 19:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="h8uyTNC2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17BE20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbeLKTSP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:18:15 -0500
Received: from mail-lj1-f179.google.com ([209.85.208.179]:34184 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbeLKTRT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 14:17:19 -0500
Received: by mail-lj1-f179.google.com with SMTP id u6-v6so14045708ljd.1
        for <linux-block@vger.kernel.org>; Tue, 11 Dec 2018 11:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7XDygkPcccQy4Mc4zLxYISf4Uom2ToSwN6J3bs9cwv8=;
        b=h8uyTNC2XH5tFv+pOZiK+bRi9bGqrVRpotZ36uGerBtY4EHQf9gIfzF2DNa182JxvW
         dDFbNkoBxZBkxfBsWJQzeRWCUxaxBcWTp/kNR1KYB/FRnyH6qDRMPUJaOoP8tr+a9LlF
         lc1YhXXcrc3S/Zq7OM/STSAgv1fFTj0ejtNvOTL/qd89HsetpIppvArcueNPb77+y4Cr
         P+CLWA7NdL6TJf0SyKjAQagnk6t8KcKiG3uyZ2IGinTdvOphti+aK3fELpiU4dqCdkj2
         Ne0oaxV74fpQUGtl+1bC1KU6/1OMFI4kMhB0QOEpgNjANP9fWEAqMU2/P/UtDiV6g5GG
         DIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7XDygkPcccQy4Mc4zLxYISf4Uom2ToSwN6J3bs9cwv8=;
        b=OhyML+gyCZ3RSNsvHXPQSbSBt+uleLgoDzk0YUtTFZLn0CfariQvnxhjqucs383HZ1
         V+Kf8UIrIsuqvcOAtyBPbj2JiWGMTuw/RYvlKnSgkDeLPZMTFDkDFKiwpc56mF+okV8l
         OWxNYpQEPT+/ntskMjDvQHEgLAwigPPylUt7hBYbQBjauk5+p1y188r5Yiv2qCStWMOC
         tm0NrttFqz9e48du5YAVo/ToZTSs3IqdWZjAMKBGe1W910tGNsnOiKrm4EJKuCWyX0Hk
         m49BGXPGIb4Apu1EcmOioWmk79RlJonpkSBh5AJXzz55+jjK7ZesOWl8ZnzPbZ1Gyd2+
         tXlw==
X-Gm-Message-State: AA+aEWaGYSmcgCvDoJhdzY7XeRGUoCiJHQUmUhi2PPoAGxTgFRFfZ15x
        o6fMvBIyW+FUpq5WhPJncbz5Jw==
X-Google-Smtp-Source: AFSGD/Xr68ifYirJhF/4HcAMcaaefrt0izY3/JAYS1Y91HWj7FtYiqDFHOi9b5HcBNA8pZwF5WWI1w==
X-Received: by 2002:a2e:9bc3:: with SMTP id w3-v6mr2704850ljj.70.1544555837437;
        Tue, 11 Dec 2018 11:17:17 -0800 (PST)
Received: from skyninja.webspeed.dk (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.gmail.com with ESMTPSA id v64sm2764583lfa.48.2018.12.11.11.17.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 11:17:16 -0800 (PST)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 14/21] lightnvm: simplify geometry enumeration
Date:   Tue, 11 Dec 2018 20:16:20 +0100
Message-Id: <20181211191627.15542-15-mb@lightnvm.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211191627.15542-1-mb@lightnvm.io>
References: <20181211191627.15542-1-mb@lightnvm.io>
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

Reviewed-by: Igor Konopko <igor.j.konopko@intel.com>
Reviewed-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/core.c      | 12 +++++-------
 drivers/nvme/host/core.c     | 18 +++++++++---------
 drivers/nvme/host/lightnvm.c | 18 ++++++------------
 drivers/nvme/host/nvme.h     |  2 --
 4 files changed, 20 insertions(+), 30 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 10e541cb8dc3..69b841d682c7 100644
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
index 1310753a01e5..c71e879821ad 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1549,8 +1549,6 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	if (ns->noiob)
 		nvme_set_chunk_size(ns);
 	nvme_update_disk_info(disk, ns, id);
-	if (ns->ndev)
-		nvme_nvm_update_nvm_info(ns);
 #ifdef CONFIG_NVME_MULTIPATH
 	if (ns->head->disk) {
 		nvme_update_disk_info(ns->head->disk, ns, id);
@@ -3156,13 +3154,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
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
@@ -3176,6 +3167,13 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
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
@@ -3189,6 +3187,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
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
index 8e0ec365ce8d..e20e737ac10c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -540,13 +540,11 @@ static inline void nvme_mpath_stop(struct nvme_ctrl *ctrl)
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

