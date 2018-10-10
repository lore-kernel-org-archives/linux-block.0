Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: <linux-block@vger.kernel.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 15/15] loop: Avoid circular locking dependency between loop_ctl_mutex and bd_mutex
Date: Wed, 10 Oct 2018 12:04:15 +0200
Message-Id: <20181010100415.26525-16-jack@suse.cz>
In-Reply-To: <20181010100415.26525-1-jack@suse.cz>
References: <20181010100415.26525-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Code in loop_change_fd() drops reference to the old file (and also the
new file in a failure case) under loop_ctl_mutex. Similarly to a
situation in loop_set_fd() this can create a circular locking dependency
if this was the last reference holding the file open. Delay dropping of
the file reference until we have released loop_ctl_mutex.

Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/block/loop.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d6b3fac25040..a517247a32fa 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -678,7 +678,7 @@ static int loop_validate_file(struct file *file, struct block_device *bdev)
 static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 			  unsigned int arg)
 {
-	struct file	*file, *old_file;
+	struct file	*file = NULL, *old_file;
 	int		error;
 	bool		partscan;
 
@@ -687,21 +687,21 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 		return error;
 	error = -ENXIO;
 	if (lo->lo_state != Lo_bound)
-		goto out_unlock;
+		goto out_err;
 
 	/* the loop device has to be read-only */
 	error = -EINVAL;
 	if (!(lo->lo_flags & LO_FLAGS_READ_ONLY))
-		goto out_unlock;
+		goto out_err;
 
 	error = -EBADF;
 	file = fget(arg);
 	if (!file)
-		goto out_unlock;
+		goto out_err;
 
 	error = loop_validate_file(file, bdev);
 	if (error)
-		goto out_putf;
+		goto out_err;
 
 	old_file = lo->lo_backing_file;
 
@@ -709,7 +709,7 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 
 	/* size of the new backing store needs to be the same */
 	if (get_loop_size(lo, file) != get_loop_size(lo, old_file))
-		goto out_putf;
+		goto out_err;
 
 	/* and ... switch */
 	blk_mq_freeze_queue(lo->lo_queue);
@@ -720,18 +720,22 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 			     lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
 	loop_update_dio(lo);
 	blk_mq_unfreeze_queue(lo->lo_queue);
-
-	fput(old_file);
 	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
 	mutex_unlock(&loop_ctl_mutex);
+	/*
+	 * We must drop file reference outside of loop_ctl_mutex as dropping
+	 * the file ref can take bd_mutex which creates circular locking
+	 * dependency.
+	 */
+	fput(old_file);
 	if (partscan)
 		loop_reread_partitions(lo, bdev);
 	return 0;
 
-out_putf:
-	fput(file);
-out_unlock:
+out_err:
 	mutex_unlock(&loop_ctl_mutex);
+	if (file)
+		fput(file);
 	return error;
 }
 
-- 
2.16.4
