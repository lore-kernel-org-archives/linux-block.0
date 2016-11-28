Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wj0-f194.google.com ([209.85.210.194]:35917 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755617AbcK1Vjw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Nov 2016 16:39:52 -0500
Received: by mail-wj0-f194.google.com with SMTP id jb2so15789714wjb.3
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2016 13:39:52 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: axboe@fb.com, =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 16/23] lightnvm: remove get_lun operation on gennvm
Date: Mon, 28 Nov 2016 22:39:07 +0100
Message-Id: <20161128213914.12516-17-m@bjorling.me>
In-Reply-To: <20161128213914.12516-1-m@bjorling.me>
References: <20161128213914.12516-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <jg@lightnvm.io>

Since LUNs are managed internally on the target, there is no need for
the media manager to implement a get_lun operation.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/gennvm.c | 13 +------------
 drivers/lightnvm/rrpc.c   | 23 +++++++++++------------
 include/linux/lightnvm.h  |  8 ++------
 3 files changed, 14 insertions(+), 30 deletions(-)

diff --git a/drivers/lightnvm/gennvm.c b/drivers/lightnvm/gennvm.c
index 8791a2a..3cf5d59 100644
--- a/drivers/lightnvm/gennvm.c
+++ b/drivers/lightnvm/gennvm.c
@@ -159,7 +159,7 @@ static int gen_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 	tdisk->fops = &gen_fops;
 	tdisk->queue = tqueue;
 
-	targetdata = tt->init(tgt_dev, tdisk, s->lun_begin, s->lun_end);
+	targetdata = tt->init(tgt_dev, tdisk, &t->lun_list);
 	if (IS_ERR(targetdata))
 		goto err_init;
 
@@ -613,16 +613,6 @@ static int gen_erase_blk(struct nvm_dev *dev, struct nvm_block *blk, int flags)
 	return nvm_erase_ppa(dev, &addr, 1, flags);
 }
 
-static struct nvm_lun *gen_get_lun(struct nvm_dev *dev, int lunid)
-{
-	struct gen_dev *gn = dev->mp;
-
-	if (unlikely(lunid >= dev->geo.nr_luns))
-		return NULL;
-
-	return &gn->luns[lunid];
-}
-
 static void gen_lun_info_print(struct nvm_dev *dev)
 {
 	struct gen_dev *gn = dev->mp;
@@ -655,7 +645,6 @@ static struct nvmm_type gen = {
 
 	.mark_blk		= gen_mark_blk,
 
-	.get_lun		= gen_get_lun,
 	.lun_info_print		= gen_lun_info_print,
 
 	.get_area		= gen_get_area,
diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
index 5377c7a..165b9d3 100644
--- a/drivers/lightnvm/rrpc.c
+++ b/drivers/lightnvm/rrpc.c
@@ -1199,10 +1199,11 @@ static void rrpc_luns_free(struct rrpc *rrpc)
 	kfree(rrpc->luns);
 }
 
-static int rrpc_luns_init(struct rrpc *rrpc, int lun_begin, int lun_end)
+static int rrpc_luns_init(struct rrpc *rrpc, struct list_head *lun_list)
 {
 	struct nvm_tgt_dev *dev = rrpc->dev;
 	struct nvm_geo *geo = &dev->geo;
+	struct nvm_lun *lun;
 	struct rrpc_lun *rlun;
 	int i, j, ret = -EINVAL;
 
@@ -1218,16 +1219,11 @@ static int rrpc_luns_init(struct rrpc *rrpc, int lun_begin, int lun_end)
 	if (!rrpc->luns)
 		return -ENOMEM;
 
+	i = 0;
+
 	/* 1:1 mapping */
-	for (i = 0; i < rrpc->nr_luns; i++) {
-		int lunid = lun_begin + i;
-		struct nvm_lun *lun;
-
-		lun = dev->mt->get_lun(dev->parent, lunid);
-		if (!lun)
-			goto err;
-
-		rlun = &rrpc->luns[i];
+	list_for_each_entry(lun, lun_list, list) {
+		rlun = &rrpc->luns[i++];
 		rlun->parent = lun;
 		rlun->blocks = vzalloc(sizeof(struct rrpc_block) *
 							geo->blks_per_lun);
@@ -1256,6 +1252,8 @@ static int rrpc_luns_init(struct rrpc *rrpc, int lun_begin, int lun_end)
 		spin_lock_init(&rlun->lock);
 	}
 
+	WARN_ON(i != rrpc->nr_luns);
+
 	return 0;
 err:
 	return ret;
@@ -1410,12 +1408,13 @@ static int rrpc_luns_configure(struct rrpc *rrpc)
 static struct nvm_tgt_type tt_rrpc;
 
 static void *rrpc_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
-						int lun_begin, int lun_end)
+						struct list_head *lun_list)
 {
 	struct request_queue *bqueue = dev->q;
 	struct request_queue *tqueue = tdisk->queue;
 	struct nvm_geo *geo = &dev->geo;
 	struct rrpc *rrpc;
+	int lun_begin = (list_first_entry(lun_list, struct nvm_lun, list))->id;
 	sector_t soffset;
 	int ret;
 
@@ -1450,7 +1449,7 @@ static void *rrpc_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
 	}
 	rrpc->soffset = soffset;
 
-	ret = rrpc_luns_init(rrpc, lun_begin, lun_end);
+	ret = rrpc_luns_init(rrpc, lun_list);
 	if (ret) {
 		pr_err("nvm: rrpc: could not initialize luns\n");
 		goto err;
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 1f1588c..e56c352 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -504,8 +504,8 @@ static inline int ppa_to_slc(struct nvm_dev *dev, int slc_pg)
 
 typedef blk_qc_t (nvm_tgt_make_rq_fn)(struct request_queue *, struct bio *);
 typedef sector_t (nvm_tgt_capacity_fn)(void *);
-typedef void *(nvm_tgt_init_fn)(struct nvm_tgt_dev *, struct gendisk *, int,
-				int);
+typedef void *(nvm_tgt_init_fn)(struct nvm_tgt_dev *, struct gendisk *,
+				struct list_head *lun_list);
 typedef void (nvm_tgt_exit_fn)(void *);
 
 struct nvm_tgt_type {
@@ -541,7 +541,6 @@ typedef int (nvmm_remove_tgt_fn)(struct nvm_dev *, struct nvm_ioctl_remove *);
 typedef int (nvmm_submit_io_fn)(struct nvm_dev *, struct nvm_rq *);
 typedef int (nvmm_erase_blk_fn)(struct nvm_dev *, struct nvm_block *, int);
 typedef void (nvmm_mark_blk_fn)(struct nvm_dev *, struct ppa_addr, int);
-typedef struct nvm_lun *(nvmm_get_lun_fn)(struct nvm_dev *, int);
 typedef void (nvmm_lun_info_print_fn)(struct nvm_dev *);
 
 typedef int (nvmm_get_area_fn)(struct nvm_dev *, sector_t *, sector_t);
@@ -563,9 +562,6 @@ struct nvmm_type {
 	/* Bad block mgmt */
 	nvmm_mark_blk_fn *mark_blk;
 
-	/* Configuration management */
-	nvmm_get_lun_fn *get_lun;
-
 	/* Statistics */
 	nvmm_lun_info_print_fn *lun_info_print;
 
-- 
2.9.3

