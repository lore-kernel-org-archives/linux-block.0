Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43276 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbeJISbR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Oct 2018 14:31:17 -0400
Received: by mail-pf1-f193.google.com with SMTP id p24-v6so667576pff.10
        for <linux-block@vger.kernel.org>; Tue, 09 Oct 2018 04:14:51 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 29/45] lightnvm: pblk: fix mapping issue on failed writes
Date: Tue,  9 Oct 2018 13:11:59 +0200
Message-Id: <20181009111215.7653-30-mb@lightnvm.io>
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

On 1.2-devices, the mapping-out of remaning sectors in the
failed-write's block can result in an infinite loop,
stalling the write pipeline, fix this.

Fixes: 6a3abf5beef6 ("lightnvm: pblk: rework write error recovery path")
Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-write.c | 12 +-----------
 include/linux/lightnvm.h      | 36 +++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 61fe22ccc7a1..9554febee480 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -106,8 +106,6 @@ static void pblk_complete_write(struct pblk *pblk, struct nvm_rq *rqd,
 /* Map remaining sectors in chunk, starting from ppa */
 static void pblk_map_remaining(struct pblk *pblk, struct ppa_addr *ppa)
 {
-	struct nvm_tgt_dev *dev = pblk->dev;
-	struct nvm_geo *geo = &dev->geo;
 	struct pblk_line *line;
 	struct ppa_addr map_ppa = *ppa;
 	u64 paddr;
@@ -125,15 +123,7 @@ static void pblk_map_remaining(struct pblk *pblk, struct ppa_addr *ppa)
 		if (!test_and_set_bit(paddr, line->invalid_bitmap))
 			le32_add_cpu(line->vsc, -1);
 
-		if (geo->version == NVM_OCSSD_SPEC_12) {
-			map_ppa.ppa++;
-			if (map_ppa.g.pg == geo->num_pg)
-				done = 1;
-		} else {
-			map_ppa.m.sec++;
-			if (map_ppa.m.sec == geo->clba)
-				done = 1;
-		}
+		done = nvm_next_ppa_in_chk(pblk->dev, &map_ppa);
 	}
 
 	line->w_err_gc->has_write_err = 1;
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index eb7300c20f24..2fdeac1a420d 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -593,6 +593,42 @@ static inline u32 nvm_ppa64_to_ppa32(struct nvm_dev *dev,
 	return ppa32;
 }
 
+static inline int nvm_next_ppa_in_chk(struct nvm_tgt_dev *dev,
+				      struct ppa_addr *ppa)
+{
+	struct nvm_geo *geo = &dev->geo;
+	int last = 0;
+
+	if (geo->version == NVM_OCSSD_SPEC_12) {
+		int sec = ppa->g.sec;
+
+		sec++;
+		if (sec == geo->ws_min) {
+			int pg = ppa->g.pg;
+
+			sec = 0;
+			pg++;
+			if (pg == geo->num_pg) {
+				int pl = ppa->g.pl;
+
+				pg = 0;
+				pl++;
+				if (pl == geo->num_pln)
+					last = 1;
+
+				ppa->g.pl = pl;
+			}
+			ppa->g.pg = pg;
+		}
+		ppa->g.sec = sec;
+	} else {
+		ppa->m.sec++;
+		if (ppa->m.sec == geo->clba)
+			last = 1;
+	}
+
+	return last;
+}
 
 typedef blk_qc_t (nvm_tgt_make_rq_fn)(struct request_queue *, struct bio *);
 typedef sector_t (nvm_tgt_capacity_fn)(void *);
-- 
2.17.1
