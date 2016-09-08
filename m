Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42198 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755937AbcIHVMo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Sep 2016 17:12:44 -0400
From: Josef Bacik <jbacik@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, <mpa@pengutronix.de>,
        <nbd-general@lists.sourceforge.net>
Subject: [PATCH 3/5] nbd: use flags instead of bool
Date: Thu, 8 Sep 2016 17:12:08 -0400
Message-ID: <1473369130-22986-4-git-send-email-jbacik@fb.com>
In-Reply-To: <1473369130-22986-1-git-send-email-jbacik@fb.com>
References: <1473369130-22986-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In preparation for some future changes, change a few of the state bools over to
normal bits to set/clear properly.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 4b7d0f3..cf855a1 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -41,8 +41,12 @@
 
 #include <linux/nbd.h>
 
+#define NBD_TIMEDOUT			0
+#define NBD_DISCONNECT_REQUESTED	1
+
 struct nbd_device {
 	u32 flags;
+	unsigned long runtime_flags;
 	struct socket * sock;	/* If == NULL, device is not ready, yet	*/
 	int magic;
 
@@ -54,8 +58,6 @@ struct nbd_device {
 	int blksize;
 	loff_t bytesize;
 	int xmit_timeout;
-	bool timedout;
-	bool disconnect; /* a disconnect has been requested by user */
 
 	struct timer_list timeout_timer;
 	/* protects initialization and shutdown of the socket */
@@ -192,7 +194,7 @@ static void nbd_xmit_timeout(unsigned long arg)
 
 	spin_lock_irqsave(&nbd->sock_lock, flags);
 
-	nbd->timedout = true;
+	set_bit(NBD_TIMEDOUT, &nbd->runtime_flags);
 
 	if (nbd->sock) {
 		sock = nbd->sock;
@@ -562,8 +564,7 @@ out:
 /* Reset all properties of an NBD device */
 static void nbd_reset(struct nbd_device *nbd)
 {
-	nbd->disconnect = false;
-	nbd->timedout = false;
+	nbd->runtime_flags = 0;
 	nbd->blksize = 1024;
 	nbd->bytesize = 0;
 	set_capacity(nbd->disk, 0);
@@ -626,7 +627,7 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 			return -EINVAL;
 		}
 
-		nbd->disconnect = true;
+		set_bit(NBD_DISCONNECT_REQUESTED, &nbd->runtime_flags);
 
 		nbd_send_cmd(nbd, blk_mq_rq_to_pdu(sreq));
 		blk_mq_free_request(sreq);
@@ -706,9 +707,10 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 		kill_bdev(bdev);
 		nbd_bdev_reset(bdev);
 
-		if (nbd->disconnect) /* user requested, ignore socket errors */
+		/* user requested, ignore socket errors */
+		if (test_bit(NBD_DISCONNECT_REQUESTED, &nbd->runtime_flags))
 			error = 0;
-		if (nbd->timedout)
+		if (test_bit(NBD_TIMEDOUT, &nbd->runtime_flags))
 			error = -ETIMEDOUT;
 
 		nbd_reset(nbd);
-- 
2.8.0.rc2

