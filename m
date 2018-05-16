Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	nbd@other.debian.org,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Cc: Josef Bacik <jbacik@fb.com>
Subject: [PATCH 5/5] nbd: call nbd_bdev_reset instead of bd_set_size on disconnect
Date: Wed, 16 May 2018 14:36:05 -0400
Message-Id: <20180516183605.16159-5-josef@toxicpanda.com>
In-Reply-To: <20180516183605.16159-1-josef@toxicpanda.com>
References: <20180516183605.16159-1-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

From: Josef Bacik <jbacik@fb.com>

We need to make sure we don't just set the size of the bdev to 0 while
it's being used by a file system.  We have the appropriate check in
nbd_bdev_reset, simply use that helper instead.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 24788bd10c8b..abc0a815354f 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1127,7 +1127,7 @@ static int nbd_start_device_ioctl(struct nbd_device *nbd, struct block_device *b
 	if (ret)
 		sock_shutdown(nbd);
 	mutex_lock(&nbd->config_lock);
-	bd_set_size(bdev, 0);
+	nbd_bdev_reset(bdev);
 	/* user requested, ignore socket errors */
 	if (test_bit(NBD_DISCONNECT_REQUESTED, &config->runtime_flags))
 		ret = 0;
-- 
2.14.3
