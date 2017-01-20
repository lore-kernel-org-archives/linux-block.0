Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50941 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752229AbdATV5M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Jan 2017 16:57:12 -0500
From: Josef Bacik <jbacik@fb.com>
To: <arnd@arndb.de>, <gregkh@linuxfoundation.org>, <axboe@fb.com>,
        <nbd-general@lists.sourceforge.net>, <linux-block@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: [PATCH 1/4] nbd: use our own workqueue for recv threads
Date: Fri, 20 Jan 2017 16:56:49 -0500
Message-ID: <1484949412-6903-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Since we are in the memory reclaim path we need our recv work to be on a
workqueue that has WQ_MEM_RECLAIM set so we can avoid deadlocks.  Also
set WQ_HIGHPRI since we are in the completion path for IO.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 9fd06ee..9fe9763 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -91,6 +91,7 @@ static struct dentry *nbd_dbg_dir;
 static unsigned int nbds_max = 16;
 static struct nbd_device *nbd_dev;
 static int max_part;
+static struct workqueue_struct *recv_workqueue;
 
 static inline struct device *nbd_to_dev(struct nbd_device *nbd)
 {
@@ -785,7 +786,7 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 			INIT_WORK(&args[i].work, recv_work);
 			args[i].nbd = nbd;
 			args[i].index = i;
-			queue_work(system_long_wq, &args[i].work);
+			queue_work(recv_workqueue, &args[i].work);
 		}
 		wait_event_interruptible(nbd->recv_wq,
 					 atomic_read(&nbd->recv_threads) == 0);
@@ -1034,10 +1035,16 @@ static int __init nbd_init(void)
 
 	if (nbds_max > 1UL << (MINORBITS - part_shift))
 		return -EINVAL;
+	recv_workqueue = alloc_workqueue("knbd-recv",
+					 WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
+	if (!recv_workqueue)
+		return -ENOMEM;
 
 	nbd_dev = kcalloc(nbds_max, sizeof(*nbd_dev), GFP_KERNEL);
-	if (!nbd_dev)
+	if (!nbd_dev) {
+		destroy_workqueue(recv_workqueue);
 		return -ENOMEM;
+	}
 
 	for (i = 0; i < nbds_max; i++) {
 		struct request_queue *q;
@@ -1117,6 +1124,7 @@ static int __init nbd_init(void)
 		put_disk(nbd_dev[i].disk);
 	}
 	kfree(nbd_dev);
+	destroy_workqueue(recv_workqueue);
 	return err;
 }
 
@@ -1136,6 +1144,7 @@ static void __exit nbd_cleanup(void)
 			put_disk(disk);
 		}
 	}
+	destroy_workqueue(recv_workqueue);
 	unregister_blkdev(NBD_MAJOR, "nbd");
 	kfree(nbd_dev);
 	printk(KERN_INFO "nbd: unregistered device at major %d\n", NBD_MAJOR);
-- 
2.7.4

