Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	nbd@other.debian.org,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Cc: Josef Bacik <jbacik@fb.com>
Subject: [PATCH] nbd: fix bdev invalidation
Date: Tue,  7 Nov 2017 13:26:56 -0500
Message-Id: <1510079216-4580-1-git-send-email-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

From: Josef Bacik <jbacik@fb.com>

We do the bdev invalidation sort of haphazardly throughout nbd which has
resulted in weirdness like partitions not showing up when doing netlink
connects, or they not disappearing properly in the ioctl case.  Fix this
by making the invalidation of the device more forceful when we drop our
config, and make sure we invalidate the bdev every time we make a new
connection so the partition table is picked up.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 5f2a4240a204..ef7398ccb387 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -220,14 +220,6 @@ static void nbd_mark_nsock_dead(struct nbd_device *nbd, struct nbd_sock *nsock,
 	nsock->sent = 0;
 }
 
-static void nbd_size_clear(struct nbd_device *nbd)
-{
-	if (nbd->config->bytesize) {
-		set_capacity(nbd->disk, 0);
-		kobject_uevent(&nbd_to_dev(nbd)->kobj, KOBJ_CHANGE);
-	}
-}
-
 static void nbd_size_update(struct nbd_device *nbd)
 {
 	struct nbd_config *config = nbd->config;
@@ -945,14 +937,20 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
 	return -ENOSPC;
 }
 
-static void nbd_bdev_reset(struct block_device *bdev)
+static void nbd_invalidate_disk(struct nbd_device *nbd)
 {
-	if (bdev->bd_openers > 1)
+	struct block_device *bdev;
+
+	if (!nbd->config->bytesize)
 		return;
-	bd_set_size(bdev, 0);
-	if (max_part > 0) {
-		blkdev_reread_part(bdev);
+
+	bdev = bdget_disk(nbd->disk, 0);
+	if (bdev) {
+		set_capacity(nbd->disk, 0);
+		__invalidate_device(bdev, true);
 		bdev->bd_invalidated = 1;
+		bdput(bdev);
+		kobject_uevent(&nbd_to_dev(nbd)->kobj, KOBJ_CHANGE);
 	}
 }
 
@@ -1022,7 +1020,7 @@ static void nbd_config_put(struct nbd_device *nbd)
 					&nbd->config_lock)) {
 		struct nbd_config *config = nbd->config;
 		nbd_dev_dbg_close(nbd);
-		nbd_size_clear(nbd);
+		nbd_invalidate_disk(nbd);
 		if (test_and_clear_bit(NBD_HAS_PID_FILE,
 				       &config->runtime_flags))
 			device_remove_file(disk_to_dev(nbd->disk), &pid_attr);
@@ -1110,15 +1108,13 @@ static int nbd_start_device_ioctl(struct nbd_device *nbd, struct block_device *b
 		return ret;
 
 	bd_set_size(bdev, config->bytesize);
-	if (max_part)
-		bdev->bd_invalidated = 1;
+	bdev->bd_invalidated = 1;
 	mutex_unlock(&nbd->config_lock);
 	ret = wait_event_interruptible(config->recv_wq,
 					 atomic_read(&config->recv_threads) == 0);
 	if (ret)
 		sock_shutdown(nbd);
 	mutex_lock(&nbd->config_lock);
-	bd_set_size(bdev, 0);
 	/* user requested, ignore socket errors */
 	if (test_bit(NBD_DISCONNECT_REQUESTED, &config->runtime_flags))
 		ret = 0;
@@ -1131,8 +1127,6 @@ static void nbd_clear_sock_ioctl(struct nbd_device *nbd,
 				 struct block_device *bdev)
 {
 	sock_shutdown(nbd);
-	kill_bdev(bdev);
-	nbd_bdev_reset(bdev);
 	if (test_and_clear_bit(NBD_HAS_CONFIG_REF,
 			       &nbd->config->runtime_flags))
 		nbd_config_put(nbd);
@@ -1708,6 +1702,11 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 	ret = nbd_start_device(nbd);
+	if (!ret) {
+		struct block_device *bdev = bdget_disk(nbd->disk, 0);
+		bdev->bd_invalidated = 1;
+		bdput(bdev);
+	}
 out:
 	mutex_unlock(&nbd->config_lock);
 	if (!ret) {
-- 
2.7.5
