Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: josef@toxicpanda.com
To: axboe@kernel.dk,
	nbd-general@lists.sourceforge.net,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Cc: Josef Bacik <jbacik@fb.com>
Subject: [PATCH 1/3] nbd: allow multiple disconnects to be sent
Date: Fri, 21 Jul 2017 10:48:13 -0400
Message-Id: <1500648495-13337-1-git-send-email-jbacik@fb.com>
List-ID: <linux-block@vger.kernel.org>

From: Josef Bacik <jbacik@fb.com>

There's no reason to limit ourselves to one disconnect message per
socket.  Sometimes networks do strange things, might as well let
sysadmins hit the panic button as much as they want.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 87a0a29..f91e7ac 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -991,9 +991,8 @@ static int nbd_disconnect(struct nbd_device *nbd)
 	struct nbd_config *config = nbd->config;
 
 	dev_info(disk_to_dev(nbd->disk), "NBD_DISCONNECT\n");
-	if (!test_and_set_bit(NBD_DISCONNECT_REQUESTED,
-			      &config->runtime_flags))
-		send_disconnects(nbd);
+	set_bit(NBD_DISCONNECT_REQUESTED, &config->runtime_flags);
+	send_disconnects(nbd);
 	return 0;
 }
 
-- 
2.7.4
