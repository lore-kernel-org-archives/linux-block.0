Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54907 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750856AbcLBVUj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 2 Dec 2016 16:20:39 -0500
From: Josef Bacik <jbacik@fb.com>
To: <linux-block@vger.kernel.org>, <mpa@pengutronix.de>,
        <nbd-general@lists.sourceforge.net>, <kernel-team@fb.com>
Subject: [PATCH] nbd: use loff_t for blocksize and nbd_set_size args
Date: Fri, 2 Dec 2016 16:19:12 -0500
Message-ID: <1480713552-3535-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

If we have large devices (say like the 40t drive I was trying to test with) we
will end up overflowing the int arguments to nbd_set_size and not get the right
size for our device.  Fix this by using loff_t everywhere so I don't have to
think about this again.  Thanks,

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index dc722a7..92f5400 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -64,7 +64,7 @@ struct nbd_device {
 	int num_connections;
 	atomic_t recv_threads;
 	wait_queue_head_t recv_wq;
-	int blksize;
+	loff_t blksize;
 	loff_t bytesize;
 
 	struct task_struct *task_recv;
@@ -134,7 +134,7 @@ static void nbd_size_update(struct nbd_device *nbd, struct block_device *bdev)
 }
 
 static int nbd_size_set(struct nbd_device *nbd, struct block_device *bdev,
-			int blocksize, int nr_blocks)
+			loff_t blocksize, loff_t nr_blocks)
 {
 	int ret;
 
@@ -143,7 +143,7 @@ static int nbd_size_set(struct nbd_device *nbd, struct block_device *bdev,
 		return ret;
 
 	nbd->blksize = blocksize;
-	nbd->bytesize = (loff_t)blocksize * (loff_t)nr_blocks;
+	nbd->bytesize = blocksize * nr_blocks;
 
 	nbd_size_update(nbd, bdev);
 
@@ -930,7 +930,7 @@ static int nbd_dev_dbg_init(struct nbd_device *nbd)
 	debugfs_create_file("tasks", 0444, dir, nbd, &nbd_dbg_tasks_ops);
 	debugfs_create_u64("size_bytes", 0444, dir, &nbd->bytesize);
 	debugfs_create_u32("timeout", 0444, dir, &nbd->tag_set.timeout);
-	debugfs_create_u32("blocksize", 0444, dir, &nbd->blksize);
+	debugfs_create_u64("blocksize", 0444, dir, &nbd->blksize);
 	debugfs_create_file("flags", 0444, dir, nbd, &nbd_dbg_flags_ops);
 
 	return 0;
-- 
2.5.5

