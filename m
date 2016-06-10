Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35804 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932602AbcFJMXB (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Fri, 10 Jun 2016 08:23:01 -0400
Received: by mail-wm0-f67.google.com with SMTP id k184so17508096wme.2
        for <linux-block@vger.kernel.org>; Fri, 10 Jun 2016 05:23:00 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	axboe@fb.com, keith.busch@intel.com, linux-nvme@lists.infradead.org
Cc: "Simon A. F. Lund" <slund@cnexlabs.com>,
	=?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 6/6] lightnvm: expose gennvm target type through sysfs
Date: Fri, 10 Jun 2016 14:22:52 +0200
Message-Id: <1465561372-19748-1-git-send-email-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: "Simon A. F. Lund" <slund@cnexlabs.com>

Create a sysfs directory for targets to expose their internal statistics
and knobs. The entries is exposed through the
/sys/block/<disk>/lightnvm/* directory.

It currently holds a single sysfs entry "type", which exports the target
type name.

Signed-off-by: Simon A. F. Lund <slund@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/gennvm.c | 112 ++++++++++++++++++++++++++++++++++++++--------
 include/linux/lightnvm.h  |  10 +++++
 2 files changed, 104 insertions(+), 18 deletions(-)

diff --git a/drivers/lightnvm/gennvm.c b/drivers/lightnvm/gennvm.c
index b74174c..bfdad3c 100644
--- a/drivers/lightnvm/gennvm.c
+++ b/drivers/lightnvm/gennvm.c
@@ -20,6 +20,87 @@
 
 #include "gennvm.h"
 
+static struct attribute gen_type_attr = {
+	.name = "type",
+	.mode = S_IRUGO
+};
+
+static struct attribute *gen_target_attrs[] = {
+	&gen_type_attr,
+	NULL,
+};
+
+static ssize_t gen_target_attr_show(struct kobject *kobj,
+				struct attribute *attr,
+				char *page)
+{
+	struct nvm_target *t = container_of(kobj, struct nvm_target, kobj);
+
+	if (strcmp(attr->name, "type") == 0)
+		return scnprintf(page, PAGE_SIZE, "%s\n", t->type->name);
+
+	if (t->type->sysfs_show)
+		return t->type->sysfs_show(t, attr, page);
+
+	return scnprintf(page, PAGE_SIZE,
+			"Unhandled attr(%s) in `nvm_target_attr_show`\n",
+			attr->name);
+}
+
+static const struct sysfs_ops target_sysfs_ops = {
+	.show = gen_target_attr_show,
+};
+
+static void gen_target_release(struct kobject *kobj)
+{
+	struct nvm_target *t = container_of(kobj, struct nvm_target, kobj);
+	struct nvm_tgt_type *tt = t->type;
+	struct gendisk *tdisk = t->disk;
+	struct request_queue *q = tdisk->queue;
+
+	pr_debug("gen: `gen_target_release`\n");
+
+	del_gendisk(tdisk);
+	blk_cleanup_queue(q);
+	put_disk(tdisk);
+
+	if (tt->exit)
+		tt->exit(tdisk->private_data);
+
+	kfree(t);
+}
+
+static struct kobj_type nvm_target_type = {
+	.sysfs_ops	= &target_sysfs_ops,
+	.default_attrs	= gen_target_attrs,
+	.release	= gen_target_release
+};
+
+void gen_unregister_target(struct nvm_target *t)
+{
+	kobject_uevent(&t->kobj, KOBJ_REMOVE);
+	kobject_del(&t->kobj);
+	kobject_put(&t->kobj);
+}
+
+int gen_register_target(struct nvm_target *t)
+{
+	struct gendisk *disk = t->disk;
+	struct device *dev = disk_to_dev(disk);
+	int ret;
+
+	ret = kobject_init_and_add(&t->kobj, &nvm_target_type,
+				   kobject_get(&dev->kobj), "%s", "lightnvm");
+	if (ret < 0) {
+		pr_err("gen: `_register_target` failed.\n");
+		kobject_put(&t->kobj);
+		return ret;
+	}
+
+	kobject_uevent(&t->kobj, KOBJ_ADD);
+	return 0;
+}
+
 static struct nvm_target *gen_find_target(struct gen_dev *gn, const char *name)
 {
 	struct nvm_target *tgt;
@@ -60,7 +141,7 @@ static int gen_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 	}
 	mutex_unlock(&gn->lock);
 
-	t = kmalloc(sizeof(struct nvm_target), GFP_KERNEL);
+	t = kzalloc(sizeof(struct nvm_target), GFP_KERNEL);
 	if (!t)
 		return -ENOMEM;
 
@@ -89,13 +170,19 @@ static int gen_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 
 	blk_queue_max_hw_sectors(tqueue, 8 * dev->ops->max_phys_sect);
 
-	set_capacity(tdisk, tt->capacity(targetdata));
-	add_disk(tdisk);
-
 	t->type = tt;
 	t->disk = tdisk;
 	t->dev = dev;
 
+	set_capacity(tdisk, tt->capacity(targetdata));
+	add_disk(tdisk);
+
+	if (gen_register_target(t))
+		goto err_init;
+
+	if (tt->sysfs_init)
+		tt->sysfs_init(t);
+
 	mutex_lock(&gn->lock);
 	list_add_tail(&t->list, &gn->targets);
 	mutex_unlock(&gn->lock);
@@ -112,20 +199,10 @@ err_t:
 
 static void __gen_remove_target(struct nvm_target *t)
 {
-	struct nvm_tgt_type *tt = t->type;
-	struct gendisk *tdisk = t->disk;
-	struct request_queue *q = tdisk->queue;
-
-	del_gendisk(tdisk);
-	blk_cleanup_queue(q);
-
-	if (tt->exit)
-		tt->exit(tdisk->private_data);
-
-	put_disk(tdisk);
-
 	list_del(&t->list);
-	kfree(t);
+	if (t->type->sysfs_exit)
+		t->type->sysfs_exit(t);
+	gen_unregister_target(t);
 }
 
 /**
@@ -627,7 +704,6 @@ static void gen_lun_info_print(struct nvm_dev *dev)
 	struct gen_lun *lun;
 	unsigned int i;
 
-
 	gen_for_each_lun(gn, lun, i) {
 		spin_lock(&lun->vlun.lock);
 
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index d190786..3823891 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -211,6 +211,8 @@ struct nvm_target {
 	struct nvm_dev *dev;
 	struct nvm_tgt_type *type;
 	struct gendisk *disk;
+
+	struct kobject kobj;
 };
 
 struct nvm_tgt_instance {
@@ -434,6 +436,10 @@ typedef blk_qc_t (nvm_tgt_make_rq_fn)(struct request_queue *, struct bio *);
 typedef sector_t (nvm_tgt_capacity_fn)(void *);
 typedef void *(nvm_tgt_init_fn)(struct nvm_dev *, struct gendisk *, int, int);
 typedef void (nvm_tgt_exit_fn)(void *);
+typedef void (nvm_tgt_sysfs_init_fn)(struct nvm_target *);
+typedef void (nvm_tgt_sysfs_exit_fn)(struct nvm_target *);
+typedef ssize_t(nvm_tgt_sysfs_show_fn)(struct nvm_target *,
+				     struct attribute *, char *);
 
 struct nvm_tgt_type {
 	const char *name;
@@ -448,6 +454,10 @@ struct nvm_tgt_type {
 	nvm_tgt_init_fn *init;
 	nvm_tgt_exit_fn *exit;
 
+	nvm_tgt_sysfs_init_fn *sysfs_init;
+	nvm_tgt_sysfs_exit_fn *sysfs_exit;
+	nvm_tgt_sysfs_show_fn *sysfs_show;
+
 	/* For internal use */
 	struct list_head list;
 };
-- 
2.1.4

