Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	nbd@other.debian.org,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Cc: Josef Bacik <jbacik@fb.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2][RESEND] nbd: wait uninterruptible for the dead timeout
Date: Mon,  6 Nov 2017 16:11:57 -0500
Message-Id: <1510002718-9574-1-git-send-email-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

From: Josef Bacik <jbacik@fb.com>

If we have a pending signal or the user kills their application then
it'll bring down the whole device, which is less than awesome.  Instead
wait uninterruptible for the dead timeout so we're sure we gave it our
best shot.

Fixes: 560bc4b39952 ("nbd: handle dead connections")
Cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 9adfb5445f8d..fdef8efcdabc 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -723,9 +723,9 @@ static int wait_for_reconnect(struct nbd_device *nbd)
 		return 0;
 	if (test_bit(NBD_DISCONNECTED, &config->runtime_flags))
 		return 0;
-	wait_event_interruptible_timeout(config->conn_wait,
-					 atomic_read(&config->live_connections),
-					 config->dead_conn_timeout);
+	wait_event_timeout(config->conn_wait,
+			   atomic_read(&config->live_connections),
+			   config->dead_conn_timeout);
 	return atomic_read(&config->live_connections);
 }
 
-- 
2.7.5
