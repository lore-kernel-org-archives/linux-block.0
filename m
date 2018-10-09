Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37496 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbeJISbI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Oct 2018 14:31:08 -0400
Received: by mail-pg1-f196.google.com with SMTP id c10-v6so657130pgq.4
        for <linux-block@vger.kernel.org>; Tue, 09 Oct 2018 04:14:41 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 26/45] lightnvm: move ppa transformations to core
Date: Tue,  9 Oct 2018 13:11:56 +0200
Message-Id: <20181009111215.7653-27-mb@lightnvm.io>
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@javigon.com>

Continuing the effort of moving 1.2 and 2.0 specific code to core, move
64_to_32 and 32_to_64 ppa helpers from pblk to core.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk.h  | 78 ++-----------------------------------
 include/linux/lightnvm.h | 83 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+), 74 deletions(-)

diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 7f4e46dfb0d7..a2cc581951ef 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -1102,86 +1102,16 @@ static inline u64 pblk_dev_ppa_to_line_addr(struct pblk *pblk,
 
 static inline struct ppa_addr pblk_ppa32_to_ppa64(struct pblk *pblk, u32 ppa32)
 {
-	struct ppa_addr ppa64;
+	struct nvm_tgt_dev *dev = pblk->dev;
 
-	ppa64.ppa = 0;
-
-	if (ppa32 == -1) {
-		ppa64.ppa = ADDR_EMPTY;
-	} else if (ppa32 & (1U << 31)) {
-		ppa64.c.line = ppa32 & ((~0U) >> 1);
-		ppa64.c.is_cached = 1;
-	} else {
-		struct nvm_tgt_dev *dev = pblk->dev;
-		struct nvm_geo *geo = &dev->geo;
-
-		if (geo->version == NVM_OCSSD_SPEC_12) {
-			struct nvm_addrf_12 *ppaf =
-					(struct nvm_addrf_12 *)&pblk->addrf;
-
-			ppa64.g.ch = (ppa32 & ppaf->ch_mask) >>
-							ppaf->ch_offset;
-			ppa64.g.lun = (ppa32 & ppaf->lun_mask) >>
-							ppaf->lun_offset;
-			ppa64.g.blk = (ppa32 & ppaf->blk_mask) >>
-							ppaf->blk_offset;
-			ppa64.g.pg = (ppa32 & ppaf->pg_mask) >>
-							ppaf->pg_offset;
-			ppa64.g.pl = (ppa32 & ppaf->pln_mask) >>
-							ppaf->pln_offset;
-			ppa64.g.sec = (ppa32 & ppaf->sec_mask) >>
-							ppaf->sec_offset;
-		} else {
-			struct nvm_addrf *lbaf = &pblk->addrf;
-
-			ppa64.m.grp = (ppa32 & lbaf->ch_mask) >>
-							lbaf->ch_offset;
-			ppa64.m.pu = (ppa32 & lbaf->lun_mask) >>
-							lbaf->lun_offset;
-			ppa64.m.chk = (ppa32 & lbaf->chk_mask) >>
-							lbaf->chk_offset;
-			ppa64.m.sec = (ppa32 & lbaf->sec_mask) >>
-							lbaf->sec_offset;
-		}
-	}
-
-	return ppa64;
+	return nvm_ppa32_to_ppa64(dev->parent, &pblk->addrf, ppa32);
 }
 
 static inline u32 pblk_ppa64_to_ppa32(struct pblk *pblk, struct ppa_addr ppa64)
 {
-	u32 ppa32 = 0;
+	struct nvm_tgt_dev *dev = pblk->dev;
 
-	if (ppa64.ppa == ADDR_EMPTY) {
-		ppa32 = ~0U;
-	} else if (ppa64.c.is_cached) {
-		ppa32 |= ppa64.c.line;
-		ppa32 |= 1U << 31;
-	} else {
-		struct nvm_tgt_dev *dev = pblk->dev;
-		struct nvm_geo *geo = &dev->geo;
-
-		if (geo->version == NVM_OCSSD_SPEC_12) {
-			struct nvm_addrf_12 *ppaf =
-					(struct nvm_addrf_12 *)&pblk->addrf;
-
-			ppa32 |= ppa64.g.ch << ppaf->ch_offset;
-			ppa32 |= ppa64.g.lun << ppaf->lun_offset;
-			ppa32 |= ppa64.g.blk << ppaf->blk_offset;
-			ppa32 |= ppa64.g.pg << ppaf->pg_offset;
-			ppa32 |= ppa64.g.pl << ppaf->pln_offset;
-			ppa32 |= ppa64.g.sec << ppaf->sec_offset;
-		} else {
-			struct nvm_addrf *lbaf = &pblk->addrf;
-
-			ppa32 |= ppa64.m.grp << lbaf->ch_offset;
-			ppa32 |= ppa64.m.pu << lbaf->lun_offset;
-			ppa32 |= ppa64.m.chk << lbaf->chk_offset;
-			ppa32 |= ppa64.m.sec << lbaf->sec_offset;
-		}
-	}
-
-	return ppa32;
+	return nvm_ppa64_to_ppa32(dev->parent, &pblk->addrf, ppa64);
 }
 
 static inline struct ppa_addr pblk_trans_map_get(struct pblk *pblk,
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 50ac5b21297c..eb7300c20f24 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -511,6 +511,89 @@ static inline u64 dev_to_chunk_addr(struct nvm_dev *dev, void *addrf,
 	return caddr;
 }
 
+static inline struct ppa_addr nvm_ppa32_to_ppa64(struct nvm_dev *dev,
+						 void *addrf, u32 ppa32)
+{
+	struct ppa_addr ppa64;
+
+	ppa64.ppa = 0;
+
+	if (ppa32 == -1) {
+		ppa64.ppa = ADDR_EMPTY;
+	} else if (ppa32 & (1U << 31)) {
+		ppa64.c.line = ppa32 & ((~0U) >> 1);
+		ppa64.c.is_cached = 1;
+	} else {
+		struct nvm_geo *geo = &dev->geo;
+
+		if (geo->version == NVM_OCSSD_SPEC_12) {
+			struct nvm_addrf_12 *ppaf = addrf;
+
+			ppa64.g.ch = (ppa32 & ppaf->ch_mask) >>
+							ppaf->ch_offset;
+			ppa64.g.lun = (ppa32 & ppaf->lun_mask) >>
+							ppaf->lun_offset;
+			ppa64.g.blk = (ppa32 & ppaf->blk_mask) >>
+							ppaf->blk_offset;
+			ppa64.g.pg = (ppa32 & ppaf->pg_mask) >>
+							ppaf->pg_offset;
+			ppa64.g.pl = (ppa32 & ppaf->pln_mask) >>
+							ppaf->pln_offset;
+			ppa64.g.sec = (ppa32 & ppaf->sec_mask) >>
+							ppaf->sec_offset;
+		} else {
+			struct nvm_addrf *lbaf = addrf;
+
+			ppa64.m.grp = (ppa32 & lbaf->ch_mask) >>
+							lbaf->ch_offset;
+			ppa64.m.pu = (ppa32 & lbaf->lun_mask) >>
+							lbaf->lun_offset;
+			ppa64.m.chk = (ppa32 & lbaf->chk_mask) >>
+							lbaf->chk_offset;
+			ppa64.m.sec = (ppa32 & lbaf->sec_mask) >>
+							lbaf->sec_offset;
+		}
+	}
+
+	return ppa64;
+}
+
+static inline u32 nvm_ppa64_to_ppa32(struct nvm_dev *dev,
+				     void *addrf, struct ppa_addr ppa64)
+{
+	u32 ppa32 = 0;
+
+	if (ppa64.ppa == ADDR_EMPTY) {
+		ppa32 = ~0U;
+	} else if (ppa64.c.is_cached) {
+		ppa32 |= ppa64.c.line;
+		ppa32 |= 1U << 31;
+	} else {
+		struct nvm_geo *geo = &dev->geo;
+
+		if (geo->version == NVM_OCSSD_SPEC_12) {
+			struct nvm_addrf_12 *ppaf = addrf;
+
+			ppa32 |= ppa64.g.ch << ppaf->ch_offset;
+			ppa32 |= ppa64.g.lun << ppaf->lun_offset;
+			ppa32 |= ppa64.g.blk << ppaf->blk_offset;
+			ppa32 |= ppa64.g.pg << ppaf->pg_offset;
+			ppa32 |= ppa64.g.pl << ppaf->pln_offset;
+			ppa32 |= ppa64.g.sec << ppaf->sec_offset;
+		} else {
+			struct nvm_addrf *lbaf = addrf;
+
+			ppa32 |= ppa64.m.grp << lbaf->ch_offset;
+			ppa32 |= ppa64.m.pu << lbaf->lun_offset;
+			ppa32 |= ppa64.m.chk << lbaf->chk_offset;
+			ppa32 |= ppa64.m.sec << lbaf->sec_offset;
+		}
+	}
+
+	return ppa32;
+}
+
+
 typedef blk_qc_t (nvm_tgt_make_rq_fn)(struct request_queue *, struct bio *);
 typedef sector_t (nvm_tgt_capacity_fn)(void *);
 typedef void *(nvm_tgt_init_fn)(struct nvm_tgt_dev *, struct gendisk *,
-- 
2.17.1
