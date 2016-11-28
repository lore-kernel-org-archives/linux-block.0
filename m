Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36016 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755375AbcK1VkC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Nov 2016 16:40:02 -0500
Received: by mail-wm0-f65.google.com with SMTP id m203so21232054wma.3
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2016 13:40:01 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: axboe@fb.com, =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 20/23] lightnvm: introduce helpers for generic ops in rrpc
Date: Mon, 28 Nov 2016 22:39:11 +0100
Message-Id: <20161128213914.12516-21-m@bjorling.me>
In-Reply-To: <20161128213914.12516-1-m@bjorling.me>
References: <20161128213914.12516-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <jg@lightnvm.io>

Avoid calling media manager and device-specific operations directly from
rrpc. Create helper functions on lightnvm's core instead.

Signed-off-by: Javier González <javier@cnexlabs.com>

Made it work with null_blk as well.
Signed-off-by: Matias Bjørling <m@bjorling.me>

Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/core.c   | 22 ++++++++++++++++++++++
 drivers/lightnvm/gennvm.c |  2 --
 drivers/lightnvm/rrpc.c   | 27 +++++++++++++--------------
 include/linux/lightnvm.h  |  5 +----
 4 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 23d582f..69f261e 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -219,6 +219,28 @@ int nvm_erase_blk(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *p, int flags)
 }
 EXPORT_SYMBOL(nvm_erase_blk);
 
+int nvm_get_l2p_tbl(struct nvm_dev *dev, u64 slba, u32 nlb,
+		    nvm_l2p_update_fn *update_l2p, void *priv)
+{
+	if (!dev->ops->get_l2p_tbl)
+		return 0;
+
+	return dev->ops->get_l2p_tbl(dev, slba, nlb, update_l2p, priv);
+}
+EXPORT_SYMBOL(nvm_get_l2p_tbl);
+
+int nvm_get_area(struct nvm_dev *dev, sector_t *lba, sector_t len)
+{
+	return dev->mt->get_area(dev, lba, len);
+}
+EXPORT_SYMBOL(nvm_get_area);
+
+void nvm_put_area(struct nvm_dev *dev, sector_t lba)
+{
+	dev->mt->put_area(dev, lba);
+}
+EXPORT_SYMBOL(nvm_put_area);
+
 void nvm_addr_to_generic_mode(struct nvm_dev *dev, struct nvm_rq *rqd)
 {
 	int i;
diff --git a/drivers/lightnvm/gennvm.c b/drivers/lightnvm/gennvm.c
index 5d7c8c4..befa828 100644
--- a/drivers/lightnvm/gennvm.c
+++ b/drivers/lightnvm/gennvm.c
@@ -175,8 +175,6 @@ static struct nvm_tgt_dev *gen_create_tgt_dev(struct nvm_dev *dev,
 	tgt_dev->geo.luns_per_chnl = (lun_balanced) ? prev_nr_luns : -1;
 	tgt_dev->total_secs = nr_luns * tgt_dev->geo.sec_per_lun;
 	tgt_dev->q = dev->q;
-	tgt_dev->ops = dev->ops;
-	tgt_dev->mt = dev->mt;
 	tgt_dev->map = dev_map;
 	tgt_dev->luns = luns;
 	memcpy(&tgt_dev->identity, &dev->identity, sizeof(struct nvm_id));
diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
index 75ed12a..e4678b7 100644
--- a/drivers/lightnvm/rrpc.c
+++ b/drivers/lightnvm/rrpc.c
@@ -1166,11 +1166,8 @@ static int rrpc_map_init(struct rrpc *rrpc)
 		r->addr = ADDR_EMPTY;
 	}
 
-	if (!dev->ops->get_l2p_tbl)
-		return 0;
-
 	/* Bring up the mapping table from device */
-	ret = dev->ops->get_l2p_tbl(dev->parent, rrpc->soffset, rrpc->nr_sects,
+	ret = nvm_get_l2p_tbl(dev->parent, rrpc->soffset, rrpc->nr_sects,
 					rrpc_l2p_update, rrpc);
 	if (ret) {
 		pr_err("nvm: rrpc: could not read L2P table.\n");
@@ -1258,6 +1255,9 @@ static int rrpc_bb_discovery(struct nvm_tgt_dev *dev, struct rrpc_lun *rlun)
 	int i;
 	int ret;
 
+	if (!dev->parent->ops->get_bb_tbl)
+		return 0;
+
 	nr_blks = geo->blks_per_lun * geo->plane_mode;
 	blks = kmalloc(nr_blks, GFP_KERNEL);
 	if (!blks)
@@ -1277,7 +1277,6 @@ static int rrpc_bb_discovery(struct nvm_tgt_dev *dev, struct rrpc_lun *rlun)
 	if (nr_blks < 0)
 		return nr_blks;
 
-	rlun->nr_free_blocks = geo->blks_per_lun;
 	for (i = 0; i < nr_blks; i++) {
 		if (blks[i] == NVM_BLK_T_FREE)
 			continue;
@@ -1348,17 +1347,19 @@ static int rrpc_luns_init(struct rrpc *rrpc, struct ppa_addr *luns)
 			list_add_tail(&rblk->list, &rlun->free_list);
 		}
 
-		if (rrpc_bb_discovery(dev, rlun))
-			goto err;
-
-		rlun->reserved_blocks = 2; /* for GC only */
-
 		rlun->rrpc = rrpc;
+		rlun->nr_free_blocks = geo->blks_per_lun;
+		rlun->reserved_blocks = 2; /* for GC only */
+
 		INIT_LIST_HEAD(&rlun->prio_list);
 		INIT_LIST_HEAD(&rlun->wblk_list);
 
 		INIT_WORK(&rlun->ws_gc, rrpc_lun_gc);
 		spin_lock_init(&rlun->lock);
+
+		if (rrpc_bb_discovery(dev, rlun))
+			goto err;
+
 	}
 
 	return 0;
@@ -1370,13 +1371,12 @@ static int rrpc_luns_init(struct rrpc *rrpc, struct ppa_addr *luns)
 static int rrpc_area_init(struct rrpc *rrpc, sector_t *begin)
 {
 	struct nvm_tgt_dev *dev = rrpc->dev;
-	struct nvmm_type *mt = dev->mt;
 	sector_t size = rrpc->nr_sects * dev->geo.sec_size;
 	int ret;
 
 	size >>= 9;
 
-	ret = mt->get_area(dev->parent, begin, size);
+	ret = nvm_get_area(dev->parent, begin, size);
 	if (!ret)
 		*begin >>= (ilog2(dev->geo.sec_size) - 9);
 
@@ -1386,10 +1386,9 @@ static int rrpc_area_init(struct rrpc *rrpc, sector_t *begin)
 static void rrpc_area_free(struct rrpc *rrpc)
 {
 	struct nvm_tgt_dev *dev = rrpc->dev;
-	struct nvmm_type *mt = dev->mt;
 	sector_t begin = rrpc->soffset << (ilog2(dev->geo.sec_size) - 9);
 
-	mt->put_area(dev->parent, begin);
+	nvm_put_area(dev->parent, begin);
 }
 
 static void rrpc_free(struct rrpc *rrpc)
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 2222853..99cd1e7 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -320,10 +320,7 @@ struct nvm_tgt_dev {
 	struct nvm_id identity;
 	struct request_queue *q;
 
-	struct nvmm_type *mt;
-	struct nvm_dev_ops *ops;
-
-	void *parent;
+	struct nvm_dev *parent;
 	void *map;
 };
 
-- 
2.9.3

