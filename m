Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34912 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726925AbeJJRZs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Oct 2018 13:25:48 -0400
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: <linux-block@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 09/15] loop: Push loop_ctl_mutex down to loop_set_status()
Date: Wed, 10 Oct 2018 12:04:09 +0200
Message-Id: <20181010100415.26525-10-jack@suse.cz>
In-Reply-To: <20181010100415.26525-1-jack@suse.cz>
References: <20181010100415.26525-1-jack@suse.cz>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Push loop_ctl_mutex down to loop_set_status(). We will need this to be
able to call loop_reread_partitions() without loop_ctl_mutex.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/block/loop.c | 51 +++++++++++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index cb4eeff91238..5661489d11a7 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1142,46 +1142,55 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	struct loop_func_table *xfer;
 	kuid_t uid = current_uid();
 
+	err = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
+	if (err)
+		return err;
 	if (lo->lo_encrypt_key_size &&
 	    !uid_eq(lo->lo_key_owner, uid) &&
-	    !capable(CAP_SYS_ADMIN))
-		return -EPERM;
-	if (lo->lo_state != Lo_bound)
-		return -ENXIO;
-	if ((unsigned int) info->lo_encrypt_key_size > LO_KEY_SIZE)
-		return -EINVAL;
+	    !capable(CAP_SYS_ADMIN)) {
+		err = -EPERM;
+		goto out_unlock;
+	}
+	if (lo->lo_state != Lo_bound) {
+		err = -ENXIO;
+		goto out_unlock;
+	}
+	if ((unsigned int) info->lo_encrypt_key_size > LO_KEY_SIZE) {
+		err = -EINVAL;
+		goto out_unlock;
+	}
 
 	/* I/O need to be drained during transfer transition */
 	blk_mq_freeze_queue(lo->lo_queue);
 
 	err = loop_release_xfer(lo);
 	if (err)
-		goto exit;
+		goto out_unfreeze;
 
 	if (info->lo_encrypt_type) {
 		unsigned int type = info->lo_encrypt_type;
 
 		if (type >= MAX_LO_CRYPT) {
 			err = -EINVAL;
-			goto exit;
+			goto out_unfreeze;
 		}
 		xfer = xfer_funcs[type];
 		if (xfer == NULL) {
 			err = -EINVAL;
-			goto exit;
+			goto out_unfreeze;
 		}
 	} else
 		xfer = NULL;
 
 	err = loop_init_xfer(lo, xfer, info);
 	if (err)
-		goto exit;
+		goto out_unfreeze;
 
 	if (lo->lo_offset != info->lo_offset ||
 	    lo->lo_sizelimit != info->lo_sizelimit) {
 		if (figure_loop_size(lo, info->lo_offset, info->lo_sizelimit)) {
 			err = -EFBIG;
-			goto exit;
+			goto out_unfreeze;
 		}
 	}
 
@@ -1213,7 +1222,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	/* update dio if lo_offset or transfer is changed */
 	__loop_update_dio(lo, lo->use_dio);
 
- exit:
+out_unfreeze:
 	blk_mq_unfreeze_queue(lo->lo_queue);
 
 	if (!err && (info->lo_flags & LO_FLAGS_PARTSCAN) &&
@@ -1222,6 +1231,8 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		lo->lo_disk->flags &= ~GENHD_FL_NO_PART_SCAN;
 		loop_reread_partitions(lo, lo->lo_device);
 	}
+out_unlock:
+	mutex_unlock(&loop_ctl_mutex);
 
 	return err;
 }
@@ -1468,12 +1479,8 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 	case LOOP_SET_STATUS:
 		err = -EPERM;
 		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN)) {
-			err = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
-			if (err)
-				return err;
 			err = loop_set_status_old(lo,
 					(struct loop_info __user *)arg);
-			mutex_unlock(&loop_ctl_mutex);
 		}
 		break;
 	case LOOP_GET_STATUS:
@@ -1481,12 +1488,8 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 	case LOOP_SET_STATUS64:
 		err = -EPERM;
 		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN)) {
-			err = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
-			if (err)
-				return err;
 			err = loop_set_status64(lo,
 					(struct loop_info64 __user *) arg);
-			mutex_unlock(&loop_ctl_mutex);
 		}
 		break;
 	case LOOP_GET_STATUS64:
@@ -1631,12 +1634,8 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 
 	switch(cmd) {
 	case LOOP_SET_STATUS:
-		err = mutex_lock_killable(&loop_ctl_mutex);
-		if (!err) {
-			err = loop_set_status_compat(lo,
-						     (const struct compat_loop_info __user *)arg);
-			mutex_unlock(&loop_ctl_mutex);
-		}
+		err = loop_set_status_compat(lo,
+			     (const struct compat_loop_info __user *)arg);
 		break;
 	case LOOP_GET_STATUS:
 		err = loop_get_status_compat(lo,
-- 
2.16.4
