Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35244 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759683AbdEWPuF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2017 11:50:05 -0400
Received: by mail-qt0-f193.google.com with SMTP id r58so22730644qtb.2
        for <linux-block@vger.kernel.org>; Tue, 23 May 2017 08:50:05 -0700 (PDT)
From: Ilya Dryomov <idryomov@gmail.com>
To: Josef Bacik <jbacik@fb.com>
Cc: nbd-general@lists.sourceforge.net, linux-block@vger.kernel.org,
        Jens Axboe <axboe@fb.com>
Subject: [PATCH v2 1/2] nbd: nbd_reset() call in nbd_dev_add() is redundant
Date: Tue, 23 May 2017 17:49:54 +0200
Message-Id: <1495554595-30945-1-git-send-email-idryomov@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

There is nothing to clear -- nbd_device has just been allocated.
Fold nbd_reset() into its other caller, nbd_config_put().

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/nbd.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 9a7bb2c29447..e725d8d5ab0b 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -937,14 +937,6 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
 	return -ENOSPC;
 }
 
-/* Reset all properties of an NBD device */
-static void nbd_reset(struct nbd_device *nbd)
-{
-	nbd->config = NULL;
-	nbd->tag_set.timeout = 0;
-	queue_flag_clear_unlocked(QUEUE_FLAG_DISCARD, nbd->disk->queue);
-}
-
 static void nbd_bdev_reset(struct block_device *bdev)
 {
 	if (bdev->bd_openers > 1)
@@ -1029,7 +1021,10 @@ static void nbd_config_put(struct nbd_device *nbd)
 			}
 			kfree(config->socks);
 		}
-		nbd_reset(nbd);
+		nbd->config = NULL;
+
+		nbd->tag_set.timeout = 0;
+		queue_flag_clear_unlocked(QUEUE_FLAG_DISCARD, nbd->disk->queue);
 
 		mutex_unlock(&nbd->config_lock);
 		nbd_put(nbd);
@@ -1483,7 +1478,6 @@ static int nbd_dev_add(int index)
 	disk->fops = &nbd_fops;
 	disk->private_data = nbd;
 	sprintf(disk->disk_name, "nbd%d", index);
-	nbd_reset(nbd);
 	add_disk(disk);
 	nbd_total_devices++;
 	return index;
-- 
2.4.3
