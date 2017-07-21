Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: josef@toxicpanda.com
To: axboe@kernel.dk,
	nbd-general@lists.sourceforge.net,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Cc: Josef Bacik <jbacik@fb.com>
Subject: [PATCH 2/3] nbd: take tx_lock before disconnecting
Date: Fri, 21 Jul 2017 10:48:14 -0400
Message-Id: <1500648495-13337-2-git-send-email-jbacik@fb.com>
In-Reply-To: <1500648495-13337-1-git-send-email-jbacik@fb.com>
References: <1500648495-13337-1-git-send-email-jbacik@fb.com>
List-ID: <linux-block@vger.kernel.org>

From: Josef Bacik <jbacik@fb.com>

We need to take the tx_lock so we don't interleave our disconnect
request between real data going down the wire.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index f91e7ac..6aefe9f 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -978,11 +978,15 @@ static void send_disconnects(struct nbd_device *nbd)
 	int i, ret;
 
 	for (i = 0; i < config->num_connections; i++) {
+		struct nbd_sock *nsock = config->socks[i];
+
 		iov_iter_kvec(&from, WRITE | ITER_KVEC, &iov, 1, sizeof(request));
+		mutex_lock(&nsock->tx_lock);
 		ret = sock_xmit(nbd, i, 1, &from, 0, NULL);
 		if (ret <= 0)
 			dev_err(disk_to_dev(nbd->disk),
 				"Send disconnect failed %d\n", ret);
+		mutex_unlock(&nsock->tx_lock);
 	}
 }
 
-- 
2.7.4
