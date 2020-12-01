Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28282C64E90
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 12:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A76BB20857
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 12:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="NLwwJ4wN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388140AbgLAM5D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Dec 2020 07:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgLAM5A (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Dec 2020 07:57:00 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE399C0617A7
        for <linux-block@vger.kernel.org>; Tue,  1 Dec 2020 04:56:19 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id l5so3036036edq.11
        for <linux-block@vger.kernel.org>; Tue, 01 Dec 2020 04:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nu4i8+4GBsk/a/34aUwhlUNnDlkBrmJ8PlbnA/APAJM=;
        b=NLwwJ4wNWpFfJoYT8pcQU9oRaFmgRg+uvhSds5tb1IgB+Btv8/ottAfmxeJrjOTfzm
         XEKqElhFHeQCSElDcYHR11MVZ1VuebXwE24p5vO/9hioBdPUfqNbLke6DmM3oE2jSVVh
         897VDTZYDiJFG66/nndkTE1nLr2UelsDQqulTsJlv+r/CS/h3WGs6gtCXUB7AsjmGLo3
         NV/xIE0meVP7hrttfgqjxp7NSUEW8eUytksxuFrZDFXQMoNQnyobPuaSM3OFaJqwj5p0
         HBte6Z4MJnbmIpPRka7YSxJegE3DF1nBN2m0n8kpj2CNxN/i9mbisouIezac7BC7VbA1
         7tUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nu4i8+4GBsk/a/34aUwhlUNnDlkBrmJ8PlbnA/APAJM=;
        b=rBcwbGQxWkDX5S7siXA7qJDyQE3nKrPDk6Wh9Zsu7mg9652zrWIy4eK7lnQtDtXJkx
         P/zUohnPR9HfIek3g3ocg9jLNHWlipn4V42V/sBuR8mBcW8srfpuuMVNEpcqq8m0Xkgy
         mOxWekDvdNWqE1Jm9Z2LRS2S/mSZ8Yz7uAZU0KE8ahy8DWRepLuJTqIvIV77tLWzfBFz
         0HSVaX+3DO/+V1Vj1WINZ0vqQBfN6DtLbQIic33/EnidNFm9qVf+SJ55twKb3Ucj4PVg
         yGSnPLtmEHPxejpE7+Rlzdg9thn7CYl/PgUVgtu8fDHkDp3KQZ8tYz0JCeWXkSETBIVm
         KRJg==
X-Gm-Message-State: AOAM531cTZUWJNPNQA7yAGkMLt+4o/6ybUz0aAdgDMj1+KD85pVVIf1a
        8hMvGM5Q/h30FPxNL73eI1eCvg==
X-Google-Smtp-Source: ABdhPJzz5pTwzbu1PD5aW260CIbDPs9e9M5OJnQFulQoh0G5riZg3GLIIR0aTuao5F0EbRz2XtZAAw==
X-Received: by 2002:aa7:d456:: with SMTP id q22mr3032586edr.206.1606827378485;
        Tue, 01 Dec 2020 04:56:18 -0800 (PST)
Received: from ch-wrk-javier.localdomain (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id be6sm796864edb.29.2020.12.01.04.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 04:56:17 -0800 (PST)
From:   javier@javigon.com
X-Google-Original-From: javier.gonz@samsung.com
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>
Subject: [PATCH 4/4] nvme: enable char device per namespace
Date:   Tue,  1 Dec 2020 13:56:10 +0100
Message-Id: <20201201125610.17138-5-javier.gonz@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201201125610.17138-1-javier.gonz@samsung.com>
References: <20201201125610.17138-1-javier.gonz@samsung.com>
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

The char device is presented as /dev/nvmeXcYnZ to follow the hidden
block device. This naming also aligns with nvme-cli filters, so the char
device should be usable without tool changes.

Signed-off-by: Javier González <javier.gonz@samsung.com>
---
 drivers/nvme/host/core.c | 144 +++++++++++++++++++++++++++++++++++----
 drivers/nvme/host/nvme.h |   3 +
 2 files changed, 132 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2c23ea6dc296..9c4acf2725f3 100644
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
@@ -497,6 +499,7 @@ static void nvme_free_ns(struct kref *kref)
 	if (ns->ndev)
 		nvme_nvm_unregister(ns);
 
+	cdev_device_del(&ns->cdev, &ns->cdev_device);
 	put_disk(ns->disk);
 	nvme_put_ns_head(ns->head);
 	nvme_put_ctrl(ns->ctrl);
@@ -1696,15 +1699,15 @@ static int nvme_handle_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
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
 
@@ -1741,6 +1744,18 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
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
@@ -1782,10 +1797,8 @@ static int nvme_compat_ioctl(struct block_device *bdev, fmode_t mode,
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
@@ -1804,12 +1817,24 @@ static int nvme_open(struct block_device *bdev, fmode_t mode)
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
@@ -1821,6 +1846,26 @@ static int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo)
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
@@ -2303,6 +2348,14 @@ static const struct block_device_operations nvme_bdev_ops = {
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
@@ -3301,6 +3354,9 @@ static inline struct nvme_ns_head *dev_to_ns_head(struct device *dev)
 {
 	struct gendisk *disk = dev_to_disk(dev);
 
+	if (dev->class == nvme_ns_class)
+		return ((struct nvme_ns *)dev_get_drvdata(dev))->head;
+
 	if (disk->fops == &nvme_bdev_ops)
 		return nvme_get_ns_from_dev(dev)->head;
 	else
@@ -3390,7 +3446,7 @@ static struct attribute *nvme_ns_id_attrs[] = {
 };
 
 static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
-		struct attribute *a, int n)
+	       struct attribute *a, int n)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
 	struct nvme_ns_ids *ids = &dev_to_ns_head(dev)->ids;
@@ -3432,6 +3488,11 @@ const struct attribute_group *nvme_ns_id_attr_groups[] = {
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
@@ -3824,6 +3885,36 @@ struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 }
 EXPORT_SYMBOL_NS_GPL(nvme_find_get_ns, NVME_TARGET_PASSTHRU);
 
+static int nvme_alloc_chardev_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns)
+{
+	char cdisk_name[DISK_NAME_LEN];
+	int ret = 0;
+
+	device_initialize(&ns->cdev_device);
+	ns->cdev_device.devt = MKDEV(MAJOR(nvme_ns_base_chr_devt),
+				     ns->head->instance);
+	ns->cdev_device.class = nvme_ns_class;
+	ns->cdev_device.parent = ctrl->device;
+	ns->cdev_device.groups = nvme_ns_char_id_attr_groups;
+	dev_set_drvdata(&ns->cdev_device, ns);
+
+	sprintf(cdisk_name, "nvme%dc%dn%d", ctrl->subsys->instance,
+			ctrl->instance, ns->head->instance);
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
@@ -3870,8 +3961,12 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
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
@@ -3887,9 +3982,12 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
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
@@ -4685,23 +4783,38 @@ static int __init nvme_core_init(void)
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
@@ -4717,6 +4830,7 @@ static void __exit nvme_core_exit(void)
 {
 	class_destroy(nvme_subsys_class);
 	class_destroy(nvme_class);
+	unregister_chrdev_region(nvme_ns_base_chr_devt, NVME_MINORS);
 	unregister_chrdev_region(nvme_ctrl_base_chr_devt, NVME_MINORS);
 	destroy_workqueue(nvme_delete_wq);
 	destroy_workqueue(nvme_reset_wq);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index cdfce7250da0..533bd54f9194 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -436,6 +436,9 @@ struct nvme_ns {
 	struct kref kref;
 	struct nvme_ns_head *head;
 
+	struct device cdev_device;	/* char device */
+	struct cdev cdev;
+
 	int lba_shift;
 	u16 ms;
 	u16 sgs;
-- 
2.17.1

