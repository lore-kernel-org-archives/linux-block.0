Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44191 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbeH2RKE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Aug 2018 13:10:04 -0400
Received: by mail-ed1-f67.google.com with SMTP id s10-v6so3874349edb.11
        for <linux-block@vger.kernel.org>; Wed, 29 Aug 2018 06:13:10 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [V2 PATCH] lightnvm: pblk: add helpers for chunk addresses
Date: Wed, 29 Aug 2018 15:12:59 +0200
Message-Id: <1535548379-11125-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

# Changes since V1:
 - Move 1.2 / 2.0 specific code to core (form Matias)

Implement helpers to go from ppas to a chunk within a line and an
address within a chunk.

These helpers will be used on the patches adding trace support in pblk,
which will be sent in this window.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk.h  | 19 +++++++++++++++++++
 include/linux/lightnvm.h | 19 +++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index be67bbfa3d0a..f95fe75fef6e 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -1034,6 +1034,25 @@ static inline struct ppa_addr addr_to_gen_ppa(struct pblk *pblk, u64 paddr,
 	return ppa;
 }
 
+static inline struct nvm_chk_meta *pblk_dev_ppa_to_chunk(struct pblk *pblk,
+							struct ppa_addr p)
+{
+	struct nvm_tgt_dev *dev = pblk->dev;
+	struct nvm_geo *geo = &dev->geo;
+	struct pblk_line *line = &pblk->lines[pblk_ppa_to_line(p)];
+	int pos = pblk_ppa_to_pos(geo, p);
+
+	return &line->chks[pos];
+}
+
+static inline u64 pblk_dev_ppa_to_chunk_addr(struct pblk *pblk,
+							struct ppa_addr p)
+{
+	struct nvm_tgt_dev *dev = pblk->dev;
+
+	return dev_to_chunk_addr(dev->parent, &pblk->addrf, p);
+}
+
 static inline u64 pblk_dev_ppa_to_line_addr(struct pblk *pblk,
 							struct ppa_addr p)
 {
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 0106984400bc..77743a02ec0d 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -487,6 +487,25 @@ static inline struct ppa_addr dev_to_generic_addr(struct nvm_dev *dev,
 	return l;
 }
 
+static inline u64 dev_to_chunk_addr(struct nvm_dev *dev, void *addrf,
+				    struct ppa_addr p)
+{
+	struct nvm_geo *geo = &dev->geo;
+	u64 caddr;
+
+	if (geo->version == NVM_OCSSD_SPEC_12) {
+		struct nvm_addrf_12 *ppaf = (struct nvm_addrf_12 *)addrf;
+
+		caddr = (u64)p.g.pg << ppaf->pg_offset;
+		caddr |= (u64)p.g.pl << ppaf->pln_offset;
+		caddr |= (u64)p.g.sec << ppaf->sec_offset;
+	} else {
+		caddr = p.m.sec;
+	}
+
+	return caddr;
+}
+
 typedef blk_qc_t (nvm_tgt_make_rq_fn)(struct request_queue *, struct bio *);
 typedef sector_t (nvm_tgt_capacity_fn)(void *);
 typedef void *(nvm_tgt_init_fn)(struct nvm_tgt_dev *, struct gendisk *,
-- 
2.7.4
