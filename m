Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91101C4361B
	for <linux-block@archiver.kernel.org>; Wed, 16 Dec 2020 18:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43912253A1
	for <linux-block@archiver.kernel.org>; Wed, 16 Dec 2020 18:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbgLPSTP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Dec 2020 13:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730021AbgLPSTP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Dec 2020 13:19:15 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5217DC061794
        for <linux-block@vger.kernel.org>; Wed, 16 Dec 2020 10:18:34 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id n26so34098518eju.6
        for <linux-block@vger.kernel.org>; Wed, 16 Dec 2020 10:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SX4WelKyM2LV1FT7S52XDF7hvQFsLxridjGFW3RI2lU=;
        b=vSUNcXWMTfyoHP2nzczHokA2n/lyzQ+CWFJPKZft5FF7qFySc1xTVJXPG6ZsPq5xJ8
         wqgUdgUccD7jpFsh2TEZ9rg1+aOe7Fq3kCF/AboLA1gp6B1lLXDjYrwlFUlApLh+ee7H
         aRb4/bNtpBgbpfzpYQoCc5/Eme0mwRJ3Ax/esQNNfoswTLIZN65NzC2UkkkEI9WgQEaP
         u4gjDHsgiq4zIS15jWqmDYiAYTc0kHsDrKib/VIu9q6MLjBQlD8l6zMHpxbNVHNwzQHk
         OCO6jJcQTfPX/YwusAJAMauR4WBn9KeOKd2IosXf3AXra1t+DqkjXrZO9wDWy0WEr1g4
         q+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SX4WelKyM2LV1FT7S52XDF7hvQFsLxridjGFW3RI2lU=;
        b=SZrLxj4QBslT5BKKmdHtdT5RS5oPKjsF7varAm+ZCxHT0ljtmtEAVEWkR38HpzlJOj
         M8qlZRN2WwkHZPkIVZmP4G3JlEM3pWyMBqe1R4pl/ey6HOGjnugbYSwXXHm4KF5VELSP
         axPhcdnvq0pG7/ZEdaH7qfS9mrsbRSYct8+qg1MsufYcNIa+2sgtudrD9aLWRO1+YNxT
         ryhDgoIiNKB3QlTm18IYAYPyDyaNW+tSjVcn3Y4F2BneacNYyasDpcbsJ5V2ab29qXt6
         kaPrrPlm4ujJBEd+Ya8BkxZYdInKxj7Er+1k0zNibJbAHAatWZWMLSVqpTNxCsHn46dZ
         JVCw==
X-Gm-Message-State: AOAM530afE18eg8ooiGHhssoWXORgXPJ58nNoHo/J7svq98g7oiZawRs
        5Tzu4+0EML2RG88VdEs+scIL6Q==
X-Google-Smtp-Source: ABdhPJzOlKMu10aiozk9lIAYsQknU0+AkKB2jgOsAXrfn23PeE4qEQ0UWoTTJ+OV7ivX6NhmAU+Kmg==
X-Received: by 2002:a17:906:cecd:: with SMTP id si13mr11946308ejb.441.1608142712797;
        Wed, 16 Dec 2020 10:18:32 -0800 (PST)
Received: from ch-wrk-javier.localdomain (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id k23sm1948451ejs.100.2020.12.16.10.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 10:18:32 -0800 (PST)
From:   javier@javigon.com
X-Google-Original-From: javier.gonz@samsung.com
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, minwoo.im.dev@gmail.com,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>
Subject: [PATCH V4] nvme: enable char device per namespace
Date:   Wed, 16 Dec 2020 19:18:28 +0100
Message-Id: <20201216181828.21040-1-javier.gonz@samsung.com>
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

Keith: Regarding nvme-cli support, should the generic handle show up in
place such as 'nvme list'? If so, I can send a patch for the filters.

Changes since V3 (merged patch from keith)
  - Use a dedicated ida for the generic handle
  - Do not abort namespace greation if the generic handle fails

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
 drivers/nvme/host/core.c | 159 +++++++++++++++++++++++++++++++++++----
 drivers/nvme/host/nvme.h |   9 +++
 2 files changed, 152 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 99f91efe3824..d1ee462f41fa 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -86,7 +86,11 @@ static DEFINE_MUTEX(nvme_subsystems_lock);
 
 static DEFINE_IDA(nvme_instance_ida);
 static dev_t nvme_ctrl_base_chr_devt;
+
+static DEFINE_IDA(nvme_gen_minor_ida);
+static dev_t nvme_ns_base_chr_devt;
 static struct class *nvme_class;
+static struct class *nvme_ns_class;
 static struct class *nvme_subsys_class;
 
 static void nvme_put_subsystem(struct nvme_subsystem *subsys);
@@ -537,7 +541,10 @@ static void nvme_free_ns(struct kref *kref)
 
 	if (ns->ndev)
 		nvme_nvm_unregister(ns);
+	if (ns->minor)
+		ida_simple_remove(&nvme_gen_minor_ida, ns->minor - 1);
 
+	cdev_device_del(&ns->cdev, &ns->cdev_device);
 	put_disk(ns->disk);
 	nvme_put_ns_head(ns->head);
 	nvme_put_ctrl(ns->ctrl);
@@ -1738,15 +1745,15 @@ static int nvme_handle_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
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
 
@@ -1783,6 +1790,12 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
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
@@ -1824,10 +1837,8 @@ static int nvme_compat_ioctl(struct block_device *bdev, fmode_t mode,
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
@@ -1846,14 +1857,22 @@ static int nvme_open(struct block_device *bdev, fmode_t mode)
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
@@ -2209,6 +2228,13 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
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
@@ -2346,6 +2372,38 @@ static const struct block_device_operations nvme_bdev_ops = {
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
@@ -3343,6 +3401,9 @@ static inline struct nvme_ns_head *dev_to_ns_head(struct device *dev)
 {
 	struct gendisk *disk = dev_to_disk(dev);
 
+	if (dev->class == nvme_ns_class)
+		return nvme_get_ns_from_cdev(dev)->head;
+
 	if (disk->fops == &nvme_bdev_ops)
 		return nvme_get_ns_from_dev(dev)->head;
 	else
@@ -3474,6 +3535,11 @@ const struct attribute_group *nvme_ns_id_attr_groups[] = {
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
@@ -3866,6 +3932,47 @@ struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 }
 EXPORT_SYMBOL_NS_GPL(nvme_find_get_ns, NVME_TARGET_PASSTHRU);
 
+static int nvme_alloc_chardev_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns)
+{
+	char cdisk_name[DISK_NAME_LEN];
+	int ret;
+
+	ret = ida_simple_get(&nvme_gen_minor_ida, 0, 0, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+
+	ns->minor = ret + 1;
+	device_initialize(&ns->cdev_device);
+	ns->cdev_device.devt = MKDEV(MAJOR(nvme_ns_base_chr_devt), ret);
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
+		goto put_ida;
+
+	cdev_init(&ns->cdev, &nvme_cdev_fops);
+	ns->cdev.owner = ctrl->ops->module;
+
+	ret = cdev_device_add(&ns->cdev, &ns->cdev_device);
+	if (ret)
+		goto free_kobj;
+
+	return ret;
+
+free_kobj:
+	kfree_const(ns->cdev_device.kobj.name);
+put_ida:
+	ida_simple_remove(&nvme_gen_minor_ida, ns->minor - 1);
+	ns->minor = 0;
+	return ret;
+}
+
 static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 		struct nvme_ns_ids *ids)
 {
@@ -3912,8 +4019,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	memcpy(disk->disk_name, disk_name, DISK_NAME_LEN);
 	ns->disk = disk;
 
-	if (nvme_update_ns_info(ns, id))
-		goto out_put_disk;
+	nvme_update_ns_info(ns, id);
 
 	if ((ctrl->quirks & NVME_QUIRK_LIGHTNVM) && id->vs[0] == 0x1) {
 		if (nvme_nvm_register(ns, disk_name, node)) {
@@ -3929,9 +4035,14 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	nvme_get_ctrl(ctrl);
 
 	device_add_disk(ctrl->device, ns->disk, nvme_ns_id_attr_groups);
-
 	nvme_mpath_add_disk(ns, id);
 	nvme_fault_inject_init(&ns->fault_inject, ns->disk->disk_name);
+
+	if (nvme_alloc_chardev_ns(ctrl, ns))
+		dev_warn(ctrl->device,
+			"failed to create generic handle for nsid:%d\n",
+			nsid);
+
 	kfree(id);
 
 	return;
@@ -4733,23 +4844,38 @@ static int __init nvme_core_init(void)
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
@@ -4765,6 +4891,7 @@ static void __exit nvme_core_exit(void)
 {
 	class_destroy(nvme_subsys_class);
 	class_destroy(nvme_class);
+	unregister_chrdev_region(nvme_ns_base_chr_devt, NVME_MINORS);
 	unregister_chrdev_region(nvme_ctrl_base_chr_devt, NVME_MINORS);
 	destroy_workqueue(nvme_delete_wq);
 	destroy_workqueue(nvme_reset_wq);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bfcedfa4b057..1e52f7da82de 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -439,6 +439,10 @@ struct nvme_ns {
 	struct kref kref;
 	struct nvme_ns_head *head;
 
+	struct device cdev_device;	/* char device */
+	struct cdev cdev;
+	int minor;
+
 	int lba_shift;
 	u16 ms;
 	u16 sgs;
@@ -818,6 +822,11 @@ static inline struct nvme_ns *nvme_get_ns_from_dev(struct device *dev)
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

