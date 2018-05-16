Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	nbd@other.debian.org,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Cc: Josef Bacik <jbacik@fb.com>
Subject: [PATCH 5/7] nbd: clear_sock on netlink disconnect
Date: Wed, 16 May 2018 14:51:20 -0400
Message-Id: <20180516185122.18590-5-josef@toxicpanda.com>
In-Reply-To: <20180516185122.18590-1-josef@toxicpanda.com>
References: <20180516185122.18590-1-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

From: Josef Bacik <jbacik@fb.com>

This is what the ioctl based nbd disconnect does as well.  Without this
the device will just sit there and wait for the connection to go away
(or IO to occur) before the device gets torn down.  Instead clear
everything up on our end so the configuration goes away as quickly as
possible.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 64278f472efe..06725ce97593 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1768,6 +1768,7 @@ static int nbd_genl_disconnect(struct sk_buff *skb, struct genl_info *info)
 	}
 	mutex_lock(&nbd->config_lock);
 	nbd_disconnect(nbd);
+	nbd_clear_sock(nbd);
 	mutex_unlock(&nbd->config_lock);
 	if (test_and_clear_bit(NBD_HAS_CONFIG_REF,
 			       &nbd->config->runtime_flags))
-- 
2.14.3
