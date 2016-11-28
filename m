Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34292 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755598AbcK1Vju (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Nov 2016 16:39:50 -0500
Received: by mail-wm0-f65.google.com with SMTP id g23so21319217wme.1
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2016 13:39:49 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: axboe@fb.com, =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 14/23] lightnvm: manage lun partitions internally in mm
Date: Mon, 28 Nov 2016 22:39:05 +0100
Message-Id: <20161128213914.12516-15-m@bjorling.me>
In-Reply-To: <20161128213914.12516-1-m@bjorling.me>
References: <20161128213914.12516-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <jg@lightnvm.io>

LUNs are exclusively owned by targets implementing a block device FTL.
Doing this reservation requires at the moment a 2-way callback gennvm
<-> target. The reason behind this is that LUNs were not assumed to
always be exclusively owned by targets. However, this design decision
goes against I/O determinism QoS (two targets would mix I/O on the same
parallel unit in the device).

This patch makes LUN reservation as part of the target creation on the
media manager. This makes that LUNs are always exclusively owned by the
target instantiated on top of them. LUN stripping and/or sharing should
be implemented on the target itself or the layers on top.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/gennvm.c | 62 +++++++++++++++++++++++++++++++++++++----------
 drivers/lightnvm/rrpc.c   |  7 ------
 include/linux/lightnvm.h  |  6 ++---
 3 files changed, 51 insertions(+), 24 deletions(-)

diff --git a/drivers/lightnvm/gennvm.c b/drivers/lightnvm/gennvm.c
index 3572ebb..9671e11 100644
--- a/drivers/lightnvm/gennvm.c
+++ b/drivers/lightnvm/gennvm.c
@@ -35,6 +35,45 @@ static const struct block_device_operations gen_fops = {
 	.owner		= THIS_MODULE,
 };
 
+static int gen_reserve_luns(struct nvm_dev *dev, struct nvm_target *t,
+			    int lun_begin, int lun_end)
+{
+	struct gen_dev *gn = dev->mp;
+	struct nvm_lun *lun;
+	int i;
+
+	for (i = lun_begin; i <= lun_end; i++) {
+		if (test_and_set_bit(i, dev->lun_map)) {
+			pr_err("nvm: lun %d already allocated\n", i);
+			goto err;
+		}
+
+		lun = &gn->luns[i];
+		list_add_tail(&lun->list, &t->lun_list);
+	}
+
+	return 0;
+
+err:
+	while (--i > lun_begin) {
+		lun = &gn->luns[i];
+		clear_bit(i, dev->lun_map);
+		list_del(&lun->list);
+	}
+
+	return -EBUSY;
+}
+
+static void gen_release_luns(struct nvm_dev *dev, struct nvm_target *t)
+{
+	struct nvm_lun *lun, *tmp;
+
+	list_for_each_entry_safe(lun, tmp, &t->lun_list, list) {
+		WARN_ON(!test_and_clear_bit(lun->id, dev->lun_map));
+		list_del(&lun->list);
+	}
+}
+
 static int gen_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 {
 	struct gen_dev *gn = dev->mp;
@@ -64,9 +103,14 @@ static int gen_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 	if (!t)
 		return -ENOMEM;
 
+	INIT_LIST_HEAD(&t->lun_list);
+
+	if (gen_reserve_luns(dev, t, s->lun_begin, s->lun_end))
+		goto err_t;
+
 	tqueue = blk_alloc_queue_node(GFP_KERNEL, dev->q->node);
 	if (!tqueue)
-		goto err_t;
+		goto err_reserve;
 	blk_queue_make_request(tqueue, tt->make_rq);
 
 	tdisk = alloc_disk(0);
@@ -105,6 +149,8 @@ static int gen_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 	put_disk(tdisk);
 err_queue:
 	blk_cleanup_queue(tqueue);
+err_reserve:
+	gen_release_luns(dev, t);
 err_t:
 	kfree(t);
 	return -ENOMEM;
@@ -122,6 +168,7 @@ static void __gen_remove_target(struct nvm_target *t)
 	if (tt->exit)
 		tt->exit(tdisk->private_data);
 
+	gen_release_luns(t->dev, t);
 	put_disk(tdisk);
 
 	list_del(&t->list);
@@ -253,6 +300,7 @@ static int gen_luns_init(struct nvm_dev *dev, struct gen_dev *gn)
 		INIT_LIST_HEAD(&lun->free_list);
 		INIT_LIST_HEAD(&lun->used_list);
 		INIT_LIST_HEAD(&lun->bb_list);
+		INIT_LIST_HEAD(&lun->list);
 
 		spin_lock_init(&lun->lock);
 
@@ -569,16 +617,6 @@ static int gen_erase_blk(struct nvm_dev *dev, struct nvm_block *blk, int flags)
 	return nvm_erase_ppa(dev, &addr, 1, flags);
 }
 
-static int gen_reserve_lun(struct nvm_dev *dev, int lunid)
-{
-	return test_and_set_bit(lunid, dev->lun_map);
-}
-
-static void gen_release_lun(struct nvm_dev *dev, int lunid)
-{
-	WARN_ON(!test_and_clear_bit(lunid, dev->lun_map));
-}
-
 static struct nvm_lun *gen_get_lun(struct nvm_dev *dev, int lunid)
 {
 	struct gen_dev *gn = dev->mp;
@@ -625,8 +663,6 @@ static struct nvmm_type gen = {
 	.mark_blk		= gen_mark_blk,
 
 	.get_lun		= gen_get_lun,
-	.reserve_lun		= gen_reserve_lun,
-	.release_lun		= gen_release_lun,
 	.lun_info_print		= gen_lun_info_print,
 
 	.get_area		= gen_get_area,
diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
index 34d2ebf..88e0d06 100644
--- a/drivers/lightnvm/rrpc.c
+++ b/drivers/lightnvm/rrpc.c
@@ -1126,7 +1126,6 @@ static void rrpc_core_free(struct rrpc *rrpc)
 
 static void rrpc_luns_free(struct rrpc *rrpc)
 {
-	struct nvm_dev *dev = rrpc->dev;
 	struct nvm_lun *lun;
 	struct rrpc_lun *rlun;
 	int i;
@@ -1139,7 +1138,6 @@ static void rrpc_luns_free(struct rrpc *rrpc)
 		lun = rlun->parent;
 		if (!lun)
 			break;
-		dev->mt->release_lun(dev, lun->id);
 		vfree(rlun->blocks);
 	}
 
@@ -1169,11 +1167,6 @@ static int rrpc_luns_init(struct rrpc *rrpc, int lun_begin, int lun_end)
 		int lunid = lun_begin + i;
 		struct nvm_lun *lun;
 
-		if (dev->mt->reserve_lun(dev, lunid)) {
-			pr_err("rrpc: lun %u is already allocated\n", lunid);
-			goto err;
-		}
-
 		lun = dev->mt->get_lun(dev, lunid);
 		if (!lun)
 			goto err;
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 33940bd..89c6954 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -210,6 +210,7 @@ struct nvm_id {
 
 struct nvm_target {
 	struct list_head list;
+	struct list_head lun_list;
 	struct nvm_dev *dev;
 	struct nvm_tgt_type *type;
 	struct gendisk *disk;
@@ -273,6 +274,7 @@ struct nvm_lun {
 	int lun_id;
 	int chnl_id;
 
+	struct list_head list;
 	spinlock_t lock;
 
 	/* lun block lists */
@@ -521,8 +523,6 @@ typedef int (nvmm_submit_io_fn)(struct nvm_dev *, struct nvm_rq *);
 typedef int (nvmm_erase_blk_fn)(struct nvm_dev *, struct nvm_block *, int);
 typedef void (nvmm_mark_blk_fn)(struct nvm_dev *, struct ppa_addr, int);
 typedef struct nvm_lun *(nvmm_get_lun_fn)(struct nvm_dev *, int);
-typedef int (nvmm_reserve_lun)(struct nvm_dev *, int);
-typedef void (nvmm_release_lun)(struct nvm_dev *, int);
 typedef void (nvmm_lun_info_print_fn)(struct nvm_dev *);
 
 typedef int (nvmm_get_area_fn)(struct nvm_dev *, sector_t *, sector_t);
@@ -550,8 +550,6 @@ struct nvmm_type {
 
 	/* Configuration management */
 	nvmm_get_lun_fn *get_lun;
-	nvmm_reserve_lun *reserve_lun;
-	nvmm_release_lun *release_lun;
 
 	/* Statistics */
 	nvmm_lun_info_print_fn *lun_info_print;
-- 
2.9.3

