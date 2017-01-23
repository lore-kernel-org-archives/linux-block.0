Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wj0-f194.google.com ([209.85.210.194]:36051 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751013AbdAWMAU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Jan 2017 07:00:20 -0500
Received: by mail-wj0-f194.google.com with SMTP id kq3so1730728wjc.3
        for <linux-block@vger.kernel.org>; Mon, 23 Jan 2017 03:59:47 -0800 (PST)
From: "=?UTF-8?q?Matias=20Bj=C3=B8rling?=" <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 5/8] lightnvm: make nvm_map_* return void
Date: Mon, 23 Jan 2017 12:59:16 +0100
Message-Id: <20170123115919.14339-6-matias@cnexlabs.com>
In-Reply-To: <20170123115919.14339-1-matias@cnexlabs.com>
References: <20170123115919.14339-1-matias@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The only check there was done was a debugging check. Remove it and
replace the return value with void to reduce error checking.

Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/core.c | 41 +++++++++--------------------------------
 1 file changed, 9 insertions(+), 32 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 18d4873..a1a7a5a 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -407,31 +407,17 @@ static int nvm_register_map(struct nvm_dev *dev)
 	return -ENOMEM;
 }
 
-static int nvm_map_to_dev(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *p)
+static void nvm_map_to_dev(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *p)
 {
 	struct nvm_dev_map *dev_map = tgt_dev->map;
 	struct nvm_ch_map *ch_map = &dev_map->chnls[p->g.ch];
 	int lun_off = ch_map->lun_offs[p->g.lun];
-	struct nvm_dev *dev = tgt_dev->parent;
-	struct nvm_dev_map *dev_rmap = dev->rmap;
-	struct nvm_ch_map *ch_rmap;
-	int lun_roff;
 
 	p->g.ch += ch_map->ch_off;
 	p->g.lun += lun_off;
-
-	ch_rmap = &dev_rmap->chnls[p->g.ch];
-	lun_roff = ch_rmap->lun_offs[p->g.lun];
-
-	if (unlikely(ch_rmap->ch_off < 0 || lun_roff < 0)) {
-		pr_err("nvm: corrupted device partition table\n");
-		return -EINVAL;
-	}
-
-	return 0;
 }
 
-static int nvm_map_to_tgt(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *p)
+static void nvm_map_to_tgt(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *p)
 {
 	struct nvm_dev *dev = tgt_dev->parent;
 	struct nvm_dev_map *dev_rmap = dev->rmap;
@@ -440,34 +426,27 @@ static int nvm_map_to_tgt(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *p)
 
 	p->g.ch -= ch_rmap->ch_off;
 	p->g.lun -= lun_roff;
-
-	return 0;
 }
 
-static int nvm_trans_rq(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd,
+static void nvm_trans_rq(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd,
 			int flag)
 {
 	int i;
-	int ret;
 
 	if (rqd->nr_ppas == 1) {
 		if (flag == TRANS_TGT_TO_DEV)
-			return nvm_map_to_dev(tgt_dev, &rqd->ppa_addr);
+			nvm_map_to_dev(tgt_dev, &rqd->ppa_addr);
 		else
-			return nvm_map_to_tgt(tgt_dev, &rqd->ppa_addr);
+			nvm_map_to_tgt(tgt_dev, &rqd->ppa_addr);
+		return;
 	}
 
 	for (i = 0; i < rqd->nr_ppas; i++) {
 		if (flag == TRANS_TGT_TO_DEV)
-			ret = nvm_map_to_dev(tgt_dev, &rqd->ppa_list[i]);
+			nvm_map_to_dev(tgt_dev, &rqd->ppa_list[i]);
 		else
-			ret = nvm_map_to_tgt(tgt_dev, &rqd->ppa_list[i]);
-
-		if (ret)
-			break;
+			nvm_map_to_tgt(tgt_dev, &rqd->ppa_list[i]);
 	}
-
-	return ret;
 }
 
 static struct ppa_addr nvm_trans_ppa(struct nvm_tgt_dev *tgt_dev,
@@ -665,9 +644,7 @@ int nvm_erase_blk(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *ppas, int flags)
 	if (!dev->ops->erase_block)
 		return 0;
 
-	ret = nvm_map_to_dev(tgt_dev, ppas);
-	if (ret)
-		return ret;
+	nvm_map_to_dev(tgt_dev, ppas);
 
 	memset(&rqd, 0, sizeof(struct nvm_rq));
 
-- 
2.7.4

