Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Cc: Josef Bacik <jbacik@fb.com>
Subject: [PATCH] nbd: change the default nbd partitions
Date: Mon, 14 Aug 2017 18:56:16 +0000
Message-Id: <1502736976-15966-1-git-send-email-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

From: Josef Bacik <jbacik@fb.com>

There's no reason to have partitions disabled for nbd by default, it costs us
nothing to have it enabled and is just confusing/obnoxious to users who try to
use partitions with nbd.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index d816ae7..6752b91 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -128,7 +128,7 @@ static struct dentry *nbd_dbg_dir;
 #define NBD_MAGIC 0x68797548
 
 static unsigned int nbds_max = 16;
-static int max_part;
+static int max_part = 16;
 static struct workqueue_struct *recv_workqueue;
 static int part_shift;
 
@@ -2146,4 +2146,4 @@ MODULE_LICENSE("GPL");
 module_param(nbds_max, int, 0444);
 MODULE_PARM_DESC(nbds_max, "number of network block devices to initialize (default: 16)");
 module_param(max_part, int, 0444);
-MODULE_PARM_DESC(max_part, "number of partitions per device (default: 0)");
+MODULE_PARM_DESC(max_part, "number of partitions per device (default: 16)");
-- 
2.9.5
