Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39332 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965027AbeBMOGX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Feb 2018 09:06:23 -0500
Received: by mail-wm0-f65.google.com with SMTP id b21so16234515wme.4
        for <linux-block@vger.kernel.org>; Tue, 13 Feb 2018 06:06:23 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 5/8] lightnvm: implement get log report chunk helpers
Date: Tue, 13 Feb 2018 15:06:05 +0100
Message-Id: <1518530768-20956-6-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1518530768-20956-1-git-send-email-javier@cnexlabs.com>
References: <1518530768-20956-1-git-send-email-javier@cnexlabs.com>
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
 drivers/lightnvm/core.c      | 28 +++++++++++++++++++++++++
 drivers/nvme/host/lightnvm.c | 50 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/lightnvm.h     | 32 ++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 80492fa6ee76..6857a888544a 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -43,6 +43,8 @@ struct nvm_ch_map {
 struct nvm_dev_map {
 	struct nvm_ch_map *chnls;
 	int nr_chnls;
+	int bch;
+	int blun;
 };
 
 static struct nvm_target *nvm_find_target(struct nvm_dev *dev, const char *name)
@@ -171,6 +173,9 @@ static struct nvm_tgt_dev *nvm_create_tgt_dev(struct nvm_dev *dev,
 	if (!dev_map->chnls)
 		goto err_chnls;
 
+	dev_map->bch = bch;
+	dev_map->blun = blun;
+
 	luns = kcalloc(nr_luns, sizeof(struct ppa_addr), GFP_KERNEL);
 	if (!luns)
 		goto err_luns;
@@ -561,6 +566,19 @@ static void nvm_unregister_map(struct nvm_dev *dev)
 	kfree(rmap);
 }
 
+static unsigned long nvm_log_off_tgt_to_dev(struct nvm_tgt_dev *tgt_dev)
+{
+	struct nvm_dev_map *dev_map = tgt_dev->map;
+	struct nvm_geo *geo = &tgt_dev->geo;
+	int lun_off;
+	unsigned long off;
+
+	lun_off = dev_map->blun + dev_map->bch * geo->num_lun;
+	off = lun_off * geo->c.num_chk * sizeof(struct nvm_chunk_log_page);
+
+	return off;
+}
+
 static void nvm_map_to_dev(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *p)
 {
 	struct nvm_dev_map *dev_map = tgt_dev->map;
@@ -720,6 +738,16 @@ static void nvm_free_rqd_ppalist(struct nvm_tgt_dev *tgt_dev,
 	nvm_dev_dma_free(tgt_dev->parent, rqd->ppa_list, rqd->dma_ppa_list);
 }
 
+int nvm_get_chunk_log_page(struct nvm_tgt_dev *tgt_dev,
+			   struct nvm_chunk_log_page *log,
+			   unsigned long off, unsigned long len)
+{
+	struct nvm_dev *dev = tgt_dev->parent;
+
+	off += nvm_log_off_tgt_to_dev(tgt_dev);
+
+	return dev->ops->get_chunk_log_page(tgt_dev->parent, log, off, len);
+}
 
 int nvm_set_tgt_bb_tbl(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *ppas,
 		       int nr_ppas, int type)
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 7bc75182c723..355d9b0cf084 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -35,6 +35,10 @@ enum nvme_nvm_admin_opcode {
 	nvme_nvm_admin_set_bb_tbl	= 0xf1,
 };
 
+enum nvme_nvm_log_page {
+	NVME_NVM_LOG_REPORT_CHUNK	= 0xCA,
+};
+
 struct nvme_nvm_ph_rw {
 	__u8			opcode;
 	__u8			flags;
@@ -553,6 +557,50 @@ static int nvme_nvm_set_bb_tbl(struct nvm_dev *nvmdev, struct ppa_addr *ppas,
 	return ret;
 }
 
+static int nvme_nvm_get_chunk_log_page(struct nvm_dev *nvmdev,
+				       struct nvm_chunk_log_page *log,
+				       unsigned long off,
+				       unsigned long total_len)
+{
+	struct nvme_ns *ns = nvmdev->q->queuedata;
+	struct nvme_command c = { };
+	unsigned long offset = off, left = total_len;
+	unsigned long len, len_dwords;
+	void *buf = log;
+	int ret;
+
+	/* The offset needs to be dword-aligned */
+	if (offset & 0x3)
+		return -EINVAL;
+
+	do {
+		/* Send 256KB at a time */
+		len = (1 << 18) > left ? left : (1 << 18);
+		len_dwords = (len >> 2) - 1;
+
+		c.get_log_page.opcode = nvme_admin_get_log_page;
+		c.get_log_page.nsid = cpu_to_le32(ns->head->ns_id);
+		c.get_log_page.lid = NVME_NVM_LOG_REPORT_CHUNK;
+		c.get_log_page.lpol = cpu_to_le32(offset & 0xffffffff);
+		c.get_log_page.lpou = cpu_to_le32(offset >> 32);
+		c.get_log_page.numdl = cpu_to_le16(len_dwords & 0xffff);
+		c.get_log_page.numdu = cpu_to_le16(len_dwords >> 16);
+
+		ret = nvme_submit_sync_cmd(ns->ctrl->admin_q, &c, buf, len);
+		if (ret) {
+			dev_err(ns->ctrl->device,
+				"get chunk log page failed (%d)\n", ret);
+			break;
+		}
+
+		buf += len;
+		offset += len;
+		left -= len;
+	} while (left);
+
+	return ret;
+}
+
 static inline void nvme_nvm_rqtocmd(struct nvm_rq *rqd, struct nvme_ns *ns,
 				    struct nvme_nvm_command *c)
 {
@@ -684,6 +732,8 @@ static struct nvm_dev_ops nvme_nvm_dev_ops = {
 	.get_bb_tbl		= nvme_nvm_get_bb_tbl,
 	.set_bb_tbl		= nvme_nvm_set_bb_tbl,
 
+	.get_chunk_log_page	= nvme_nvm_get_chunk_log_page,
+
 	.submit_io		= nvme_nvm_submit_io,
 	.submit_io_sync		= nvme_nvm_submit_io_sync,
 
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 1148b3f22b27..eb2900a18160 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -73,10 +73,13 @@ struct nvm_rq;
 struct nvm_id;
 struct nvm_dev;
 struct nvm_tgt_dev;
+struct nvm_chunk_log_page;
 
 typedef int (nvm_id_fn)(struct nvm_dev *);
 typedef int (nvm_op_bb_tbl_fn)(struct nvm_dev *, struct ppa_addr, u8 *);
 typedef int (nvm_op_set_bb_fn)(struct nvm_dev *, struct ppa_addr *, int, int);
+typedef int (nvm_get_chunk_lp_fn)(struct nvm_dev *, struct nvm_chunk_log_page *,
+				  unsigned long, unsigned long);
 typedef int (nvm_submit_io_fn)(struct nvm_dev *, struct nvm_rq *);
 typedef int (nvm_submit_io_sync_fn)(struct nvm_dev *, struct nvm_rq *);
 typedef void *(nvm_create_dma_pool_fn)(struct nvm_dev *, char *);
@@ -90,6 +93,8 @@ struct nvm_dev_ops {
 	nvm_op_bb_tbl_fn	*get_bb_tbl;
 	nvm_op_set_bb_fn	*set_bb_tbl;
 
+	nvm_get_chunk_lp_fn	*get_chunk_log_page;
+
 	nvm_submit_io_fn	*submit_io;
 	nvm_submit_io_sync_fn	*submit_io_sync;
 
@@ -286,6 +291,30 @@ struct nvm_dev_geo {
 	struct nvm_common_geo c;
 };
 
+enum {
+	/* Chunk states */
+	NVM_CHK_ST_FREE =	1 << 0,
+	NVM_CHK_ST_CLOSED =	1 << 1,
+	NVM_CHK_ST_OPEN =	1 << 2,
+	NVM_CHK_ST_OFFLINE =	1 << 3,
+	NVM_CHK_ST_HOST_USE =	1 << 7,
+
+	/* Chunk types */
+	NVM_CHK_TP_W_SEQ =	1 << 0,
+	NVM_CHK_TP_W_RAN =	1 << 2,
+	NVM_CHK_TP_SZ_SPEC =	1 << 4,
+};
+
+struct nvm_chunk_log_page {
+	__u8	state;
+	__u8	type;
+	__u8	wear_index;
+	__u8	rsvd[5];
+	__u64	slba;
+	__u64	cnlb;
+	__u64	wp;
+};
+
 struct nvm_target {
 	struct list_head list;
 	struct nvm_tgt_dev *dev;
@@ -505,6 +534,9 @@ extern struct nvm_dev *nvm_alloc_dev(int);
 extern int nvm_register(struct nvm_dev *);
 extern void nvm_unregister(struct nvm_dev *);
 
+extern int nvm_get_chunk_log_page(struct nvm_tgt_dev *,
+				  struct nvm_chunk_log_page *,
+				  unsigned long, unsigned long);
 extern int nvm_set_tgt_bb_tbl(struct nvm_tgt_dev *, struct ppa_addr *,
 			      int, int);
 extern int nvm_max_phys_sects(struct nvm_tgt_dev *);
-- 
2.7.4
