Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wj0-f196.google.com ([209.85.210.196]:34118 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755577AbcK1Vjr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Nov 2016 16:39:47 -0500
Received: by mail-wj0-f196.google.com with SMTP id xy5so15802403wjc.1
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2016 13:39:46 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: axboe@fb.com, =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 10/23] lightnvm: make address conversion functions global
Date: Mon, 28 Nov 2016 22:39:01 +0100
Message-Id: <20161128213914.12516-11-m@bjorling.me>
In-Reply-To: <20161128213914.12516-1-m@bjorling.me>
References: <20161128213914.12516-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <jg@lightnvm.io>

Targets are assumed to used the same generic ppa format, where the
address is partitioned on ch:lun:block:pg:pl:sec. Thus, make the
function in charge of transforming the ppa address from a linear format
to the generic one available to all targets.

This function will be needed by the media manager in order to do target
mapping translations when targets are divided on different physical
partitions.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/rrpc.c  | 30 ------------------------------
 include/linux/lightnvm.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
index 60ca9d4..9253acc 100644
--- a/drivers/lightnvm/rrpc.c
+++ b/drivers/lightnvm/rrpc.c
@@ -136,36 +136,6 @@ static u64 block_to_addr(struct rrpc *rrpc, struct rrpc_block *rblk)
 	return blk->id * rrpc->dev->sec_per_blk;
 }
 
-static struct ppa_addr linear_to_generic_addr(struct nvm_dev *dev,
-							struct ppa_addr r)
-{
-	struct ppa_addr l;
-	int secs, pgs, blks, luns;
-	sector_t ppa = r.ppa;
-
-	l.ppa = 0;
-
-	div_u64_rem(ppa, dev->sec_per_pg, &secs);
-	l.g.sec = secs;
-
-	sector_div(ppa, dev->sec_per_pg);
-	div_u64_rem(ppa, dev->pgs_per_blk, &pgs);
-	l.g.pg = pgs;
-
-	sector_div(ppa, dev->pgs_per_blk);
-	div_u64_rem(ppa, dev->blks_per_lun, &blks);
-	l.g.blk = blks;
-
-	sector_div(ppa, dev->blks_per_lun);
-	div_u64_rem(ppa, dev->luns_per_chnl, &luns);
-	l.g.lun = luns;
-
-	sector_div(ppa, dev->luns_per_chnl);
-	l.g.ch = ppa;
-
-	return l;
-}
-
 static struct ppa_addr rrpc_ppa_to_gaddr(struct nvm_dev *dev, u64 addr)
 {
 	struct ppa_addr paddr;
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index e598308..98278a9 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -361,6 +361,36 @@ struct nvm_dev {
 	spinlock_t lock;
 };
 
+static inline struct ppa_addr linear_to_generic_addr(struct nvm_dev *dev,
+							struct ppa_addr r)
+{
+	struct ppa_addr l;
+	int secs, pgs, blks, luns;
+	sector_t ppa = r.ppa;
+
+	l.ppa = 0;
+
+	div_u64_rem(ppa, dev->sec_per_pg, &secs);
+	l.g.sec = secs;
+
+	sector_div(ppa, dev->sec_per_pg);
+	div_u64_rem(ppa, dev->pgs_per_blk, &pgs);
+	l.g.pg = pgs;
+
+	sector_div(ppa, dev->pgs_per_blk);
+	div_u64_rem(ppa, dev->blks_per_lun, &blks);
+	l.g.blk = blks;
+
+	sector_div(ppa, dev->blks_per_lun);
+	div_u64_rem(ppa, dev->luns_per_chnl, &luns);
+	l.g.lun = luns;
+
+	sector_div(ppa, dev->luns_per_chnl);
+	l.g.ch = ppa;
+
+	return l;
+}
+
 static inline struct ppa_addr generic_to_dev_addr(struct nvm_dev *dev,
 						struct ppa_addr r)
 {
-- 
2.9.3

