Return-Path: <prvs=32104809ab=jbacik@fb.com>
From: Josef Bacik <jbacik@fb.com>
To: <linux-block@vger.kernel.org>, <kernel-team@fb.com>,
        <nbd-general@lists.sourceforge.net>, <axboe@kernel.dk>
Subject: [PATCH] nbd: freeze the queue before making changes
Date: Mon, 6 Feb 2017 10:54:49 -0500
Message-ID: <1486396489-2911-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

The way we make changes to the NBD device is inherently racey, as we
could be in the middle of a request and suddenly change the number of
connections.  In practice this isn't a big deal, but with timeouts we
have to take the config_lock in order to protect ourselves since it is
important those values don't change.  Fix this by freezing the queue
before we do any of our device operations.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 164a548..f8b3ecd 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -199,7 +199,6 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 	if (nbd->num_connections > 1) {
 		dev_err_ratelimited(nbd_to_dev(nbd),
 				    "Connection timed out, retrying\n");
-		mutex_lock(&nbd->config_lock);
 		/*
 		 * Hooray we have more connections, requeue this IO, the submit
 		 * path will put it on a real connection.
@@ -213,11 +212,9 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 				kernel_sock_shutdown(nsock->sock, SHUT_RDWR);
 				mutex_unlock(&nsock->tx_lock);
 			}
-			mutex_unlock(&nbd->config_lock);
 			blk_mq_requeue_request(req, true);
 			return BLK_EH_RESET_TIMER;
 		}
-		mutex_unlock(&nbd->config_lock);
 	} else {
 		dev_err_ratelimited(nbd_to_dev(nbd),
 				    "Connection timed out\n");
@@ -225,9 +222,7 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 	set_bit(NBD_TIMEDOUT, &nbd->runtime_flags);
 	req->errors++;
 
-	mutex_lock(&nbd->config_lock);
 	sock_shutdown(nbd);
-	mutex_unlock(&nbd->config_lock);
 	return BLK_EH_HANDLED;
 }
 
@@ -756,7 +751,9 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 			return -EINVAL;
 
 		mutex_unlock(&nbd->config_lock);
+		blk_mq_unfreeze_queue(nbd->disk->queue);
 		fsync_bdev(bdev);
+		blk_mq_freeze_queue(nbd->disk->queue);
 		mutex_lock(&nbd->config_lock);
 
 		/* Check again after getting mutex back.  */
@@ -870,10 +867,14 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 			args[i].index = i;
 			queue_work(recv_workqueue, &args[i].work);
 		}
+		blk_mq_unfreeze_queue(nbd->disk->queue);
+
 		wait_event_interruptible(nbd->recv_wq,
 					 atomic_read(&nbd->recv_threads) == 0);
 		for (i = 0; i < num_connections; i++)
 			flush_work(&args[i].work);
+
+		blk_mq_freeze_queue(nbd->disk->queue);
 		nbd_dev_dbg_close(nbd);
 		nbd_size_clear(nbd, bdev);
 		device_remove_file(disk_to_dev(nbd->disk), &pid_attr);
@@ -924,9 +925,11 @@ static int nbd_ioctl(struct block_device *bdev, fmode_t mode,
 
 	BUG_ON(nbd->magic != NBD_MAGIC);
 
+	blk_mq_freeze_queue(nbd->disk->queue);
 	mutex_lock(&nbd->config_lock);
 	error = __nbd_ioctl(bdev, nbd, cmd, arg);
 	mutex_unlock(&nbd->config_lock);
+	blk_mq_unfreeze_queue(nbd->disk->queue);
 
 	return error;
 }
-- 
2.7.4
