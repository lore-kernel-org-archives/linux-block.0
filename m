Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C70C4361B
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 12:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCBB823BE0
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 12:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731759AbgLIMoD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Dec 2020 07:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731740AbgLIMn7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Dec 2020 07:43:59 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79FBC0613D6
        for <linux-block@vger.kernel.org>; Wed,  9 Dec 2020 04:43:18 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id b73so1360475edf.13
        for <linux-block@vger.kernel.org>; Wed, 09 Dec 2020 04:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sqhsxuS2emImV6XGj8F5LGT5a7h8FnexIO/q9STo0QE=;
        b=PT8U3bHEQXPoXJ5ExamxougC0DgcAvqbQJsvB4nvxFVI2HQSv2AWnUkLjv+dneykM6
         r9KaB13ysjtXmM8zc+YE7LLZkEKvRVygOsFWs3d3H7xQ2SRgYXtG/lwi11/dshYEJrzB
         WCDUop7Nzq4y9fdMLT9n0h1RCf/p3vIoxVl3iQfvhHc16J8TgKSpO2GCi+hqT/l7vxB0
         0lToG18J3h5CV6Qx3pk9wXqDwTsR1abS16nFwNlZNAE7bWHF+c/tZ8qUBScc6Bw70AUF
         SnUIh93Vu5/9WayCCEmZwiekhVmxDiTg+BkTc2VMmc0v9Py6Tt09r5i6b3hJ9VY5nx8K
         pMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sqhsxuS2emImV6XGj8F5LGT5a7h8FnexIO/q9STo0QE=;
        b=nHHSF1uAkzmh4Si6ZMfS1xYIKEUFwP8AaT2bBdpjjASKk+C52TswZbfvQnkvFibbzp
         tA4jTSWi+qUiX0WwR0RC08u2fsErM5KEsjx28Asx1qD1VhWl2jFcrE0Rt68ivvDk9mre
         pPV5OcAtNmYEZsyg+1s/9C6NJ1U7hIrKeRJXDPdKTMUVyHdFOAUb3nEgyx/XqzIw7h18
         oIOM7ccLP5s8asMIc3lH2WHz2/Oy49ryS8eZBiv1AQy0rSsVEKjnw2ml1zyB3/LwkbAl
         2ZJfMka/EmqJKjh0EpjZAarkvFdw6OTlBfqyKpxLmAkkkp+2u0sl1ClHfhp8P+rQU4Cf
         HFig==
X-Gm-Message-State: AOAM532xiftiC8CY9WCtDz6v+JV0VTce6vO/EGknx4kIud1xm0ddF8q7
        sHEIDEx7ezZAq9GtBCy++iFCeA==
X-Google-Smtp-Source: ABdhPJzz0KEZoG6DqaNhSTPjJ01ty8n7RfP/UOdBfD1QU1WeGhBqH1vHnJoi1GOZcwjTgpb8igyIaw==
X-Received: by 2002:a50:b264:: with SMTP id o91mr1810340edd.7.1607517797639;
        Wed, 09 Dec 2020 04:43:17 -0800 (PST)
Received: from ch-wrk-javier.cnexlabs.com (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id f8sm1546693eds.19.2020.12.09.04.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 04:43:16 -0800 (PST)
From:   javier@javigon.com
X-Google-Original-From: javier.gonz@samsung.com
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, minwoo.im.dev@gmail.com,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>
Subject: [PATCH V3] nvme: enable char device per namespace
Date:   Wed,  9 Dec 2020 13:43:13 +0100
Message-Id: <20201209124313.20723-1-javier.gonz@samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Javier González <javier.gonz@samsung.com>

Create a char device per NVMe namespace. This char device is always
initialized, independently of whether the features implemented by the
device are supported by the kernel. User-space can therefore always
issue IOCTLs to the NVMe driver using the char device.

The char device is presented as /dev/generic-nvmeXcYnZ. This naming
scheme follows the convention of the hidden device (nvmeXcYnZ). Support
for multipath will follow.

Keith: Regarding nvme-cli support, what do you think about reporting the
char device as existing block devices? If this is OK with you, I will
submit patches for the filters.

Changes since V2:
  - Apply a number of naming and code structure improvements (from
    Christoph)
  - Use i_cdev to pull struct nvme_ns in the ioctl path instead of
    populating file->private_data (from Christoph)
  - Change char device and sysfs entries to /dev/generic-nvmeXcYnZ to
    follow the hidden device naming scheme (from Christoph and Keith)

Changes since V1:
  - Remove patches 1-3 which are already picked up by Christoph
  - Change the char device and sysfs entries to nvmeXnYc / c signals
    char device
  - Address Minwoo's comments on inline functions and style

Signed-off-by: Javier González <javier.gonz@samsung.com>
---
 drivers/nvme/host/core.c | 142 ++++++++++++++++++++++++++++++++++-----
 drivers/nvme/host/nvme.h |   8 +++
 2 files changed, 134 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 99f91efe3824..006ac8ee9c7c 100644
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
+static int nvme_disk_ioctl(struct gendisk *disk, unsigned int cmd,
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
 
@@ -1783,6 +1786,12 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 	return ret;
 }
 
+static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
+		      unsigned int cmd, unsigned long arg)
+{
+	return nvme_disk_ioctl(bdev->bd_disk, cmd, arg);
+}
+
 #ifdef CONFIG_COMPAT
 struct nvme_user_io32 {
 	__u8	opcode;
@@ -1824,10 +1833,8 @@ static int nvme_compat_ioctl(struct block_device *bdev, fmode_t mode,
 #define nvme_compat_ioctl	NULL
 #endif /* CONFIG_COMPAT */
 
-static int nvme_open(struct block_device *bdev, fmode_t mode)
+static int nvme_ns_open(struct nvme_ns *ns)
 {
-	struct nvme_ns *ns = bdev->bd_disk->private_data;
-
 #ifdef CONFIG_NVME_MULTIPATH
 	/* should never be called due to GENHD_FL_HIDDEN */
 	if (WARN_ON_ONCE(ns->head->disk))
@@ -1846,14 +1853,22 @@ static int nvme_open(struct block_device *bdev, fmode_t mode)
 	return -ENXIO;
 }
 
-static void nvme_release(struct gendisk *disk, fmode_t mode)
+static void nvme_ns_release(struct nvme_ns *ns)
 {
-	struct nvme_ns *ns = disk->private_data;
-
 	module_put(ns->ctrl->ops->module);
 	nvme_put_ns(ns);
 }
 
+static int nvme_open(struct block_device *bdev, fmode_t mode)
+{
+	return nvme_ns_open(bdev->bd_disk->private_data);
+}
+
+static void nvme_release(struct gendisk *disk, fmode_t mode)
+{
+	nvme_ns_release(disk->private_data);
+}
+
 static int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 {
 	/* some standard values */
@@ -2209,6 +2224,13 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 	return 0;
 
 out_unfreeze:
+	/*
+	 * When the device does not support any of the features required by the
+	 * kernel (or viceversa), hide the block device. We can still rely on
+	 * the namespace char device for submitting IOCTLs
+	 */
+	ns->disk->flags |= GENHD_FL_HIDDEN;
+
 	blk_mq_unfreeze_queue(ns->disk->queue);
 	return ret;
 }
@@ -2346,6 +2368,38 @@ static const struct block_device_operations nvme_bdev_ops = {
 	.pr_ops		= &nvme_pr_ops,
 };
 
+static int nvme_cdev_open(struct inode *inode, struct file *file)
+{
+	struct nvme_ns *ns = container_of(inode->i_cdev, struct nvme_ns, cdev);
+
+	return nvme_ns_open(ns);
+}
+
+static int nvme_cdev_release(struct inode *inode, struct file *file)
+{
+	struct nvme_ns *ns = container_of(inode->i_cdev, struct nvme_ns, cdev);
+
+	nvme_ns_release(ns);
+	return 0;
+}
+
+static long nvme_cdev_ioctl(struct file *file, unsigned int cmd,
+			    unsigned long arg)
+{
+	struct nvme_ns *ns = container_of(file->f_inode->i_cdev,
+				struct nvme_ns, cdev);
+
+	return nvme_disk_ioctl(ns->disk, cmd, arg);
+}
+
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
@@ -3343,6 +3397,9 @@ static inline struct nvme_ns_head *dev_to_ns_head(struct device *dev)
 {
 	struct gendisk *disk = dev_to_disk(dev);
 
+	if (dev->class == nvme_ns_class)
+		return nvme_get_ns_from_cdev(dev)->head;
+
 	if (disk->fops == &nvme_bdev_ops)
 		return nvme_get_ns_from_dev(dev)->head;
 	else
@@ -3474,6 +3531,11 @@ const struct attribute_group *nvme_ns_id_attr_groups[] = {
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
@@ -3866,6 +3928,36 @@ struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
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
+	sprintf(cdisk_name, "nvme-generic-%dc%dn%d", ctrl->subsys->instance,
+		ctrl->instance, ns->head->instance);
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
@@ -3912,8 +4004,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	memcpy(disk->disk_name, disk_name, DISK_NAME_LEN);
 	ns->disk = disk;
 
-	if (nvme_update_ns_info(ns, id))
-		goto out_put_disk;
+	nvme_update_ns_info(ns, id);
 
 	if ((ctrl->quirks & NVME_QUIRK_LIGHTNVM) && id->vs[0] == 0x1) {
 		if (nvme_nvm_register(ns, disk_name, node)) {
@@ -3929,9 +4020,12 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
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
@@ -4733,23 +4827,38 @@ static int __init nvme_core_init(void)
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
@@ -4765,6 +4874,7 @@ static void __exit nvme_core_exit(void)
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

