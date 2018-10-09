Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44974 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbeJISbZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Oct 2018 14:31:25 -0400
Received: by mail-pg1-f196.google.com with SMTP id g2-v6so640826pgu.11
        for <linux-block@vger.kernel.org>; Tue, 09 Oct 2018 04:14:58 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 31/45] lightnvm: use internal allocation for chunk log page
Date: Tue,  9 Oct 2018 13:12:01 +0200
Message-Id: <20181009111215.7653-32-mb@lightnvm.io>
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@javigon.com>

The lightnvm subsystem provides helpers to retrieve chunk metadata,
where the target needs to provide a buffer to store the metadata. An
implicit assumption is that this buffer is contiguous and can be used to
retrieve the data from the device. If the device exposes too many
chunks, then kmalloc might fail, thus failing instance creation.

This patch removes this assumption by implementing an internal buffer in
the lightnvm subsystem to retrieve chunk metadata. Targets can then
use virtual memory allocations. Since this is a target API change, adapt
pblk accordingly.

Signed-off-by: Javier González <javier@cnexlabs.com>
Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c |  4 ++--
 drivers/lightnvm/pblk-init.c |  2 +-
 drivers/nvme/host/lightnvm.c | 25 +++++++++++++++++--------
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 84f3b4912b92..875f3cf615ac 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -120,7 +120,7 @@ static void pblk_end_io_erase(struct nvm_rq *rqd)
 /*
  * Get information for all chunks from the device.
  *
- * The caller is responsible for freeing the returned structure
+ * The caller is responsible for freeing (vmalloc) the returned structure
  */
 struct nvm_chk_meta *pblk_get_chunk_meta(struct pblk *pblk)
 {
@@ -134,7 +134,7 @@ struct nvm_chk_meta *pblk_get_chunk_meta(struct pblk *pblk)
 	ppa.ppa = 0;
 
 	len = geo->all_chunks * sizeof(*meta);
-	meta = kzalloc(len, GFP_KERNEL);
+	meta = vzalloc(len);
 	if (!meta)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index fb66bc84d5ca..7ef8249108f0 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -1039,7 +1039,7 @@ static int pblk_lines_init(struct pblk *pblk)
 
 	pblk_set_provision(pblk, nr_free_chks);
 
-	kfree(chunk_meta);
+	vfree(chunk_meta);
 	return 0;
 
 fail_free_lines:
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index e42af7771fe5..7d0a4d3b0a48 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -573,7 +573,7 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
 	struct nvm_geo *geo = &ndev->geo;
 	struct nvme_ns *ns = ndev->q->queuedata;
 	struct nvme_ctrl *ctrl = ns->ctrl;
-	struct nvme_nvm_chk_meta *dev_meta = (struct nvme_nvm_chk_meta *)meta;
+	struct nvme_nvm_chk_meta *dev_meta, *dev_meta_off;
 	struct ppa_addr ppa;
 	size_t left = nchks * sizeof(struct nvme_nvm_chk_meta);
 	size_t log_pos, offset, len;
@@ -585,6 +585,10 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
 	 */
 	max_len = min_t(unsigned int, ctrl->max_hw_sectors << 9, 256 * 1024);
 
+	dev_meta = kmalloc(max_len, GFP_KERNEL);
+	if (!dev_meta)
+		return -ENOMEM;
+
 	/* Normalize lba address space to obtain log offset */
 	ppa.ppa = slba;
 	ppa = dev_to_generic_addr(ndev, ppa);
@@ -598,6 +602,9 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
 	while (left) {
 		len = min_t(unsigned int, left, max_len);
 
+		memset(dev_meta, 0, max_len);
+		dev_meta_off = dev_meta;
+
 		ret = nvme_get_log(ctrl, ns->head->ns_id,
 				NVME_NVM_LOG_REPORT_CHUNK, 0, dev_meta, len,
 				offset);
@@ -607,21 +614,23 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
 		}
 
 		for (i = 0; i < len; i += sizeof(struct nvme_nvm_chk_meta)) {
-			meta->state = dev_meta->state;
-			meta->type = dev_meta->type;
-			meta->wi = dev_meta->wi;
-			meta->slba = le64_to_cpu(dev_meta->slba);
-			meta->cnlb = le64_to_cpu(dev_meta->cnlb);
-			meta->wp = le64_to_cpu(dev_meta->wp);
+			meta->state = dev_meta_off->state;
+			meta->type = dev_meta_off->type;
+			meta->wi = dev_meta_off->wi;
+			meta->slba = le64_to_cpu(dev_meta_off->slba);
+			meta->cnlb = le64_to_cpu(dev_meta_off->cnlb);
+			meta->wp = le64_to_cpu(dev_meta_off->wp);
 
 			meta++;
-			dev_meta++;
+			dev_meta_off++;
 		}
 
 		offset += len;
 		left -= len;
 	}
 
+	kfree(dev_meta);
+
 	return ret;
 }
 
-- 
2.17.1
