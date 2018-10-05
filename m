Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:4640 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727701AbeJEUhB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Oct 2018 16:37:01 -0400
From: Igor Konopko <igor.j.konopko@intel.com>
To: mb@lightnvm.io, javier@cnexlabs.com
Cc: linux-block@vger.kernel.org, marcin.dziegielewski@intel.com,
        igor.j.konopko@intel.com
Subject: [PATCH 4/5] lightnvm: Disable interleaved metadata
Date: Fri,  5 Oct 2018 15:34:36 +0200
Message-Id: <20181005133437.25255-5-igor.j.konopko@intel.com>
In-Reply-To: <20181005133437.25255-1-igor.j.konopko@intel.com>
References: <20181005133437.25255-1-igor.j.konopko@intel.com>
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
index b794e279da31..1529aa37b30f 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -1152,6 +1152,12 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
 		return ERR_PTR(-EINVAL);
 	}
 
+	if (geo->ext) {
+		pblk_err(pblk, "extended metadata not supported\n");
+		kfree(pblk);
+		return ERR_PTR(-EINVAL);
+	}
+
 	spin_lock_init(&pblk->resubmit_lock);
 	spin_lock_init(&pblk->trans_lock);
 	spin_lock_init(&pblk->lock);
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index e370793f52d5..7020e87bcee4 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -989,6 +989,7 @@ void nvme_nvm_update_nvm_info(struct nvme_ns *ns)
 
 	geo->csecs = 1 << ns->lba_shift;
 	geo->sos = ns->ms;
+	geo->ext = ns->ext;
 }
 
 int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node)
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index c6c998716ee7..abd29f50f2a1 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -357,6 +357,7 @@ struct nvm_geo {
 	u32	clba;		/* sectors per chunk */
 	u16	csecs;		/* sector size */
 	u16	sos;		/* out-of-band area size */
+	u16	ext;		/* metadata in extended data buffer */
 
 	/* device write constrains */
 	u32	ws_min;		/* minimum write size */
-- 
2.17.1
