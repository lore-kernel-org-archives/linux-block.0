Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:38380 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756429AbeFOW1h (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jun 2018 18:27:37 -0400
From: Igor Konopko <igor.j.konopko@intel.com>
To: mb@lightnvm.io, javier@cnexlabs.com
Cc: linux-block@vger.kernel.org, michal.sorn@intel.com,
        marcin.dziegielewski@intel.com, igor.j.konopko@intel.com
Subject: [PATCH 5/5] lightnvm: pblk: Disable interleaved metadata in pblk
Date: Sat, 16 Jun 2018 00:27:06 +0200
Message-Id: <20180615222706.3801-6-igor.j.konopko@intel.com>
In-Reply-To: <20180615222706.3801-1-igor.j.konopko@intel.com>
References: <20180615222706.3801-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Currently pblk and lightnvm does only check for size
of OOB metadata and does not care wheather this meta
is located in separate buffer or is interleaved with
data in single buffer.

In reality only the first scenario is supported, where
second mode will break pblk functionality during any
IO operation.

The goal of this patch is to block creation of pblk
devices in case of interleaved metadata

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/pblk-init.c | 6 ++++++
 drivers/nvme/host/lightnvm.c | 1 +
 include/linux/lightnvm.h     | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 5eb641da46ed..483a6d479e7d 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -1238,6 +1238,12 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
 		return ERR_PTR(-EINVAL);
 	}
 
+	if (geo->ext) {
+		pr_err("pblk: extended (interleaved) metadata in data buffer"
+			" not supported\n");
+		return ERR_PTR(-EINVAL);
+	}
+
 	pblk = kzalloc(sizeof(struct pblk), GFP_KERNEL);
 	if (!pblk)
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 670478abc754..872ab854ccf5 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -979,6 +979,7 @@ void nvme_nvm_update_nvm_info(struct nvme_ns *ns)
 
 	geo->csecs = 1 << ns->lba_shift;
 	geo->sos = ns->ms;
+	geo->ext = ns->ext;
 }
 
 int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node)
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 72a55d71917e..b13e64e2112f 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -350,6 +350,7 @@ struct nvm_geo {
 	u32	clba;		/* sectors per chunk */
 	u16	csecs;		/* sector size */
 	u16	sos;		/* out-of-band area size */
+	u16	ext;		/* metadata in extended data buffer */
 
 	/* device write constrains */
 	u32	ws_min;		/* minimum write size */
-- 
2.14.3
