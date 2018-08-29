Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35120 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbeH2QUf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Aug 2018 12:20:35 -0400
Received: by mail-ed1-f66.google.com with SMTP id y20-v6so3779912edq.2
        for <linux-block@vger.kernel.org>; Wed, 29 Aug 2018 05:23:54 -0700 (PDT)
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
To: Matias Bjorling <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Gonzales <javier@cnexlabs.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 2/7] lightnvm: pblk: fix mapping issue on failed writes
Date: Wed, 29 Aug 2018 14:23:29 +0200
Message-Id: <1535545414-550-3-git-send-email-hans.ml.holmberg@owltronix.com>
In-Reply-To: <1535545414-550-1-git-send-email-hans.ml.holmberg@owltronix.com>
References: <1535545414-550-1-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

On 1.2-devices, the mapping-out of remaning sectors in the
failed-write's block can result in an infinite loop,
stalling the write pipeline, fix this.

Fixes: 6a3abf5beef6 ("lightnvm: pblk: rework write error recovery path")

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-write.c | 45 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 1bc879ab679d..fd67325f6e54 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -103,6 +103,41 @@ static void pblk_complete_write(struct pblk *pblk, struct nvm_rq *rqd,
 	pblk_rb_sync_end(&pblk->rwb, &flags);
 }
 
+static int pblk_next_ppa_in_blk(struct nvm_geo *geo, struct ppa_addr *ppa)
+{
+	int done = 0;
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
+					done = 1;
+
+				ppa->g.pl = pl;
+			}
+			ppa->g.pg = pg;
+		}
+		ppa->g.sec = sec;
+	} else {
+		ppa->m.sec++;
+		if (ppa->m.sec == geo->clba)
+			done = 1;
+	}
+
+	return done;
+}
+
 /* Map remaining sectors in chunk, starting from ppa */
 static void pblk_map_remaining(struct pblk *pblk, struct ppa_addr *ppa)
 {
@@ -125,15 +160,7 @@ static void pblk_map_remaining(struct pblk *pblk, struct ppa_addr *ppa)
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
+		done = pblk_next_ppa_in_blk(geo, &map_ppa);
 	}
 
 	line->w_err_gc->has_write_err = 1;
-- 
2.7.4
