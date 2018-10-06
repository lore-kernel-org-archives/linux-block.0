Return-Path: <esyr@redhat.com>
Date: Sat, 6 Oct 2018 20:07:03 +0200
From: Eugene Syromiatnikov <esyr@redhat.com>
To: nbd@other.debian.org, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] nbd: avoid losing the pointer to reallocated config->socks
 in nbd_add_socket()
Message-ID: <20181006180703.GA1870@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

In the (very unlikely) case of config->socks reallocation success and
nsock allocation failure config->nsock will not get updated with the new pointer
to socks array. Fix it by updating config->socks right after reallocation
successfulness check.

Fixes: 9561a7ade0c2 ("nbd: add multi-connection support")
Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
Cc: stable@vger.kernel.org # 4.10+
---
 drivers/block/nbd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 14a5125..bfeaf68 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -951,14 +951,14 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 		sockfd_put(sock);
 		return -ENOMEM;
 	}
+	config->socks = socks;
+
 	nsock = kzalloc(sizeof(struct nbd_sock), GFP_KERNEL);
 	if (!nsock) {
 		sockfd_put(sock);
 		return -ENOMEM;
 	}
 
-	config->socks = socks;
-
 	nsock->fallback_index = -1;
 	nsock->dead = false;
 	mutex_init(&nsock->tx_lock);
-- 
2.1.4
