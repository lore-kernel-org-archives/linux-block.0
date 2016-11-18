Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35848 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752804AbcKROn7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2016 09:43:59 -0500
Received: by mail-wm0-f48.google.com with SMTP id g23so42644916wme.1
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2016 06:43:58 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 01/20] lightnvm: enable to send hint to erase command
Date: Fri, 18 Nov 2016 15:43:23 +0100
Message-Id: <1479480222-18790-2-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1479480222-18790-1-git-send-email-javier@cnexlabs.com>
References: <1479480222-18790-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <jg@lightnvm.io>

Erases might be subject to host hints. An example is multi-plane
programming to erase blocks in parallel. Enable targets to specify this
hints.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/core.c      | 9 ++++++---
 drivers/lightnvm/gennvm.c    | 5 ++---
 drivers/lightnvm/rrpc.c      | 2 +-
 drivers/lightnvm/sysblk.c    | 4 ++--
 drivers/nvme/host/lightnvm.c | 1 +
 include/linux/lightnvm.h     | 7 +++----
 6 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 1111740..8664fe0 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -202,9 +202,9 @@ int nvm_submit_io(struct nvm_dev *dev, struct nvm_rq *rqd)
 }
 EXPORT_SYMBOL(nvm_submit_io);
 
-int nvm_erase_blk(struct nvm_dev *dev, struct nvm_block *blk)
+int nvm_erase_blk(struct nvm_dev *dev, struct nvm_block *blk, int flags)
 {
-	return dev->mt->erase_blk(dev, blk, 0);
+	return dev->mt->erase_blk(dev, blk, flags);
 }
 EXPORT_SYMBOL(nvm_erase_blk);
 
@@ -285,7 +285,8 @@ void nvm_free_rqd_ppalist(struct nvm_dev *dev, struct nvm_rq *rqd)
 }
 EXPORT_SYMBOL(nvm_free_rqd_ppalist);
 
-int nvm_erase_ppa(struct nvm_dev *dev, struct ppa_addr *ppas, int nr_ppas)
+int nvm_erase_ppa(struct nvm_dev *dev, struct ppa_addr *ppas, int nr_ppas,
+								int flags)
 {
 	struct nvm_rq rqd;
 	int ret;
@@ -301,6 +302,8 @@ int nvm_erase_ppa(struct nvm_dev *dev, struct ppa_addr *ppas, int nr_ppas)
 
 	nvm_generic_to_addr_mode(dev, &rqd);
 
+	rqd.flags = flags;
+
 	ret = dev->ops->erase_block(dev, &rqd);
 
 	nvm_free_rqd_ppalist(dev, &rqd);
diff --git a/drivers/lightnvm/gennvm.c b/drivers/lightnvm/gennvm.c
index b74174c..730d736 100644
--- a/drivers/lightnvm/gennvm.c
+++ b/drivers/lightnvm/gennvm.c
@@ -593,12 +593,11 @@ static int gen_submit_io(struct nvm_dev *dev, struct nvm_rq *rqd)
 	return dev->ops->submit_io(dev, rqd);
 }
 
-static int gen_erase_blk(struct nvm_dev *dev, struct nvm_block *blk,
-							unsigned long flags)
+static int gen_erase_blk(struct nvm_dev *dev, struct nvm_block *blk, int flags)
 {
 	struct ppa_addr addr = block_to_ppa(dev, blk);
 
-	return nvm_erase_ppa(dev, &addr, 1);
+	return nvm_erase_ppa(dev, &addr, 1, flags);
 }
 
 static int gen_reserve_lun(struct nvm_dev *dev, int lunid)
diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
index 37fcaad..067e890 100644
--- a/drivers/lightnvm/rrpc.c
+++ b/drivers/lightnvm/rrpc.c
@@ -404,7 +404,7 @@ static void rrpc_block_gc(struct work_struct *work)
 	if (rrpc_move_valid_pages(rrpc, rblk))
 		goto put_back;
 
-	if (nvm_erase_blk(dev, rblk->parent))
+	if (nvm_erase_blk(dev, rblk->parent, 0))
 		goto put_back;
 
 	rrpc_put_blk(rrpc, rblk);
diff --git a/drivers/lightnvm/sysblk.c b/drivers/lightnvm/sysblk.c
index a75bd28..d229067 100644
--- a/drivers/lightnvm/sysblk.c
+++ b/drivers/lightnvm/sysblk.c
@@ -379,7 +379,7 @@ static int nvm_prepare_new_sysblks(struct nvm_dev *dev, struct sysblk_scan *s)
 		ppa = &s->ppas[scan_ppa_idx(i, nxt_blk)];
 		ppa->g.pg = ppa_to_slc(dev, 0);
 
-		ret = nvm_erase_ppa(dev, ppa, 1);
+		ret = nvm_erase_ppa(dev, ppa, 1, 0);
 		if (ret)
 			return ret;
 
@@ -725,7 +725,7 @@ int nvm_dev_factory(struct nvm_dev *dev, int flags)
 	/* continue to erase until list of blks until empty */
 	while ((ppa_cnt =
 			nvm_fact_get_blks(dev, ppas, max_ppas, blk_bitmap)) > 0)
-		nvm_erase_ppa(dev, ppas, ppa_cnt);
+		nvm_erase_ppa(dev, ppas, ppa_cnt, 0);
 
 	/* mark host reserved blocks free */
 	if (flags & NVM_FACTORY_RESET_HOST_BLKS) {
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index f23e6fe..037dff5 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -526,6 +526,7 @@ static int nvme_nvm_erase_block(struct nvm_dev *dev, struct nvm_rq *rqd)
 	c.erase.nsid = cpu_to_le32(ns->ns_id);
 	c.erase.spba = cpu_to_le64(rqd->ppa_addr.ppa);
 	c.erase.length = cpu_to_le16(rqd->nr_ppas - 1);
+	c.erase.control = cpu_to_le16(rqd->flags);
 
 	return nvme_submit_sync_cmd(q, (struct nvme_command *)&c, NULL, 0);
 }
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index fb2e601..d87be02 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -470,8 +470,7 @@ typedef int (nvmm_open_blk_fn)(struct nvm_dev *, struct nvm_block *);
 typedef int (nvmm_close_blk_fn)(struct nvm_dev *, struct nvm_block *);
 typedef void (nvmm_flush_blk_fn)(struct nvm_dev *, struct nvm_block *);
 typedef int (nvmm_submit_io_fn)(struct nvm_dev *, struct nvm_rq *);
-typedef int (nvmm_erase_blk_fn)(struct nvm_dev *, struct nvm_block *,
-								unsigned long);
+typedef int (nvmm_erase_blk_fn)(struct nvm_dev *, struct nvm_block *, int);
 typedef void (nvmm_mark_blk_fn)(struct nvm_dev *, struct ppa_addr, int);
 typedef struct nvm_lun *(nvmm_get_lun_fn)(struct nvm_dev *, int);
 typedef int (nvmm_reserve_lun)(struct nvm_dev *, int);
@@ -537,8 +536,8 @@ extern void nvm_addr_to_generic_mode(struct nvm_dev *, struct nvm_rq *);
 extern int nvm_set_rqd_ppalist(struct nvm_dev *, struct nvm_rq *,
 					const struct ppa_addr *, int, int);
 extern void nvm_free_rqd_ppalist(struct nvm_dev *, struct nvm_rq *);
-extern int nvm_erase_ppa(struct nvm_dev *, struct ppa_addr *, int);
-extern int nvm_erase_blk(struct nvm_dev *, struct nvm_block *);
+extern int nvm_erase_ppa(struct nvm_dev *, struct ppa_addr *, int, int);
+extern int nvm_erase_blk(struct nvm_dev *, struct nvm_block *, int);
 extern void nvm_end_io(struct nvm_rq *, int);
 extern int nvm_submit_ppa(struct nvm_dev *, struct ppa_addr *, int, int, int,
 								void *, int);
-- 
2.7.4

