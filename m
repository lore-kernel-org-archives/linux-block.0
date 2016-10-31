Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:62596 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S947385AbcJaWDw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Oct 2016 18:03:52 -0400
From: Scott Bauer <scott.bauer@intel.com>
To: linux-nvme@lists.infradead.org
Cc: Rafael.Antognolli@intel.com, axboe@fb.com, keith.busch@intel.com,
        jonathan.derrick@intel.com, j.naumann@fu-berlin.de,
        hch@infradead.org, linux-block@vger.kernel.org,
        Scott Bauer <scott.bauer@intel.com>
Subject: [RFC PATCH 6/6] block: ioctl: Wire up Sed to block ioctls
Date: Mon, 31 Oct 2016 15:58:19 -0600
Message-Id: <1477951099-3127-7-git-send-email-scott.bauer@intel.com>
In-Reply-To: <1477951099-3127-1-git-send-email-scott.bauer@intel.com>
References: <1477951099-3127-1-git-send-email-scott.bauer@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Scott Bauer <scott.bauer@intel.com>
Signed-off-by: Rafael Antognolli <Rafael.Antognolli@intel.com>
---
 block/compat_ioctl.c |  14 ++++
 block/ioctl.c        | 200 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 213 insertions(+), 1 deletion(-)

diff --git a/block/compat_ioctl.c b/block/compat_ioctl.c
index 556826a..2b83019 100644
--- a/block/compat_ioctl.c
+++ b/block/compat_ioctl.c
@@ -10,6 +10,7 @@
 #include <linux/syscalls.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
+#include <linux/sed.h>
 
 static int compat_put_ushort(unsigned long arg, unsigned short val)
 {
@@ -746,6 +747,19 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 	case BLKTRACETEARDOWN: /* compatible */
 		ret = blk_trace_ioctl(bdev, cmd, compat_ptr(arg));
 		return ret;
+	case IOC_SED_SAVE:
+	case IOC_SED_LOCK_UNLOCK:
+	case IOC_SED_TAKE_OWNERSHIP:
+	case IOC_SED_ACTIVATE_LSP:
+	case IOC_SED_SET_PW:
+	case IOC_SED_ACTIVATE_USR:
+	case IOC_SED_REVERT_TPR:
+	case IOC_SED_LR_SETUP:
+	case IOC_SED_ADD_USR_TO_LR:
+	case IOC_SED_ENABLE_DISABLE_MBR:
+	case IOC_SED_ERASE_LR:
+		return blkdev_ioctl(bdev, mode, cmd,
+				(unsigned long)compat_ptr(arg));
 	default:
 		if (disk->fops->compat_ioctl)
 			ret = disk->fops->compat_ioctl(bdev, mode, cmd, arg);
diff --git a/block/ioctl.c b/block/ioctl.c
index 755119c..f5c971b 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -8,6 +8,7 @@
 #include <linux/fs.h>
 #include <linux/blktrace_api.h>
 #include <linux/pr.h>
+#include <linux/sed.h>
 #include <asm/uaccess.h>
 
 static int blkpg_ioctl(struct block_device *bdev, struct blkpg_ioctl_arg __user *arg)
@@ -392,6 +393,181 @@ static int blkdev_pr_clear(struct block_device *bdev,
 	return ops->pr_clear(bdev, c.key);
 }
 
+static int blkdev_sed_save(struct block_device *bdev,
+		struct sed_key __user *arg)
+{
+	const struct sec_ops *ops = bdev->bd_disk->fops->sec_ops;
+	struct sed_key k;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+	if (!ops || !ops->send || !ops->recv)
+		return -EOPNOTSUPP;
+	if (copy_from_user(&k, arg, sizeof(k)))
+		return -EFAULT;
+
+	return sed_save(bdev, &k);
+}
+
+static int blkdev_sed_lock_unlock(struct block_device *bdev,
+		struct sed_key __user *arg)
+{
+	const struct sec_ops *ops = bdev->bd_disk->fops->sec_ops;
+	struct sed_key k;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+	if (!ops || !ops->send || !ops->recv)
+		return -EOPNOTSUPP;
+	if (copy_from_user(&k, arg, sizeof(k)))
+		return -EFAULT;
+
+	return sed_lock_unlock(bdev, &k);
+}
+
+static int blkdev_sed_take_ownership(struct block_device *bdev,
+		struct sed_key __user *arg)
+{
+	const struct sec_ops *ops = bdev->bd_disk->fops->sec_ops;
+	struct sed_key k;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+	if (!ops || !ops->send || !ops->recv)
+		return -EOPNOTSUPP;
+	if (copy_from_user(&k, arg, sizeof(k)))
+		return -EFAULT;
+
+	return sed_take_ownership(bdev, &k);
+}
+
+static int blkdev_sed_activate_lsp(struct block_device *bdev,
+		struct sed_key __user *arg)
+{
+	const struct sec_ops *ops = bdev->bd_disk->fops->sec_ops;
+	struct sed_key k;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+	if (!ops || !ops->send || !ops->recv)
+		return -EOPNOTSUPP;
+	if (copy_from_user(&k, arg, sizeof(k)))
+		return -EFAULT;
+
+	return sed_activate_lsp(bdev, &k);
+}
+
+static int blkdev_sed_set_pw(struct block_device *bdev,
+			     struct sed_key __user *arg)
+{
+	const struct sec_ops *ops = bdev->bd_disk->fops->sec_ops;
+	struct sed_key k;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+	if (!ops || !ops->send || !ops->recv)
+		return -EOPNOTSUPP;
+	if (copy_from_user(&k, arg, sizeof(k)))
+		return -EFAULT;
+
+	return sed_set_pw(bdev, &k);
+}
+
+static int blkdev_sed_activate_user(struct block_device *bdev,
+				    struct sed_key __user *arg)
+{
+	const struct sec_ops *ops = bdev->bd_disk->fops->sec_ops;
+	struct sed_key k;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+	if (!ops || !ops->send || !ops->recv)
+		return -EOPNOTSUPP;
+	if (copy_from_user(&k, arg, sizeof(k)))
+		return -EFAULT;
+	return sed_activate_user(bdev, &k);
+}
+
+static int blkdev_sed_reverttper(struct block_device *bdev,
+				 struct sed_key __user *arg)
+{
+	const struct sec_ops *ops = bdev->bd_disk->fops->sec_ops;
+	struct sed_key k;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+	if (!ops || !ops->send || !ops->recv)
+		return -EOPNOTSUPP;
+	if (copy_from_user(&k, arg, sizeof(k)))
+		return -EFAULT;
+
+	return sed_reverttper(bdev, &k);
+}
+
+static int blkdev_sed_setuplr(struct block_device *bdev,
+			      struct sed_key __user *arg)
+{
+	const struct sec_ops *ops = bdev->bd_disk->fops->sec_ops;
+	struct sed_key k;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+	if (!ops || !ops->send || !ops->recv)
+		return -EOPNOTSUPP;
+	if (copy_from_user(&k, arg, sizeof(k)))
+		return -EFAULT;
+
+	return sed_setup_locking_range(bdev, &k);
+}
+
+static int blkdev_sed_add_usr_to_lr(struct block_device *bdev,
+				    struct sed_key __user *arg)
+{
+	const struct sec_ops *ops = bdev->bd_disk->fops->sec_ops;
+	struct sed_key k;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+	if (!ops || !ops->send || !ops->recv)
+		return -EOPNOTSUPP;
+	if (copy_from_user(&k, arg, sizeof(k)))
+		return -EFAULT;
+
+	return sed_adduser_to_lr(bdev, &k);
+}
+
+static int blkdev_sed_do_mbr(struct block_device *bdev,
+			     struct sed_key __user *arg)
+{
+	const struct sec_ops *ops = bdev->bd_disk->fops->sec_ops;
+	struct sed_key k;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+	if (!ops || !ops->send || !ops->recv)
+		return -EOPNOTSUPP;
+	if (copy_from_user(&k, arg, sizeof(k)))
+		return -EFAULT;
+
+	return sed_do_mbr(bdev, &k);
+}
+
+static int blkdev_sed_erase_lr(struct block_device *bdev,
+			     struct sed_key __user *arg)
+{
+	const struct sec_ops *ops = bdev->bd_disk->fops->sec_ops;
+	struct sed_key k;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+	if (!ops || !ops->send || !ops->recv)
+		return -EOPNOTSUPP;
+	if (copy_from_user(&k, arg, sizeof(k)))
+		return -EFAULT;
+
+	return sed_erase_lr(bdev, &k);
+}
+
 /*
  * Is it an unrecognized ioctl? The correct returns are either
  * ENOTTY (final) or ENOIOCTLCMD ("I don't know this one, try a
@@ -551,7 +727,7 @@ int blkdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 		return put_ushort(arg, !blk_queue_nonrot(bdev_get_queue(bdev)));
 	case BLKRASET:
 	case BLKFRASET:
-		if(!capable(CAP_SYS_ADMIN))
+		if (!capable(CAP_SYS_ADMIN))
 			return -EACCES;
 		bdi = blk_get_backing_dev_info(bdev);
 		bdi->ra_pages = (arg * 512) / PAGE_SIZE;
@@ -586,6 +762,28 @@ int blkdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 		return blkdev_pr_preempt(bdev, argp, true);
 	case IOC_PR_CLEAR:
 		return blkdev_pr_clear(bdev, argp);
+	case IOC_SED_SAVE:
+		return blkdev_sed_save(bdev, argp);
+	case IOC_SED_LOCK_UNLOCK:
+		return blkdev_sed_lock_unlock(bdev, argp);
+	case IOC_SED_TAKE_OWNERSHIP:
+		return blkdev_sed_take_ownership(bdev, argp);
+	case IOC_SED_ACTIVATE_LSP:
+		return blkdev_sed_activate_lsp(bdev, argp);
+	case IOC_SED_SET_PW:
+		return blkdev_sed_set_pw(bdev, argp);
+	case IOC_SED_ACTIVATE_USR:
+		return blkdev_sed_activate_user(bdev, argp);
+	case IOC_SED_REVERT_TPR:
+		return blkdev_sed_reverttper(bdev, argp);
+	case IOC_SED_LR_SETUP:
+		return blkdev_sed_setuplr(bdev, argp);
+	case IOC_SED_ADD_USR_TO_LR:
+		return blkdev_sed_add_usr_to_lr(bdev, argp);
+	case IOC_SED_ENABLE_DISABLE_MBR:
+		return blkdev_sed_do_mbr(bdev, argp);
+	case IOC_SED_ERASE_LR:
+		return blkdev_sed_erase_lr(bdev, argp);
 	default:
 		return __blkdev_driver_ioctl(bdev, mode, cmd, arg);
 	}
-- 
2.7.4

