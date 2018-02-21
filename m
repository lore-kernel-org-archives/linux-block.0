Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41028 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932234AbeBUJ1j (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Feb 2018 04:27:39 -0500
Received: by mail-wr0-f193.google.com with SMTP id f14so2429467wre.8
        for <linux-block@vger.kernel.org>; Wed, 21 Feb 2018 01:27:38 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 16/20] lightnvm: implement get log report chunk helpers
Date: Wed, 21 Feb 2018 10:26:54 +0100
Message-Id: <1519205218-26994-17-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
References: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@javigon.com>

The 2.0 spec provides a report chunk log page that can be retrieved
using the stangard nvme get log page. This replaces the dedicated
get/put bad block table in 1.2.

This patch implements the helper functions to allow targets retrieve the
chunk metadata using get log page

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/core.c      | 11 +++++++
 drivers/nvme/host/lightnvm.c | 74 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/lightnvm.h     | 24 ++++++++++++++
 3 files changed, 109 insertions(+)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 59b62ca65596..1d9d045c28ed 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -719,6 +719,17 @@ static void nvm_free_rqd_ppalist(struct nvm_tgt_dev *tgt_dev,
 	nvm_dev_dma_free(tgt_dev->parent, rqd->ppa_list, rqd->dma_ppa_list);
 }
 
+int nvm_get_chunk_meta(struct nvm_tgt_dev *tgt_dev, struct nvm_chk_meta *meta,
+		struct ppa_addr ppa, int nchks)
+{
+	struct nvm_dev *dev = tgt_dev->parent;
+
+	nvm_ppa_tgt_to_dev(tgt_dev, &ppa, 1);
+
+	return dev->ops->get_chk_meta(tgt_dev->parent, meta,
+						(sector_t)ppa.ppa, nchks);
+}
+EXPORT_SYMBOL(nvm_get_chunk_meta);
 
 int nvm_set_tgt_bb_tbl(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *ppas,
 		       int nr_ppas, int type)
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 88c71d0d0d8c..20f1783e4e47 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -35,6 +35,10 @@ enum nvme_nvm_admin_opcode {
 	nvme_nvm_admin_set_bb_tbl	= 0xf1,
 };
 
+enum nvme_nvm_log_page {
+	NVME_NVM_LOG_REPORT_CHUNK	= 0xca,
+};
+
 struct nvme_nvm_ph_rw {
 	__u8			opcode;
 	__u8			flags;
@@ -242,6 +246,16 @@ struct nvme_nvm_id20 {
 	__u8			vs[1024];
 };
 
+struct nvme_nvm_chk_meta {
+	__u8	state;
+	__u8	type;
+	__u8	wi;
+	__u8	rsvd[5];
+	__le64	slba;
+	__le64	cnlb;
+	__le64	wp;
+};
+
 /*
  * Check we didn't inadvertently grow the command struct
  */
@@ -258,6 +272,9 @@ static inline void _nvme_nvm_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_nvm_bb_tbl) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_nvm_id20_addrf) != 8);
 	BUILD_BUG_ON(sizeof(struct nvme_nvm_id20) != NVME_IDENTIFY_DATA_SIZE);
+	BUILD_BUG_ON(sizeof(struct nvme_nvm_chk_meta) != 32);
+	BUILD_BUG_ON(sizeof(struct nvme_nvm_chk_meta) !=
+						sizeof(struct nvm_chk_meta));
 }
 
 static void nvme_nvm_set_addr_12(struct nvm_addr_format_12 *dst,
@@ -553,6 +570,61 @@ static int nvme_nvm_set_bb_tbl(struct nvm_dev *nvmdev, struct ppa_addr *ppas,
 	return ret;
 }
 
+/*
+ * Expect the lba in device format
+ */
+static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
+				 struct nvm_chk_meta *meta,
+				 sector_t slba, int nchks)
+{
+	struct nvm_dev_geo *dev_geo = &ndev->dev_geo;
+	struct nvme_ns *ns = ndev->q->queuedata;
+	struct nvme_ctrl *ctrl = ns->ctrl;
+	struct nvme_nvm_chk_meta *dev_meta = (struct nvme_nvm_chk_meta *)meta;
+	struct ppa_addr ppa;
+	size_t left = nchks * sizeof(struct nvme_nvm_chk_meta);
+	size_t log_pos, offset, len;
+	int ret, i;
+
+	/* Normalize lba address space to obtain log offset */
+	ppa.ppa = slba;
+	ppa = dev_to_generic_addr(ndev, ppa);
+
+	log_pos = ppa.m.chk;
+	log_pos += ppa.m.lun * dev_geo->c.num_chk;
+	log_pos += ppa.m.ch * dev_geo->num_lun * dev_geo->c.num_chk;
+
+	offset = log_pos * sizeof(struct nvme_nvm_chk_meta);
+
+	while (left) {
+		len = min_t(unsigned int, left, ctrl->max_hw_sectors << 9);
+
+		ret = nvme_get_log_ext(ctrl, ns, NVME_NVM_LOG_REPORT_CHUNK,
+				dev_meta, len, offset);
+		if (ret) {
+			dev_err(ctrl->device, "Get REPORT CHUNK log error\n");
+			break;
+		}
+
+		for (i = 0; i < len; i += sizeof(struct nvme_nvm_chk_meta)) {
+			meta->state = dev_meta->state;
+			meta->type = dev_meta->type;
+			meta->wi = dev_meta->wi;
+			meta->slba = le64_to_cpu(dev_meta->slba);
+			meta->cnlb = le64_to_cpu(dev_meta->cnlb);
+			meta->wp = le64_to_cpu(dev_meta->wp);
+
+			meta++;
+			dev_meta++;
+		}
+
+		offset += len;
+		left -= len;
+	}
+
+	return ret;
+}
+
 static inline void nvme_nvm_rqtocmd(struct nvm_rq *rqd, struct nvme_ns *ns,
 				    struct nvme_nvm_command *c)
 {
@@ -684,6 +756,8 @@ static struct nvm_dev_ops nvme_nvm_dev_ops = {
 	.get_bb_tbl		= nvme_nvm_get_bb_tbl,
 	.set_bb_tbl		= nvme_nvm_set_bb_tbl,
 
+	.get_chk_meta		= nvme_nvm_get_chk_meta,
+
 	.submit_io		= nvme_nvm_submit_io,
 	.submit_io_sync		= nvme_nvm_submit_io_sync,
 
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 91340998f0c3..bc43700c37ec 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -81,10 +81,13 @@ struct nvm_rq;
 struct nvm_id;
 struct nvm_dev;
 struct nvm_tgt_dev;
+struct nvm_chk_meta;
 
 typedef int (nvm_id_fn)(struct nvm_dev *);
 typedef int (nvm_op_bb_tbl_fn)(struct nvm_dev *, struct ppa_addr, u8 *);
 typedef int (nvm_op_set_bb_fn)(struct nvm_dev *, struct ppa_addr *, int, int);
+typedef int (nvm_get_chk_meta_fn)(struct nvm_dev *, struct nvm_chk_meta *,
+								sector_t, int);
 typedef int (nvm_submit_io_fn)(struct nvm_dev *, struct nvm_rq *);
 typedef int (nvm_submit_io_sync_fn)(struct nvm_dev *, struct nvm_rq *);
 typedef void *(nvm_create_dma_pool_fn)(struct nvm_dev *, char *);
@@ -98,6 +101,8 @@ struct nvm_dev_ops {
 	nvm_op_bb_tbl_fn	*get_bb_tbl;
 	nvm_op_set_bb_fn	*set_bb_tbl;
 
+	nvm_get_chk_meta_fn	*get_chk_meta;
+
 	nvm_submit_io_fn	*submit_io;
 	nvm_submit_io_sync_fn	*submit_io_sync;
 
@@ -292,6 +297,20 @@ struct nvm_dev_geo {
 	struct nvm_common_geo c;
 };
 
+/*
+ * Note: The structure size is linked to nvme_nvm_chk_meta such that the same
+ * buffer can be used when converting from little endian to cpu addressing.
+ */
+struct nvm_chk_meta {
+	u8	state;
+	u8	type;
+	u8	wi;
+	u8	rsvd[5];
+	u64	slba;
+	u64	cnlb;
+	u64	wp;
+};
+
 struct nvm_target {
 	struct list_head list;
 	struct nvm_tgt_dev *dev;
@@ -512,6 +531,11 @@ extern struct nvm_dev *nvm_alloc_dev(int);
 extern int nvm_register(struct nvm_dev *);
 extern void nvm_unregister(struct nvm_dev *);
 
+
+extern int nvm_get_chunk_meta(struct nvm_tgt_dev *tgt_dev,
+			      struct nvm_chk_meta *meta, struct ppa_addr ppa,
+			      int nchks);
+
 extern int nvm_set_tgt_bb_tbl(struct nvm_tgt_dev *, struct ppa_addr *,
 			      int, int);
 extern int nvm_submit_io(struct nvm_tgt_dev *, struct nvm_rq *);
-- 
2.7.4
