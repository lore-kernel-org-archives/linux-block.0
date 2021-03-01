Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E2EC433E0
	for <linux-block@archiver.kernel.org>; Mon,  1 Mar 2021 19:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B8CA60231
	for <linux-block@archiver.kernel.org>; Mon,  1 Mar 2021 19:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241930AbhCAT3s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Mar 2021 14:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241485AbhCATZj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Mar 2021 14:25:39 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDE0C061756
        for <linux-block@vger.kernel.org>; Mon,  1 Mar 2021 11:24:58 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id b7so8761251edz.8
        for <linux-block@vger.kernel.org>; Mon, 01 Mar 2021 11:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rv9lq3bFIO3avoEjZ4+xtnNVp+V9BnImfk4aUWZxpa8=;
        b=zviIuxJHCxr8o52lvIOxhHmYPZEfQH/1xT/a3TDzpERqOt2IuR4pQ2g6m0KEmhCmjn
         YWQJzJGRZuVJsAnmOTi2R8/vRw3hcybsBEZ+AuT50NZDIRTodxIiyPifh0bolSbcK5GN
         zzi1fkqVcw94qsxXJ2uBbc/WHtGY1gs75xNcg02qr/jP23xDWiNKFB1Q5d0+7ghdYX+1
         7rxlJfG9yG71p9/ZUxdJVuB5fSKoi7cwanDRPXkGJjFGADbB8Jg7h9BRopKOJKmlExry
         9nZ8k9mZAWYb8hL7xgdSwFZEQz/VC3u55gPp32VyY1OTq4IfxT44N0Mwt2k7mrHDwAqT
         wkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rv9lq3bFIO3avoEjZ4+xtnNVp+V9BnImfk4aUWZxpa8=;
        b=UruIwkaD93ngwn/j0ZFehIp7lgzHOxGYm4IP+v2AExJg3gmUQzL84nnQci9WK26Qta
         8/mGdrSQXXhvqjo8WxkShcXiRrU0tDunPsKDWcmOOdy9KBAFWMF+MpDvsu0wh7TTVFcA
         3EvhwAW0rEE4vwjxiqI6W/yS88+Kt+Jsj5JIQtGSGyq5kAw1pvAnZY308EJqIJ2/cbnB
         bblPKyvi2/InnFS2zVpuabC9hnIR6f9IUeyCDZUh+9SXObhGhpNdNkXKcZrvxTY/Yx53
         wdOSErkIDVJuz1scSmmY6D0jyog9gsd/4t9A8ImiUq9jqM5etsWxXfvIlwnbC6GEvlrT
         KAmw==
X-Gm-Message-State: AOAM533KneCmW9RDuMyHB92ydE4psj1mwT4WQyARSsyYdeIkncQ9V+2v
        jo0EvtPa7rp2cvTesURi51nAww==
X-Google-Smtp-Source: ABdhPJzHD5Th3rJGrAUIOntEwL3hlECfLagMEUPt7iOHni3nM3Z+no28zhgrUFGhFv/ELdOarVCqQw==
X-Received: by 2002:a50:8466:: with SMTP id 93mr17765170edp.55.1614626697182;
        Mon, 01 Mar 2021 11:24:57 -0800 (PST)
Received: from ch-wrk-javier.localdomain (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id i4sm14107110eje.90.2021.03.01.11.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 11:24:56 -0800 (PST)
From:   javier@javigon.com
X-Google-Original-From: javier.gonz@samsung.com
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, minwoo.im.dev@gmail.com,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>
Subject: [PATCH V6 1/2] nvme: enable char device per namespace
Date:   Mon,  1 Mar 2021 20:24:51 +0100
Message-Id: <20210301192452.16770-2-javier.gonz@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210301192452.16770-1-javier.gonz@samsung.com>
References: <20210301192452.16770-1-javier.gonz@samsung.com>
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
 drivers/nvme/host/core.c | 185 +++++++++++++++++++++++++++++++++++----
 drivers/nvme/host/nvme.h |   5 ++
 2 files changed, 174 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d77f3f26d8d3..b94609bc92f4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -86,13 +86,31 @@ static DEFINE_MUTEX(nvme_subsystems_lock);
 
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
 
+/*
+ * These two helpers check whether the given instance is per-namespace
+ * character device (generic device) or not.
+ */
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
@@ -559,7 +577,10 @@ static void nvme_free_ns(struct kref *kref)
 
 	if (ns->ndev)
 		nvme_nvm_unregister(ns);
+	if (nvme_ns_is_generic(ns))
+		ida_simple_remove(&nvme_gen_minor_ida, ns->minor - 1);
 
+	cdev_device_del(&ns->cdev, &ns->cdev_device);
 	put_disk(ns->disk);
 	nvme_put_ns_head(ns->head);
 	nvme_put_ctrl(ns->ctrl);
@@ -1772,15 +1793,15 @@ static int nvme_handle_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
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
 
@@ -1817,6 +1838,12 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
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
@@ -1858,10 +1885,8 @@ static int nvme_compat_ioctl(struct block_device *bdev, fmode_t mode,
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
@@ -1880,14 +1905,22 @@ static int nvme_open(struct block_device *bdev, fmode_t mode)
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
@@ -2205,6 +2238,8 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 	unsigned lbaf = id->flbas & NVME_NS_FLBAS_LBA_MASK;
 	int ret;
 
+	ns->features |= NVME_NS_CHAR_SUPPORTED;
+
 	blk_mq_freeze_queue(ns->disk->queue);
 	ns->lba_shift = id->lbaf[lbaf].ds;
 	nvme_set_queue_limits(ns->ctrl, ns->queue);
@@ -2378,6 +2413,44 @@ static const struct block_device_operations nvme_bdev_ops = {
 	.pr_ops		= &nvme_pr_ops,
 };
 
+static inline struct nvme_ns *dev_to_ns(struct device *dev)
+{
+	return container_of(dev, struct nvme_ns, cdev_device);
+}
+
+static inline struct nvme_ns *cdev_to_ns(struct cdev *cdev)
+{
+	return container_of(cdev, struct nvme_ns, cdev);
+}
+
+static int nvme_cdev_open(struct inode *inode, struct file *file)
+{
+	return nvme_ns_open(cdev_to_ns(inode->i_cdev));
+}
+
+static int nvme_cdev_release(struct inode *inode, struct file *file)
+{
+	nvme_ns_release(cdev_to_ns(inode->i_cdev));
+
+	return 0;
+}
+
+static long nvme_cdev_ioctl(struct file *file, unsigned int cmd,
+			    unsigned long arg)
+{
+	struct nvme_ns *ns = cdev_to_ns(file->f_inode->i_cdev);
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
@@ -3379,6 +3452,9 @@ static inline struct nvme_ns_head *dev_to_ns_head(struct device *dev)
 {
 	struct gendisk *disk = dev_to_disk(dev);
 
+	if (nvme_dev_is_generic(dev))
+		return dev_to_ns(dev)->head;
+
 	if (disk->fops == &nvme_bdev_ops)
 		return nvme_get_ns_from_dev(dev)->head;
 	else
@@ -3488,6 +3564,8 @@ static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
 	}
 #ifdef CONFIG_NVME_MULTIPATH
 	if (a == &dev_attr_ana_grpid.attr || a == &dev_attr_ana_state.attr) {
+		if (nvme_dev_is_generic(dev))
+			return 0;
 		if (dev_to_disk(dev)->fops != &nvme_bdev_ops) /* per-path attr */
 			return 0;
 		if (!nvme_ctrl_use_ana(nvme_get_ns_from_dev(dev)->ctrl))
@@ -3510,6 +3588,11 @@ const struct attribute_group *nvme_ns_id_attr_groups[] = {
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
@@ -3902,6 +3985,47 @@ struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
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
@@ -3948,8 +4072,16 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	memcpy(disk->disk_name, disk_name, DISK_NAME_LEN);
 	ns->disk = disk;
 
-	if (nvme_update_ns_info(ns, id))
-		goto out_put_disk;
+	/*
+	 * If the namespace update fails in a graceful manner, hide the block
+	 * device, but still allow for the namespace char device to be created.
+	 */
+	if (nvme_update_ns_info(ns, id)) {
+		if (ns->features & NVME_NS_CHAR_SUPPORTED)
+			ns->disk->flags |= GENHD_FL_HIDDEN;
+		else
+			goto out_put_disk;
+	}
 
 	if ((ctrl->quirks & NVME_QUIRK_LIGHTNVM) && id->vs[0] == 0x1) {
 		if (nvme_nvm_register(ns, disk_name, node)) {
@@ -3965,9 +4097,14 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
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
@@ -4780,23 +4917,38 @@ static int __init nvme_core_init(void)
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
@@ -4812,6 +4964,7 @@ static void __exit nvme_core_exit(void)
 {
 	class_destroy(nvme_subsys_class);
 	class_destroy(nvme_class);
+	unregister_chrdev_region(nvme_ns_base_chr_devt, NVME_MINORS);
 	unregister_chrdev_region(nvme_ctrl_base_chr_devt, NVME_MINORS);
 	destroy_workqueue(nvme_delete_wq);
 	destroy_workqueue(nvme_reset_wq);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 07b34175c6ce..a145eaa7f86f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -425,6 +425,7 @@ struct nvme_ns_head {
 enum nvme_ns_features {
 	NVME_NS_EXT_LBAS = 1 << 0, /* support extended LBA format */
 	NVME_NS_METADATA_SUPPORTED = 1 << 1, /* support getting generated md */
+	NVME_NS_CHAR_SUPPORTED = 1 << 2, /* support for char device */
 };
 
 struct nvme_ns {
@@ -442,6 +443,10 @@ struct nvme_ns {
 	struct kref kref;
 	struct nvme_ns_head *head;
 
+	struct device cdev_device;	/* char device */
+	struct cdev cdev;
+	int minor;
+
 	int lba_shift;
 	u16 ms;
 	u16 sgs;
-- 
2.17.1

