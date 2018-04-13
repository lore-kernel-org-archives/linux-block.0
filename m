Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	nbd@other.debian.org,
	linux-block@vger.kernel.org,
	kernel-team@fb.com,
	alex@iss-integration.com
Cc: Josef Bacik <jbacik@fb.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] nbd: update size when connected
Date: Fri, 13 Apr 2018 12:03:33 -0400
Message-Id: <20180413160334.5496-2-josef@toxicpanda.com>
In-Reply-To: <20180413160334.5496-1-josef@toxicpanda.com>
References: <20180413160334.5496-1-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

From: Josef Bacik <jbacik@fb.com>

I messed up changing the size of an NBD device while it was connected by
not actually updating the device or doing the uevent.  Fix this by
updating everything if we're connected and we change the size.

cc: stable@vger.kernel.org
Fixes: 639812a ("nbd: don't set the device size until we're connected")
Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index e33da3e6aa20..1520383b12f6 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -243,6 +243,8 @@ static void nbd_size_set(struct nbd_device *nbd, loff_t blocksize,
 	struct nbd_config *config = nbd->config;
 	config->blksize = blocksize;
 	config->bytesize = blocksize * nr_blocks;
+	if (nbd->task_recv != NULL)
+		nbd_size_update(nbd);
 }
 
 static void nbd_complete_rq(struct request *req)
-- 
2.14.3
