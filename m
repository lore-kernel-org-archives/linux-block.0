Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42356 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757258AbcIHVMy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Sep 2016 17:12:54 -0400
From: Josef Bacik <jbacik@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, <mpa@pengutronix.de>,
        <nbd-general@lists.sourceforge.net>
Subject: [PATCH 2/5] nbd: don't shutdown sock with irq's disabled
Date: Thu, 8 Sep 2016 17:12:07 -0400
Message-ID: <1473369130-22986-3-git-send-email-jbacik@fb.com>
In-Reply-To: <1473369130-22986-1-git-send-email-jbacik@fb.com>
References: <1473369130-22986-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

We hit a warning when shutting down the nbd connection because we have irq's
disabled.  We don't really need to do the shutdown under the lock, just clear
the nbd->sock.  So do the shutdown outside of the irq.  This gets rid of the
warning.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 15e7c67..4b7d0f3 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -161,6 +161,8 @@ static void nbd_end_request(struct nbd_cmd *cmd)
  */
 static void sock_shutdown(struct nbd_device *nbd)
 {
+	struct socket *sock;
+
 	spin_lock_irq(&nbd->sock_lock);
 
 	if (!nbd->sock) {
@@ -168,18 +170,21 @@ static void sock_shutdown(struct nbd_device *nbd)
 		return;
 	}
 
+	sock = nbd->sock;
 	dev_warn(disk_to_dev(nbd->disk), "shutting down socket\n");
-	kernel_sock_shutdown(nbd->sock, SHUT_RDWR);
-	sockfd_put(nbd->sock);
 	nbd->sock = NULL;
 	spin_unlock_irq(&nbd->sock_lock);
 
+	kernel_sock_shutdown(sock, SHUT_RDWR);
+	sockfd_put(sock);
+
 	del_timer(&nbd->timeout_timer);
 }
 
 static void nbd_xmit_timeout(unsigned long arg)
 {
 	struct nbd_device *nbd = (struct nbd_device *)arg;
+	struct socket *sock = NULL;
 	unsigned long flags;
 
 	if (!atomic_read(&nbd->outstanding_cmds))
@@ -189,10 +194,16 @@ static void nbd_xmit_timeout(unsigned long arg)
 
 	nbd->timedout = true;
 
-	if (nbd->sock)
-		kernel_sock_shutdown(nbd->sock, SHUT_RDWR);
+	if (nbd->sock) {
+		sock = nbd->sock;
+		get_file(sock->file);
+	}
 
 	spin_unlock_irqrestore(&nbd->sock_lock, flags);
+	if (sock) {
+		kernel_sock_shutdown(sock, SHUT_RDWR);
+		sockfd_put(sock);
+	}
 
 	dev_err(nbd_to_dev(nbd), "Connection timed out, shutting down connection\n");
 }
-- 
2.8.0.rc2

