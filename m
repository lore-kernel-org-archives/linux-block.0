Return-Path: <kvigor@gmail.com>
Return-Path: <kvigor@gmail.com>
From: kvigor@gmail.com
To: linux-block@vger.kernel.org
Cc: josef@toxicpanda.com,
	axboe@kernel.dk,
	Kevin Vigor <kvigor@fb.com>
Subject: [PATCH] nbd: clear DISCONNECT_REQUESTED flag once disconnection occurs.
Date: Tue, 29 May 2018 17:09:51 -0600
Message-Id: <1527635391-9156-1-git-send-email-kvigor@gmail.com>
List-ID: <linux-block@vger.kernel.org>

From: Kevin Vigor <kvigor@fb.com>

When a userspace client requests a NBD device be disconnected, the
DISCONNECT_REQUESTED flag is set. While this flag is set, the driver
will not inform userspace when a connection is closed.

Unfortunately the flag was never cleared, so once a disconnect was
requested the driver would thereafter never tell userspace about a
closed connection. Thus when connections failed due to timeout, no
attempt to reconnect was made and eventually the device would fail.

Fix by clearing the DISCONNECT_REQUESTED flag (and setting the
DISCONNECTED flag) once all connections are closed.

Additionally wake all tasks waiting in wait_for_reconnect() when a
connection is established instead of only waking one and letting the
rest timeout.

Signed-off-by: Kevin Vigor <kvigor@fb.com>
---
 drivers/block/nbd.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index afbc202..11956d4 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -213,7 +213,15 @@ static void nbd_mark_nsock_dead(struct nbd_device *nbd, struct nbd_sock *nsock,
 	}
 	if (!nsock->dead) {
 		kernel_sock_shutdown(nsock->sock, SHUT_RDWR);
-		atomic_dec(&nbd->config->live_connections);
+		if (atomic_dec_return(&nbd->config->live_connections) == 0) {
+			if (test_and_clear_bit(NBD_DISCONNECT_REQUESTED,
+					       &nbd->config->runtime_flags)) {
+				set_bit(NBD_DISCONNECTED,
+					&nbd->config->runtime_flags);
+				dev_info(nbd_to_dev(nbd),
+					"Disconnected due to user request.\n");
+			}
+		}
 	}
 	nsock->dead = true;
 	nsock->pending = NULL;
@@ -292,7 +300,9 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 
 	if (config->num_connections > 1) {
 		dev_err_ratelimited(nbd_to_dev(nbd),
-				    "Connection timed out, retrying\n");
+				    "Connection timed out, retrying (%d/%d alive)\n",
+				    atomic_read(&config->live_connections),
+				    config->num_connections);
 		/*
 		 * Hooray we have more connections, requeue this IO, the submit
 		 * path will put it on a real connection.
@@ -714,10 +724,9 @@ static int wait_for_reconnect(struct nbd_device *nbd)
 		return 0;
 	if (test_bit(NBD_DISCONNECTED, &config->runtime_flags))
 		return 0;
-	wait_event_timeout(config->conn_wait,
-			   atomic_read(&config->live_connections),
-			   config->dead_conn_timeout);
-	return atomic_read(&config->live_connections);
+	return wait_event_timeout(config->conn_wait,
+				  atomic_read(&config->live_connections) > 0,
+				  config->dead_conn_timeout) > 0;
 }
 
 static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
@@ -937,7 +946,7 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
 		queue_work(recv_workqueue, &args->work);
 
 		atomic_inc(&config->live_connections);
-		wake_up(&config->conn_wait);
+		wake_up_all(&config->conn_wait);
 		return 0;
 	}
 	sockfd_put(sock);
-- 
2.7.4
