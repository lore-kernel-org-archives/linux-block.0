Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	nbd-general@lists.sourceforge.net,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 08/12] nbd: only clear the queue on device teardown
Date: Thu,  6 Apr 2017 17:02:03 -0400
Message-Id: <1491512527-4286-9-git-send-email-jbacik@fb.com>
In-Reply-To: <1491512527-4286-1-git-send-email-jbacik@fb.com>
References: <1491512527-4286-1-git-send-email-jbacik@fb.com>
List-ID: <linux-block@vger.kernel.org>

When running a disconnect torture test I noticed that sometimes we would
crash with a negative ref count on our queue.  This was because we were
ending the same request twice.  Turns out we were racing with
NBD_CLEAR_SOCK clearing the requests as well as the teardown of the
device clearing the requests.  So instead make the ioctl only shutdown
the sockets and make it so that we only ever run nbd_clear_que from the
device teardown.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 911e36c..70c5e75 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -616,7 +616,9 @@ static void nbd_clear_req(struct request *req, void *data, bool reserved)
 
 static void nbd_clear_que(struct nbd_device *nbd)
 {
+	blk_mq_stop_hw_queues(nbd->disk->queue);
 	blk_mq_tagset_busy_iter(&nbd->tag_set, nbd_clear_req, NULL);
+	blk_mq_start_hw_queues(nbd->disk->queue);
 	dev_dbg(disk_to_dev(nbd->disk), "queue cleared\n");
 }
 
@@ -1041,7 +1043,7 @@ static int nbd_start_device_ioctl(struct nbd_device *nbd, struct block_device *b
 static void nbd_clear_sock_ioctl(struct nbd_device *nbd,
 				 struct block_device *bdev)
 {
-	nbd_clear_sock(nbd);
+	sock_shutdown(nbd);
 	kill_bdev(bdev);
 	nbd_bdev_reset(bdev);
 	if (test_and_clear_bit(NBD_HAS_CONFIG_REF,
-- 
2.7.4
