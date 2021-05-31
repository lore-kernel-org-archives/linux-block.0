Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BD1C47082
	for <linux-block@archiver.kernel.org>; Mon, 31 May 2021 07:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B960610A0
	for <linux-block@archiver.kernel.org>; Mon, 31 May 2021 07:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhEaH1U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 May 2021 03:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbhEaH1R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 May 2021 03:27:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0E9C0613ED
        for <linux-block@vger.kernel.org>; Mon, 31 May 2021 00:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=wvTZiINnq4ilxn025toNzgEAkT4+qJ1Tke0tWuVbRY4=; b=GzRIsABvqGsbz1ZD94u1rMKeph
        Z6znw1hfdchFu815ZDbcdSz0AJsO9pahEqip2FYQNSIU774aNLJAwyJ4htPiIhqp79Cyd3ds005Lf
        si/ASfsQxwqENoTVffUJDDC4sCyUV+abrcGYCK8lUWMEZ2FUlf3GagdE42iuKY+frlGYepEfr/yol
        EWNiDZchz/Y9+xjbjL/+oY0qbazntCEAeTSKg6144vgM89Y5T6JMkNTo6ru2MaQ50aH8sEGzsWsNJ
        4vg3GlEcvrT/tA7tONkVYWNEjGoK+ZWkSByGT+Pe471Se+P7QyirfMyOQ5kLYG3bXtKuyGgoPqSTC
        Jxm8Q9GQ==;
Received: from shol69.static.otenet.gr ([83.235.170.67] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lncIj-00BBUI-Ue; Mon, 31 May 2021 07:25:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] remove the raw driver
Date:   Mon, 31 May 2021 10:25:26 +0300
Message-Id: <20210531072526.97052-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The raw driver used to provide direct unbuffered access to block devices
before O_DIRECT was invented.  It has been obsolete for more than a
decade.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/char/Kconfig     |  21 ---
 drivers/char/Makefile    |   1 -
 drivers/char/mem.c       |   1 -
 drivers/char/raw.c       | 362 ---------------------------------------
 fs/block_dev.c           |   6 +-
 include/linux/fs.h       |   3 -
 include/uapi/linux/raw.h |  17 --
 7 files changed, 2 insertions(+), 409 deletions(-)
 delete mode 100644 drivers/char/raw.c
 delete mode 100644 include/uapi/linux/raw.h

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index b151e0fcdeb5..8e516aad632b 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -357,27 +357,6 @@ config NVRAM
 	  To compile this driver as a module, choose M here: the
 	  module will be called nvram.
 
-config RAW_DRIVER
-	tristate "RAW driver (/dev/raw/rawN)"
-	depends on BLOCK
-	help
-	  The raw driver permits block devices to be bound to /dev/raw/rawN.
-	  Once bound, I/O against /dev/raw/rawN uses efficient zero-copy I/O.
-	  See the raw(8) manpage for more details.
-
-	  Applications should preferably open the device (eg /dev/hda1)
-	  with the O_DIRECT flag.
-
-config MAX_RAW_DEVS
-	int "Maximum number of RAW devices to support (1-65536)"
-	depends on RAW_DRIVER
-	range 1 65536
-	default "256"
-	help
-	  The maximum number of RAW devices that are supported.
-	  Default is 256. Increase this number in case you need lots of
-	  raw devices.
-
 config DEVPORT
 	bool "/dev/port character device"
 	depends on ISA || PCI
diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index ffce287ef415..96128e849d6a 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -8,7 +8,6 @@ obj-$(CONFIG_TTY_PRINTK)	+= ttyprintk.o
 obj-y				+= misc.o
 obj-$(CONFIG_ATARI_DSP56K)	+= dsp56k.o
 obj-$(CONFIG_VIRTIO_CONSOLE)	+= virtio_console.o
-obj-$(CONFIG_RAW_DRIVER)	+= raw.o
 obj-$(CONFIG_MSPEC)		+= mspec.o
 obj-$(CONFIG_UV_MMTIMER)	+= uv_mmtimer.o
 obj-$(CONFIG_IBM_BSR)		+= bsr.o
diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 15dc54fa1d47..1c596b5cdb27 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -16,7 +16,6 @@
 #include <linux/mman.h>
 #include <linux/random.h>
 #include <linux/init.h>
-#include <linux/raw.h>
 #include <linux/tty.h>
 #include <linux/capability.h>
 #include <linux/ptrace.h>
diff --git a/drivers/char/raw.c b/drivers/char/raw.c
deleted file mode 100644
index 5d52a1f4738c..000000000000
--- a/drivers/char/raw.c
+++ /dev/null
@@ -1,362 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * linux/drivers/char/raw.c
- *
- * Front-end raw character devices.  These can be bound to any block
- * devices to provide genuine Unix raw character device semantics.
- *
- * We reserve minor number 0 for a control interface.  ioctl()s on this
- * device are used to bind the other minor numbers to block devices.
- */
-
-#include <linux/init.h>
-#include <linux/fs.h>
-#include <linux/major.h>
-#include <linux/blkdev.h>
-#include <linux/backing-dev.h>
-#include <linux/module.h>
-#include <linux/raw.h>
-#include <linux/capability.h>
-#include <linux/uio.h>
-#include <linux/cdev.h>
-#include <linux/device.h>
-#include <linux/mutex.h>
-#include <linux/gfp.h>
-#include <linux/compat.h>
-#include <linux/vmalloc.h>
-
-#include <linux/uaccess.h>
-
-struct raw_device_data {
-	dev_t binding;
-	struct block_device *bdev;
-	int inuse;
-};
-
-static struct class *raw_class;
-static struct raw_device_data *raw_devices;
-static DEFINE_MUTEX(raw_mutex);
-static const struct file_operations raw_ctl_fops; /* forward declaration */
-
-static int max_raw_minors = CONFIG_MAX_RAW_DEVS;
-
-module_param(max_raw_minors, int, 0);
-MODULE_PARM_DESC(max_raw_minors, "Maximum number of raw devices (1-65536)");
-
-/*
- * Open/close code for raw IO.
- *
- * We just rewrite the i_mapping for the /dev/raw/rawN file descriptor to
- * point at the blockdev's address_space and set the file handle to use
- * O_DIRECT.
- *
- * Set the device's soft blocksize to the minimum possible.  This gives the
- * finest possible alignment and has no adverse impact on performance.
- */
-static int raw_open(struct inode *inode, struct file *filp)
-{
-	const int minor = iminor(inode);
-	struct block_device *bdev;
-	int err;
-
-	if (minor == 0) {	/* It is the control device */
-		filp->f_op = &raw_ctl_fops;
-		return 0;
-	}
-
-	pr_warn_ratelimited(
-		"process %s (pid %d) is using the deprecated raw device\n"
-		"support will be removed in Linux 5.14.\n",
-		current->comm, current->pid);
-
-	mutex_lock(&raw_mutex);
-
-	/*
-	 * All we need to do on open is check that the device is bound.
-	 */
-	err = -ENODEV;
-	if (!raw_devices[minor].binding)
-		goto out;
-	bdev = blkdev_get_by_dev(raw_devices[minor].binding,
-				 filp->f_mode | FMODE_EXCL, raw_open);
-	if (IS_ERR(bdev)) {
-		err = PTR_ERR(bdev);
-		goto out;
-	}
-	err = set_blocksize(bdev, bdev_logical_block_size(bdev));
-	if (err)
-		goto out1;
-	filp->f_flags |= O_DIRECT;
-	filp->f_mapping = bdev->bd_inode->i_mapping;
-	if (++raw_devices[minor].inuse == 1)
-		file_inode(filp)->i_mapping =
-			bdev->bd_inode->i_mapping;
-	filp->private_data = bdev;
-	raw_devices[minor].bdev = bdev;
-	mutex_unlock(&raw_mutex);
-	return 0;
-
-out1:
-	blkdev_put(bdev, filp->f_mode | FMODE_EXCL);
-out:
-	mutex_unlock(&raw_mutex);
-	return err;
-}
-
-/*
- * When the final fd which refers to this character-special node is closed, we
- * make its ->mapping point back at its own i_data.
- */
-static int raw_release(struct inode *inode, struct file *filp)
-{
-	const int minor= iminor(inode);
-	struct block_device *bdev;
-
-	mutex_lock(&raw_mutex);
-	bdev = raw_devices[minor].bdev;
-	if (--raw_devices[minor].inuse == 0)
-		/* Here  inode->i_mapping == bdev->bd_inode->i_mapping  */
-		inode->i_mapping = &inode->i_data;
-	mutex_unlock(&raw_mutex);
-
-	blkdev_put(bdev, filp->f_mode | FMODE_EXCL);
-	return 0;
-}
-
-/*
- * Forward ioctls to the underlying block device.
- */
-static long
-raw_ioctl(struct file *filp, unsigned int command, unsigned long arg)
-{
-	struct block_device *bdev = filp->private_data;
-	return blkdev_ioctl(bdev, 0, command, arg);
-}
-
-static int bind_set(int number, u64 major, u64 minor)
-{
-	dev_t dev = MKDEV(major, minor);
-	dev_t raw = MKDEV(RAW_MAJOR, number);
-	struct raw_device_data *rawdev;
-	int err = 0;
-
-	if (number <= 0 || number >= max_raw_minors)
-		return -EINVAL;
-
-	if (MAJOR(dev) != major || MINOR(dev) != minor)
-		return -EINVAL;
-
-	rawdev = &raw_devices[number];
-
-	/*
-	 * This is like making block devices, so demand the
-	 * same capability
-	 */
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
-	/*
-	 * For now, we don't need to check that the underlying
-	 * block device is present or not: we can do that when
-	 * the raw device is opened.  Just check that the
-	 * major/minor numbers make sense.
-	 */
-
-	if (MAJOR(dev) == 0 && dev != 0)
-		return -EINVAL;
-
-	mutex_lock(&raw_mutex);
-	if (rawdev->inuse) {
-		mutex_unlock(&raw_mutex);
-		return -EBUSY;
-	}
-	if (rawdev->binding)
-		module_put(THIS_MODULE);
-
-	rawdev->binding = dev;
-	if (!dev) {
-		/* unbind */
-		device_destroy(raw_class, raw);
-	} else {
-		__module_get(THIS_MODULE);
-		device_destroy(raw_class, raw);
-		device_create(raw_class, NULL, raw, NULL, "raw%d", number);
-	}
-	mutex_unlock(&raw_mutex);
-	return err;
-}
-
-static int bind_get(int number, dev_t *dev)
-{
-	if (number <= 0 || number >= max_raw_minors)
-		return -EINVAL;
-	*dev = raw_devices[number].binding;
-	return 0;
-}
-
-/*
- * Deal with ioctls against the raw-device control interface, to bind
- * and unbind other raw devices.
- */
-static long raw_ctl_ioctl(struct file *filp, unsigned int command,
-			  unsigned long arg)
-{
-	struct raw_config_request rq;
-	dev_t dev;
-	int err;
-
-	switch (command) {
-	case RAW_SETBIND:
-		if (copy_from_user(&rq, (void __user *) arg, sizeof(rq)))
-			return -EFAULT;
-
-		return bind_set(rq.raw_minor, rq.block_major, rq.block_minor);
-
-	case RAW_GETBIND:
-		if (copy_from_user(&rq, (void __user *) arg, sizeof(rq)))
-			return -EFAULT;
-
-		err = bind_get(rq.raw_minor, &dev);
-		if (err)
-			return err;
-
-		rq.block_major = MAJOR(dev);
-		rq.block_minor = MINOR(dev);
-
-		if (copy_to_user((void __user *)arg, &rq, sizeof(rq)))
-			return -EFAULT;
-
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
-#ifdef CONFIG_COMPAT
-struct raw32_config_request {
-	compat_int_t	raw_minor;
-	compat_u64	block_major;
-	compat_u64	block_minor;
-};
-
-static long raw_ctl_compat_ioctl(struct file *file, unsigned int cmd,
-				unsigned long arg)
-{
-	struct raw32_config_request __user *user_req = compat_ptr(arg);
-	struct raw32_config_request rq;
-	dev_t dev;
-	int err = 0;
-
-	switch (cmd) {
-	case RAW_SETBIND:
-		if (copy_from_user(&rq, user_req, sizeof(rq)))
-			return -EFAULT;
-
-		return bind_set(rq.raw_minor, rq.block_major, rq.block_minor);
-
-	case RAW_GETBIND:
-		if (copy_from_user(&rq, user_req, sizeof(rq)))
-			return -EFAULT;
-
-		err = bind_get(rq.raw_minor, &dev);
-		if (err)
-			return err;
-
-		rq.block_major = MAJOR(dev);
-		rq.block_minor = MINOR(dev);
-
-		if (copy_to_user(user_req, &rq, sizeof(rq)))
-			return -EFAULT;
-
-		return 0;
-	}
-
-	return -EINVAL;
-}
-#endif
-
-static const struct file_operations raw_fops = {
-	.read_iter	= blkdev_read_iter,
-	.write_iter	= blkdev_write_iter,
-	.fsync		= blkdev_fsync,
-	.open		= raw_open,
-	.release	= raw_release,
-	.unlocked_ioctl = raw_ioctl,
-	.llseek		= default_llseek,
-	.owner		= THIS_MODULE,
-};
-
-static const struct file_operations raw_ctl_fops = {
-	.unlocked_ioctl = raw_ctl_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl	= raw_ctl_compat_ioctl,
-#endif
-	.open		= raw_open,
-	.owner		= THIS_MODULE,
-	.llseek		= noop_llseek,
-};
-
-static struct cdev raw_cdev;
-
-static char *raw_devnode(struct device *dev, umode_t *mode)
-{
-	return kasprintf(GFP_KERNEL, "raw/%s", dev_name(dev));
-}
-
-static int __init raw_init(void)
-{
-	dev_t dev = MKDEV(RAW_MAJOR, 0);
-	int ret;
-
-	if (max_raw_minors < 1 || max_raw_minors > 65536) {
-		pr_warn("raw: invalid max_raw_minors (must be between 1 and 65536), using %d\n",
-			CONFIG_MAX_RAW_DEVS);
-		max_raw_minors = CONFIG_MAX_RAW_DEVS;
-	}
-
-	raw_devices = vzalloc(array_size(max_raw_minors,
-					 sizeof(struct raw_device_data)));
-	if (!raw_devices) {
-		printk(KERN_ERR "Not enough memory for raw device structures\n");
-		ret = -ENOMEM;
-		goto error;
-	}
-
-	ret = register_chrdev_region(dev, max_raw_minors, "raw");
-	if (ret)
-		goto error;
-
-	cdev_init(&raw_cdev, &raw_fops);
-	ret = cdev_add(&raw_cdev, dev, max_raw_minors);
-	if (ret)
-		goto error_region;
-	raw_class = class_create(THIS_MODULE, "raw");
-	if (IS_ERR(raw_class)) {
-		printk(KERN_ERR "Error creating raw class.\n");
-		cdev_del(&raw_cdev);
-		ret = PTR_ERR(raw_class);
-		goto error_region;
-	}
-	raw_class->devnode = raw_devnode;
-	device_create(raw_class, NULL, MKDEV(RAW_MAJOR, 0), NULL, "rawctl");
-
-	return 0;
-
-error_region:
-	unregister_chrdev_region(dev, max_raw_minors);
-error:
-	vfree(raw_devices);
-	return ret;
-}
-
-static void __exit raw_exit(void)
-{
-	device_destroy(raw_class, MKDEV(RAW_MAJOR, 0));
-	class_destroy(raw_class);
-	cdev_del(&raw_cdev);
-	unregister_chrdev_region(MKDEV(RAW_MAJOR, 0), max_raw_minors);
-}
-
-module_init(raw_init);
-module_exit(raw_exit);
-MODULE_LICENSE("GPL");
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 6cc4d4cfe0c2..15c448eb8226 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1669,7 +1669,7 @@ static long block_ioctl(struct file *file, unsigned cmd, unsigned long arg)
  * Does not take i_mutex for the write and thus is not for general purpose
  * use.
  */
-ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
+static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *bd_inode = bdev_file_inode(file);
@@ -1707,9 +1707,8 @@ ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	blk_finish_plug(&plug);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(blkdev_write_iter);
 
-ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
+static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *bd_inode = bdev_file_inode(file);
@@ -1731,7 +1730,6 @@ ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	iov_iter_reexpand(to, iov_iter_count(to) + shorted);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(blkdev_read_iter);
 
 /*
  * Try to release a page associated with block device when the system
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c3c88fdb9b2a..8652ed7cdce8 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3242,11 +3242,8 @@ ssize_t vfs_iocb_iter_write(struct file *file, struct kiocb *iocb,
 			    struct iov_iter *iter);
 
 /* fs/block_dev.c */
-extern ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to);
-extern ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from);
 extern int blkdev_fsync(struct file *filp, loff_t start, loff_t end,
 			int datasync);
-extern void block_sync_page(struct page *page);
 
 /* fs/splice.c */
 extern ssize_t generic_file_splice_read(struct file *, loff_t *,
diff --git a/include/uapi/linux/raw.h b/include/uapi/linux/raw.h
deleted file mode 100644
index 47874919d0b9..000000000000
--- a/include/uapi/linux/raw.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __LINUX_RAW_H
-#define __LINUX_RAW_H
-
-#include <linux/types.h>
-
-#define RAW_SETBIND	_IO( 0xac, 0 )
-#define RAW_GETBIND	_IO( 0xac, 1 )
-
-struct raw_config_request 
-{
-	int	raw_minor;
-	__u64	block_major;
-	__u64	block_minor;
-};
-
-#endif /* __LINUX_RAW_H */
-- 
2.30.2

