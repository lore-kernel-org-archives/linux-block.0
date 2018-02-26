Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52075 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753179AbeBZNRj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Feb 2018 08:17:39 -0500
Received: by mail-wm0-f68.google.com with SMTP id h21so17383277wmd.1
        for <linux-block@vger.kernel.org>; Mon, 26 Feb 2018 05:17:39 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 11/19] lightnvm: pblk: rename ppaf* to addrf*
Date: Mon, 26 Feb 2018 14:17:10 +0100
Message-Id: <1519651038-16845-12-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1519651038-16845-1-git-send-email-javier@cnexlabs.com>
References: <1519651038-16845-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In preparation for 2.0 support in pblk, rename variables referring to
the address format to addrf and reserve ppaf for the 1.2 path.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-init.c  |  8 ++++----
 drivers/lightnvm/pblk-sysfs.c |  4 ++--
 drivers/lightnvm/pblk.h       | 16 ++++++++--------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 30aec863f136..ec39800eea42 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -80,7 +80,7 @@ static size_t pblk_trans_map_size(struct pblk *pblk)
 {
 	int entry_size = 8;
 
-	if (pblk->ppaf_bitsize < 32)
+	if (pblk->addrf_len < 32)
 		entry_size = 4;
 
 	return entry_size * pblk->rl.nr_secs;
@@ -198,7 +198,7 @@ static int pblk_set_addrf_12(struct nvm_geo *geo,
 	return dst->blk_offset + src->blk_len;
 }
 
-static int pblk_set_ppaf(struct pblk *pblk)
+static int pblk_set_addrf(struct pblk *pblk)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
@@ -210,7 +210,7 @@ static int pblk_set_ppaf(struct pblk *pblk)
 		return -EINVAL;
 	}
 
-	pblk->ppaf_bitsize = pblk_set_addrf_12(geo, (void *)&pblk->ppaf);
+	pblk->addrf_len = pblk_set_addrf_12(geo, (void *)&pblk->addrf);
 
 	return 0;
 }
@@ -319,7 +319,7 @@ static int pblk_core_init(struct pblk *pblk)
 	if (!pblk->r_end_wq)
 		goto free_bb_wq;
 
-	if (pblk_set_ppaf(pblk))
+	if (pblk_set_addrf(pblk))
 		goto free_r_end_wq;
 
 	if (pblk_rwb_init(pblk))
diff --git a/drivers/lightnvm/pblk-sysfs.c b/drivers/lightnvm/pblk-sysfs.c
index 81288aa9162a..d3b50741b691 100644
--- a/drivers/lightnvm/pblk-sysfs.c
+++ b/drivers/lightnvm/pblk-sysfs.c
@@ -117,12 +117,12 @@ static ssize_t pblk_sysfs_ppaf(struct pblk *pblk, char *page)
 	struct nvm_addr_format_12 *geo_ppaf;
 	ssize_t sz = 0;
 
-	ppaf = (struct nvm_addr_format_12 *)&pblk->ppaf;
+	ppaf = (struct nvm_addr_format_12 *)&pblk->addrf;
 	geo_ppaf = (struct nvm_addr_format_12 *)&geo->c.addrf;
 
 	sz = snprintf(page, PAGE_SIZE,
 		"pblk:(s:%d)ch:%d/%d,lun:%d/%d,blk:%d/%d,pg:%d/%d,pl:%d/%d,sec:%d/%d\n",
-			pblk->ppaf_bitsize,
+			pblk->addrf_len,
 			ppaf->ch_offset, ppaf->ch_len,
 			ppaf->lun_offset, ppaf->lun_len,
 			ppaf->blk_offset, ppaf->blk_len,
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 4f7a365436f1..46b29a492f74 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -570,8 +570,8 @@ struct pblk {
 	struct pblk_line_mgmt l_mg;		/* Line management */
 	struct pblk_line_meta lm;		/* Line metadata */
 
-	struct nvm_addr_format ppaf;
-	int ppaf_bitsize;
+	struct nvm_addr_format addrf;
+	int addrf_len;
 
 	struct pblk_rb rwb;
 
@@ -948,7 +948,7 @@ static inline struct ppa_addr addr_to_gen_ppa(struct pblk *pblk, u64 paddr,
 					      u64 line_id)
 {
 	struct nvm_addr_format_12 *ppaf =
-				(struct nvm_addr_format_12 *)&pblk->ppaf;
+				(struct nvm_addr_format_12 *)&pblk->addrf;
 	struct ppa_addr ppa;
 
 	ppa.ppa = 0;
@@ -966,7 +966,7 @@ static inline u64 pblk_dev_ppa_to_line_addr(struct pblk *pblk,
 							struct ppa_addr p)
 {
 	struct nvm_addr_format_12 *ppaf =
-				(struct nvm_addr_format_12 *)&pblk->ppaf;
+				(struct nvm_addr_format_12 *)&pblk->addrf;
 	u64 paddr;
 
 	paddr = (u64)p.g.ch << ppaf->ch_offset;
@@ -991,7 +991,7 @@ static inline struct ppa_addr pblk_ppa32_to_ppa64(struct pblk *pblk, u32 ppa32)
 		ppa64.c.is_cached = 1;
 	} else {
 		struct nvm_addr_format_12 *ppaf =
-				(struct nvm_addr_format_12 *)&pblk->ppaf;
+				(struct nvm_addr_format_12 *)&pblk->addrf;
 
 		ppa64.g.ch = (ppa32 & ppaf->ch_mask) >> ppaf->ch_offset;
 		ppa64.g.lun = (ppa32 & ppaf->lun_mask) >> ppaf->lun_offset;
@@ -1015,7 +1015,7 @@ static inline u32 pblk_ppa64_to_ppa32(struct pblk *pblk, struct ppa_addr ppa64)
 		ppa32 |= 1U << 31;
 	} else {
 		struct nvm_addr_format_12 *ppaf =
-				(struct nvm_addr_format_12 *)&pblk->ppaf;
+				(struct nvm_addr_format_12 *)&pblk->addrf;
 
 		ppa32 |= ppa64.g.ch << ppaf->ch_offset;
 		ppa32 |= ppa64.g.lun << ppaf->lun_offset;
@@ -1033,7 +1033,7 @@ static inline struct ppa_addr pblk_trans_map_get(struct pblk *pblk,
 {
 	struct ppa_addr ppa;
 
-	if (pblk->ppaf_bitsize < 32) {
+	if (pblk->addrf_len < 32) {
 		u32 *map = (u32 *)pblk->trans_map;
 
 		ppa = pblk_ppa32_to_ppa64(pblk, map[lba]);
@@ -1049,7 +1049,7 @@ static inline struct ppa_addr pblk_trans_map_get(struct pblk *pblk,
 static inline void pblk_trans_map_set(struct pblk *pblk, sector_t lba,
 						struct ppa_addr ppa)
 {
-	if (pblk->ppaf_bitsize < 32) {
+	if (pblk->addrf_len < 32) {
 		u32 *map = (u32 *)pblk->trans_map;
 
 		map[lba] = pblk_ppa64_to_ppa32(pblk, ppa);
-- 
2.7.4
