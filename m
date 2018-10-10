Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34952 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727016AbeJJRZu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Oct 2018 13:25:50 -0400
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: <linux-block@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 11/15] loop: Push loop_ctl_mutex down to loop_change_fd()
Date: Wed, 10 Oct 2018 12:04:11 +0200
Message-Id: <20181010100415.26525-12-jack@suse.cz>
In-Reply-To: <20181010100415.26525-1-jack@suse.cz>
References: <20181010100415.26525-1-jack@suse.cz>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Push loop_ctl_mutex down to loop_change_fd(). We will need this to be
able to call loop_reread_partitions() without loop_ctl_mutex.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/block/loop.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index b4500d82238d..c53ad5e88a7d 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -692,19 +692,22 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	struct file	*file, *old_file;
 	int		error;
 
+	error = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
+	if (error)
+		return error;
 	error = -ENXIO;
 	if (lo->lo_state != Lo_bound)
-		goto out;
+		goto out_unlock;
 
 	/* the loop device has to be read-only */
 	error = -EINVAL;
 	if (!(lo->lo_flags & LO_FLAGS_READ_ONLY))
-		goto out;
+		goto out_unlock;
 
 	error = -EBADF;
 	file = fget(arg);
 	if (!file)
-		goto out;
+		goto out_unlock;
 
 	error = loop_validate_file(file, bdev);
 	if (error)
@@ -731,11 +734,13 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	fput(old_file);
 	if (lo->lo_flags & LO_FLAGS_PARTSCAN)
 		loop_reread_partitions(lo, bdev);
+	mutex_unlock(&loop_ctl_mutex);
 	return 0;
 
- out_putf:
+out_putf:
 	fput(file);
- out:
+out_unlock:
+	mutex_unlock(&loop_ctl_mutex);
 	return error;
 }
 
@@ -1470,12 +1475,7 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 	case LOOP_SET_FD:
 		return loop_set_fd(lo, mode, bdev, arg);
 	case LOOP_CHANGE_FD:
-		err = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
-		if (err)
-			return err;
-		err = loop_change_fd(lo, bdev, arg);
-		mutex_unlock(&loop_ctl_mutex);
-		break;
+		return loop_change_fd(lo, bdev, arg);
 	case LOOP_CLR_FD:
 		return loop_clr_fd(lo);
 	case LOOP_SET_STATUS:
-- 
2.16.4
