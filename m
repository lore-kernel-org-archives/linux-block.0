Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	nbd-general@lists.sourceforge.net,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Cc: Josef Bacik <jbacik@fb.com>
Subject: [PATCH 3/4] nbd: set queue timeout properly
Date: Fri, 24 Mar 2017 14:08:28 -0400
Message-Id: <1490378909-4056-4-git-send-email-josef@toxicpanda.com>
In-Reply-To: <1490378909-4056-1-git-send-email-josef@toxicpanda.com>
References: <1490378909-4056-1-git-send-email-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

From: Josef Bacik <jbacik@fb.com>

We can't just set the timeout on the tagset, we have to set it on the
queue as it would have been setup already at this point.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index dbc22f4..b0003da 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -844,7 +844,10 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 		nbd_size_set(nbd, bdev, nbd->blksize, arg);
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
