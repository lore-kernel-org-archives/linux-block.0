Return-Path: <SRS0=T2Jf=2X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A391C3276C
	for <linux-block@archiver.kernel.org>; Thu,  2 Jan 2020 15:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D53E2084D
	for <linux-block@archiver.kernel.org>; Thu,  2 Jan 2020 15:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgABPEa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jan 2020 10:04:30 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:45177 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728636AbgABPE3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jan 2020 10:04:29 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MWzwP-1jG2Br20ZF-00XLic; Thu, 02 Jan 2020 16:04:14 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Jan Kara <jack@suse.cz>, Keith Busch <kbusch@kernel.org>,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        Ajay Joshi <ajay.joshi@wdc.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 19/22] compat_ioctl: block: move blkdev_compat_ioctl() into ioctl.c
Date:   Thu,  2 Jan 2020 15:55:37 +0100
Message-Id: <20200102145552.1853992-20-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200102145552.1853992-1-arnd@arndb.de>
References: <20200102145552.1853992-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:AobWlplSlA2Whov09irGofZvBKo5W2XbOTAhppGoB4oy1w5jBuD
 OWmackwyrf5Kem8ektCbYUf29P5KoHwn63WLrQhMGpz3vRPi13fUgyDduV2OSpkrbxCuWrD
 9bu3b67TlKPrSkhH4q71WANR6b9hJ0BGHR5rJQZsoFaCtl1A68BYkpO8k1gKzIFIkz/BGWz
 9tmL4U0gUw2C+AEwjKKcA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vlIXjwMN2sA=:DA3+nAEFxoDYj+8AxiiHQk
 SbtxJEaaKVJspxg0wDZ6iObIYdSyYdDuI1xMc/tAyEeo6IBiRf3ysOGNBdeInRtqcH4O5C1AU
 z3u2+xKsBPsOymUtNaJfIxGMlAXnMDFoSYObU59hNzf3lLN5kozASidlpfU1qhDPNZrUhbjWy
 qO3gRR4YMQSPrha+PoGcstu85IHHsiWvWodZCrasSi+60Cr8B3Toj02XOR3O0btbbAMNSRFMX
 JRo5yOPILm6m5+kiPLxNu/zU0Y3k1gVEWLwuQ+y8Lkb+vWOlWGpe1nusAhUsLG9NvO55Me6MW
 qqoXaABaQEpxhVr/3lOC+ul4tzqmVLhHfftxHZR82s9h3+kKtA9zMPmoeY7N8mxQ7R15GFATc
 M4S9A1F3vXOi2Fj3nNUtisgV2kNgBVyzrMGofvQzwpraG9z3ozl/koKZCaQb+8waMLf/vtko6
 I1+NeQDbz0nKV4Ncy2LwmBdDzNdBG11xN1AfkuuSouRc1lTfBjxltFJCanYxaHHJ0y/PpZjB9
 Xz5eNV3zdDChK9aLuucPzFFHWk2z7GUJ6bMKwvzN0uwe5C4GhFqnyZzkMB1e/mpZDCqnwHZS5
 JW6r0mfU2B9GH1+BXOUcjUndVV8XXNyeq9M8bK/Fdz7po8IiOlB8ez8QU8vkw2yxl5Pj5+ew0
 ziOASaFpgOBtSzj4MEnCO7vHPL54bWZXp8KiS4vHa4o4Y6Da4caLKQS0BQwIj2+Dx8aaGYMCA
 BcG0IHY+avn2+qHFwc4RID5K5Ru8mBpwxpcyuAvkibNt8eBJOmjbLVgutzYKy+34iNSARmzZv
 LKwYVm3mqySwSGG1637fdO6xw6uhEcmISw5qRPmbswQ17JiJ4GjoORu0BWpERVE3DVUVCp9RF
 4Hk+4r/8ZjphFLbH3pFA==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Having both in the same file allows a number of simplifications
to the compat path, and makes it more likely that changes to
the native path get applied to the compat version as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 block/Makefile       |   1 -
 block/compat_ioctl.c | 226 -------------------------------------------
 block/ioctl.c        | 219 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 219 insertions(+), 227 deletions(-)
 delete mode 100644 block/compat_ioctl.c

diff --git a/block/Makefile b/block/Makefile
index 205a5f2fef17..1f70c73ea83d 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -25,7 +25,6 @@ obj-$(CONFIG_MQ_IOSCHED_KYBER)	+= kyber-iosched.o
 bfq-y				:= bfq-iosched.o bfq-wf2q.o bfq-cgroup.o
 obj-$(CONFIG_IOSCHED_BFQ)	+= bfq.o
 
-obj-$(CONFIG_BLOCK_COMPAT)	+= compat_ioctl.o
 obj-$(CONFIG_BLK_CMDLINE_PARSER)	+= cmdline-parser.o
 obj-$(CONFIG_BLK_DEV_INTEGRITY) += bio-integrity.o blk-integrity.o t10-pi.o
 obj-$(CONFIG_BLK_MQ_PCI)	+= blk-mq-pci.o
diff --git a/block/compat_ioctl.c b/block/compat_ioctl.c
deleted file mode 100644
index 928b917e692f..000000000000
--- a/block/compat_ioctl.c
+++ /dev/null
@@ -1,226 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/blkdev.h>
-#include <linux/blkpg.h>
-#include <linux/blktrace_api.h>
-#include <linux/cdrom.h>
-#include <linux/compat.h>
-#include <linux/elevator.h>
-#include <linux/hdreg.h>
-#include <linux/pr.h>
-#include <linux/slab.h>
-#include <linux/syscalls.h>
-#include <linux/types.h>
-#include <linux/uaccess.h>
-
-static int compat_put_ushort(unsigned long arg, unsigned short val)
-{
-	return put_user(val, (unsigned short __user *)compat_ptr(arg));
-}
-
-static int compat_put_int(unsigned long arg, int val)
-{
-	return put_user(val, (compat_int_t __user *)compat_ptr(arg));
-}
-
-static int compat_put_uint(unsigned long arg, unsigned int val)
-{
-	return put_user(val, (compat_uint_t __user *)compat_ptr(arg));
-}
-
-static int compat_put_long(unsigned long arg, long val)
-{
-	return put_user(val, (compat_long_t __user *)compat_ptr(arg));
-}
-
-static int compat_put_ulong(unsigned long arg, compat_ulong_t val)
-{
-	return put_user(val, (compat_ulong_t __user *)compat_ptr(arg));
-}
-
-static int compat_put_u64(unsigned long arg, u64 val)
-{
-	return put_user(val, (compat_u64 __user *)compat_ptr(arg));
-}
-
-struct compat_hd_geometry {
-	unsigned char heads;
-	unsigned char sectors;
-	unsigned short cylinders;
-	u32 start;
-};
-
-static int compat_hdio_getgeo(struct gendisk *disk, struct block_device *bdev,
-			struct compat_hd_geometry __user *ugeo)
-{
-	struct hd_geometry geo;
-	int ret;
-
-	if (!ugeo)
-		return -EINVAL;
-	if (!disk->fops->getgeo)
-		return -ENOTTY;
-
-	memset(&geo, 0, sizeof(geo));
-	/*
-	 * We need to set the startsect first, the driver may
-	 * want to override it.
-	 */
-	geo.start = get_start_sect(bdev);
-	ret = disk->fops->getgeo(bdev, &geo);
-	if (ret)
-		return ret;
-
-	ret = copy_to_user(ugeo, &geo, 4);
-	ret |= put_user(geo.start, &ugeo->start);
-	if (ret)
-		ret = -EFAULT;
-
-	return ret;
-}
-
-struct compat_blkpg_ioctl_arg {
-	compat_int_t op;
-	compat_int_t flags;
-	compat_int_t datalen;
-	compat_caddr_t data;
-};
-
-static int compat_blkpg_ioctl(struct block_device *bdev, fmode_t mode,
-		unsigned int cmd, struct compat_blkpg_ioctl_arg __user *ua32)
-{
-	struct blkpg_ioctl_arg __user *a = compat_alloc_user_space(sizeof(*a));
-	compat_caddr_t udata;
-	compat_int_t n;
-	int err;
-
-	err = get_user(n, &ua32->op);
-	err |= put_user(n, &a->op);
-	err |= get_user(n, &ua32->flags);
-	err |= put_user(n, &a->flags);
-	err |= get_user(n, &ua32->datalen);
-	err |= put_user(n, &a->datalen);
-	err |= get_user(udata, &ua32->data);
-	err |= put_user(compat_ptr(udata), &a->data);
-	if (err)
-		return err;
-
-	return blkdev_ioctl(bdev, mode, cmd, (unsigned long)a);
-}
-
-#define BLKBSZGET_32		_IOR(0x12, 112, int)
-#define BLKBSZSET_32		_IOW(0x12, 113, int)
-#define BLKGETSIZE64_32		_IOR(0x12, 114, int)
-
-/* Most of the generic ioctls are handled in the normal fallback path.
-   This assumes the blkdev's low level compat_ioctl always returns
-   ENOIOCTLCMD for unknown ioctls. */
-long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
-{
-	int ret = -ENOIOCTLCMD;
-	struct inode *inode = file->f_mapping->host;
-	struct block_device *bdev = inode->i_bdev;
-	struct gendisk *disk = bdev->bd_disk;
-	fmode_t mode = file->f_mode;
-	loff_t size;
-	unsigned int max_sectors;
-
-	/*
-	 * O_NDELAY can be altered using fcntl(.., F_SETFL, ..), so we have
-	 * to updated it before every ioctl.
-	 */
-	if (file->f_flags & O_NDELAY)
-		mode |= FMODE_NDELAY;
-	else
-		mode &= ~FMODE_NDELAY;
-
-	switch (cmd) {
-	case HDIO_GETGEO:
-		return compat_hdio_getgeo(disk, bdev, compat_ptr(arg));
-	case BLKPBSZGET:
-		return compat_put_uint(arg, bdev_physical_block_size(bdev));
-	case BLKIOMIN:
-		return compat_put_uint(arg, bdev_io_min(bdev));
-	case BLKIOOPT:
-		return compat_put_uint(arg, bdev_io_opt(bdev));
-	case BLKALIGNOFF:
-		return compat_put_int(arg, bdev_alignment_offset(bdev));
-	case BLKDISCARDZEROES:
-		return compat_put_uint(arg, 0);
-	case BLKFLSBUF:
-	case BLKROSET:
-	case BLKDISCARD:
-	case BLKSECDISCARD:
-	case BLKZEROOUT:
-	/*
-	 * the ones below are implemented in blkdev_locked_ioctl,
-	 * but we call blkdev_ioctl, which gets the lock for us
-	 */
-	case BLKRRPART:
-	case BLKREPORTZONE:
-	case BLKRESETZONE:
-	case BLKOPENZONE:
-	case BLKCLOSEZONE:
-	case BLKFINISHZONE:
-	case BLKGETZONESZ:
-	case BLKGETNRZONES:
-		return blkdev_ioctl(bdev, mode, cmd,
-				(unsigned long)compat_ptr(arg));
-	case BLKBSZSET_32:
-		return blkdev_ioctl(bdev, mode, BLKBSZSET,
-				(unsigned long)compat_ptr(arg));
-	case BLKPG:
-		return compat_blkpg_ioctl(bdev, mode, cmd, compat_ptr(arg));
-	case BLKRAGET:
-	case BLKFRAGET:
-		if (!arg)
-			return -EINVAL;
-		return compat_put_long(arg,
-			       (bdev->bd_bdi->ra_pages * PAGE_SIZE) / 512);
-	case BLKROGET: /* compatible */
-		return compat_put_int(arg, bdev_read_only(bdev) != 0);
-	case BLKBSZGET_32: /* get the logical block size (cf. BLKSSZGET) */
-		return compat_put_int(arg, block_size(bdev));
-	case BLKSSZGET: /* get block device hardware sector size */
-		return compat_put_int(arg, bdev_logical_block_size(bdev));
-	case BLKSECTGET:
-		max_sectors = min_t(unsigned int, USHRT_MAX,
-				    queue_max_sectors(bdev_get_queue(bdev)));
-		return compat_put_ushort(arg, max_sectors);
-	case BLKROTATIONAL:
-		return compat_put_ushort(arg,
-					 !blk_queue_nonrot(bdev_get_queue(bdev)));
-	case BLKRASET: /* compatible, but no compat_ptr (!) */
-	case BLKFRASET:
-		if (!capable(CAP_SYS_ADMIN))
-			return -EACCES;
-		bdev->bd_bdi->ra_pages = (arg * 512) / PAGE_SIZE;
-		return 0;
-	case BLKGETSIZE:
-		size = i_size_read(bdev->bd_inode);
-		if ((size >> 9) > ~0UL)
-			return -EFBIG;
-		return compat_put_ulong(arg, size >> 9);
-
-	case BLKGETSIZE64_32:
-		return compat_put_u64(arg, i_size_read(bdev->bd_inode));
-
-	case BLKTRACESETUP32:
-	case BLKTRACESTART: /* compatible */
-	case BLKTRACESTOP:  /* compatible */
-	case BLKTRACETEARDOWN: /* compatible */
-		ret = blk_trace_ioctl(bdev, cmd, compat_ptr(arg));
-		return ret;
-	case IOC_PR_REGISTER:
-	case IOC_PR_RESERVE:
-	case IOC_PR_RELEASE:
-	case IOC_PR_PREEMPT:
-	case IOC_PR_PREEMPT_ABORT:
-	case IOC_PR_CLEAR:
-		return blkdev_ioctl(bdev, mode, cmd,
-				(unsigned long)compat_ptr(arg));
-	default:
-		if (disk->fops->compat_ioctl)
-			ret = disk->fops->compat_ioctl(bdev, mode, cmd, arg);
-		return ret;
-	}
-}
diff --git a/block/ioctl.c b/block/ioctl.c
index e728331d1a5b..f8c4e2649335 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -269,6 +269,38 @@ static int put_u64(unsigned long arg, u64 val)
 	return put_user(val, (u64 __user *)arg);
 }
 
+#ifdef CONFIG_COMPAT
+static int compat_put_ushort(unsigned long arg, unsigned short val)
+{
+	return put_user(val, (unsigned short __user *)compat_ptr(arg));
+}
+
+static int compat_put_int(unsigned long arg, int val)
+{
+	return put_user(val, (compat_int_t __user *)compat_ptr(arg));
+}
+
+static int compat_put_uint(unsigned long arg, unsigned int val)
+{
+	return put_user(val, (compat_uint_t __user *)compat_ptr(arg));
+}
+
+static int compat_put_long(unsigned long arg, long val)
+{
+	return put_user(val, (compat_long_t __user *)compat_ptr(arg));
+}
+
+static int compat_put_ulong(unsigned long arg, compat_ulong_t val)
+{
+	return put_user(val, (compat_ulong_t __user *)compat_ptr(arg));
+}
+
+static int compat_put_u64(unsigned long arg, u64 val)
+{
+	return put_user(val, (compat_u64 __user *)compat_ptr(arg));
+}
+#endif
+
 int __blkdev_driver_ioctl(struct block_device *bdev, fmode_t mode,
 			unsigned cmd, unsigned long arg)
 {
@@ -476,6 +508,44 @@ static int blkdev_getgeo(struct block_device *bdev,
 	return 0;
 }
 
+#ifdef CONFIG_COMPAT
+struct compat_hd_geometry {
+	unsigned char heads;
+	unsigned char sectors;
+	unsigned short cylinders;
+	u32 start;
+};
+
+static int compat_hdio_getgeo(struct gendisk *disk, struct block_device *bdev,
+			struct compat_hd_geometry __user *ugeo)
+{
+	struct hd_geometry geo;
+	int ret;
+
+	if (!ugeo)
+		return -EINVAL;
+	if (!disk->fops->getgeo)
+		return -ENOTTY;
+
+	memset(&geo, 0, sizeof(geo));
+	/*
+	 * We need to set the startsect first, the driver may
+	 * want to override it.
+	 */
+	geo.start = get_start_sect(bdev);
+	ret = disk->fops->getgeo(bdev, &geo);
+	if (ret)
+		return ret;
+
+	ret = copy_to_user(ugeo, &geo, 4);
+	ret |= put_user(geo.start, &ugeo->start);
+	if (ret)
+		ret = -EFAULT;
+
+	return ret;
+}
+#endif
+
 /* set the logical block size */
 static int blkdev_bszset(struct block_device *bdev, fmode_t mode,
 		int __user *argp)
@@ -604,3 +674,152 @@ int blkdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 	}
 }
 EXPORT_SYMBOL_GPL(blkdev_ioctl);
+
+#ifdef CONFIG_COMPAT
+struct compat_blkpg_ioctl_arg {
+	compat_int_t op;
+	compat_int_t flags;
+	compat_int_t datalen;
+	compat_caddr_t data;
+};
+
+static int compat_blkpg_ioctl(struct block_device *bdev, fmode_t mode,
+		unsigned int cmd, struct compat_blkpg_ioctl_arg __user *ua32)
+{
+	struct blkpg_ioctl_arg __user *a = compat_alloc_user_space(sizeof(*a));
+	compat_caddr_t udata;
+	compat_int_t n;
+	int err;
+
+	err = get_user(n, &ua32->op);
+	err |= put_user(n, &a->op);
+	err |= get_user(n, &ua32->flags);
+	err |= put_user(n, &a->flags);
+	err |= get_user(n, &ua32->datalen);
+	err |= put_user(n, &a->datalen);
+	err |= get_user(udata, &ua32->data);
+	err |= put_user(compat_ptr(udata), &a->data);
+	if (err)
+		return err;
+
+	return blkdev_ioctl(bdev, mode, cmd, (unsigned long)a);
+}
+
+#define BLKBSZGET_32		_IOR(0x12, 112, int)
+#define BLKBSZSET_32		_IOW(0x12, 113, int)
+#define BLKGETSIZE64_32		_IOR(0x12, 114, int)
+
+/* Most of the generic ioctls are handled in the normal fallback path.
+   This assumes the blkdev's low level compat_ioctl always returns
+   ENOIOCTLCMD for unknown ioctls. */
+long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
+{
+	int ret = -ENOIOCTLCMD;
+	struct inode *inode = file->f_mapping->host;
+	struct block_device *bdev = inode->i_bdev;
+	struct gendisk *disk = bdev->bd_disk;
+	fmode_t mode = file->f_mode;
+	loff_t size;
+	unsigned int max_sectors;
+
+	/*
+	 * O_NDELAY can be altered using fcntl(.., F_SETFL, ..), so we have
+	 * to updated it before every ioctl.
+	 */
+	if (file->f_flags & O_NDELAY)
+		mode |= FMODE_NDELAY;
+	else
+		mode &= ~FMODE_NDELAY;
+
+	switch (cmd) {
+	case HDIO_GETGEO:
+		return compat_hdio_getgeo(disk, bdev, compat_ptr(arg));
+	case BLKPBSZGET:
+		return compat_put_uint(arg, bdev_physical_block_size(bdev));
+	case BLKIOMIN:
+		return compat_put_uint(arg, bdev_io_min(bdev));
+	case BLKIOOPT:
+		return compat_put_uint(arg, bdev_io_opt(bdev));
+	case BLKALIGNOFF:
+		return compat_put_int(arg, bdev_alignment_offset(bdev));
+	case BLKDISCARDZEROES:
+		return compat_put_uint(arg, 0);
+	case BLKFLSBUF:
+	case BLKROSET:
+	case BLKDISCARD:
+	case BLKSECDISCARD:
+	case BLKZEROOUT:
+	/*
+	 * the ones below are implemented in blkdev_locked_ioctl,
+	 * but we call blkdev_ioctl, which gets the lock for us
+	 */
+	case BLKRRPART:
+	case BLKREPORTZONE:
+	case BLKRESETZONE:
+	case BLKOPENZONE:
+	case BLKCLOSEZONE:
+	case BLKFINISHZONE:
+	case BLKGETZONESZ:
+	case BLKGETNRZONES:
+		return blkdev_ioctl(bdev, mode, cmd,
+				(unsigned long)compat_ptr(arg));
+	case BLKBSZSET_32:
+		return blkdev_ioctl(bdev, mode, BLKBSZSET,
+				(unsigned long)compat_ptr(arg));
+	case BLKPG:
+		return compat_blkpg_ioctl(bdev, mode, cmd, compat_ptr(arg));
+	case BLKRAGET:
+	case BLKFRAGET:
+		if (!arg)
+			return -EINVAL;
+		return compat_put_long(arg,
+			       (bdev->bd_bdi->ra_pages * PAGE_SIZE) / 512);
+	case BLKROGET: /* compatible */
+		return compat_put_int(arg, bdev_read_only(bdev) != 0);
+	case BLKBSZGET_32: /* get the logical block size (cf. BLKSSZGET) */
+		return compat_put_int(arg, block_size(bdev));
+	case BLKSSZGET: /* get block device hardware sector size */
+		return compat_put_int(arg, bdev_logical_block_size(bdev));
+	case BLKSECTGET:
+		max_sectors = min_t(unsigned int, USHRT_MAX,
+				    queue_max_sectors(bdev_get_queue(bdev)));
+		return compat_put_ushort(arg, max_sectors);
+	case BLKROTATIONAL:
+		return compat_put_ushort(arg,
+					 !blk_queue_nonrot(bdev_get_queue(bdev)));
+	case BLKRASET: /* compatible, but no compat_ptr (!) */
+	case BLKFRASET:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EACCES;
+		bdev->bd_bdi->ra_pages = (arg * 512) / PAGE_SIZE;
+		return 0;
+	case BLKGETSIZE:
+		size = i_size_read(bdev->bd_inode);
+		if ((size >> 9) > ~0UL)
+			return -EFBIG;
+		return compat_put_ulong(arg, size >> 9);
+
+	case BLKGETSIZE64_32:
+		return compat_put_u64(arg, i_size_read(bdev->bd_inode));
+
+	case BLKTRACESETUP32:
+	case BLKTRACESTART: /* compatible */
+	case BLKTRACESTOP:  /* compatible */
+	case BLKTRACETEARDOWN: /* compatible */
+		ret = blk_trace_ioctl(bdev, cmd, compat_ptr(arg));
+		return ret;
+	case IOC_PR_REGISTER:
+	case IOC_PR_RESERVE:
+	case IOC_PR_RELEASE:
+	case IOC_PR_PREEMPT:
+	case IOC_PR_PREEMPT_ABORT:
+	case IOC_PR_CLEAR:
+		return blkdev_ioctl(bdev, mode, cmd,
+				(unsigned long)compat_ptr(arg));
+	default:
+		if (disk->fops->compat_ioctl)
+			ret = disk->fops->compat_ioctl(bdev, mode, cmd, arg);
+		return ret;
+	}
+}
+#endif
-- 
2.20.0

