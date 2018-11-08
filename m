Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: <linux-block@vger.kernel.org>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 01/16] block/loop: Don't grab "struct file" for vfs_getattr() operation.
Date: Thu,  8 Nov 2018 14:01:01 +0100
Message-Id: <20181108130116.12140-2-jack@suse.cz>
In-Reply-To: <20181108130116.12140-1-jack@suse.cz>
References: <20181108130116.12140-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

vfs_getattr() needs "struct path" rather than "struct file".
Let's use path_get()/path_put() rather than get_file()/fput().

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/block/loop.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index cb0cc8685076..a29ef169f360 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1204,7 +1204,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 static int
 loop_get_status(struct loop_device *lo, struct loop_info64 *info)
 {
-	struct file *file;
+	struct path path;
 	struct kstat stat;
 	int ret;
 
@@ -1229,16 +1229,16 @@ loop_get_status(struct loop_device *lo, struct loop_info64 *info)
 	}
 
 	/* Drop lo_ctl_mutex while we call into the filesystem. */
-	file = get_file(lo->lo_backing_file);
+	path = lo->lo_backing_file->f_path;
+	path_get(&path);
 	mutex_unlock(&lo->lo_ctl_mutex);
-	ret = vfs_getattr(&file->f_path, &stat, STATX_INO,
-			  AT_STATX_SYNC_AS_STAT);
+	ret = vfs_getattr(&path, &stat, STATX_INO, AT_STATX_SYNC_AS_STAT);
 	if (!ret) {
 		info->lo_device = huge_encode_dev(stat.dev);
 		info->lo_inode = stat.ino;
 		info->lo_rdevice = huge_encode_dev(stat.rdev);
 	}
-	fput(file);
+	path_put(&path);
 	return ret;
 }
 
-- 
2.16.4
