Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45968 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753054AbeBUJ1Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Feb 2018 04:27:24 -0500
Received: by mail-wr0-f195.google.com with SMTP id p104so2417042wrc.12
        for <linux-block@vger.kernel.org>; Wed, 21 Feb 2018 01:27:23 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 13/20] lightnvm: add support for 2.0 address format
Date: Wed, 21 Feb 2018 10:26:51 +0100
Message-Id: <1519205218-26994-14-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
References: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add support for 2.0 address format. Also, align address bits for 1.2 and
2.0 to be able to operate on channel and luns without requiring a format
conversion. Use a generic address format for this purpose.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/core.c  |  20 ++++-----
 include/linux/lightnvm.h | 105 ++++++++++++++++++++++++++++++++++-------------
 2 files changed, 86 insertions(+), 39 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index f70a907223e2..baec963b2c96 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -196,8 +196,8 @@ static struct nvm_tgt_dev *nvm_create_tgt_dev(struct nvm_dev *dev,
 
 		for (j = 0; j < luns_in_chnl; j++) {
 			luns[lunid].ppa = 0;
-			luns[lunid].g.ch = i;
-			luns[lunid++].g.lun = j;
+			luns[lunid].a.ch = i;
+			luns[lunid++].a.lun = j;
 
 			lun_offs[j] = blun;
 			lun_roffs[j + blun] = blun;
@@ -563,22 +563,22 @@ static void nvm_unregister_map(struct nvm_dev *dev)
 static void nvm_map_to_dev(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *p)
 {
 	struct nvm_dev_map *dev_map = tgt_dev->map;
-	struct nvm_ch_map *ch_map = &dev_map->chnls[p->g.ch];
-	int lun_off = ch_map->lun_offs[p->g.lun];
+	struct nvm_ch_map *ch_map = &dev_map->chnls[p->a.ch];
+	int lun_off = ch_map->lun_offs[p->a.lun];
 
-	p->g.ch += ch_map->ch_off;
-	p->g.lun += lun_off;
+	p->a.ch += ch_map->ch_off;
+	p->a.lun += lun_off;
 }
 
 static void nvm_map_to_tgt(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *p)
 {
 	struct nvm_dev *dev = tgt_dev->parent;
 	struct nvm_dev_map *dev_rmap = dev->rmap;
-	struct nvm_ch_map *ch_rmap = &dev_rmap->chnls[p->g.ch];
-	int lun_roff = ch_rmap->lun_offs[p->g.lun];
+	struct nvm_ch_map *ch_rmap = &dev_rmap->chnls[p->a.ch];
+	int lun_roff = ch_rmap->lun_offs[p->a.lun];
 
-	p->g.ch -= ch_rmap->ch_off;
-	p->g.lun -= lun_roff;
+	p->a.ch -= ch_rmap->ch_off;
+	p->a.lun -= lun_roff;
 }
 
 static void nvm_ppa_tgt_to_dev(struct nvm_tgt_dev *tgt_dev,
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index e1c4292ea33d..cd310bf06051 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -16,12 +16,22 @@ enum {
 	NVM_IOTYPE_GC = 1,
 };
 
-#define NVM_BLK_BITS (16)
-#define NVM_PG_BITS  (16)
-#define NVM_SEC_BITS (8)
-#define NVM_PL_BITS  (8)
-#define NVM_LUN_BITS (8)
-#define NVM_CH_BITS  (7)
+/* common format */
+#define NVM_GEN_CH_BITS  (8)
+#define NVM_GEN_LUN_BITS (8)
+#define NVM_GEN_RESERVED (48)
+
+/* 1.2 format */
+#define NVM_12_BLK_BITS (16)
+#define NVM_12_PG_BITS  (16)
+#define NVM_12_PL_BITS  (4)
+#define NVM_12_SEC_BITS (4)
+#define NVM_12_RESERVED (8)
+
+/* 2.0 format */
+#define NVM_20_CHK_BITS (16)
+#define NVM_20_SEC_BITS (24)
+#define NVM_20_RESERVED (8)
 
 enum {
 	NVM_OCSSD_SPEC_12 = 12,
@@ -31,16 +41,33 @@ enum {
 struct ppa_addr {
 	/* Generic structure for all addresses */
 	union {
+		/* generic device format */
 		struct {
-			u64 blk		: NVM_BLK_BITS;
-			u64 pg		: NVM_PG_BITS;
-			u64 sec		: NVM_SEC_BITS;
-			u64 pl		: NVM_PL_BITS;
-			u64 lun		: NVM_LUN_BITS;
-			u64 ch		: NVM_CH_BITS;
-			u64 reserved	: 1;
+			u64 ch		: NVM_GEN_CH_BITS;
+			u64 lun		: NVM_GEN_LUN_BITS;
+			u64 reserved	: NVM_GEN_RESERVED;
+		} a;
+
+		/* 1.2 device format */
+		struct {
+			u64 ch		: NVM_GEN_CH_BITS;
+			u64 lun		: NVM_GEN_LUN_BITS;
+			u64 blk		: NVM_12_BLK_BITS;
+			u64 pg		: NVM_12_PG_BITS;
+			u64 pl		: NVM_12_PL_BITS;
+			u64 sec		: NVM_12_SEC_BITS;
+			u64 reserved	: NVM_12_RESERVED;
 		} g;
 
+		/* 2.0 device format */
+		struct {
+			u64 ch		: NVM_GEN_CH_BITS;
+			u64 lun		: NVM_GEN_LUN_BITS;
+			u64 chk		: NVM_20_CHK_BITS;
+			u64 sec		: NVM_20_SEC_BITS;
+			u64 reserved	: NVM_20_RESERVED;
+		} m;
+
 		struct {
 			u64 line	: 63;
 			u64 is_cached	: 1;
@@ -392,16 +419,26 @@ static inline struct ppa_addr generic_to_dev_addr(struct nvm_tgt_dev *tgt_dev,
 						  struct ppa_addr r)
 {
 	struct nvm_geo *geo = &tgt_dev->geo;
-	struct nvm_addr_format_12 *ppaf =
-				(struct nvm_addr_format_12 *)&geo->c.addrf;
 	struct ppa_addr l;
 
-	l.ppa = ((u64)r.g.ch) << ppaf->ch_offset;
-	l.ppa |= ((u64)r.g.lun) << ppaf->lun_offset;
-	l.ppa |= ((u64)r.g.blk) << ppaf->blk_offset;
-	l.ppa |= ((u64)r.g.pg) << ppaf->pg_offset;
-	l.ppa |= ((u64)r.g.pl) << ppaf->pln_offset;
-	l.ppa |= ((u64)r.g.sec) << ppaf->sec_offset;
+	if (geo->c.version == NVM_OCSSD_SPEC_12) {
+		struct nvm_addr_format_12 *ppaf =
+				(struct nvm_addr_format_12 *)&geo->c.addrf;
+
+		l.ppa = ((u64)r.g.ch) << ppaf->ch_offset;
+		l.ppa |= ((u64)r.g.lun) << ppaf->lun_offset;
+		l.ppa |= ((u64)r.g.blk) << ppaf->blk_offset;
+		l.ppa |= ((u64)r.g.pg) << ppaf->pg_offset;
+		l.ppa |= ((u64)r.g.pl) << ppaf->pln_offset;
+		l.ppa |= ((u64)r.g.sec) << ppaf->sec_offset;
+	} else {
+		struct nvm_addr_format *lbaf = &geo->c.addrf;
+
+		l.ppa = ((u64)r.m.ch) << lbaf->ch_offset;
+		l.ppa |= ((u64)r.m.lun) << lbaf->lun_offset;
+		l.ppa |= ((u64)r.m.chk) << lbaf->chk_offset;
+		l.ppa |= ((u64)r.m.sec) << lbaf->sec_offset;
+	}
 
 	return l;
 }
@@ -410,18 +447,28 @@ static inline struct ppa_addr dev_to_generic_addr(struct nvm_tgt_dev *tgt_dev,
 						  struct ppa_addr r)
 {
 	struct nvm_geo *geo = &tgt_dev->geo;
-	struct nvm_addr_format_12 *ppaf =
-				(struct nvm_addr_format_12 *)&geo->c.addrf;
 	struct ppa_addr l;
 
 	l.ppa = 0;
 
-	l.g.ch = (r.ppa & ppaf->ch_mask) >> ppaf->ch_offset;
-	l.g.lun = (r.ppa & ppaf->lun_mask) >> ppaf->lun_offset;
-	l.g.blk = (r.ppa & ppaf->blk_mask) >> ppaf->blk_offset;
-	l.g.pg = (r.ppa & ppaf->pg_mask) >> ppaf->pg_offset;
-	l.g.pl = (r.ppa & ppaf->pln_mask) >> ppaf->pln_offset;
-	l.g.sec = (r.ppa & ppaf->sec_mask) >> ppaf->sec_offset;
+	if (geo->c.version == NVM_OCSSD_SPEC_12) {
+		struct nvm_addr_format_12 *ppaf =
+				(struct nvm_addr_format_12 *)&geo->c.addrf;
+
+		l.g.ch = (r.ppa & ppaf->ch_mask) >> ppaf->ch_offset;
+		l.g.lun = (r.ppa & ppaf->lun_mask) >> ppaf->lun_offset;
+		l.g.blk = (r.ppa & ppaf->blk_mask) >> ppaf->blk_offset;
+		l.g.pg = (r.ppa & ppaf->pg_mask) >> ppaf->pg_offset;
+		l.g.pl = (r.ppa & ppaf->pln_mask) >> ppaf->pln_offset;
+		l.g.sec = (r.ppa & ppaf->sec_mask) >> ppaf->sec_offset;
+	} else {
+		struct nvm_addr_format *lbaf = &geo->c.addrf;
+
+		l.m.ch = (r.ppa & lbaf->ch_mask) >> lbaf->ch_offset;
+		l.m.lun = (r.ppa & lbaf->lun_mask) >> lbaf->lun_offset;
+		l.m.chk = (r.ppa & lbaf->chk_mask) >> lbaf->chk_offset;
+		l.m.sec = (r.ppa & lbaf->sec_mask) >> lbaf->sec_offset;
+	}
 
 	return l;
 }
-- 
2.7.4
