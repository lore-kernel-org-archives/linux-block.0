Return-Path: <prvs=4233a57768=jbacik@fb.com>
From: Josef Bacik <jbacik@fb.com>
To: <axboe@kernel.dk>, <nbd-general@lists.sourceforge.net>,
        <linux-block@vger.kernel.org>, <kernel-team@fb.com>
CC: <stable@vger.kernel.org>
Subject: [PATCH] nbd: stop leaking sockets
Date: Wed, 1 Mar 2017 11:47:22 -0500
Message-ID: <1488386842-16515-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

This was introduced in the multi-connection patch, we've been leaking
socket's ever since.

Fixes: 9561a7a ("nbd: add multi-connection support")
cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 0bf2b21..c7e93f6 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -689,8 +689,10 @@ static int nbd_clear_sock(struct nbd_device *nbd, struct block_device *bdev)
 	    nbd->num_connections) {
 		int i;
 
-		for (i = 0; i < nbd->num_connections; i++)
+		for (i = 0; i < nbd->num_connections; i++) {
+			sockfd_put(nbd->socks[i]->sock);
 			kfree(nbd->socks[i]);
+		}
 		kfree(nbd->socks);
 		nbd->socks = NULL;
 		nbd->num_connections = 0;
-- 
2.7.4
