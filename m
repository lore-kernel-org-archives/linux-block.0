Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	nbd-general@lists.sourceforge.net,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Cc: stable@vger.kernel.org
Subject: [PATCH] nbd: don't set the device size until we're connected
Date: Mon,  9 Oct 2017 13:12:10 -0400
Message-Id: <1507569130-5067-1-git-send-email-jbacik@fb.com>
List-ID: <linux-block@vger.kernel.org>

A user reported a regression with using the normal ioctl interface on
newer kernels.  This happens because I was setting the device size
before the device was actually connected, which caused us to error out
and close everything down.  This didn't happen on netlink because we
hold the device lock the whole time we're setting things up, but we
don't do that for the ioctl path.  This fixes the problem.

Cc: stable@vger.kernel.org
Fixes: 29eaadc ("nbd: stop using the bdev everywhere")
Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 883dfeb..baebbdf 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -243,7 +243,6 @@ static void nbd_size_set(struct nbd_device *nbd, loff_t blocksize,
 	struct nbd_config *config = nbd->config;
 	config->blksize = blocksize;
 	config->bytesize = blocksize * nr_blocks;
-	nbd_size_update(nbd);
 }
 
 static void nbd_complete_rq(struct request *req)
@@ -1094,6 +1093,7 @@ static int nbd_start_device(struct nbd_device *nbd)
 		args->index = i;
 		queue_work(recv_workqueue, &args->work);
 	}
+	nbd_size_update(nbd);
 	return error;
 }
 
-- 
2.9.5
