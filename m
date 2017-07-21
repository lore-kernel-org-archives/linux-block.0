Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: josef@toxicpanda.com
To: axboe@kernel.dk,
	nbd-general@lists.sourceforge.net,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Cc: Josef Bacik <jbacik@fb.com>
Subject: [PATCH 3/3] nbd: only set sndtimeo if we have a timeout set
Date: Fri, 21 Jul 2017 10:48:15 -0400
Message-Id: <1500648495-13337-3-git-send-email-jbacik@fb.com>
In-Reply-To: <1500648495-13337-1-git-send-email-jbacik@fb.com>
References: <1500648495-13337-1-git-send-email-jbacik@fb.com>
List-ID: <linux-block@vger.kernel.org>

From: Josef Bacik <jbacik@fb.com>

A user reported that he was getting immediate disconnects with my
sndtimeo patch applied.  This is because by default the OSS nbd client
doesn't set a timeout, so we end up setting the sndtimeo to 0, which of
course means we have send errors a lot.  Instead only set our sndtimeo
if the user specified a timeout, otherwise we'll just wait forever like
we did previously.

Fixes: dc88e34d69d8 ("nbd: set sk->sk_sndtimeo for our sockets")
Reported-by: Adam Borowski <kilobyte@angband.pl>
Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 6aefe9f..64b19b1 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -908,7 +908,8 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
 			continue;
 		}
 		sk_set_memalloc(sock->sk);
-		sock->sk->sk_sndtimeo = nbd->tag_set.timeout;
+		if (nbd->tag_set.timeout)
+			sock->sk->sk_sndtimeo = nbd->tag_set.timeout;
 		atomic_inc(&config->recv_threads);
 		refcount_inc(&nbd->config_refs);
 		old = nsock->sock;
@@ -1077,7 +1078,9 @@ static int nbd_start_device(struct nbd_device *nbd)
 			return -ENOMEM;
 		}
 		sk_set_memalloc(config->socks[i]->sock->sk);
-		config->socks[i]->sock->sk->sk_sndtimeo = nbd->tag_set.timeout;
+		if (nbd->tag_set.timeout)
+			config->socks[i]->sock->sk->sk_sndtimeo =
+				nbd->tag_set.timeout;
 		atomic_inc(&config->recv_threads);
 		refcount_inc(&nbd->config_refs);
 		INIT_WORK(&args->work, recv_work);
-- 
2.7.4
