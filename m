Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wj0-f196.google.com ([209.85.210.196]:35855 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755465AbcK1Vjl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Nov 2016 16:39:41 -0500
Received: by mail-wj0-f196.google.com with SMTP id jb2so15789129wjb.3
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2016 13:39:40 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: axboe@fb.com, =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 02/23] nvme: lightnvm: attach lightnvm sysfs to nvme block device
Date: Mon, 28 Nov 2016 22:38:53 +0100
Message-Id: <20161128213914.12516-3-m@bjorling.me>
In-Reply-To: <20161128213914.12516-1-m@bjorling.me>
References: <20161128213914.12516-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Previously, LBA read and write were not supported in the lightnvm
specification. Now that it supports it, lets use the traditional
NVMe gendisk, and attach the lightnvm sysfs geometry export.

Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/Makefile    |   2 +-
 drivers/lightnvm/core.c      |  15 +---
 drivers/lightnvm/lightnvm.h  |  35 --------
 drivers/lightnvm/sysfs.c     | 198 -------------------------------------------
 drivers/nvme/host/core.c     |  45 +++++-----
 drivers/nvme/host/lightnvm.c | 175 +++++++++++++++++++++++++++++++++++---
 drivers/nvme/host/nvme.h     |  31 +++----
 include/linux/lightnvm.h     |   2 -
 8 files changed, 201 insertions(+), 302 deletions(-)
 delete mode 100644 drivers/lightnvm/lightnvm.h
 delete mode 100644 drivers/lightnvm/sysfs.c

diff --git a/drivers/lightnvm/Makefile b/drivers/lightnvm/Makefile
index 1f6b652..a7a0a22 100644
--- a/drivers/lightnvm/Makefile
+++ b/drivers/lightnvm/Makefile
@@ -2,6 +2,6 @@
 # Makefile for Open-Channel SSDs.
 #
 
-obj-$(CONFIG_NVM)		:= core.o sysblk.o sysfs.o
+obj-$(CONFIG_NVM)		:= core.o sysblk.o
 obj-$(CONFIG_NVM_GENNVM) 	+= gennvm.o
 obj-$(CONFIG_NVM_RRPC)		+= rrpc.o
diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 1cac0f8..1111740 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -27,8 +27,6 @@
 #include <linux/lightnvm.h>
 #include <linux/sched/sysctl.h>
 
-#include "lightnvm.h"
-
 static LIST_HEAD(nvm_tgt_types);
 static DECLARE_RWSEM(nvm_tgtt_lock);
 static LIST_HEAD(nvm_mgrs);
@@ -657,11 +655,6 @@ static int nvm_init(struct nvm_dev *dev)
 	return ret;
 }
 
-static void nvm_exit(struct nvm_dev *dev)
-{
-	nvm_sysfs_unregister_dev(dev);
-}
-
 struct nvm_dev *nvm_alloc_dev(int node)
 {
 	return kzalloc_node(sizeof(struct nvm_dev), GFP_KERNEL, node);
@@ -691,10 +684,6 @@ int nvm_register(struct nvm_dev *dev)
 		}
 	}
 
-	ret = nvm_sysfs_register_dev(dev);
-	if (ret)
-		goto err_ppalist;
-
 	if (dev->identity.cap & NVM_ID_DCAP_BBLKMGMT) {
 		ret = nvm_get_sysblock(dev, &dev->sb);
 		if (!ret)
@@ -711,8 +700,6 @@ int nvm_register(struct nvm_dev *dev)
 	up_write(&nvm_lock);
 
 	return 0;
-err_ppalist:
-	dev->ops->destroy_dma_pool(dev->dma_pool);
 err_init:
 	kfree(dev->lun_map);
 	return ret;
@@ -725,7 +712,7 @@ void nvm_unregister(struct nvm_dev *dev)
 	list_del(&dev->devices);
 	up_write(&nvm_lock);
 
-	nvm_exit(dev);
+	nvm_free(dev);
 }
 EXPORT_SYMBOL(nvm_unregister);
 
diff --git a/drivers/lightnvm/lightnvm.h b/drivers/lightnvm/lightnvm.h
deleted file mode 100644
index 305c181..0000000
--- a/drivers/lightnvm/lightnvm.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/*
- * Copyright (C) 2016 CNEX Labs. All rights reserved.
- * Initial release: Matias Bjorling <matias@cnexlabs.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License version
- * 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; see the file COPYING.  If not, write to
- * the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139,
- * USA.
- *
- */
-
-#ifndef LIGHTNVM_H
-#define LIGHTNVM_H
-
-#include <linux/lightnvm.h>
-
-/* core -> sysfs.c */
-int __must_check nvm_sysfs_register_dev(struct nvm_dev *);
-void nvm_sysfs_unregister_dev(struct nvm_dev *);
-int nvm_sysfs_register(void);
-void nvm_sysfs_unregister(void);
-
-/* sysfs > core */
-void nvm_free(struct nvm_dev *);
-
-#endif
diff --git a/drivers/lightnvm/sysfs.c b/drivers/lightnvm/sysfs.c
deleted file mode 100644
index 0338c27..0000000
--- a/drivers/lightnvm/sysfs.c
+++ /dev/null
@@ -1,198 +0,0 @@
-#include <linux/kernel.h>
-#include <linux/lightnvm.h>
-#include <linux/miscdevice.h>
-#include <linux/kobject.h>
-#include <linux/blk-mq.h>
-
-#include "lightnvm.h"
-
-static ssize_t nvm_dev_attr_show(struct device *dev,
-				 struct device_attribute *dattr, char *page)
-{
-	struct nvm_dev *ndev = container_of(dev, struct nvm_dev, dev);
-	struct nvm_id *id = &ndev->identity;
-	struct nvm_id_group *grp = &id->groups[0];
-	struct attribute *attr = &dattr->attr;
-
-	if (strcmp(attr->name, "version") == 0) {
-		return scnprintf(page, PAGE_SIZE, "%u\n", id->ver_id);
-	} else if (strcmp(attr->name, "vendor_opcode") == 0) {
-		return scnprintf(page, PAGE_SIZE, "%u\n", id->vmnt);
-	} else if (strcmp(attr->name, "capabilities") == 0) {
-		return scnprintf(page, PAGE_SIZE, "%u\n", id->cap);
-	} else if (strcmp(attr->name, "device_mode") == 0) {
-		return scnprintf(page, PAGE_SIZE, "%u\n", id->dom);
-	} else if (strcmp(attr->name, "media_manager") == 0) {
-		if (!ndev->mt)
-			return scnprintf(page, PAGE_SIZE, "%s\n", "none");
-		return scnprintf(page, PAGE_SIZE, "%s\n", ndev->mt->name);
-	} else if (strcmp(attr->name, "ppa_format") == 0) {
-		return scnprintf(page, PAGE_SIZE,
-			"0x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x\n",
-			id->ppaf.ch_offset, id->ppaf.ch_len,
-			id->ppaf.lun_offset, id->ppaf.lun_len,
-			id->ppaf.pln_offset, id->ppaf.pln_len,
-			id->ppaf.blk_offset, id->ppaf.blk_len,
-			id->ppaf.pg_offset, id->ppaf.pg_len,
-			id->ppaf.sect_offset, id->ppaf.sect_len);
-	} else if (strcmp(attr->name, "media_type") == 0) {	/* u8 */
-		return scnprintf(page, PAGE_SIZE, "%u\n", grp->mtype);
-	} else if (strcmp(attr->name, "flash_media_type") == 0) {
-		return scnprintf(page, PAGE_SIZE, "%u\n", grp->fmtype);
-	} else if (strcmp(attr->name, "num_channels") == 0) {
-		return scnprintf(page, PAGE_SIZE, "%u\n", grp->num_ch);
-	} else if (strcmp(attr->name, "num_luns") == 0) {
-		return scnprintf(page, PAGE_SIZE, "%u\n", grp->num_lun);
-	} else if (strcmp(attr->name, "num_planes") == 0) {
-		return scnprintf(page, PAGE_SIZE, "%u\n", grp->num_pln);
-	} else if (strcmp(attr->name, "num_blocks") == 0) {	/* u16 */
-		return scnprintf(page, PAGE_SIZE, "%u\n", grp->num_blk);
-	} else if (strcmp(attr->name, "num_pages") == 0) {
-		return scnprintf(page, PAGE_SIZE, "%u\n", grp->num_pg);
-	} else if (strcmp(attr->name, "page_size") == 0) {
-		return scnprintf(page, PAGE_SIZE, "%u\n", grp->fpg_sz);
-	} else if (strcmp(attr->name, "hw_sector_size") == 0) {
-		return scnprintf(page, PAGE_SIZE, "%u\n", grp->csecs);
-	} else if (strcmp(attr->name, "oob_sector_size") == 0) {/* u32 */
-		return scnprintf(page, PAGE_SIZE, "%u\n", grp->sos);
-	} else if (strcmp(attr->name, "read_typ") == 0) {
-		return scnprintf(page, PAGE_SIZE, "%u\n", grp->trdt);
-	} else if (strcmp(attr->name, "read_max") == 0) {
-		return scnprintf(page, PAGE_SIZE, "%u\n", grp->trdm);
-	} else if (strcmp(attr->name, "prog_typ") == 0) {
-		return scnprintf(page, PAGE_SIZE, "%u\n", grp->tprt);
-	} else if (strcmp(attr->name, "prog_max") == 0) {
-		return scnprintf(page, PAGE_SIZE, "%u\n", grp->tprm);
-	} else if (strcmp(attr->name, "erase_typ") == 0) {
-		return scnprintf(page, PAGE_SIZE, "%u\n", grp->tbet);
-	} else if (strcmp(attr->name, "erase_max") == 0) {
-		return scnprintf(page, PAGE_SIZE, "%u\n", grp->tbem);
-	} else if (strcmp(attr->name, "multiplane_modes") == 0) {
-		return scnprintf(page, PAGE_SIZE, "0x%08x\n", grp->mpos);
-	} else if (strcmp(attr->name, "media_capabilities") == 0) {
-		return scnprintf(page, PAGE_SIZE, "0x%08x\n", grp->mccap);
-	} else if (strcmp(attr->name, "max_phys_secs") == 0) {
-		return scnprintf(page, PAGE_SIZE, "%u\n",
-				ndev->ops->max_phys_sect);
-	} else {
-		return scnprintf(page,
-				 PAGE_SIZE,
-				 "Unhandled attr(%s) in `nvm_dev_attr_show`\n",
-				 attr->name);
-	}
-}
-
-#define NVM_DEV_ATTR_RO(_name)						\
-	DEVICE_ATTR(_name, S_IRUGO, nvm_dev_attr_show, NULL)
-
-static NVM_DEV_ATTR_RO(version);
-static NVM_DEV_ATTR_RO(vendor_opcode);
-static NVM_DEV_ATTR_RO(capabilities);
-static NVM_DEV_ATTR_RO(device_mode);
-static NVM_DEV_ATTR_RO(ppa_format);
-static NVM_DEV_ATTR_RO(media_manager);
-
-static NVM_DEV_ATTR_RO(media_type);
-static NVM_DEV_ATTR_RO(flash_media_type);
-static NVM_DEV_ATTR_RO(num_channels);
-static NVM_DEV_ATTR_RO(num_luns);
-static NVM_DEV_ATTR_RO(num_planes);
-static NVM_DEV_ATTR_RO(num_blocks);
-static NVM_DEV_ATTR_RO(num_pages);
-static NVM_DEV_ATTR_RO(page_size);
-static NVM_DEV_ATTR_RO(hw_sector_size);
-static NVM_DEV_ATTR_RO(oob_sector_size);
-static NVM_DEV_ATTR_RO(read_typ);
-static NVM_DEV_ATTR_RO(read_max);
-static NVM_DEV_ATTR_RO(prog_typ);
-static NVM_DEV_ATTR_RO(prog_max);
-static NVM_DEV_ATTR_RO(erase_typ);
-static NVM_DEV_ATTR_RO(erase_max);
-static NVM_DEV_ATTR_RO(multiplane_modes);
-static NVM_DEV_ATTR_RO(media_capabilities);
-static NVM_DEV_ATTR_RO(max_phys_secs);
-
-#define NVM_DEV_ATTR(_name) (dev_attr_##_name##)
-
-static struct attribute *nvm_dev_attrs[] = {
-	&dev_attr_version.attr,
-	&dev_attr_vendor_opcode.attr,
-	&dev_attr_capabilities.attr,
-	&dev_attr_device_mode.attr,
-	&dev_attr_media_manager.attr,
-
-	&dev_attr_ppa_format.attr,
-	&dev_attr_media_type.attr,
-	&dev_attr_flash_media_type.attr,
-	&dev_attr_num_channels.attr,
-	&dev_attr_num_luns.attr,
-	&dev_attr_num_planes.attr,
-	&dev_attr_num_blocks.attr,
-	&dev_attr_num_pages.attr,
-	&dev_attr_page_size.attr,
-	&dev_attr_hw_sector_size.attr,
-	&dev_attr_oob_sector_size.attr,
-	&dev_attr_read_typ.attr,
-	&dev_attr_read_max.attr,
-	&dev_attr_prog_typ.attr,
-	&dev_attr_prog_max.attr,
-	&dev_attr_erase_typ.attr,
-	&dev_attr_erase_max.attr,
-	&dev_attr_multiplane_modes.attr,
-	&dev_attr_media_capabilities.attr,
-	&dev_attr_max_phys_secs.attr,
-	NULL,
-};
-
-static struct attribute_group nvm_dev_attr_group = {
-	.name = "lightnvm",
-	.attrs = nvm_dev_attrs,
-};
-
-static const struct attribute_group *nvm_dev_attr_groups[] = {
-	&nvm_dev_attr_group,
-	NULL,
-};
-
-static void nvm_dev_release(struct device *device)
-{
-	struct nvm_dev *dev = container_of(device, struct nvm_dev, dev);
-	struct request_queue *q = dev->q;
-
-	pr_debug("nvm/sysfs: `nvm_dev_release`\n");
-
-	blk_mq_unregister_dev(device, q);
-
-	nvm_free(dev);
-}
-
-static struct device_type nvm_type = {
-	.name		= "lightnvm",
-	.groups		= nvm_dev_attr_groups,
-	.release	= nvm_dev_release,
-};
-
-int nvm_sysfs_register_dev(struct nvm_dev *dev)
-{
-	int ret;
-
-	if (!dev->parent_dev)
-		return 0;
-
-	dev->dev.parent = dev->parent_dev;
-	dev_set_name(&dev->dev, "%s", dev->name);
-	dev->dev.type = &nvm_type;
-	device_initialize(&dev->dev);
-	ret = device_add(&dev->dev);
-
-	if (!ret)
-		blk_mq_register_dev(&dev->dev, dev->q);
-
-	return ret;
-}
-
-void nvm_sysfs_unregister_dev(struct nvm_dev *dev)
-{
-	if (dev && dev->parent_dev)
-		kobject_put(&dev->dev.kobj);
-}
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e54bb10..8c64483 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1673,28 +1673,25 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	if (nvme_revalidate_ns(ns, &id))
 		goto out_free_queue;
 
-	if (nvme_nvm_ns_supported(ns, id)) {
-		if (nvme_nvm_register(ns, disk_name, node,
-							&nvme_ns_attr_group)) {
-			dev_warn(ctrl->dev, "%s: LightNVM init failure\n",
-								__func__);
-			goto out_free_id;
-		}
-	} else {
-		disk = alloc_disk_node(0, node);
-		if (!disk)
-			goto out_free_id;
-
-		disk->fops = &nvme_fops;
-		disk->private_data = ns;
-		disk->queue = ns->queue;
-		disk->flags = GENHD_FL_EXT_DEVT;
-		memcpy(disk->disk_name, disk_name, DISK_NAME_LEN);
-		ns->disk = disk;
-
-		__nvme_revalidate_disk(disk, id);
+	if (nvme_nvm_ns_supported(ns, id) &&
+				nvme_nvm_register(ns, disk_name, node)) {
+		dev_warn(ctrl->dev, "%s: LightNVM init failure\n", __func__);
+		goto out_free_id;
 	}
 
+	disk = alloc_disk_node(0, node);
+	if (!disk)
+		goto out_free_id;
+
+	disk->fops = &nvme_fops;
+	disk->private_data = ns;
+	disk->queue = ns->queue;
+	disk->flags = GENHD_FL_EXT_DEVT;
+	memcpy(disk->disk_name, disk_name, DISK_NAME_LEN);
+	ns->disk = disk;
+
+	__nvme_revalidate_disk(disk, id);
+
 	mutex_lock(&ctrl->namespaces_mutex);
 	list_add_tail(&ns->list, &ctrl->namespaces);
 	mutex_unlock(&ctrl->namespaces_mutex);
@@ -1703,14 +1700,14 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	kfree(id);
 
-	if (ns->ndev)
-		return;
-
 	device_add_disk(ctrl->device, ns->disk);
 	if (sysfs_create_group(&disk_to_dev(ns->disk)->kobj,
 					&nvme_ns_attr_group))
 		pr_warn("%s: failed to create sysfs group for identification\n",
 			ns->disk->disk_name);
+	if (ns->ndev && nvme_nvm_register_sysfs(ns))
+		pr_warn("%s: failed to register lightnvm sysfs group for identification\n",
+			ns->disk->disk_name);
 	return;
  out_free_id:
 	kfree(id);
@@ -1732,6 +1729,8 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 			blk_integrity_unregister(ns->disk);
 		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
 					&nvme_ns_attr_group);
+		if (ns->ndev)
+			nvme_nvm_unregister_sysfs(ns);
 		del_gendisk(ns->disk);
 		blk_mq_abort_requeue_list(ns->queue);
 		blk_cleanup_queue(ns->queue);
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index de3dc87..f23e6fe 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -575,12 +575,10 @@ static struct nvm_dev_ops nvme_nvm_dev_ops = {
 	.max_phys_sect		= 64,
 };
 
-int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node,
-		      const struct attribute_group *attrs)
+int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node)
 {
 	struct request_queue *q = ns->queue;
 	struct nvm_dev *dev;
-	int ret;
 
 	dev = nvm_alloc_dev(node);
 	if (!dev)
@@ -589,18 +587,10 @@ int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node,
 	dev->q = q;
 	memcpy(dev->name, disk_name, DISK_NAME_LEN);
 	dev->ops = &nvme_nvm_dev_ops;
-	dev->parent_dev = ns->ctrl->device;
 	dev->private_data = ns;
 	ns->ndev = dev;
 
-	ret = nvm_register(dev);
-
-	ns->lba_shift = ilog2(dev->sec_size) - 9;
-
-	if (sysfs_create_group(&dev->dev.kobj, attrs))
-		pr_warn("%s: failed to create sysfs group for identification\n",
-			disk_name);
-	return ret;
+	return nvm_register(dev);
 }
 
 void nvme_nvm_unregister(struct nvme_ns *ns)
@@ -608,6 +598,167 @@ void nvme_nvm_unregister(struct nvme_ns *ns)
 	nvm_unregister(ns->ndev);
 }
 
+static ssize_t nvm_dev_attr_show(struct device *dev,
+				 struct device_attribute *dattr, char *page)
+{
+	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
+	struct nvm_dev *ndev = ns->ndev;
+	struct nvm_id *id;
+	struct nvm_id_group *grp;
+	struct attribute *attr;
+
+	if (!ndev)
+		return 0;
+
+	id = &ndev->identity;
+	grp = &id->groups[0];
+	attr = &dattr->attr;
+
+	if (strcmp(attr->name, "version") == 0) {
+		return scnprintf(page, PAGE_SIZE, "%u\n", id->ver_id);
+	} else if (strcmp(attr->name, "vendor_opcode") == 0) {
+		return scnprintf(page, PAGE_SIZE, "%u\n", id->vmnt);
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
+	} else if (strcmp(attr->name, "max_phys_secs") == 0) {
+		return scnprintf(page, PAGE_SIZE, "%u\n",
+				ndev->ops->max_phys_sect);
+	} else {
+		return scnprintf(page,
+				 PAGE_SIZE,
+				 "Unhandled attr(%s) in `nvm_dev_attr_show`\n",
+				 attr->name);
+	}
+}
+
+#define NVM_DEV_ATTR_RO(_name)						\
+	DEVICE_ATTR(_name, S_IRUGO, nvm_dev_attr_show, NULL)
+
+static NVM_DEV_ATTR_RO(version);
+static NVM_DEV_ATTR_RO(vendor_opcode);
+static NVM_DEV_ATTR_RO(capabilities);
+static NVM_DEV_ATTR_RO(device_mode);
+static NVM_DEV_ATTR_RO(ppa_format);
+static NVM_DEV_ATTR_RO(media_manager);
+
+static NVM_DEV_ATTR_RO(media_type);
+static NVM_DEV_ATTR_RO(flash_media_type);
+static NVM_DEV_ATTR_RO(num_channels);
+static NVM_DEV_ATTR_RO(num_luns);
+static NVM_DEV_ATTR_RO(num_planes);
+static NVM_DEV_ATTR_RO(num_blocks);
+static NVM_DEV_ATTR_RO(num_pages);
+static NVM_DEV_ATTR_RO(page_size);
+static NVM_DEV_ATTR_RO(hw_sector_size);
+static NVM_DEV_ATTR_RO(oob_sector_size);
+static NVM_DEV_ATTR_RO(read_typ);
+static NVM_DEV_ATTR_RO(read_max);
+static NVM_DEV_ATTR_RO(prog_typ);
+static NVM_DEV_ATTR_RO(prog_max);
+static NVM_DEV_ATTR_RO(erase_typ);
+static NVM_DEV_ATTR_RO(erase_max);
+static NVM_DEV_ATTR_RO(multiplane_modes);
+static NVM_DEV_ATTR_RO(media_capabilities);
+static NVM_DEV_ATTR_RO(max_phys_secs);
+
+static struct attribute *nvm_dev_attrs[] = {
+	&dev_attr_version.attr,
+	&dev_attr_vendor_opcode.attr,
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
+	&dev_attr_max_phys_secs.attr,
+	NULL,
+};
+
+static const struct attribute_group nvm_dev_attr_group = {
+	.name		= "lightnvm",
+	.attrs		= nvm_dev_attrs,
+};
+
+int nvme_nvm_register_sysfs(struct nvme_ns *ns)
+{
+	return sysfs_create_group(&disk_to_dev(ns->disk)->kobj,
+					&nvm_dev_attr_group);
+}
+
+void nvme_nvm_unregister_sysfs(struct nvme_ns *ns)
+{
+	sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
+					&nvm_dev_attr_group);
+}
+
 /* move to shared place when used in multiple places. */
 #define PCI_VENDOR_ID_CNEX 0x1d1d
 #define PCI_DEVICE_ID_CNEX_WL 0x2807
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 468fc44..a3d6ffd 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -321,37 +321,34 @@ int nvme_sg_get_version_num(int __user *ip);
 
 #ifdef CONFIG_NVM
 int nvme_nvm_ns_supported(struct nvme_ns *ns, struct nvme_id_ns *id);
-int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node,
-		      const struct attribute_group *attrs);
+int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node);
 void nvme_nvm_unregister(struct nvme_ns *ns);
-
-static inline struct nvme_ns *nvme_get_ns_from_dev(struct device *dev)
-{
-	if (dev->type->devnode)
-		return dev_to_disk(dev)->private_data;
-
-	return (container_of(dev, struct nvm_dev, dev))->private_data;
-}
+int nvme_nvm_register_sysfs(struct nvme_ns *ns);
+void nvme_nvm_unregister_sysfs(struct nvme_ns *ns);
 #else
 static inline int nvme_nvm_register(struct nvme_ns *ns, char *disk_name,
-				    int node,
-				    const struct attribute_group *attrs)
+				    int node)
 {
 	return 0;
 }
 
 static inline void nvme_nvm_unregister(struct nvme_ns *ns) {};
-
+static inline int nvme_nvm_register_sysfs(struct nvme_ns *ns)
+{
+	return 0;
+}
+static inline void nvme_nvm_unregister_sysfs(struct nvme_ns *ns) {};
 static inline int nvme_nvm_ns_supported(struct nvme_ns *ns, struct nvme_id_ns *id)
 {
 	return 0;
 }
-static inline struct nvme_ns *nvme_get_ns_from_dev(struct device *dev)
-{
-	return dev_to_disk(dev)->private_data;
-}
 #endif /* CONFIG_NVM */
 
+static inline struct nvme_ns *nvme_get_ns_from_dev(struct device *dev)
+{
+	return dev_to_disk(dev)->private_data;
+}
+
 int __init nvme_core_init(void);
 void nvme_core_exit(void);
 
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index d190786..fb2e601 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -352,8 +352,6 @@ struct nvm_dev {
 
 	/* Backend device */
 	struct request_queue *q;
-	struct device dev;
-	struct device *parent_dev;
 	char name[DISK_NAME_LEN];
 	void *private_data;
 
-- 
2.9.3

