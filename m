Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40923 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751771AbdAMPvm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jan 2017 10:51:42 -0500
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id v0DFpVFd007540
        for <linux-block@vger.kernel.org>; Fri, 13 Jan 2017 07:51:31 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 27xxg6ge5j-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 13 Jan 2017 07:51:31 -0800
From: Josef Bacik <jbacik@fb.com>
To: <linux-block@vger.kernel.org>
Subject: [PATCH] nbd: create a recv workqueue per nbd device
Date: Fri, 13 Jan 2017 10:51:13 -0500
Message-ID: <1484322673-10606-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Since we are in the memory reclaim path we need our recv work to be on a
workqueue that has WQ_MEM_RECLAIM set so we can avoid deadlocks.  Also
set WQ_HIGHPRI since we are in the completion path for IO.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 99c8446..e0a8d51 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -70,6 +70,7 @@ struct nbd_device {
 	struct task_struct *task_recv;
 	struct task_struct *task_setup;
 
+	struct workqueue_struct *recv_workqueue;
 #if IS_ENABLED(CONFIG_DEBUG_FS)
 	struct dentry *dbg_dir;
 #endif
@@ -787,7 +788,7 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 			INIT_WORK(&args[i].work, recv_work);
 			args[i].nbd = nbd;
 			args[i].index = i;
-			queue_work(system_long_wq, &args[i].work);
+			queue_work(nbd->recv_workqueue, &args[i].work);
 		}
 		wait_event_interruptible(nbd->recv_wq,
 					 atomic_read(&nbd->recv_threads) == 0);
@@ -1074,6 +1075,16 @@ static int __init nbd_init(void)
 			goto out;
 		}
 
+		nbd_dev[i].recv_workqueue =
+			alloc_workqueue("knbd-recv",
+					WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
+		if (!nbd_dev[i].recv_workqueue) {
+			blk_mq_free_tag_set(&nbd_dev[i].tag_set);
+			blk_cleanup_queue(disk->queue);
+			put_disk(disk);
+			goto out;
+		}
+
 		/*
 		 * Tell the block layer that we are not a rotational device
 		 */
@@ -1115,6 +1126,7 @@ static int __init nbd_init(void)
 		blk_mq_free_tag_set(&nbd_dev[i].tag_set);
 		blk_cleanup_queue(nbd_dev[i].disk->queue);
 		put_disk(nbd_dev[i].disk);
+		destroy_workqueue(nbd_dev[i].recv_workqueue);
 	}
 	kfree(nbd_dev);
 	return err;
@@ -1134,6 +1146,7 @@ static void __exit nbd_cleanup(void)
 			blk_cleanup_queue(disk->queue);
 			blk_mq_free_tag_set(&nbd_dev[i].tag_set);
 			put_disk(disk);
+			destroy_workqueue(nbd_dev[i].recv_workqueue);
 		}
 	}
 	unregister_blkdev(NBD_MAJOR, "nbd");
-- 
2.5.5

