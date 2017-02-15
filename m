Return-Path: <prvs=32195039d6=jbacik@fb.com>
From: Josef Bacik <jbacik@fb.com>
To: <axboe@kernel.dk>, <nbd-general@lists.sourceforge.net>,
        <linux-block@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH] nbd: cleanup workqueue on error properly
Date: Wed, 15 Feb 2017 16:49:48 -0500
Message-ID: <1487195388-28532-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

If we fail to register the blockdev we need to make sure to destroy the
recv workqueue.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 0623f8f..a032a00 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1271,8 +1271,10 @@ static int __init nbd_init(void)
 	if (!recv_workqueue)
 		return -ENOMEM;
 
-	if (register_blkdev(NBD_MAJOR, "nbd"))
+	if (register_blkdev(NBD_MAJOR, "nbd")) {
+		destroy_workqueue(recv_workqueue);
 		return -EIO;
+	}
 
 	nbd_dbg_init();
 
-- 
2.7.4
