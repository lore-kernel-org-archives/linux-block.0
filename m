Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42272 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757833AbcIHVNH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Sep 2016 17:13:07 -0400
From: Josef Bacik <jbacik@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, <mpa@pengutronix.de>,
        <nbd-general@lists.sourceforge.net>
Subject: [PATCH 4/5] nbd: allow block mq to deal with timeouts
Date: Thu, 8 Sep 2016 17:12:09 -0400
Message-ID: <1473369130-22986-5-git-send-email-jbacik@fb.com>
In-Reply-To: <1473369130-22986-1-git-send-email-jbacik@fb.com>
References: <1473369130-22986-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Instead of rolling our own timer, just utilize the blk mq req timeout and do the
disconnect if any of our commands timeout.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 51 ++++++++++++++-------------------------------------
 1 file changed, 14 insertions(+), 37 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index cf855a1..4c6dd1a 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -50,16 +50,13 @@ struct nbd_device {
 	struct socket * sock;	/* If == NULL, device is not ready, yet	*/
 	int magic;
 
-	atomic_t outstanding_cmds;
 	struct blk_mq_tag_set tag_set;
 
 	struct mutex tx_lock;
 	struct gendisk *disk;
 	int blksize;
 	loff_t bytesize;
-	int xmit_timeout;
 
-	struct timer_list timeout_timer;
 	/* protects initialization and shutdown of the socket */
 	spinlock_t sock_lock;
 	struct task_struct *task_recv;
@@ -154,7 +151,6 @@ static void nbd_end_request(struct nbd_cmd *cmd)
 	dev_dbg(nbd_to_dev(nbd), "request %p: %s\n", cmd,
 		error ? "failed" : "done");
 
-	atomic_dec(&nbd->outstanding_cmds);
 	blk_mq_complete_request(req, error);
 }
 
@@ -165,7 +161,7 @@ static void sock_shutdown(struct nbd_device *nbd)
 {
 	struct socket *sock;
 
-	spin_lock_irq(&nbd->sock_lock);
+	spin_lock(&nbd->sock_lock);
 
 	if (!nbd->sock) {
 		spin_unlock_irq(&nbd->sock_lock);
@@ -175,24 +171,20 @@ static void sock_shutdown(struct nbd_device *nbd)
 	sock = nbd->sock;
 	dev_warn(disk_to_dev(nbd->disk), "shutting down socket\n");
 	nbd->sock = NULL;
-	spin_unlock_irq(&nbd->sock_lock);
+	spin_unlock(&nbd->sock_lock);
 
 	kernel_sock_shutdown(sock, SHUT_RDWR);
 	sockfd_put(sock);
-
-	del_timer(&nbd->timeout_timer);
 }
 
-static void nbd_xmit_timeout(unsigned long arg)
+static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
+						 bool reserved)
 {
-	struct nbd_device *nbd = (struct nbd_device *)arg;
+	struct nbd_cmd *cmd = blk_mq_rq_to_pdu(req);
+	struct nbd_device *nbd = cmd->nbd;
 	struct socket *sock = NULL;
-	unsigned long flags;
-
-	if (!atomic_read(&nbd->outstanding_cmds))
-		return;
 
-	spin_lock_irqsave(&nbd->sock_lock, flags);
+	spin_lock(&nbd->sock_lock);
 
 	set_bit(NBD_TIMEDOUT, &nbd->runtime_flags);
 
@@ -201,13 +193,15 @@ static void nbd_xmit_timeout(unsigned long arg)
 		get_file(sock->file);
 	}
 
-	spin_unlock_irqrestore(&nbd->sock_lock, flags);
+	spin_unlock(&nbd->sock_lock);
 	if (sock) {
 		kernel_sock_shutdown(sock, SHUT_RDWR);
 		sockfd_put(sock);
 	}
 
+	req->errors++;
 	dev_err(nbd_to_dev(nbd), "Connection timed out, shutting down connection\n");
+	return BLK_EH_HANDLED;
 }
 
 /*
@@ -257,9 +251,6 @@ static int sock_xmit(struct nbd_device *nbd, int send, void *buf, int size,
 
 	tsk_restore_flags(current, pflags, PF_MEMALLOC);
 
-	if (!send && nbd->xmit_timeout)
-		mod_timer(&nbd->timeout_timer, jiffies + nbd->xmit_timeout);
-
 	return result;
 }
 
@@ -512,10 +503,6 @@ static void nbd_handle_cmd(struct nbd_cmd *cmd)
 		goto error_out;
 	}
 
-	if (nbd->xmit_timeout && !atomic_read(&nbd->outstanding_cmds))
-		mod_timer(&nbd->timeout_timer, jiffies + nbd->xmit_timeout);
-
-	atomic_inc(&nbd->outstanding_cmds);
 	if (nbd_send_cmd(nbd, cmd) != 0) {
 		dev_err(disk_to_dev(nbd->disk), "Request send failed\n");
 		req->errors++;
@@ -569,9 +556,8 @@ static void nbd_reset(struct nbd_device *nbd)
 	nbd->bytesize = 0;
 	set_capacity(nbd->disk, 0);
 	nbd->flags = 0;
-	nbd->xmit_timeout = 0;
+	nbd->tag_set.timeout = 0;
 	queue_flag_clear_unlocked(QUEUE_FLAG_DISCARD, nbd->disk->queue);
-	del_timer_sync(&nbd->timeout_timer);
 }
 
 static void nbd_bdev_reset(struct block_device *bdev)
@@ -668,13 +654,7 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 		return nbd_size_set(nbd, bdev, nbd->blksize, arg);
 
 	case NBD_SET_TIMEOUT:
-		nbd->xmit_timeout = arg * HZ;
-		if (arg)
-			mod_timer(&nbd->timeout_timer,
-				  jiffies + nbd->xmit_timeout);
-		else
-			del_timer_sync(&nbd->timeout_timer);
-
+		nbd->tag_set.timeout = arg * HZ;
 		return 0;
 
 	case NBD_SET_FLAGS:
@@ -836,7 +816,7 @@ static int nbd_dev_dbg_init(struct nbd_device *nbd)
 
 	debugfs_create_file("tasks", 0444, dir, nbd, &nbd_dbg_tasks_ops);
 	debugfs_create_u64("size_bytes", 0444, dir, &nbd->bytesize);
-	debugfs_create_u32("timeout", 0444, dir, &nbd->xmit_timeout);
+	debugfs_create_u32("timeout", 0444, dir, &nbd->tag_set.timeout);
 	debugfs_create_u32("blocksize", 0444, dir, &nbd->blksize);
 	debugfs_create_file("flags", 0444, dir, nbd, &nbd_dbg_flags_ops);
 
@@ -903,6 +883,7 @@ static struct blk_mq_ops nbd_mq_ops = {
 	.queue_rq	= nbd_queue_rq,
 	.map_queue	= blk_mq_map_queue,
 	.init_request	= nbd_init_request,
+	.timeout	= nbd_xmit_timeout,
 };
 
 /*
@@ -1007,10 +988,6 @@ static int __init nbd_init(void)
 		nbd_dev[i].magic = NBD_MAGIC;
 		spin_lock_init(&nbd_dev[i].sock_lock);
 		mutex_init(&nbd_dev[i].tx_lock);
-		init_timer(&nbd_dev[i].timeout_timer);
-		nbd_dev[i].timeout_timer.function = nbd_xmit_timeout;
-		nbd_dev[i].timeout_timer.data = (unsigned long)&nbd_dev[i];
-		atomic_set(&nbd_dev[i].outstanding_cmds, 0);
 		disk->major = NBD_MAJOR;
 		disk->first_minor = i << part_shift;
 		disk->fops = &nbd_fops;
-- 
2.8.0.rc2

