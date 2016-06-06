Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34615 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167AbcFFOqN (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Mon, 6 Jun 2016 10:46:13 -0400
Received: by mail-wm0-f65.google.com with SMTP id n184so17077980wmn.1
        for <linux-block@vger.kernel.org>; Mon, 06 Jun 2016 07:46:13 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Simon Lund <slund@cnexlabs.com>,
	=?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [RFC PATCH 5/6] lightnvm: expose device geometry through sysfs
Date: Mon,  6 Jun 2016 16:46:02 +0200
Message-Id: <1465224363-25797-6-git-send-email-m@bjorling.me>
In-Reply-To: <1465224363-25797-1-git-send-email-m@bjorling.me>
References: <1465224363-25797-1-git-send-email-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Simon Lund <slund@cnexlabs.com>

For a host to access an Open-Channel SSD, it has to know its geometry,
so that it writes and reads at the appropriate device bounds.

The geometry information is kept within the kernel, and not
exported to user-space for consumption. This patch exposes the
configuration through sysfs and enables user-space libraries, such as
liblightnvm, to use the sysfs implementation to get the geometry of an
Open-Channel SSD.

The sysfs entries are stored within the device hierarchy, and can be
found using the "lightnvm" device type.

An example configuration looks like this:

/sys/class/nvme/
└── nvme0n1
   ├── capabilities: 3
   ├── device_mode: 1
   ├── channel_parallelism: 0
   ├── erase_max: 1000000
   ├── erase_typ: 1000000
   ├── flash_media_type: 0
   ├── media_capabilities: 0x00000001
   ├── media_type: 0
   ├── multiplane: 0x00010101
   ├── num_blocks: 1022
   ├── num_channels: 1
   ├── num_luns: 4
   ├── num_pages: 64
   ├── num_planes: 1
   ├── page_size: 4096
   ├── prog_max: 100000
   ├── prog_typ: 100000
   ├── read_max: 10000
   ├── read_typ: 10000
   ├── sector_oob_size: 0
   ├── sector_size: 4096
   ├── media_manager: gennvm
   ├── num_groups: 1
   ├── ppa_format: 0x380830082808001010102008
   ├── vendor_opcode: 0
   └── version: 1

Signed-off-by: Simon Lund <slund@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/Makefile    |   2 +-
 drivers/lightnvm/core.c      |  20 +++--
 drivers/lightnvm/lightnvm.h  |  35 ++++++++
 drivers/lightnvm/sysfs.c     | 200 +++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/core.c     |  13 +--
 drivers/nvme/host/lightnvm.c |  12 ++-
 drivers/nvme/host/nvme.h     |   6 +-
 include/linux/lightnvm.h     |   3 +
 8 files changed, 274 insertions(+), 17 deletions(-)
 create mode 100644 drivers/lightnvm/lightnvm.h
 create mode 100644 drivers/lightnvm/sysfs.c

diff --git a/drivers/lightnvm/Makefile b/drivers/lightnvm/Makefile
index a7a0a22..1f6b652 100644
--- a/drivers/lightnvm/Makefile
+++ b/drivers/lightnvm/Makefile
@@ -2,6 +2,6 @@
 # Makefile for Open-Channel SSDs.
 #
 
-obj-$(CONFIG_NVM)		:= core.o sysblk.o
+obj-$(CONFIG_NVM)		:= core.o sysblk.o sysfs.o
 obj-$(CONFIG_NVM_GENNVM) 	+= gennvm.o
 obj-$(CONFIG_NVM_RRPC)		+= rrpc.o
diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 5736c59..f71fbb9 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -27,6 +27,8 @@
 #include <linux/lightnvm.h>
 #include <linux/sched/sysctl.h>
 
+#include "lightnvm.h"
+
 static LIST_HEAD(nvm_tgt_types);
 static DECLARE_RWSEM(nvm_tgtt_lock);
 static LIST_HEAD(nvm_mgrs);
@@ -593,15 +595,19 @@ static void nvm_free_mgr(struct nvm_dev *dev)
 	dev->mt = NULL;
 }
 
-static void nvm_free(struct nvm_dev *dev)
+void nvm_free(struct nvm_dev *dev)
 {
 	if (!dev)
 		return;
 
 	nvm_free_mgr(dev);
 
+	if (dev->dma_pool)
+		dev->ops->destroy_dma_pool(dev->dma_pool);
+
 	kfree(dev->lptbl);
 	kfree(dev->lun_map);
+	kfree(dev);
 }
 
 static int nvm_init(struct nvm_dev *dev)
@@ -648,11 +654,7 @@ err:
 
 static void nvm_exit(struct nvm_dev *dev)
 {
-	if (dev->dma_pool)
-		dev->ops->destroy_dma_pool(dev->dma_pool);
-	nvm_free(dev);
-
-	pr_info("nvm: successfully unloaded\n");
+	nvm_sysfs_unregister_dev(dev);
 }
 
 struct nvm_dev *nvm_alloc_dev(int node)
@@ -683,6 +685,10 @@ int nvm_register(struct nvm_dev *dev)
 		}
 	}
 
+	ret = nvm_sysfs_register_dev(dev);
+	if (ret)
+		goto err_ppalist;
+
 	if (dev->identity.cap & NVM_ID_DCAP_BBLKMGMT) {
 		ret = nvm_get_sysblock(dev, &dev->sb);
 		if (!ret)
@@ -699,6 +705,8 @@ int nvm_register(struct nvm_dev *dev)
 	up_write(&nvm_lock);
 
 	return 0;
+err_ppalist:
+	dev->ops->destroy_dma_pool(dev->dma_pool);
 err_init:
 	kfree(dev->lun_map);
 	return ret;
diff --git a/drivers/lightnvm/lightnvm.h b/drivers/lightnvm/lightnvm.h
new file mode 100644
index 0000000..93f1aac
--- /dev/null
+++ b/drivers/lightnvm/lightnvm.h
@@ -0,0 +1,35 @@
+/*
+ * Copyright (C) 2016 CNEX Labs. All rights reserved.
+ * Initial release: Matias Bjorling <matias@cnexlabs.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; see the file COPYING.  If not, write to
+ * the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139,
+ * USA.
+ *
+ */
+
+#ifndef LIGHTNVM_H
+#define LIGHTNVM_H
+
+#include <linux/lightnvm.h>
+
+/* core -> sysfs.c */
+int nvm_sysfs_register_dev(struct nvm_dev *);
+void nvm_sysfs_unregister_dev(struct nvm_dev *);
+int nvm_sysfs_register(void);
+void nvm_sysfs_unregister(void);
+
+/* sysfs > core */
+void nvm_free(struct nvm_dev *);
+
+#endif
diff --git a/drivers/lightnvm/sysfs.c b/drivers/lightnvm/sysfs.c
new file mode 100644
index 0000000..82d340a
--- /dev/null
+++ b/drivers/lightnvm/sysfs.c
@@ -0,0 +1,200 @@
+#include <linux/kernel.h>
+#include <linux/lightnvm.h>
+#include <linux/miscdevice.h>
+#include <linux/kobject.h>
+#include <linux/blk-mq.h>
+
+#include "lightnvm.h"
+
+static ssize_t nvm_dev_attr_show(struct device *dev,
+				 struct device_attribute *dattr, char *page)
+{
+	struct nvm_dev *ndev = container_of(dev, struct nvm_dev, dev);
+	struct nvm_id *id = &ndev->identity;
+	struct nvm_id_group *grp = &id->groups[0];
+	struct attribute *attr = &dattr->attr;
+
+	if (strcmp(attr->name, "version") == 0) {
+		return scnprintf(page, PAGE_SIZE, "%u\n", id->ver_id);
+	} else if (strcmp(attr->name, "vendor_opcode") == 0) {
+		return scnprintf(page, PAGE_SIZE, "%u\n", id->vmnt);
+	} else if (strcmp(attr->name, "num_groups") == 0) {
+		return scnprintf(page, PAGE_SIZE, "%u\n", id->cgrps);
+	} else if (strcmp(attr->name, "capabilities") == 0) {
+		return scnprintf(page, PAGE_SIZE, "%u\n", id->cap);
+	} else if (strcmp(attr->name, "device_mode") == 0) {
+		return scnprintf(page, PAGE_SIZE, "%u\n", id->dom);
+	} else if (strcmp(attr->name, "media_manager") == 0) {
+		if (!ndev->mt)
+			return scnprintf(page, PAGE_SIZE, "%s\n", "none");
+		return scnprintf(page, PAGE_SIZE, "%s\n", ndev->mt->name);
+	} else if (strcmp(attr->name, "ppa_format") == 0) {
+		return scnprintf(page, PAGE_SIZE,
+			"0x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x\n",
+			id->ppaf.ch_offset, id->ppaf.ch_len,
+			id->ppaf.lun_offset, id->ppaf.lun_len,
+			id->ppaf.pln_offset, id->ppaf.pln_len,
+			id->ppaf.blk_offset, id->ppaf.blk_len,
+			id->ppaf.pg_offset, id->ppaf.pg_len,
+			id->ppaf.sect_offset, id->ppaf.sect_len);
+	} else if (strcmp(attr->name, "media_type") == 0) {	/* u8 */
+		return scnprintf(page, PAGE_SIZE, "%u\n", grp->mtype);
+	} else if (strcmp(attr->name, "flash_media_type") == 0) {
+		return scnprintf(page, PAGE_SIZE, "%u\n", grp->fmtype);
+	} else if (strcmp(attr->name, "num_channels") == 0) {
+		return scnprintf(page, PAGE_SIZE, "%u\n", grp->num_ch);
+	} else if (strcmp(attr->name, "num_luns") == 0) {
+		return scnprintf(page, PAGE_SIZE, "%u\n", grp->num_lun);
+	} else if (strcmp(attr->name, "num_planes") == 0) {
+		return scnprintf(page, PAGE_SIZE, "%u\n", grp->num_pln);
+	} else if (strcmp(attr->name, "num_blocks") == 0) {	/* u16 */
+		return scnprintf(page, PAGE_SIZE, "%u\n", grp->num_blk);
+	} else if (strcmp(attr->name, "num_pages") == 0) {
+		return scnprintf(page, PAGE_SIZE, "%u\n", grp->num_pg);
+	} else if (strcmp(attr->name, "page_size") == 0) {
+		return scnprintf(page, PAGE_SIZE, "%u\n", grp->fpg_sz);
+	} else if (strcmp(attr->name, "hw_sector_size") == 0) {
+		return scnprintf(page, PAGE_SIZE, "%u\n", grp->csecs);
+	} else if (strcmp(attr->name, "oob_sector_size") == 0) {/* u32 */
+		return scnprintf(page, PAGE_SIZE, "%u\n", grp->sos);
+	} else if (strcmp(attr->name, "read_typ") == 0) {
+		return scnprintf(page, PAGE_SIZE, "%u\n", grp->trdt);
+	} else if (strcmp(attr->name, "read_max") == 0) {
+		return scnprintf(page, PAGE_SIZE, "%u\n", grp->trdm);
+	} else if (strcmp(attr->name, "prog_typ") == 0) {
+		return scnprintf(page, PAGE_SIZE, "%u\n", grp->tprt);
+	} else if (strcmp(attr->name, "prog_max") == 0) {
+		return scnprintf(page, PAGE_SIZE, "%u\n", grp->tprm);
+	} else if (strcmp(attr->name, "erase_typ") == 0) {
+		return scnprintf(page, PAGE_SIZE, "%u\n", grp->tbet);
+	} else if (strcmp(attr->name, "erase_max") == 0) {
+		return scnprintf(page, PAGE_SIZE, "%u\n", grp->tbem);
+	} else if (strcmp(attr->name, "multiplane_modes") == 0) {
+		return scnprintf(page, PAGE_SIZE, "0x%08x\n", grp->mpos);
+	} else if (strcmp(attr->name, "media_capabilities") == 0) {
+		return scnprintf(page, PAGE_SIZE, "0x%08x\n", grp->mccap);
+	} else if (strcmp(attr->name, "channel_parallelism") == 0) {/* u16 */
+		return scnprintf(page, PAGE_SIZE, "%u\n", grp->cpar);
+	} else {
+		return scnprintf(page,
+				 PAGE_SIZE,
+				 "Unhandled attr(%s) in `nvm_dev_attr_show`\n",
+				 attr->name);
+	}
+}
+
+#define NVM_DEV_ATTR_RO(_name) 					\
+static DEVICE_ATTR(_name, S_IRUGO, nvm_dev_attr_show, NULL);
+
+NVM_DEV_ATTR_RO(version);
+NVM_DEV_ATTR_RO(vendor_opcode);
+NVM_DEV_ATTR_RO(num_groups);
+NVM_DEV_ATTR_RO(capabilities);
+NVM_DEV_ATTR_RO(device_mode);
+NVM_DEV_ATTR_RO(ppa_format);
+NVM_DEV_ATTR_RO(media_manager);
+
+NVM_DEV_ATTR_RO(media_type);
+NVM_DEV_ATTR_RO(flash_media_type);
+NVM_DEV_ATTR_RO(num_channels);
+NVM_DEV_ATTR_RO(num_luns);
+NVM_DEV_ATTR_RO(num_planes);
+NVM_DEV_ATTR_RO(num_blocks);
+NVM_DEV_ATTR_RO(num_pages);
+NVM_DEV_ATTR_RO(page_size);
+NVM_DEV_ATTR_RO(hw_sector_size);
+NVM_DEV_ATTR_RO(oob_sector_size);
+NVM_DEV_ATTR_RO(read_typ);
+NVM_DEV_ATTR_RO(read_max);
+NVM_DEV_ATTR_RO(prog_typ);
+NVM_DEV_ATTR_RO(prog_max);
+NVM_DEV_ATTR_RO(erase_typ);
+NVM_DEV_ATTR_RO(erase_max);
+NVM_DEV_ATTR_RO(multiplane_modes);
+NVM_DEV_ATTR_RO(media_capabilities);
+NVM_DEV_ATTR_RO(channel_parallelism);
+
+#define NVM_DEV_ATTR(_name) (dev_attr_##_name##)
+
+static struct attribute *nvm_dev_attrs[] = {
+	&dev_attr_version.attr,
+	&dev_attr_vendor_opcode.attr,
+	&dev_attr_num_groups.attr,
+	&dev_attr_capabilities.attr,
+	&dev_attr_device_mode.attr,
+	&dev_attr_media_manager.attr,
+
+	&dev_attr_ppa_format.attr,
+	&dev_attr_media_type.attr,
+	&dev_attr_flash_media_type.attr,
+	&dev_attr_num_channels.attr,
+	&dev_attr_num_luns.attr,
+	&dev_attr_num_planes.attr,
+	&dev_attr_num_blocks.attr,
+	&dev_attr_num_pages.attr,
+	&dev_attr_page_size.attr,
+	&dev_attr_hw_sector_size.attr,
+	&dev_attr_oob_sector_size.attr,
+	&dev_attr_read_typ.attr,
+	&dev_attr_read_max.attr,
+	&dev_attr_prog_typ.attr,
+	&dev_attr_prog_max.attr,
+	&dev_attr_erase_typ.attr,
+	&dev_attr_erase_max.attr,
+	&dev_attr_multiplane_modes.attr,
+	&dev_attr_media_capabilities.attr,
+	&dev_attr_channel_parallelism.attr,
+	NULL,
+};
+
+static struct attribute_group nvm_dev_attr_group = {
+	.name = "lightnvm",
+	.attrs = nvm_dev_attrs,
+};
+
+
+const static struct attribute_group *nvm_dev_attr_groups[] = {
+	&nvm_dev_attr_group,
+	NULL,
+};
+
+static void nvm_dev_release(struct device *device)
+{
+	struct nvm_dev *dev = container_of(device, struct nvm_dev, dev);
+	struct request_queue *q = dev->q;
+
+	pr_debug("nvm/sysfs: `nvm_dev_release`\n");
+
+	blk_mq_unregister_dev(device, q);
+
+	nvm_free(dev);
+}
+
+static struct device_type nvm_type = {
+	.name		= "lightnvm",
+	.groups		= nvm_dev_attr_groups,
+	.release	= nvm_dev_release,
+};
+
+int nvm_sysfs_register_dev(struct nvm_dev *dev)
+{
+	if (!dev->parent_dev)
+		return 0;
+
+	dev->dev.parent = dev->parent_dev;
+	dev_set_name(&dev->dev, "%s", dev->name);
+	dev->dev.class = dev->parent_dev->class;
+	dev->dev.type = &nvm_type;
+	device_initialize(&dev->dev);
+	device_add(&dev->dev);
+
+	blk_mq_register_dev(&dev->dev, dev->q);
+
+	return 0;
+}
+
+void nvm_sysfs_unregister_dev(struct nvm_dev *dev)
+{
+	if (dev && dev->parent_dev)
+		kobject_put(&dev->dev.kobj);
+}
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ff20f1c..0e63546 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1095,7 +1095,7 @@ static DEVICE_ATTR(reset_controller, S_IWUSR, NULL, nvme_sysfs_reset);
 static ssize_t wwid_show(struct device *dev, struct device_attribute *attr,
 								char *buf)
 {
-	struct nvme_ns *ns = dev_to_disk(dev)->private_data;
+	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
 	struct nvme_ctrl *ctrl = ns->ctrl;
 	int serial_len = sizeof(ctrl->serial);
 	int model_len = sizeof(ctrl->model);
@@ -1119,7 +1119,7 @@ static DEVICE_ATTR(wwid, S_IRUGO, wwid_show, NULL);
 static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
 								char *buf)
 {
-	struct nvme_ns *ns = dev_to_disk(dev)->private_data;
+	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
 	return sprintf(buf, "%pU\n", ns->uuid);
 }
 static DEVICE_ATTR(uuid, S_IRUGO, uuid_show, NULL);
@@ -1127,7 +1127,7 @@ static DEVICE_ATTR(uuid, S_IRUGO, uuid_show, NULL);
 static ssize_t eui_show(struct device *dev, struct device_attribute *attr,
 								char *buf)
 {
-	struct nvme_ns *ns = dev_to_disk(dev)->private_data;
+	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
 	return sprintf(buf, "%8phd\n", ns->eui);
 }
 static DEVICE_ATTR(eui, S_IRUGO, eui_show, NULL);
@@ -1135,7 +1135,7 @@ static DEVICE_ATTR(eui, S_IRUGO, eui_show, NULL);
 static ssize_t nsid_show(struct device *dev, struct device_attribute *attr,
 								char *buf)
 {
-	struct nvme_ns *ns = dev_to_disk(dev)->private_data;
+	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
 	return sprintf(buf, "%d\n", ns->ns_id);
 }
 static DEVICE_ATTR(nsid, S_IRUGO, nsid_show, NULL);
@@ -1152,7 +1152,7 @@ static umode_t nvme_attrs_are_visible(struct kobject *kobj,
 		struct attribute *a, int n)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
-	struct nvme_ns *ns = dev_to_disk(dev)->private_data;
+	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
 
 	if (a == &dev_attr_uuid.attr) {
 		if (!memchr_inv(ns->uuid, 0, sizeof(ns->uuid)))
@@ -1272,7 +1272,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	sprintf(disk_name, "nvme%dn%d", ctrl->instance, ns->instance);
 
 	if (nvme_nvm_ns_supported(ns, id)) {
-		if (nvme_nvm_register(ns, disk_name, node)) {
+		if (nvme_nvm_register(ns, disk_name, node,
+							&nvme_ns_attr_group)) {
 			dev_warn(ctrl->dev, "%s: LightNVM init failure\n",
 								__func__);
 			goto out_free_id;
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index cd406c5..c9c7189 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -592,10 +592,12 @@ static struct nvm_dev_ops nvme_nvm_dev_ops = {
 	.max_phys_sect		= 64,
 };
 
-int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node)
+int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node,
+		      const struct attribute_group *attrs)
 {
 	struct request_queue *q = ns->queue;
 	struct nvm_dev *dev;
+	int ret;
 
 	dev = nvm_alloc_dev(node);
 	if (!dev)
@@ -604,9 +606,15 @@ int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node)
 	dev->q = q;
 	memcpy(dev->name, disk_name, DISK_NAME_LEN);
 	dev->ops = &nvme_nvm_dev_ops;
+	dev->parent_dev = ns->ctrl->device;
+	dev->private_data = ns;
 	ns->ndev = dev;
 
-	return nvm_register(dev);
+	ret = nvm_register(dev);
+	if (sysfs_create_group(&dev->dev.kobj, attrs))
+		pr_warn("%s: failed to create sysfs group for identification\n",
+			ns->disk->disk_name);
+	return ret;
 }
 
 void nvme_nvm_unregister(struct nvme_ns *ns)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index d62c6fd..d7f1afc 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -292,7 +292,8 @@ int nvme_sg_get_version_num(int __user *ip);
 
 #ifdef CONFIG_NVM
 int nvme_nvm_ns_supported(struct nvme_ns *ns, struct nvme_id_ns *id);
-int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node);
+int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node,
+		      const struct attribute_group *attrs);
 void nvme_nvm_unregister(struct nvme_ns *ns);
 
 static inline struct nvme_ns *nvme_get_ns_from_dev(struct device *dev)
@@ -304,7 +305,8 @@ static inline struct nvme_ns *nvme_get_ns_from_dev(struct device *dev)
 }
 #else
 static inline int nvme_nvm_register(struct nvme_ns *ns, char *disk_name,
-								int node)
+				    int node,
+				    const struct attribute_group *attrs)
 {
 	return 0;
 }
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 5afc263..d190786 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -352,7 +352,10 @@ struct nvm_dev {
 
 	/* Backend device */
 	struct request_queue *q;
+	struct device dev;
+	struct device *parent_dev;
 	char name[DISK_NAME_LEN];
+	void *private_data;
 
 	struct mutex mlock;
 	spinlock_t lock;
-- 
2.1.4

