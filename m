Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: josef@toxicpanda.com
To: axboe@kernel.dk,
	nbd-general@lists.sourceforge.net,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Cc: Josef Bacik <jbacik@fb.com>
Subject: [PATCH] nbd: clear disconnected on reconnect
Date: Tue, 25 Jul 2017 13:31:19 -0400
Message-Id: <1501003879-18014-1-git-send-email-jbacik@fb.com>
List-ID: <linux-block@vger.kernel.org>

From: Josef Bacik <jbacik@fb.com>

If our device loses its connection for longer than the dead timeout we
will set NBD_DISCONNECTED in order to quickly fail any pending IO's that
flood in after the IO's that were waiting during the dead timer.
However if we re-connect at some point in the future we'll still see
this DISCONNECTED flag set if we then lose our connection again after
that, which means we won't get notifications for our newly lost
connections.  Fix this by just clearing the DISCONNECTED flag on
reconnect in order to make sure everything works as it's supposed to.

Reported-by: Dan Melnic <dmm@fb.com>
Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 64b19b1..5bdf923 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -923,6 +923,8 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
 		mutex_unlock(&nsock->tx_lock);
 		sockfd_put(old);
 
+		clear_bit(NBD_DISCONNECTED, &config->runtime_flags);
+
 		/* We take the tx_mutex in an error path in the recv_work, so we
 		 * need to queue_work outside of the tx_mutex.
 		 */
-- 
2.7.4
