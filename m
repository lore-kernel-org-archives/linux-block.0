Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4D5C4361B
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 13:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C417323A79
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 13:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbgLHNaU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Dec 2020 08:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729462AbgLHNaT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Dec 2020 08:30:19 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37603C061749
        for <linux-block@vger.kernel.org>; Tue,  8 Dec 2020 05:29:39 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id m19so24542826ejj.11
        for <linux-block@vger.kernel.org>; Tue, 08 Dec 2020 05:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZDjPtFOmPb+UCVeLzwciBz5SQK3rSreSTXi0Ly+FfwU=;
        b=yPNHmXSpB5j+9cP4Q9axPSrZSft9mjC/PoHtyTYyPaN5Oc34iHmSLAPzxkjACM9ldj
         SSZsxFGX8cYk7J1voxvBY/qNQwv3pNQ9xUF/TBKfO50Qy+ZTssDdnhvvv9LXR1UHwP30
         jNfDl2aEgEXcQMMcBSq9+E77cbIDr49wFSQxsc8qv8Pi0fzZ1dSPUOVYygiBXlsRSKYJ
         9mSrlS/NJMWWGvirzbdSa0DeiNr2xtJrn9yZD9uNFsHlI/a8LIRWiZkwamv54Ixj63B7
         CfiDgXgwuQZiDpDTopVC33j5qp7ziWCulFEWst6HmwOk76YLrMndtBuotKmJ6aEwNWMG
         waag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZDjPtFOmPb+UCVeLzwciBz5SQK3rSreSTXi0Ly+FfwU=;
        b=QHBRb6sIK7couq+qfrpflmh1jeVyF0CPAr0cWZ0gkjPZCzXexQikL7lct4fP+oNyEJ
         ZC4ukG+GW53AwbOmw9kObp1dQ1JdBVI/fTigVg7SW5aiH6wEwADm76VFiXwtKojy3f5Z
         jF+4CpM24foEujV3iQU9RpgneCq+J4z7uUalRKvGKPAIvwW2TRXi2z24+OKM+yNRlwNB
         TYlwr07F5sQ9nbSkXZq53SGgWVkhFDTkEWEgNh2VqH9BpVq8OvyeXgLDXu++xk1ygJso
         wCAv4/FIxtGZbCFln8r/IxUbP8B5ewpx/BqUohWBFpTap80/aN0MNhBJ9WKf9G8MFq40
         eouQ==
X-Gm-Message-State: AOAM533kxwo+Zgy3Ag5qVZEE4onuS8xWJbmHSdbUx4QJiqmB7rtTFj+d
        LYSw57h4+WqumNrCcagdiKvmDw==
X-Google-Smtp-Source: ABdhPJy7SGIilHGBpw+HNU6zCAfxGMdMLOLNprGQzNVXPuMbaaa9Hl7pXG1v5Ur5PyYgTRJ2n3Cr7A==
X-Received: by 2002:a17:906:7e43:: with SMTP id z3mr23015815ejr.67.1607434177928;
        Tue, 08 Dec 2020 05:29:37 -0800 (PST)
Received: from ch-wrk-javier.cnexlabs.com (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id cf17sm17034969edb.16.2020.12.08.05.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 05:29:36 -0800 (PST)
From:   javier@javigon.com
X-Google-Original-From: javier.gonz@samsung.com
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, minwoo.im.dev@gmail.com,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>
Subject: [PATCH V2] nvme: enable char device per namespace
Date:   Tue,  8 Dec 2020 14:29:34 +0100
Message-Id: <20201208132934.625-1-javier.gonz@samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Javier González <javier.gonz@samsung.com>

Create a char device per NVMe namespace. This char device is always
initialized, independently of whether thedeatures implemented by the
device are supported by the kernel. User-space can therefore always
issue IOCTLs to the NVMe driver using this char device.

The char device is presented as /dev/nvmeXnYc. This naming aligns with
nvme-cli filters, so the char device should be usable without tool
changes. It also follows a new name conventio to avoid confusion with
the existing hidden device (i.e., nvmeXcYnZ).

Changes since V1:

  - Remove patches 1-3 which are already picked up by Christoph
  - Change the char device and sysfs entries to nvmeXnYc / c signals
    char device
  - Address Minwoo's comments on inline functions and style

Signed-off-by: Javier González <javier.gonz@samsung.com>
---
 drivers/nvme/host/core.c | 141 +++++++++++++++++++++++++++++++++++----
 drivers/nvme/host/nvme.h |   8 +++
 2 files changed, 135 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 99f91efe3824..e446aaba5ccd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -86,7 +86,9 @@ static DEFINE_MUTEX(nvme_subsystems_lock);
 
 static DEFINE_IDA(nvme_instance_ida);
 static dev_t nvme_ctrl_base_chr_devt;
+static dev_t nvme_ns_base_chr_devt;
 static struct class *nvme_class;
+static struct class *nvme_ns_class;
 static struct class *nvme_subsys_class;
 
 static void nvme_put_subsystem(struct nvme_subsystem *subsys);
@@ -538,6 +540,7 @@ static void nvme_free_ns(struct kref *kref)
 	if (ns->ndev)
 		nvme_nvm_unregister(ns);
 
+	cdev_device_del(&ns->cdev, &ns->cdev_device);
 	put_disk(ns->disk);
 	nvme_put_ns_head(ns->head);
 	nvme_put_ctrl(ns->ctrl);
@@ -1738,15 +1741,15 @@ static int nvme_handle_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
 	return ret;
 }
 
-static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
-		unsigned int cmd, unsigned long arg)
+static int __nvme_ns_ioctl(struct gendisk *disk, unsigned int cmd,
+			   unsigned long arg)
 {
 	struct nvme_ns_head *head = NULL;
 	void __user *argp = (void __user *)arg;
 	struct nvme_ns *ns;
 	int srcu_idx, ret;
 
-	ns = nvme_get_ns_from_disk(bdev->bd_disk, &head, &srcu_idx);
+	ns = nvme_get_ns_from_disk(disk, &head, &srcu_idx);
 	if (unlikely(!ns))
 		return -EWOULDBLOCK;
 
@@ -1783,6 +1786,18 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 	return ret;
 }
 
+static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
+		      unsigned int cmd, unsigned long arg)
+{
+	return __nvme_ns_ioctl(bdev->bd_disk, cmd, arg);
+}
+
+static long nvme_cdev_ioctl(struct file *file, unsigned int cmd,
+			    unsigned long arg)
+{
+	return __nvme_ns_ioctl((struct gendisk *)file->private_data, cmd, arg);
+}
+
 #ifdef CONFIG_COMPAT
 struct nvme_user_io32 {
 	__u8	opcode;
@@ -1824,10 +1839,8 @@ static int nvme_compat_ioctl(struct block_device *bdev, fmode_t mode,
 #define nvme_compat_ioctl	NULL
 #endif /* CONFIG_COMPAT */
 
-static int nvme_open(struct block_device *bdev, fmode_t mode)
+static int __nvme_open(struct nvme_ns *ns)
 {
-	struct nvme_ns *ns = bdev->bd_disk->private_data;
-
 #ifdef CONFIG_NVME_MULTIPATH
 	/* should never be called due to GENHD_FL_HIDDEN */
 	if (WARN_ON_ONCE(ns->head->disk))
@@ -1846,12 +1859,24 @@ static int nvme_open(struct block_device *bdev, fmode_t mode)
 	return -ENXIO;
 }
 
+static void __nvme_release(struct nvme_ns *ns)
+{
+	module_put(ns->ctrl->ops->module);
+	nvme_put_ns(ns);
+}
+
+static int nvme_open(struct block_device *bdev, fmode_t mode)
+{
+	struct nvme_ns *ns = bdev->bd_disk->private_data;
+
+	return __nvme_open(ns);
+}
+
 static void nvme_release(struct gendisk *disk, fmode_t mode)
 {
 	struct nvme_ns *ns = disk->private_data;
 
-	module_put(ns->ctrl->ops->module);
-	nvme_put_ns(ns);
+	__nvme_release(ns);
 }
 
 static int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo)
@@ -1863,6 +1888,26 @@ static int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 	return 0;
 }
 
+static int nvme_cdev_open(struct inode *inode, struct file *file)
+{
+	struct nvme_ns *ns = container_of(inode->i_cdev, struct nvme_ns, cdev);
+	int ret;
+
+	ret = __nvme_open(ns);
+	if (!ret)
+		file->private_data = ns->disk;
+
+	return ret;
+}
+
+static int nvme_cdev_release(struct inode *inode, struct file *file)
+{
+	struct nvme_ns *ns = container_of(inode->i_cdev, struct nvme_ns, cdev);
+
+	__nvme_release(ns);
+	return 0;
+}
+
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type,
 				u32 max_integrity_segments)
@@ -2346,6 +2391,14 @@ static const struct block_device_operations nvme_bdev_ops = {
 	.pr_ops		= &nvme_pr_ops,
 };
 
+static const struct file_operations nvme_cdev_fops = {
+	.owner		= THIS_MODULE,
+	.open		= nvme_cdev_open,
+	.release	= nvme_cdev_release,
+	.unlocked_ioctl	= nvme_cdev_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
+};
+
 #ifdef CONFIG_NVME_MULTIPATH
 static int nvme_ns_head_open(struct block_device *bdev, fmode_t mode)
 {
@@ -3343,6 +3396,9 @@ static inline struct nvme_ns_head *dev_to_ns_head(struct device *dev)
 {
 	struct gendisk *disk = dev_to_disk(dev);
 
+	if (dev->class == nvme_ns_class)
+		return nvme_get_ns_from_cdev(dev)->head;
+
 	if (disk->fops == &nvme_bdev_ops)
 		return nvme_get_ns_from_dev(dev)->head;
 	else
@@ -3474,6 +3530,11 @@ const struct attribute_group *nvme_ns_id_attr_groups[] = {
 	NULL,
 };
 
+const struct attribute_group *nvme_ns_char_id_attr_groups[] = {
+	&nvme_ns_id_attr_group,
+	NULL,
+};
+
 #define nvme_show_str_function(field)						\
 static ssize_t  field##_show(struct device *dev,				\
 			    struct device_attribute *attr, char *buf)		\
@@ -3866,6 +3927,35 @@ struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 }
 EXPORT_SYMBOL_NS_GPL(nvme_find_get_ns, NVME_TARGET_PASSTHRU);
 
+static int nvme_alloc_chardev_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns)
+{
+	char cdisk_name[DISK_NAME_LEN];
+	int ret;
+
+	device_initialize(&ns->cdev_device);
+	ns->cdev_device.devt = MKDEV(MAJOR(nvme_ns_base_chr_devt),
+				     ns->head->instance);
+	ns->cdev_device.class = nvme_ns_class;
+	ns->cdev_device.parent = ctrl->device;
+	ns->cdev_device.groups = nvme_ns_char_id_attr_groups;
+	dev_set_drvdata(&ns->cdev_device, ns);
+
+	sprintf(cdisk_name, "nvme%dn%dc", ctrl->instance, ns->head->instance);
+
+	ret = dev_set_name(&ns->cdev_device, "%s", cdisk_name);
+	if (ret)
+		return ret;
+
+	cdev_init(&ns->cdev, &nvme_cdev_fops);
+	ns->cdev.owner = ctrl->ops->module;
+
+	ret = cdev_device_add(&ns->cdev, &ns->cdev_device);
+	if (ret)
+		kfree_const(ns->cdev_device.kobj.name);
+
+	return ret;
+}
+
 static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 		struct nvme_ns_ids *ids)
 {
@@ -3912,8 +4002,12 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	memcpy(disk->disk_name, disk_name, DISK_NAME_LEN);
 	ns->disk = disk;
 
+	/* When the device does not support any of the features required by the
+	 * kernel (or viceversa), hide the block device. We can still rely on
+	 * the namespace char device for submitting IOCTLs
+	 */
 	if (nvme_update_ns_info(ns, id))
-		goto out_put_disk;
+		disk->flags |= GENHD_FL_HIDDEN;
 
 	if ((ctrl->quirks & NVME_QUIRK_LIGHTNVM) && id->vs[0] == 0x1) {
 		if (nvme_nvm_register(ns, disk_name, node)) {
@@ -3929,9 +4023,12 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	nvme_get_ctrl(ctrl);
 
 	device_add_disk(ctrl->device, ns->disk, nvme_ns_id_attr_groups);
-
 	nvme_mpath_add_disk(ns, id);
 	nvme_fault_inject_init(&ns->fault_inject, ns->disk->disk_name);
+
+	if (nvme_alloc_chardev_ns(ctrl, ns))
+		goto out_put_disk;
+
 	kfree(id);
 
 	return;
@@ -4733,23 +4830,38 @@ static int __init nvme_core_init(void)
 	if (result < 0)
 		goto destroy_delete_wq;
 
+	result = alloc_chrdev_region(&nvme_ns_base_chr_devt, 0,
+			NVME_MINORS, "nvmec");
+	if (result < 0)
+		goto unregister_dev_chrdev;
+
 	nvme_class = class_create(THIS_MODULE, "nvme");
 	if (IS_ERR(nvme_class)) {
 		result = PTR_ERR(nvme_class);
-		goto unregister_chrdev;
+		goto unregister_ns_chrdev;
 	}
 	nvme_class->dev_uevent = nvme_class_uevent;
 
+	nvme_ns_class = class_create(THIS_MODULE, "nvme-ns");
+	if (IS_ERR(nvme_ns_class)) {
+		result = PTR_ERR(nvme_ns_class);
+		goto destroy_dev_class;
+	}
+
 	nvme_subsys_class = class_create(THIS_MODULE, "nvme-subsystem");
 	if (IS_ERR(nvme_subsys_class)) {
 		result = PTR_ERR(nvme_subsys_class);
-		goto destroy_class;
+		goto destroy_ns_class;
 	}
 	return 0;
 
-destroy_class:
+destroy_ns_class:
+	class_destroy(nvme_ns_class);
+destroy_dev_class:
 	class_destroy(nvme_class);
-unregister_chrdev:
+unregister_ns_chrdev:
+	unregister_chrdev_region(nvme_ns_base_chr_devt, NVME_MINORS);
+unregister_dev_chrdev:
 	unregister_chrdev_region(nvme_ctrl_base_chr_devt, NVME_MINORS);
 destroy_delete_wq:
 	destroy_workqueue(nvme_delete_wq);
@@ -4765,6 +4877,7 @@ static void __exit nvme_core_exit(void)
 {
 	class_destroy(nvme_subsys_class);
 	class_destroy(nvme_class);
+	unregister_chrdev_region(nvme_ns_base_chr_devt, NVME_MINORS);
 	unregister_chrdev_region(nvme_ctrl_base_chr_devt, NVME_MINORS);
 	destroy_workqueue(nvme_delete_wq);
 	destroy_workqueue(nvme_reset_wq);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bfcedfa4b057..1dd99f207aee 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -439,6 +439,9 @@ struct nvme_ns {
 	struct kref kref;
 	struct nvme_ns_head *head;
 
+	struct device cdev_device;	/* char device */
+	struct cdev cdev;
+
 	int lba_shift;
 	u16 ms;
 	u16 sgs;
@@ -818,6 +821,11 @@ static inline struct nvme_ns *nvme_get_ns_from_dev(struct device *dev)
 	return dev_to_disk(dev)->private_data;
 }
 
+static inline struct nvme_ns *nvme_get_ns_from_cdev(struct device *dev)
+{
+	return dev_get_drvdata(dev);
+}
+
 #ifdef CONFIG_NVME_HWMON
 int nvme_hwmon_init(struct nvme_ctrl *ctrl);
 #else
-- 
2.17.1

