Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: <linux-block@vger.kernel.org>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 03/16] loop: Fold __loop_release into loop_release
Date: Thu,  8 Nov 2018 14:01:03 +0100
Message-Id: <20181108130116.12140-4-jack@suse.cz>
In-Reply-To: <20181108130116.12140-1-jack@suse.cz>
References: <20181108130116.12140-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

__loop_release() has a single call site. Fold it there. This is
currently not a huge win but it will make following replacement of
loop_index_mutex more obvious.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/block/loop.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 63008e879771..3de2cd94225a 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1641,12 +1641,15 @@ static int lo_open(struct block_device *bdev, fmode_t mode)
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
@@ -1656,7 +1659,7 @@ static void __lo_release(struct loop_device *lo)
 		 */
 		err = loop_clr_fd(lo);
 		if (!err)
-			return;
+			goto unlock_index;
 	} else if (lo->lo_state == Lo_bound) {
 		/*
 		 * Otherwise keep thread (if running) and config,
@@ -1667,12 +1670,7 @@ static void __lo_release(struct loop_device *lo)
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
