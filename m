Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4996C43603
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 20:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 801E120836
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 20:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfLKUxk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 15:53:40 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:48923 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfLKUxk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 15:53:40 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MUGqT-1iEz5s0XzP-00RH4A; Wed, 11 Dec 2019 21:52:03 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        Arnd Bergmann <arnd@arndb.de>, Hannes Reinecke <hare@suse.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org
Subject: [PATCH 20/24] compat_ioctl: move HDIO ioctl handling into drivers/ide
Date:   Wed, 11 Dec 2019 21:42:54 +0100
Message-Id: <20191211204306.1207817-21-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191211204306.1207817-1-arnd@arndb.de>
References: <20191211204306.1207817-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:WqFkragwamlquVD0w4XYqhcIWXTSfEm2ryUKFK8u+208jHdn86k
 pOxQ/44+skwkscooobamLqYROzjiyDHmhR7vd7mZsDkdahZFFDTypnjyg/Hdp8tBpAR6T6t
 BG5ICdH2nzWjz0M5aEYDqPXUJycrPXfLGPpgxHV+DfwvgdtlxeAmHPywiBQZ3TMIxNX5TLz
 YgsS8Zzbr8SkrSCkHWbKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hXVkbih942Q=:6QoC8VGHeNYu3jkFNSWBjN
 Bsgw6GAWOhVxTu0RrIuR52HnpgA7zCpo4k6rUZ/Ogwet5Q1aK3+ymqu8O2ZORhCOS5IxxCq6Q
 avF0hh61iAVZgSDinHGfpDrdC3HPuGf1j+0QDyI26R+r9JpawVfRAK0hdOhOTDqCA62TYjvtt
 q6wWAO7PwZTQY7UzLdAavR34PTGVI4Gv0s36ziwloXx8/Q9CYunu8oc7pUEoJCtTrloeCy+gZ
 0Rl/8jwIWskh1FutmymHQoNzK3jjV0akRImu0cQ9DBFiYYS7AY/0BbV31IPeiXfwrVMgBIOTg
 y7bTbSAxuZdkUEbwHu9WYNbB79CSOdvAOER/Z47+cgzlseAhhhpfhyx/yG5yBy+rF8tCgMUTY
 Us/BhbRYrko109srTIDpm2l5V6+THpeaWq5fbXd9jmghprTW1s1YY+HBtS+3iuvzmx4RXEJNz
 RU0EtureQPgp69sBqlhSdHzUvLlWGAgJG74445fxi8kWvfP9Jkf+mlwrwghiHbC5S0AfvT9oc
 GyShavXEXp4jIfNX4UgkEDaUxHDSE5ImMZ6+G6vAm6kna+LeQVvj7e0HOnD3+kiErSCEpnIhq
 U4B+vpo0NNwtVonekdLUxnokR3fin+AGa8PeTMnwJUUkLAYXy4hm1yLFg5QMxJXmSKEw84Ot/
 zmKCTHtKHyOzrzzDiEWzg0pc3XxwuIlcfPO2I02B/6fCvRd1lApXlzTnGG83ygYr2jAkatL6T
 BIPER0eTia5DCHC2AfUbal6lY2ygnrrOmL3q+9S5Rytp/oX+bo7+UEb2XJtQZgFCF2x2ahKN4
 a2bmMo0r9pZ8j9WqxVTaSzR5KHHWlombQ3+4L+BK63p6aC7LMuZdF7sXrH9eO34qTDK1oyXRp
 dAOLQ2wgSYEiTKaW5Icw==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Most of the HDIO ioctls are only used by the obsolete drivers/ide
subsystem, these can be handled by changing ide_cmd_ioctl() to be aware
of compat mode and doing the correct transformations in place and using
it as both native and compat handlers for all drivers.

The SCSI drivers implementing the same commands are already doing
this in the drivers, so the compat_blkdev_driver_ioctl() function
is no longer needed now.

The BLKSECTSET and HDIO_GETGEO_BIG ioctls are not implemented
in any driver any more and no longer need any conversion.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 block/compat_ioctl.c           | 75 ----------------------------------
 drivers/ide/ide-cd.c           |  8 +++-
 drivers/ide/ide-disk.c         |  3 ++
 drivers/ide/ide-floppy_ioctl.c |  7 ++--
 drivers/ide/ide-ioctls.c       | 47 +++++++++++++--------
 drivers/ide/ide-tape.c         | 14 +++++++
 6 files changed, 57 insertions(+), 97 deletions(-)

diff --git a/block/compat_ioctl.c b/block/compat_ioctl.c
index 7cb534d6e767..765aa5357655 100644
--- a/block/compat_ioctl.c
+++ b/block/compat_ioctl.c
@@ -77,24 +77,6 @@ static int compat_hdio_getgeo(struct gendisk *disk, struct block_device *bdev,
 	return ret;
 }
 
-static int compat_hdio_ioctl(struct block_device *bdev, fmode_t mode,
-		unsigned int cmd, unsigned long arg)
-{
-	unsigned long __user *p;
-	int error;
-
-	p = compat_alloc_user_space(sizeof(unsigned long));
-	error = __blkdev_driver_ioctl(bdev, mode,
-				cmd, (unsigned long)p);
-	if (error == 0) {
-		unsigned int __user *uvp = compat_ptr(arg);
-		unsigned long v;
-		if (get_user(v, p) || put_user(v, uvp))
-			error = -EFAULT;
-	}
-	return error;
-}
-
 struct compat_blkpg_ioctl_arg {
 	compat_int_t op;
 	compat_int_t flags;
@@ -128,61 +110,6 @@ static int compat_blkpg_ioctl(struct block_device *bdev, fmode_t mode,
 #define BLKBSZSET_32		_IOW(0x12, 113, int)
 #define BLKGETSIZE64_32		_IOR(0x12, 114, int)
 
-static int compat_blkdev_driver_ioctl(struct block_device *bdev, fmode_t mode,
-			unsigned cmd, unsigned long arg)
-{
-	switch (cmd) {
-	case HDIO_GET_UNMASKINTR:
-	case HDIO_GET_MULTCOUNT:
-	case HDIO_GET_KEEPSETTINGS:
-	case HDIO_GET_32BIT:
-	case HDIO_GET_NOWERR:
-	case HDIO_GET_DMA:
-	case HDIO_GET_NICE:
-	case HDIO_GET_WCACHE:
-	case HDIO_GET_ACOUSTIC:
-	case HDIO_GET_ADDRESS:
-	case HDIO_GET_BUSSTATE:
-		return compat_hdio_ioctl(bdev, mode, cmd, arg);
-
-	/*
-	 * No handler required for the ones below, we just need to
-	 * convert arg to a 64 bit pointer.
-	 */
-	case BLKSECTSET:
-	/*
-	 * 0x03 -- HD/IDE ioctl's used by hdparm and friends.
-	 *         Some need translations, these do not.
-	 */
-	case HDIO_GET_IDENTITY:
-	case HDIO_DRIVE_TASK:
-	case HDIO_DRIVE_CMD:
-	/* 0x330 is reserved -- it used to be HDIO_GETGEO_BIG */
-	case 0x330:
-		arg = (unsigned long)compat_ptr(arg);
-	/* These intepret arg as an unsigned long, not as a pointer,
-	 * so we must not do compat_ptr() conversion. */
-	case HDIO_SET_MULTCOUNT:
-	case HDIO_SET_UNMASKINTR:
-	case HDIO_SET_KEEPSETTINGS:
-	case HDIO_SET_32BIT:
-	case HDIO_SET_NOWERR:
-	case HDIO_SET_DMA:
-	case HDIO_SET_PIO_MODE:
-	case HDIO_SET_NICE:
-	case HDIO_SET_WCACHE:
-	case HDIO_SET_ACOUSTIC:
-	case HDIO_SET_BUSSTATE:
-	case HDIO_SET_ADDRESS:
-		break;
-	default:
-		/* unknown ioctl number */
-		return -ENOIOCTLCMD;
-	}
-
-	return __blkdev_driver_ioctl(bdev, mode, cmd, arg);
-}
-
 /* Most of the generic ioctls are handled in the normal fallback path.
    This assumes the blkdev's low level compat_ioctl always returns
    ENOIOCTLCMD for unknown ioctls. */
@@ -293,8 +220,6 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 	default:
 		if (disk->fops->compat_ioctl)
 			ret = disk->fops->compat_ioctl(bdev, mode, cmd, arg);
-		if (ret == -ENOIOCTLCMD)
-			ret = compat_blkdev_driver_ioctl(bdev, mode, cmd, arg);
 		return ret;
 	}
 }
diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 2de6e8ace957..521564da8707 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1727,8 +1727,12 @@ static int idecd_locked_compat_ioctl(struct block_device *bdev, fmode_t mode,
 		break;
 	}
 
-	return cdrom_ioctl(&info->devinfo, bdev, mode, cmd,
-			   (unsigned long)compat_ptr(arg));
+	err = generic_ide_ioctl(info->drive, bdev, cmd, arg);
+	if (err == -EINVAL)
+		err = cdrom_ioctl(&info->devinfo, bdev, mode, cmd,
+				  (unsigned long)compat_ptr(arg));
+
+	return err;
 }
 
 static int idecd_compat_ioctl(struct block_device *bdev, fmode_t mode,
diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
index 197912af5c2f..27f1098e4bcd 100644
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -794,4 +794,7 @@ const struct ide_disk_ops ide_ata_disk_ops = {
 	.set_doorlock		= ide_disk_set_doorlock,
 	.do_request		= ide_do_rw_disk,
 	.ioctl			= ide_disk_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl		= ide_disk_ioctl,
+#endif
 };
diff --git a/drivers/ide/ide-floppy_ioctl.c b/drivers/ide/ide-floppy_ioctl.c
index 4fd70f804d6f..39a790ac6cc3 100644
--- a/drivers/ide/ide-floppy_ioctl.c
+++ b/drivers/ide/ide-floppy_ioctl.c
@@ -329,10 +329,9 @@ int ide_floppy_compat_ioctl(ide_drive_t *drive, struct block_device *bdev,
 	if (cmd != CDROM_SEND_PACKET && cmd != SCSI_IOCTL_SEND_COMMAND)
 		err = scsi_cmd_blk_ioctl(bdev, mode, cmd, argp);
 
-	/*
-	 * there is no generic_ide_compat_ioctl(), that is handled
-	 * through compat_blkdev_ioctl().
-	 */
+	if (err == -ENOTTY)
+		err = generic_ide_ioctl(drive, bdev, cmd, arg);
+
 out:
 	mutex_unlock(&ide_floppy_ioctl_mutex);
 	return err;
diff --git a/drivers/ide/ide-ioctls.c b/drivers/ide/ide-ioctls.c
index d48c17003874..d97da46fdd79 100644
--- a/drivers/ide/ide-ioctls.c
+++ b/drivers/ide/ide-ioctls.c
@@ -3,11 +3,21 @@
  * IDE ioctls handling.
  */
 
+#include <linux/compat.h>
 #include <linux/export.h>
 #include <linux/hdreg.h>
 #include <linux/ide.h>
 #include <linux/slab.h>
 
+static int put_user_long(long val, unsigned long arg)
+{
+#ifdef CONFIG_COMPAT
+	if (in_compat_syscall())
+		return put_user(val, (compat_long_t __user *)compat_ptr(arg));
+#endif
+	return put_user(val, (long __user *)arg);
+}
+
 static const struct ide_ioctl_devset ide_ioctl_settings[] = {
 { HDIO_GET_32BIT,	 HDIO_SET_32BIT,	&ide_devset_io_32bit  },
 { HDIO_GET_KEEPSETTINGS, HDIO_SET_KEEPSETTINGS,	&ide_devset_keepsettings },
@@ -37,7 +47,7 @@ int ide_setting_ioctl(ide_drive_t *drive, struct block_device *bdev,
 	mutex_lock(&ide_setting_mtx);
 	err = ds->get(drive);
 	mutex_unlock(&ide_setting_mtx);
-	return err >= 0 ? put_user(err, (long __user *)arg) : err;
+	return err >= 0 ? put_user_long(err, arg) : err;
 
 set_val:
 	if (bdev != bdev->bd_contains)
@@ -56,7 +66,7 @@ int ide_setting_ioctl(ide_drive_t *drive, struct block_device *bdev,
 EXPORT_SYMBOL_GPL(ide_setting_ioctl);
 
 static int ide_get_identity_ioctl(ide_drive_t *drive, unsigned int cmd,
-				  unsigned long arg)
+				  void __user *argp)
 {
 	u16 *id = NULL;
 	int size = (cmd == HDIO_GET_IDENTITY) ? (ATA_ID_WORDS * 2) : 142;
@@ -77,7 +87,7 @@ static int ide_get_identity_ioctl(ide_drive_t *drive, unsigned int cmd,
 	memcpy(id, drive->id, size);
 	ata_id_to_hd_driveid(id);
 
-	if (copy_to_user((void __user *)arg, id, size))
+	if (copy_to_user(argp, id, size))
 		rc = -EFAULT;
 
 	kfree(id);
@@ -87,10 +97,10 @@ static int ide_get_identity_ioctl(ide_drive_t *drive, unsigned int cmd,
 
 static int ide_get_nice_ioctl(ide_drive_t *drive, unsigned long arg)
 {
-	return put_user((!!(drive->dev_flags & IDE_DFLAG_DSC_OVERLAP)
+	return put_user_long((!!(drive->dev_flags & IDE_DFLAG_DSC_OVERLAP)
 			 << IDE_NICE_DSC_OVERLAP) |
 			(!!(drive->dev_flags & IDE_DFLAG_NICE1)
-			 << IDE_NICE_1), (long __user *)arg);
+			 << IDE_NICE_1), arg);
 }
 
 static int ide_set_nice_ioctl(ide_drive_t *drive, unsigned long arg)
@@ -115,7 +125,7 @@ static int ide_set_nice_ioctl(ide_drive_t *drive, unsigned long arg)
 	return 0;
 }
 
-static int ide_cmd_ioctl(ide_drive_t *drive, unsigned long arg)
+static int ide_cmd_ioctl(ide_drive_t *drive, void __user *argp)
 {
 	u8 *buf = NULL;
 	int bufsize = 0, err = 0;
@@ -123,7 +133,7 @@ static int ide_cmd_ioctl(ide_drive_t *drive, unsigned long arg)
 	struct ide_cmd cmd;
 	struct ide_taskfile *tf = &cmd.tf;
 
-	if (NULL == (void *) arg) {
+	if (NULL == argp) {
 		struct request *rq;
 
 		rq = blk_get_request(drive->queue, REQ_OP_DRV_IN, 0);
@@ -135,7 +145,7 @@ static int ide_cmd_ioctl(ide_drive_t *drive, unsigned long arg)
 		return err;
 	}
 
-	if (copy_from_user(args, (void __user *)arg, 4))
+	if (copy_from_user(args, argp, 4))
 		return -EFAULT;
 
 	memset(&cmd, 0, sizeof(cmd));
@@ -181,19 +191,18 @@ static int ide_cmd_ioctl(ide_drive_t *drive, unsigned long arg)
 	args[1] = tf->error;
 	args[2] = tf->nsect;
 abort:
-	if (copy_to_user((void __user *)arg, &args, 4))
+	if (copy_to_user(argp, &args, 4))
 		err = -EFAULT;
 	if (buf) {
-		if (copy_to_user((void __user *)(arg + 4), buf, bufsize))
+		if (copy_to_user((argp + 4), buf, bufsize))
 			err = -EFAULT;
 		kfree(buf);
 	}
 	return err;
 }
 
-static int ide_task_ioctl(ide_drive_t *drive, unsigned long arg)
+static int ide_task_ioctl(ide_drive_t *drive, void __user *p)
 {
-	void __user *p = (void __user *)arg;
 	int err = 0;
 	u8 args[7];
 	struct ide_cmd cmd;
@@ -237,6 +246,12 @@ int generic_ide_ioctl(ide_drive_t *drive, struct block_device *bdev,
 		      unsigned int cmd, unsigned long arg)
 {
 	int err;
+	void __user *argp = (void __user *)arg;
+
+#ifdef CONFIG_COMPAT
+	if (in_compat_syscall())
+		argp = compat_ptr(arg);
+#endif
 
 	err = ide_setting_ioctl(drive, bdev, cmd, arg, ide_ioctl_settings);
 	if (err != -EOPNOTSUPP)
@@ -247,7 +262,7 @@ int generic_ide_ioctl(ide_drive_t *drive, struct block_device *bdev,
 	case HDIO_GET_IDENTITY:
 		if (bdev != bdev->bd_contains)
 			return -EINVAL;
-		return ide_get_identity_ioctl(drive, cmd, arg);
+		return ide_get_identity_ioctl(drive, cmd, argp);
 	case HDIO_GET_NICE:
 		return ide_get_nice_ioctl(drive, arg);
 	case HDIO_SET_NICE:
@@ -265,11 +280,11 @@ int generic_ide_ioctl(ide_drive_t *drive, struct block_device *bdev,
 	case HDIO_DRIVE_CMD:
 		if (!capable(CAP_SYS_RAWIO))
 			return -EACCES;
-		return ide_cmd_ioctl(drive, arg);
+		return ide_cmd_ioctl(drive, argp);
 	case HDIO_DRIVE_TASK:
 		if (!capable(CAP_SYS_RAWIO))
 			return -EACCES;
-		return ide_task_ioctl(drive, arg);
+		return ide_task_ioctl(drive, argp);
 	case HDIO_DRIVE_RESET:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EACCES;
@@ -277,7 +292,7 @@ int generic_ide_ioctl(ide_drive_t *drive, struct block_device *bdev,
 	case HDIO_GET_BUSSTATE:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EACCES;
-		if (put_user(BUSSTATE_ON, (long __user *)arg))
+		if (put_user_long(BUSSTATE_ON, arg))
 			return -EFAULT;
 		return 0;
 	case HDIO_SET_BUSSTATE:
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 3e7482695f77..4c2a95a2f0b6 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -1945,11 +1945,25 @@ static int idetape_ioctl(struct block_device *bdev, fmode_t mode,
 	return err;
 }
 
+#ifdef CONFIG_COMPAT
+static int idetape_compat_ioctl(struct block_device *bdev, fmode_t mode,
+				unsigned int cmd, unsigned long arg)
+{
+        if (cmd == 0x0340 || cmd == 0x350)
+		arg = (unsigned long)compat_ptr(arg);
+
+	return idetape_ioctl(bdev, mode, cmd, arg);
+}
+#endif
+
 static const struct block_device_operations idetape_block_ops = {
 	.owner		= THIS_MODULE,
 	.open		= idetape_open,
 	.release	= idetape_release,
 	.ioctl		= idetape_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= idetape_compat_ioctl,
+#endif
 };
 
 static int ide_tape_probe(ide_drive_t *drive)
-- 
2.20.0

