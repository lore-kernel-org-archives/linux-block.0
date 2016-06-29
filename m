Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33095 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638AbcF2OmX (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Wed, 29 Jun 2016 10:42:23 -0400
Received: by mail-wm0-f66.google.com with SMTP id r201so14878557wme.0
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2016 07:42:14 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [RFC PATCH 05/11] lightnvm: move target mgmt into media mgr
Date: Wed, 29 Jun 2016 16:41:50 +0200
Message-Id: <1467211316-22373-6-git-send-email-m@bjorling.me>
In-Reply-To: <1467211316-22373-1-git-send-email-m@bjorling.me>
References: <1467211316-22373-1-git-send-email-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

To enable persistent block management to easily control creation and
removal of targets, we move target management into the media
manager. The LightNVM core continues to maintain which target types are
registered, while the media manager now keeps track of its initialized
targets.

Two new callbacks for the media manager are introduced. create_tgt and
remove_tgt. Note that remove_tgt returns 0 on successfully removing a
target, and returns 1 if the target was not found.

Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/core.c   | 198 +++++++++-------------------------------------
 drivers/lightnvm/gennvm.c | 154 ++++++++++++++++++++++++++++++++++++
 drivers/lightnvm/gennvm.h |   3 +
 include/linux/lightnvm.h  |  10 +++
 4 files changed, 206 insertions(+), 159 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 0da196f..8afb04c 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -18,8 +18,6 @@
  *
  */
 
-#include <linux/blkdev.h>
-#include <linux/blk-mq.h>
 #include <linux/list.h>
 #include <linux/types.h>
 #include <linux/sem.h>
@@ -28,42 +26,37 @@
 #include <linux/miscdevice.h>
 #include <linux/lightnvm.h>
 #include <linux/sched/sysctl.h>
-#include <uapi/linux/lightnvm.h>
 
 static LIST_HEAD(nvm_tgt_types);
 static LIST_HEAD(nvm_mgrs);
 static LIST_HEAD(nvm_devices);
-static LIST_HEAD(nvm_targets);
 static DECLARE_RWSEM(nvm_lock);
 
-static struct nvm_target *nvm_find_target(const char *name)
+struct nvm_tgt_type *nvm_find_target_type(const char *name, int lock)
 {
-	struct nvm_target *tgt;
+	struct nvm_tgt_type *tmp, *tt = NULL;
 
-	list_for_each_entry(tgt, &nvm_targets, list)
-		if (!strcmp(name, tgt->disk->disk_name))
-			return tgt;
+	if (lock)
+		down_write(&nvm_lock);
 
-	return NULL;
-}
-
-static struct nvm_tgt_type *nvm_find_target_type(const char *name)
-{
-	struct nvm_tgt_type *tt;
-
-	list_for_each_entry(tt, &nvm_tgt_types, list)
-		if (!strcmp(name, tt->name))
-			return tt;
+	list_for_each_entry(tmp, &nvm_tgt_types, list)
+		if (!strcmp(name, tmp->name)) {
+			tt = tmp;
+			break;
+		}
 
-	return NULL;
+	if (lock)
+		up_write(&nvm_lock);
+	return tt;
 }
+EXPORT_SYMBOL(nvm_find_target_type);
 
 int nvm_register_tgt_type(struct nvm_tgt_type *tt)
 {
 	int ret = 0;
 
 	down_write(&nvm_lock);
-	if (nvm_find_target_type(tt->name))
+	if (nvm_find_target_type(tt->name, 0))
 		ret = -EEXIST;
 	else
 		list_add(&tt->list, &nvm_tgt_types);
@@ -605,42 +598,11 @@ err_fmtype:
 	return ret;
 }
 
-static void nvm_remove_target(struct nvm_target *t)
-{
-	struct nvm_tgt_type *tt = t->type;
-	struct gendisk *tdisk = t->disk;
-	struct request_queue *q = tdisk->queue;
-
-	lockdep_assert_held(&nvm_lock);
-
-	del_gendisk(tdisk);
-	blk_cleanup_queue(q);
-
-	if (tt->exit)
-		tt->exit(tdisk->private_data);
-
-	put_disk(tdisk);
-
-	list_del(&t->list);
-	kfree(t);
-}
-
 static void nvm_free_mgr(struct nvm_dev *dev)
 {
-	struct nvm_target *tgt, *tmp;
-
 	if (!dev->mt)
 		return;
 
-	down_write(&nvm_lock);
-	list_for_each_entry_safe(tgt, tmp, &nvm_targets, list) {
-		if (tgt->dev != dev)
-			continue;
-
-		nvm_remove_target(tgt);
-	}
-	up_write(&nvm_lock);
-
 	dev->mt->unregister_mgr(dev);
 	dev->mt = NULL;
 }
@@ -787,91 +749,6 @@ void nvm_unregister(char *disk_name)
 }
 EXPORT_SYMBOL(nvm_unregister);
 
-static const struct block_device_operations nvm_fops = {
-	.owner		= THIS_MODULE,
-};
-
-static int nvm_create_target(struct nvm_dev *dev,
-						struct nvm_ioctl_create *create)
-{
-	struct nvm_ioctl_create_simple *s = &create->conf.s;
-	struct request_queue *tqueue;
-	struct gendisk *tdisk;
-	struct nvm_tgt_type *tt;
-	struct nvm_target *t;
-	void *targetdata;
-
-	if (!dev->mt) {
-		pr_info("nvm: device has no media manager registered.\n");
-		return -ENODEV;
-	}
-
-	down_write(&nvm_lock);
-	tt = nvm_find_target_type(create->tgttype);
-	if (!tt) {
-		pr_err("nvm: target type %s not found\n", create->tgttype);
-		up_write(&nvm_lock);
-		return -EINVAL;
-	}
-
-	t = nvm_find_target(create->tgtname);
-	if (t) {
-		pr_err("nvm: target name already exists.\n");
-		up_write(&nvm_lock);
-		return -EINVAL;
-	}
-	up_write(&nvm_lock);
-
-	t = kmalloc(sizeof(struct nvm_target), GFP_KERNEL);
-	if (!t)
-		return -ENOMEM;
-
-	tqueue = blk_alloc_queue_node(GFP_KERNEL, dev->q->node);
-	if (!tqueue)
-		goto err_t;
-	blk_queue_make_request(tqueue, tt->make_rq);
-
-	tdisk = alloc_disk(0);
-	if (!tdisk)
-		goto err_queue;
-
-	sprintf(tdisk->disk_name, "%s", create->tgtname);
-	tdisk->flags = GENHD_FL_EXT_DEVT;
-	tdisk->major = 0;
-	tdisk->first_minor = 0;
-	tdisk->fops = &nvm_fops;
-	tdisk->queue = tqueue;
-
-	targetdata = tt->init(dev, tdisk, s->lun_begin, s->lun_end);
-	if (IS_ERR(targetdata))
-		goto err_init;
-
-	tdisk->private_data = targetdata;
-	tqueue->queuedata = targetdata;
-
-	blk_queue_max_hw_sectors(tqueue, 8 * dev->ops->max_phys_sect);
-
-	set_capacity(tdisk, tt->capacity(targetdata));
-	add_disk(tdisk);
-
-	t->type = tt;
-	t->disk = tdisk;
-	t->dev = dev;
-
-	down_write(&nvm_lock);
-	list_add_tail(&t->list, &nvm_targets);
-	up_write(&nvm_lock);
-
-	return 0;
-err_init:
-	put_disk(tdisk);
-err_queue:
-	blk_cleanup_queue(tqueue);
-err_t:
-	kfree(t);
-	return -ENOMEM;
-}
-
 static int __nvm_configure_create(struct nvm_ioctl_create *create)
 {
 	struct nvm_dev *dev;
@@ -880,11 +757,17 @@ static int __nvm_configure_create(struct nvm_ioctl_create *create)
 	down_write(&nvm_lock);
 	dev = nvm_find_nvm_dev(create->dev);
 	up_write(&nvm_lock);
+
 	if (!dev) {
 		pr_err("nvm: device not found\n");
 		return -EINVAL;
 	}
 
+	if (!dev->mt) {
+		pr_info("nvm: device has no media manager registered.\n");
+		return -ENODEV;
+	}
+
 	if (create->conf.type != NVM_CONFIG_TYPE_SIMPLE) {
 		pr_err("nvm: config type not valid\n");
 		return -EINVAL;
@@ -897,25 +780,7 @@ static int __nvm_configure_create(struct nvm_ioctl_create *create)
 		return -EINVAL;
 	}
 
-	return nvm_create_target(dev, create);
-}
-
-static int __nvm_configure_remove(struct nvm_ioctl_remove *remove)
-{
-	struct nvm_target *t;
-
-	down_write(&nvm_lock);
-	t = nvm_find_target(remove->tgtname);
-	if (!t) {
-		pr_err("nvm: target \"%s\" doesn't exist.\n", remove->tgtname);
-		up_write(&nvm_lock);
-		return -EINVAL;
-	}
-
-	nvm_remove_target(t);
-	up_write(&nvm_lock);
-
-	return 0;
+	return dev->mt->create_tgt(dev, create);
 }
 
 #ifdef CONFIG_NVM_DEBUG
@@ -950,8 +815,9 @@ static int nvm_configure_show(const char *val)
 static int nvm_configure_remove(const char *val)
 {
 	struct nvm_ioctl_remove remove;
+	struct nvm_dev *dev;
 	char opcode;
-	int ret;
+	int ret = 0;
 
 	ret = sscanf(val, "%c %256s", &opcode, remove.tgtname);
 	if (ret != 2) {
@@ -961,7 +827,13 @@ static int nvm_configure_remove(const char *val)
 
 	remove.flags = 0;
 
-	return __nvm_configure_remove(&remove);
+	list_for_each_entry(dev, &nvm_devices, devices) {
+		ret = dev->mt->remove_tgt(dev, &remove);
+		if (!ret)
+			break;
+	}
+
+	return ret;
 }
 
 static int nvm_configure_create(const char *val)
@@ -1158,6 +1030,8 @@ static long nvm_ioctl_dev_create(struct file *file, void __user *arg)
 static long nvm_ioctl_dev_remove(struct file *file, void __user *arg)
 {
 	struct nvm_ioctl_remove remove;
+	struct nvm_dev *dev;
+	int ret = 0;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -1172,7 +1046,13 @@ static long nvm_ioctl_dev_remove(struct file *file, void __user *arg)
 		return -EINVAL;
 	}
 
-	return __nvm_configure_remove(&remove);
+	list_for_each_entry(dev, &nvm_devices, devices) {
+		ret = dev->mt->remove_tgt(dev, &remove);
+		if (!ret)
+			break;
+	}
+
+	return ret;
 }
 
 static void nvm_setup_nvm_sb_info(struct nvm_sb_info *info)
diff --git a/drivers/lightnvm/gennvm.c b/drivers/lightnvm/gennvm.c
index 3d2762f..41760b2 100644
--- a/drivers/lightnvm/gennvm.c
+++ b/drivers/lightnvm/gennvm.c
@@ -20,6 +20,144 @@
 
 #include "gennvm.h"
 
+static struct nvm_target *gen_find_target(struct gen_dev *gn, const char *name)
+{
+	struct nvm_target *tgt;
+
+	list_for_each_entry(tgt, &gn->targets, list)
+		if (!strcmp(name, tgt->disk->disk_name))
+			return tgt;
+
+	return NULL;
+}
+
+static const struct block_device_operations gen_fops = {
+	.owner		= THIS_MODULE,
+};
+
+static int gen_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
+{
+	struct gen_dev *gn = dev->mp;
+	struct nvm_ioctl_create_simple *s = &create->conf.s;
+	struct request_queue *tqueue;
+	struct gendisk *tdisk;
+	struct nvm_tgt_type *tt;
+	struct nvm_target *t;
+	void *targetdata;
+
+	tt = nvm_find_target_type(create->tgttype, 1);
+	if (!tt) {
+		pr_err("nvm: target type %s not found\n", create->tgttype);
+		return -EINVAL;
+	}
+
+	mutex_lock(&gn->lock);
+	t = gen_find_target(gn, create->tgtname);
+	if (t) {
+		pr_err("nvm: target name already exists.\n");
+		mutex_unlock(&gn->lock);
+		return -EINVAL;
+	}
+	mutex_unlock(&gn->lock);
+
+	t = kmalloc(sizeof(struct nvm_target), GFP_KERNEL);
+	if (!t)
+		return -ENOMEM;
+
+	tqueue = blk_alloc_queue_node(GFP_KERNEL, dev->q->node);
+	if (!tqueue)
+		goto err_t;
+	blk_queue_make_request(tqueue, tt->make_rq);
+
+	tdisk = alloc_disk(0);
+	if (!tdisk)
+		goto err_queue;
+
+	sprintf(tdisk->disk_name, "%s", create->tgtname);
+	tdisk->flags = GENHD_FL_EXT_DEVT;
+	tdisk->major = 0;
+	tdisk->first_minor = 0;
+	tdisk->fops = &gen_fops;
+	tdisk->queue = tqueue;
+
+	targetdata = tt->init(dev, tdisk, s->lun_begin, s->lun_end);
+	if (IS_ERR(targetdata))
+		goto err_init;
+
+	tdisk->private_data = targetdata;
+	tqueue->queuedata = targetdata;
+
+	blk_queue_max_hw_sectors(tqueue, 8 * dev->ops->max_phys_sect);
+
+	set_capacity(tdisk, tt->capacity(targetdata));
+	add_disk(tdisk);
+
+	t->type = tt;
+	t->disk = tdisk;
+	t->dev = dev;
+
+	mutex_lock(&gn->lock);
+	list_add_tail(&t->list, &gn->targets);
+	mutex_unlock(&gn->lock);
+
+	return 0;
+err_init:
+	put_disk(tdisk);
+err_queue:
+	blk_cleanup_queue(tqueue);
+err_t:
+	kfree(t);
+	return -ENOMEM;
+}
+
+static void __gen_remove_target(struct nvm_target *t)
+{
+	struct nvm_tgt_type *tt = t->type;
+	struct gendisk *tdisk = t->disk;
+	struct request_queue *q = tdisk->queue;
+
+	del_gendisk(tdisk);
+	blk_cleanup_queue(q);
+
+	if (tt->exit)
+		tt->exit(tdisk->private_data);
+
+	put_disk(tdisk);
+
+	list_del(&t->list);
+	kfree(t);
+}
+
+/**
+ * gen_remove_tgt - Removes a target from the media manager
+ * @dev:	device
+ * @remove:	ioctl structure with target name to remove.
+ *
+ * Returns:
+ * 0: on success
+ * 1: on not found
+ * <0: on error
+ */
+static int gen_remove_tgt(struct nvm_dev *dev, struct nvm_ioctl_remove *remove)
+{
+	struct gen_dev *gn = dev->mp;
+	struct nvm_target *t;
+
+	if (!gn)
+		return 1;
+
+	mutex_lock(&gn->lock);
+	t = gen_find_target(gn, remove->tgtname);
+	if (!t) {
+		mutex_unlock(&gn->lock);
+		return 1;
+	}
+	__gen_remove_target(t);
+	mutex_unlock(&gn->lock);
+
+	return 0;
+}
+
 static int gen_get_area(struct nvm_dev *dev, sector_t *lba, sector_t len)
 {
 	struct gen_dev *gn = dev->mp;
@@ -295,6 +433,8 @@ static int gen_register(struct nvm_dev *dev)
 	gn->dev = dev;
 	gn->nr_luns = dev->nr_luns;
 	INIT_LIST_HEAD(&gn->area_list);
+	mutex_init(&gn->lock);
+	INIT_LIST_HEAD(&gn->targets);
 	dev->mp = gn;
 
 	ret = gen_luns_init(dev, gn);
@@ -318,6 +458,17 @@ err:
 
 static void gen_unregister(struct nvm_dev *dev)
 {
+	struct gen_dev *gn = dev->mp;
+	struct nvm_target *t, *tmp;
+
+	mutex_lock(&gn->lock);
+	list_for_each_entry_safe(t, tmp, &gn->targets, list) {
+		if (t->dev != dev)
+			continue;
+		__gen_remove_target(t);
+	}
+	mutex_unlock(&gn->lock);
+
 	gen_free(dev);
 	module_put(THIS_MODULE);
 }
@@ -515,6 +666,9 @@ static struct nvmm_type gen = {
 	.register_mgr		= gen_register,
 	.unregister_mgr		= gen_unregister,
 
+	.create_tgt		= gen_create_tgt,
+	.remove_tgt		= gen_remove_tgt,
+
 	.get_blk_unlocked	= gen_get_blk_unlocked,
 	.put_blk_unlocked	= gen_put_blk_unlocked,
 
diff --git a/drivers/lightnvm/gennvm.h b/drivers/lightnvm/gennvm.h
index bf06219..8ecfa81 100644
--- a/drivers/lightnvm/gennvm.h
+++ b/drivers/lightnvm/gennvm.h
@@ -40,6 +40,9 @@ struct gen_dev {
 	int nr_luns;
 	struct gen_lun *luns;
 	struct list_head area_list;
+
+	struct mutex lock;
+	struct list_head targets;
 };
 
 struct gen_area {
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 8b51d57..d619f6d 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -1,7 +1,9 @@
 #ifndef NVM_H
 #define NVM_H
 
+#include <linux/blkdev.h>
 #include <linux/types.h>
+#include <uapi/linux/lightnvm.h>
 
 enum {
 	NVM_IO_OK = 0,
@@ -447,6 +449,8 @@ struct nvm_tgt_type {
 	struct list_head list;
 };
 
+extern struct nvm_tgt_type *nvm_find_target_type(const char *, int);
+
 extern int nvm_register_tgt_type(struct nvm_tgt_type *);
 extern void nvm_unregister_tgt_type(struct nvm_tgt_type *);
 
@@ -455,6 +459,9 @@ extern void nvm_dev_dma_free(struct nvm_dev *, void *, dma_addr_t);
 
 typedef int (nvmm_register_fn)(struct nvm_dev *);
 typedef void (nvmm_unregister_fn)(struct nvm_dev *);
+
+typedef int (nvmm_create_tgt_fn)(struct nvm_dev *, struct nvm_ioctl_create *);
+typedef int (nvmm_remove_tgt_fn)(struct nvm_dev *, struct nvm_ioctl_remove *);
 typedef struct nvm_block *(nvmm_get_blk_fn)(struct nvm_dev *,
 					      struct nvm_lun *, unsigned long);
 typedef void (nvmm_put_blk_fn)(struct nvm_dev *, struct nvm_block *);
@@ -480,6 +487,9 @@ struct nvmm_type {
 	nvmm_register_fn *register_mgr;
 	nvmm_unregister_fn *unregister_mgr;
 
+	nvmm_create_tgt_fn *create_tgt;
+	nvmm_remove_tgt_fn *remove_tgt;
+
 	/* Block administration callbacks */
 	nvmm_get_blk_fn *get_blk_unlocked;
 	nvmm_put_blk_fn *put_blk_unlocked;
-- 
2.1.4

