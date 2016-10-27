Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37044 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942928AbcJ0OuQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Oct 2016 10:50:16 -0400
Received: by mail-wm0-f49.google.com with SMTP id 140so28758653wmv.0
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2016 07:50:15 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 4/7] lightnvm: drop reserve and release LUN callbacks
Date: Thu, 27 Oct 2016 16:49:40 +0200
Message-Id: <1477579783-5289-4-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1477579783-5289-1-git-send-email-javier@cnexlabs.com>
References: <1477579783-5289-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On target initialization, targets use callbacks to the media manager to
configure the LUNs they use. In order to simplify the flow, drop this
callbacks and manage everything internally on the media manager.

By making use of the newly introduce LUN management structure, the media
manager knows which target exclusively owns each target and can
therefore allocate and free all the necessary structures before
initializing the target. Not exclusively owned LUNs belong to the media
manager in any case.

Adapt rrpc to not use the reserve_lun/release_lun callback functions.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/gennvm.c | 62 +++++++++++++++++++++++++++++++++++------------
 drivers/lightnvm/rrpc.c   | 12 +--------
 include/linux/lightnvm.h  |  5 +---
 3 files changed, 49 insertions(+), 30 deletions(-)

diff --git a/drivers/lightnvm/gennvm.c b/drivers/lightnvm/gennvm.c
index 8bff725..575afc4 100644
--- a/drivers/lightnvm/gennvm.c
+++ b/drivers/lightnvm/gennvm.c
@@ -35,6 +35,30 @@ static const struct block_device_operations gen_fops = {
 	.owner		= THIS_MODULE,
 };
 
+static int gen_reserve_luns(struct nvm_dev *dev, int lun_begin, int lun_end,
+			    struct nvm_target *t)
+{
+	struct gen_dev *gn = dev->mp;
+	struct gen_lun *lun;
+	int i;
+
+	for (i = lun_begin; i <= lun_end; i++) {
+		if (test_and_set_bit(i, dev->lun_map)) {
+			pr_err("gennvm: lun %d is already allocated\n", i);
+			goto fail;
+		}
+
+		lun = &gn->luns[i];
+	}
+
+	return 0;
+fail:
+	while (--i > lun_begin)
+		clear_bit(i, dev->lun_map);
+
+	return 1;
+}
+
 static int gen_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 {
 	struct gen_dev *gn = dev->mp;
@@ -80,6 +104,9 @@ static int gen_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 	tdisk->fops = &gen_fops;
 	tdisk->queue = tqueue;
 
+	if (tt->exclusive && gen_reserve_luns(dev, s->lun_begin, s->lun_end, t))
+		goto err_init;
+
 	targetdata = tt->init(dev, tdisk, s->lun_begin, s->lun_end);
 	if (IS_ERR(targetdata))
 		goto err_init;
@@ -110,7 +137,23 @@ err_t:
 	return -ENOMEM;
 }
 
-static void __gen_remove_target(struct nvm_target *t)
+static void gen_release_luns(struct nvm_dev *dev, struct nvm_target *t)
+{
+	struct gen_dev *gn = dev->mp;
+	struct gen_lun *lun;
+	int lunid;
+	int i;
+
+	gen_for_each_lun(gn, lun, i) {
+		if (lun->tgt != t)
+			continue;
+
+		lunid = lun->vlun.id;
+		WARN_ON(!test_and_clear_bit(lunid, dev->lun_map));
+	}
+}
+
+static void __gen_remove_target(struct nvm_dev *dev, struct nvm_target *t)
 {
 	struct nvm_tgt_type *tt = t->type;
 	struct gendisk *tdisk = t->disk;
@@ -122,6 +165,7 @@ static void __gen_remove_target(struct nvm_target *t)
 	if (tt->exit)
 		tt->exit(tdisk->private_data);
 
+	gen_release_luns(dev, t);
 	put_disk(tdisk);
 
 	list_del(&t->list);
@@ -152,7 +196,7 @@ static int gen_remove_tgt(struct nvm_dev *dev, struct nvm_ioctl_remove *remove)
 		mutex_unlock(&gn->lock);
 		return 1;
 	}
-	__gen_remove_target(t);
+	__gen_remove_target(dev, t);
 	mutex_unlock(&gn->lock);
 
 	return 0;
@@ -474,7 +518,7 @@ static void gen_unregister(struct nvm_dev *dev)
 	list_for_each_entry_safe(t, tmp, &gn->targets, list) {
 		if (t->dev != dev)
 			continue;
-		__gen_remove_target(t);
+		__gen_remove_target(dev, t);
 	}
 	mutex_unlock(&gn->lock);
 
@@ -618,16 +662,6 @@ static int gen_erase_blk(struct nvm_dev *dev, struct nvm_block *blk, int flags)
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
@@ -674,8 +708,6 @@ static struct nvmm_type gen = {
 	.mark_blk		= gen_mark_blk,
 
 	.get_lun		= gen_get_lun,
-	.reserve_lun		= gen_reserve_lun,
-	.release_lun		= gen_release_lun,
 	.lun_info_print		= gen_lun_info_print,
 
 	.get_area		= gen_get_area,
diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
index f293d00..cb30ccf 100644
--- a/drivers/lightnvm/rrpc.c
+++ b/drivers/lightnvm/rrpc.c
@@ -1167,8 +1167,6 @@ static void rrpc_core_free(struct rrpc *rrpc)
 
 static void rrpc_luns_free(struct rrpc *rrpc)
 {
-	struct nvm_dev *dev = rrpc->dev;
-	struct nvm_lun *lun;
 	struct rrpc_lun *rlun;
 	int i;
 
@@ -1177,10 +1175,6 @@ static void rrpc_luns_free(struct rrpc *rrpc)
 
 	for (i = 0; i < rrpc->nr_luns; i++) {
 		rlun = &rrpc->luns[i];
-		lun = rlun->parent;
-		if (!lun)
-			break;
-		dev->mt->release_lun(dev, lun->id);
 		vfree(rlun->blocks);
 	}
 
@@ -1210,11 +1204,6 @@ static int rrpc_luns_init(struct rrpc *rrpc, int lun_begin, int lun_end)
 		int lunid = lun_begin + i;
 		struct nvm_lun *lun;
 
-		if (dev->mt->reserve_lun(dev, lunid)) {
-			pr_err("rrpc: lun %u is already allocated\n", lunid);
-			goto err;
-		}
-
 		lun = dev->mt->get_lun(dev, lunid);
 		if (!lun) {
 			pr_err("rrpc: cannot get lun %d\n", lun->id);
@@ -1508,6 +1497,7 @@ err:
 static struct nvm_tgt_type tt_rrpc = {
 	.name		= "rrpc",
 	.version	= {1, 0, 0},
+	.exclusive	= 1,
 
 	.make_rq	= rrpc_make_rq,
 	.capacity	= rrpc_capacity,
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 14c6fa5..1957829 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -438,6 +438,7 @@ typedef void (nvm_tgt_exit_fn)(void *);
 struct nvm_tgt_type {
 	const char *name;
 	unsigned int version[3];
+	int exclusive;
 
 	/* target entry points */
 	nvm_tgt_make_rq_fn *make_rq;
@@ -487,8 +488,6 @@ typedef int (nvmm_submit_io_fn)(struct nvm_dev *, struct nvm_rq *);
 typedef int (nvmm_erase_blk_fn)(struct nvm_dev *, struct nvm_block *, int);
 typedef void (nvmm_mark_blk_fn)(struct nvm_dev *, struct ppa_addr, int);
 typedef struct nvm_lun *(nvmm_get_lun_fn)(struct nvm_dev *, int);
-typedef int (nvmm_reserve_lun)(struct nvm_dev *, int);
-typedef void (nvmm_release_lun)(struct nvm_dev *, int);
 typedef void (nvmm_lun_info_print_fn)(struct nvm_dev *);
 
 typedef int (nvmm_get_area_fn)(struct nvm_dev *, sector_t *, sector_t);
@@ -519,8 +518,6 @@ struct nvmm_type {
 
 	/* Configuration management */
 	nvmm_get_lun_fn *get_lun;
-	nvmm_reserve_lun *reserve_lun;
-	nvmm_release_lun *release_lun;
 
 	/* Statistics */
 	nvmm_lun_info_print_fn *lun_info_print;
-- 
2.7.4

