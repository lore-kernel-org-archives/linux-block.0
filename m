Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: josef@toxicpanda.com
To: axboe@kernel.dk,
	nbd-general@lists.sourceforge.net,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Cc: Josef Bacik <jbacik@fb.com>
Subject: [PATCH] nbd: set sk->sk_sndtimeo for our sockets
Date: Thu,  8 Jun 2017 15:39:30 -0400
Message-Id: <1496950770-5642-1-git-send-email-jbacik@fb.com>
List-ID: <linux-block@vger.kernel.org>

From: Josef Bacik <jbacik@fb.com>

If the nbd server stops receiving packets altogether we will get stuck
waiting for them to receive indefinitely as the tcp buffer will never
empty, which looks like a deadlock.  Fix this by setting the sk send
timeout to our configured timeout, that way if the server really
misbehaves we'll disconnect cleanly instead of waiting forever.

Reported-by: Dan Melnic <dmm@fb.com>
Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index f3f191b..ac0f7a8 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -910,6 +910,7 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
 			continue;
 		}
 		sk_set_memalloc(sock->sk);
+		sock->sk->sk_sndtimeo = nbd->tag_set.timeout;
 		atomic_inc(&config->recv_threads);
 		refcount_inc(&nbd->config_refs);
 		old = nsock->sock;
@@ -1071,6 +1072,7 @@ static int nbd_start_device(struct nbd_device *nbd)
 			return -ENOMEM;
 		}
 		sk_set_memalloc(config->socks[i]->sock->sk);
+		config->socks[i]->sock->sk->sk_sndtimeo = nbd->tag_set.timeout;
 		atomic_inc(&config->recv_threads);
 		refcount_inc(&nbd->config_refs);
 		INIT_WORK(&args->work, recv_work);
-- 
2.7.4
