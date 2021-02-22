Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C59C433E0
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 19:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A25C764E12
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 19:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhBVTCU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Feb 2021 14:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbhBVTBx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Feb 2021 14:01:53 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFC2C06178A
        for <linux-block@vger.kernel.org>; Mon, 22 Feb 2021 11:01:12 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id hs11so31122277ejc.1
        for <linux-block@vger.kernel.org>; Mon, 22 Feb 2021 11:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fjdnbz/KKZ8VL/osDjzbfGtDSRNHFNL+hrel03gTOo8=;
        b=BZsxd3+hV9Xfb/93Ladx71qfFeIeI1JkqnCfKQ6+nZ8RhQkdc2klexpK2nquhJ/nKc
         ur8ZidRYDFIP0J617yMowUBkmptfdkMCgZOWeIdH4SQxPG2GIYneUllM7kJ4w3NQUKmL
         7AVo+2+MXerkWoTnQqoGkU9MyIyisNgortTLD/RHWkdEH7eTSIi9D9Aw8ZOgB2FJ++1d
         dzrJaT7a0oGHlh9Yu5TwZt2csAoLjpYvcafWHKMG03CGxdHzQXrClwozkCv4XEixmCbK
         WxI2CRHdmS97zhNIcMSL2C9VxxvJ5dCoZlMbfSeatvVeYhxZy4CMnYhFsuCjgFuVkQNH
         kcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fjdnbz/KKZ8VL/osDjzbfGtDSRNHFNL+hrel03gTOo8=;
        b=o8Cg00T2TYQvPsIZoyaIs9WkXq4YRWPS7TQ4mVRo/2QTjKYORh2v/t3MI8i+HApeDh
         las7ByrnkOuPg0TpofKWMPbrrQP2oDIS3DxGuwrNZV6+kGBuxZq8TbKzPXqrH1qkeyVT
         C+RMeNNaLmfWLHiPqXPpduCnytpIhAWPbb/876s3hZOK7aGDUdK1zjbXH2g5O1cYCmwt
         9bHy7u4ETqcuUGtMvwKbglm/YTVMWDGtRd5UZY1KXpUDktprxds+wze7IDq0Q2rA2vkF
         D3Ak//BWuFldOan+o6fhXzqKtZhFDUEHfYBgJdrKwQs6WRlqeYDqXwgHBjGBBZ7WmDOO
         DOwQ==
X-Gm-Message-State: AOAM531ZJlqEWtoEQExXlEfFyyFZyB1HOp+YTG5sGoVVsY6YwbkmVenO
        5OuYdUL5KXhhf5doUZA/sAX0rbUyR+9EDODPy58=
X-Google-Smtp-Source: ABdhPJywZ52Uzif46P5VIB34urWxH5g5dKgy5XY8++/JiQjzV6agBwm8Ddmv3gBDJB+owMZ3LlVhBg==
X-Received: by 2002:a17:906:7c4f:: with SMTP id g15mr22469830ejp.184.1614020471454;
        Mon, 22 Feb 2021 11:01:11 -0800 (PST)
Received: from ch-wrk-javier.localdomain (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id d23sm9204528ejw.109.2021.02.22.11.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 11:01:11 -0800 (PST)
From:   javier@javigon.com
X-Google-Original-From: javier.gonz@samsung.com
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, minwoo.im.dev@gmail.com,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>
Subject: [PATCH V5 1/2] nvme: enable char device per namespace
Date:   Mon, 22 Feb 2021 20:01:06 +0100
Message-Id: <20210222190107.8479-2-javier.gonz@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210222190107.8479-1-javier.gonz@samsung.com>
References: <20210222190107.8479-1-javier.gonz@samsung.com>
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

The char device is presented as /dev/nvme-generic-XcYnZ. This naming
scheme follows the convention of the hidden device (nvmeXcYnZ). Support
for multipath will follow.

Signed-off-by: Javier González <javier.gonz@samsung.com>
Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 drivers/nvme/host/core.c | 171 +++++++++++++++++++++++++++++++++++----
 drivers/nvme/host/nvme.h |   9 +++
 2 files changed, 164 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d77f3f26d8d3..d4884105ad95 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -86,13 +86,27 @@ static DEFINE_MUTEX(nvme_subsystems_lock);
 
 static DEFINE_IDA(nvme_instance_ida);
 static dev_t nvme_ctrl_base_chr_devt;
+
+static DEFINE_IDA(nvme_gen_minor_ida);
+static dev_t nvme_ns_base_chr_devt;
 static struct class *nvme_class;
+static struct class *nvme_ns_class;
 static struct class *nvme_subsys_class;
 
 static void nvme_put_subsystem(struct nvme_subsystem *subsys);
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 					   unsigned nsid);
 
+static inline bool nvme_dev_is_generic(struct device *dev)
+{
+	return dev->class == nvme_ns_class;
+}
+
+static inline bool nvme_ns_is_generic(struct nvme_ns *ns)
+{
+	return !!ns->minor;
+}
+
 /*
  * Prepare a queue for teardown.
  *
@@ -559,7 +573,10 @@ static void nvme_free_ns(struct kref *kref)
 
 	if (ns->ndev)
 		nvme_nvm_unregister(ns);
+	if (nvme_ns_is_generic(ns))
+		ida_simple_remove(&nvme_gen_minor_ida, ns->minor - 1);
 
+	cdev_device_del(&ns->cdev, &ns->cdev_device);
 	put_disk(ns->disk);
 	nvme_put_ns_head(ns->head);
 	nvme_put_ctrl(ns->ctrl);
@@ -1772,15 +1789,15 @@ static int nvme_handle_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
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
 
@@ -1817,6 +1834,12 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
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
@@ -1858,10 +1881,8 @@ static int nvme_compat_ioctl(struct block_device *bdev, fmode_t mode,
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
@@ -1880,14 +1901,22 @@ static int nvme_open(struct block_device *bdev, fmode_t mode)
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
@@ -2241,6 +2270,13 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
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
@@ -2378,6 +2414,38 @@ static const struct block_device_operations nvme_bdev_ops = {
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
@@ -3379,6 +3447,9 @@ static inline struct nvme_ns_head *dev_to_ns_head(struct device *dev)
 {
 	struct gendisk *disk = dev_to_disk(dev);
 
+	if (nvme_dev_is_generic(dev))
+		return nvme_get_ns_from_cdev(dev)->head;
+
 	if (disk->fops == &nvme_bdev_ops)
 		return nvme_get_ns_from_dev(dev)->head;
 	else
@@ -3488,6 +3559,8 @@ static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
 	}
 #ifdef CONFIG_NVME_MULTIPATH
 	if (a == &dev_attr_ana_grpid.attr || a == &dev_attr_ana_state.attr) {
+		if (nvme_dev_is_generic(dev))
+			return 0;
 		if (dev_to_disk(dev)->fops != &nvme_bdev_ops) /* per-path attr */
 			return 0;
 		if (!nvme_ctrl_use_ana(nvme_get_ns_from_dev(dev)->ctrl))
@@ -3510,6 +3583,11 @@ const struct attribute_group *nvme_ns_id_attr_groups[] = {
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
@@ -3902,6 +3980,47 @@ struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
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
@@ -3948,8 +4067,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	memcpy(disk->disk_name, disk_name, DISK_NAME_LEN);
 	ns->disk = disk;
 
-	if (nvme_update_ns_info(ns, id))
-		goto out_put_disk;
+	nvme_update_ns_info(ns, id);
 
 	if ((ctrl->quirks & NVME_QUIRK_LIGHTNVM) && id->vs[0] == 0x1) {
 		if (nvme_nvm_register(ns, disk_name, node)) {
@@ -3965,9 +4083,14 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
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
@@ -4780,23 +4903,38 @@ static int __init nvme_core_init(void)
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
@@ -4812,6 +4950,7 @@ static void __exit nvme_core_exit(void)
 {
 	class_destroy(nvme_subsys_class);
 	class_destroy(nvme_class);
+	unregister_chrdev_region(nvme_ns_base_chr_devt, NVME_MINORS);
 	unregister_chrdev_region(nvme_ctrl_base_chr_devt, NVME_MINORS);
 	destroy_workqueue(nvme_delete_wq);
 	destroy_workqueue(nvme_reset_wq);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 07b34175c6ce..8528caab61c5 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -442,6 +442,10 @@ struct nvme_ns {
 	struct kref kref;
 	struct nvme_ns_head *head;
 
+	struct device cdev_device;	/* char device */
+	struct cdev cdev;
+	int minor;
+
 	int lba_shift;
 	u16 ms;
 	u16 sgs;
@@ -819,6 +823,11 @@ static inline struct nvme_ns *nvme_get_ns_from_dev(struct device *dev)
 	return dev_to_disk(dev)->private_data;
 }
 
+static inline struct nvme_ns *nvme_get_ns_from_cdev(struct device *dev)
+{
+	return dev_get_drvdata(dev);
+}
+
 #ifdef CONFIG_NVME_HWMON
 int nvme_hwmon_init(struct nvme_ctrl *ctrl);
 void nvme_hwmon_exit(struct nvme_ctrl *ctrl);
-- 
2.17.1

