Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34622 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513AbcFFOqO (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Mon, 6 Jun 2016 10:46:14 -0400
Received: by mail-wm0-f68.google.com with SMTP id n184so17078144wmn.1
        for <linux-block@vger.kernel.org>; Mon, 06 Jun 2016 07:46:13 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Simon Lund <slund@cnexlabs.com>,
	=?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [RFC PATCH 6/6] lightnvm: expose gennvm target type through sysfs
Date: Mon,  6 Jun 2016 16:46:03 +0200
Message-Id: <1465224363-25797-7-git-send-email-m@bjorling.me>
In-Reply-To: <1465224363-25797-1-git-send-email-m@bjorling.me>
References: <1465224363-25797-1-git-send-email-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Simon Lund <slund@cnexlabs.com>

Create a sysfs directory for targets to expose their internal statistics
and knobs. The entries is exposed through the
/sys/block/<disk>/lightnvm/* directory.

It currently holds a single sysfs entry "type", which exports the target
type name.

Signed-off-by: Simon Lund <slund@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/gennvm.c | 109 ++++++++++++++++++++++++++++++++++++++--------
 include/linux/lightnvm.h  |   2 +
 2 files changed, 94 insertions(+), 17 deletions(-)

diff --git a/drivers/lightnvm/gennvm.c b/drivers/lightnvm/gennvm.c
index b74174c..c48bc9c 100644
--- a/drivers/lightnvm/gennvm.c
+++ b/drivers/lightnvm/gennvm.c
@@ -20,6 +20,90 @@
 
 #include "gennvm.h"
 
+#define GEN_TARGET_ATTR_RO(_name)					\
+	static struct attribute gen_target_##_name##_attr = {		\
+	.name = __stringify(_name),					\
+	.mode = S_IRUGO							\
+	}
+
+#define GEN_TARGET_ATTR_LIST(_name) (&gen_target_##_name##_attr)
+
+GEN_TARGET_ATTR_RO(type);
+
+static struct attribute *gen_target_attrs[] = {
+	GEN_TARGET_ATTR_LIST(type),
+	NULL,
+};
+
+static ssize_t gen_target_attr_show(struct kobject *kobj,
+				struct attribute *attr,
+				char *page)
+{
+	struct nvm_target *t = container_of(kobj, struct nvm_target, kobj);
+
+	if (strcmp(attr->name, "type") == 0) {
+		return scnprintf(page, PAGE_SIZE, "%s\n", t->type->name);
+	} else {
+		return scnprintf(page, PAGE_SIZE,
+			"Unhandled attr(%s) in `nvm_target_attr_show`\n",
+			attr->name);
+	}
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
@@ -60,7 +144,7 @@ static int gen_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 	}
 	mutex_unlock(&gn->lock);
 
-	t = kmalloc(sizeof(struct nvm_target), GFP_KERNEL);
+	t = kzalloc(sizeof(struct nvm_target), GFP_KERNEL);
 	if (!t)
 		return -ENOMEM;
 
@@ -89,13 +173,16 @@ static int gen_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 
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
 	mutex_lock(&gn->lock);
 	list_add_tail(&t->list, &gn->targets);
 	mutex_unlock(&gn->lock);
@@ -112,20 +199,8 @@ err_t:
 
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
+	gen_unregister_target(t);
 }
 
 /**
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index d190786..646ca24 100644
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
-- 
2.1.4

