Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:45449 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751188AbeC0EkX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Mar 2018 00:40:23 -0400
Received: by mail-pg0-f68.google.com with SMTP id y63so5008784pgy.12
        for <linux-block@vger.kernel.org>; Mon, 26 Mar 2018 21:40:22 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/2] loop: don't call into filesystem while holding lo_ctl_mutex
Date: Mon, 26 Mar 2018 21:39:11 -0700
Message-Id: <1f5e0cb1ff94eec231ae638221b7885a6836d70b.1522125370.git.osandov@fb.com>
In-Reply-To: <cover.1522125370.git.osandov@fb.com>
References: <cover.1522125370.git.osandov@fb.com>
In-Reply-To: <cover.1522125370.git.osandov@fb.com>
References: <cover.1522125370.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

We hit an issue where a loop device on NFS was stuck in
loop_get_status() doing vfs_getattr() after the NFS server died, which
caused a pile-up of uninterruptible processes waiting on lo_ctl_mutex.
There's no reason to hold this lock while we wait on the filesystem;
let's drop it so that other processes can do their thing. We need to
grab a reference on lo_backing_file while we use it, and we can get rid
of the check on lo_device, which has been unnecessary since commit
a34c0ae9ebd6 ("[PATCH] loop: remove the bio remapping capability") in
the linux-history tree.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 drivers/block/loop.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index ed6fafdc5377..93a60bda7608 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1167,21 +1167,17 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 static int
 loop_get_status(struct loop_device *lo, struct loop_info64 *info)
 {
-	struct file *file = lo->lo_backing_file;
+	struct file *file;
 	struct kstat stat;
-	int error;
+	int ret;
 
-	if (lo->lo_state != Lo_bound)
+	if (lo->lo_state != Lo_bound) {
+		mutex_unlock(&lo->lo_ctl_mutex);
 		return -ENXIO;
-	error = vfs_getattr(&file->f_path, &stat,
-			    STATX_INO, AT_STATX_SYNC_AS_STAT);
-	if (error)
-		return error;
+	}
+
 	memset(info, 0, sizeof(*info));
 	info->lo_number = lo->lo_number;
-	info->lo_device = huge_encode_dev(stat.dev);
-	info->lo_inode = stat.ino;
-	info->lo_rdevice = huge_encode_dev(lo->lo_device ? stat.rdev : stat.dev);
 	info->lo_offset = lo->lo_offset;
 	info->lo_sizelimit = lo->lo_sizelimit;
 	info->lo_flags = lo->lo_flags;
@@ -1194,7 +1190,19 @@ loop_get_status(struct loop_device *lo, struct loop_info64 *info)
 		memcpy(info->lo_encrypt_key, lo->lo_encrypt_key,
 		       lo->lo_encrypt_key_size);
 	}
-	return 0;
+
+	/* Drop lo_ctl_mutex while we call into the filesystem. */
+	file = get_file(lo->lo_backing_file);
+	mutex_unlock(&lo->lo_ctl_mutex);
+	ret = vfs_getattr(&file->f_path, &stat, STATX_INO,
+			  AT_STATX_SYNC_AS_STAT);
+	if (!ret) {
+		info->lo_device = huge_encode_dev(stat.dev);
+		info->lo_inode = stat.ino;
+		info->lo_rdevice = huge_encode_dev(stat.rdev);
+	}
+	fput(file);
+	return ret;
 }
 
 static void
@@ -1374,7 +1382,8 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 		break;
 	case LOOP_GET_STATUS:
 		err = loop_get_status_old(lo, (struct loop_info __user *) arg);
-		break;
+		/* loop_get_status() unlocks lo_ctl_mutex */
+		goto out_unlocked;
 	case LOOP_SET_STATUS64:
 		err = -EPERM;
 		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN))
@@ -1383,7 +1392,8 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 		break;
 	case LOOP_GET_STATUS64:
 		err = loop_get_status64(lo, (struct loop_info64 __user *) arg);
-		break;
+		/* loop_get_status() unlocks lo_ctl_mutex */
+		goto out_unlocked;
 	case LOOP_SET_CAPACITY:
 		err = -EPERM;
 		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN))
@@ -1544,7 +1554,7 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 		mutex_lock(&lo->lo_ctl_mutex);
 		err = loop_get_status_compat(
 			lo, (struct compat_loop_info __user *) arg);
-		mutex_unlock(&lo->lo_ctl_mutex);
+		/* loop_get_status() unlocks lo_ctl_mutex */
 		break;
 	case LOOP_SET_CAPACITY:
 	case LOOP_CLR_FD:
-- 
2.16.2
