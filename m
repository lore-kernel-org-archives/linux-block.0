Return-Path: <colin.king@canonical.com>
From: Colin King <colin.king@canonical.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] loop: remove redundant pointer inode
Date: Mon,  2 Jul 2018 08:47:06 +0100
Message-Id: <20180702074706.10586-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-block@vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Pointer inode is being assigned but is never used hence it is redundant
and can be removed.

Cleans up clang warning:
warning: variable 'inode' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/block/loop.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d6b6f434fd4b..6e0b870308ee 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -690,7 +690,6 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 			  unsigned int arg)
 {
 	struct file	*file, *old_file;
-	struct inode	*inode;
 	int		error;
 
 	error = -ENXIO;
@@ -711,7 +710,6 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	if (error)
 		goto out_putf;
 
-	inode = file->f_mapping->host;
 	old_file = lo->lo_backing_file;
 
 	error = -EINVAL;
-- 
2.17.1
