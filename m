Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	nbd-general@lists.sourceforge.net,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 01/12] nbd: put socket in error cases
Date: Thu,  6 Apr 2017 17:01:56 -0400
Message-Id: <1491512527-4286-2-git-send-email-jbacik@fb.com>
In-Reply-To: <1491512527-4286-1-git-send-email-jbacik@fb.com>
References: <1491512527-4286-1-git-send-email-jbacik@fb.com>
List-ID: <linux-block@vger.kernel.org>

When adding a new socket we look it up and then try to add it to our
configuration.  If any of those steps fail we need to make sure we put
the socket so we don't leak them.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 03ae729..a4fd82e 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -628,16 +628,21 @@ static int nbd_add_socket(struct nbd_device *nbd, struct block_device *bdev,
 	if (nbd->task_setup != current) {
 		dev_err(disk_to_dev(nbd->disk),
 			"Device being setup by another task");
+		sockfd_put(sock);
 		return -EINVAL;
 	}
 
 	socks = krealloc(nbd->socks, (nbd->num_connections + 1) *
 			 sizeof(struct nbd_sock *), GFP_KERNEL);
-	if (!socks)
+	if (!socks) {
+		sockfd_put(sock);
 		return -ENOMEM;
+	}
 	nsock = kzalloc(sizeof(struct nbd_sock), GFP_KERNEL);
-	if (!nsock)
+	if (!nsock) {
+		sockfd_put(sock);
 		return -ENOMEM;
+	}
 
 	nbd->socks = socks;
 
-- 
2.7.4
