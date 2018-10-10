Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: <linux-block@vger.kernel.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 03/15] loop: Fold __loop_release into loop_release
Date: Wed, 10 Oct 2018 12:04:03 +0200
Message-Id: <20181010100415.26525-4-jack@suse.cz>
In-Reply-To: <20181010100415.26525-1-jack@suse.cz>
References: <20181010100415.26525-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

__loop_release() has a single call site. Fold it there. This is
currently not a huge win but it will make following replacement of
loop_index_mutex more obvious.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/block/loop.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d0f1b7106572..cc43d835fe6f 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1642,12 +1642,15 @@ static int lo_open(struct block_device *bdev, fmode_t mode)
 	return err;
 }
 
-static void __lo_release(struct loop_device *lo)
+static void lo_release(struct gendisk *disk, fmode_t mode)
 {
+	struct loop_device *lo;
 	int err;
 
+	mutex_lock(&loop_index_mutex);
+	lo = disk->private_data;
 	if (atomic_dec_return(&lo->lo_refcnt))
-		return;
+		goto unlock_index;
 
 	mutex_lock(&loop_ctl_mutex);
 	if (lo->lo_flags & LO_FLAGS_AUTOCLEAR) {
@@ -1657,7 +1660,7 @@ static void __lo_release(struct loop_device *lo)
 		 */
 		err = loop_clr_fd(lo);
 		if (!err)
-			return;
+			goto unlock_index;
 	} else if (lo->lo_state == Lo_bound) {
 		/*
 		 * Otherwise keep thread (if running) and config,
@@ -1668,12 +1671,7 @@ static void __lo_release(struct loop_device *lo)
 	}
 
 	mutex_unlock(&loop_ctl_mutex);
-}
-
-static void lo_release(struct gendisk *disk, fmode_t mode)
-{
-	mutex_lock(&loop_index_mutex);
-	__lo_release(disk->private_data);
+unlock_index:
 	mutex_unlock(&loop_index_mutex);
 }
 
-- 
2.16.4
