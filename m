Return-Path: <prvs=423213d9ff=jbacik@fb.com>
From: Josef Bacik <jbacik@fb.com>
To: <axboe@kernel.dk>, <nbd-general@lists.sourceforge.net>,
        <linux-block@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH 4/6] nbd: set queue timeout properly
Date: Tue, 28 Feb 2017 11:57:09 -0500
Message-ID: <1488301031-3199-5-git-send-email-jbacik@fb.com>
In-Reply-To: <1488301031-3199-1-git-send-email-jbacik@fb.com>
References: <1488301031-3199-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

We can't just set the timeout on the tagset, we have to set it on the
queue as it would have been setup already at this point.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 059c80a..ac5a03a 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -909,7 +909,10 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 		nbd_size_set(nbd, nbd->blksize, arg);
 		return 0;
 	case NBD_SET_TIMEOUT:
-		nbd->tag_set.timeout = arg * HZ;
+		if (arg) {
+			nbd->tag_set.timeout = arg * HZ;
+			blk_queue_rq_timeout(nbd->disk->queue, arg * HZ);
+		}
 		return 0;
 
 	case NBD_SET_FLAGS:
-- 
2.7.4
