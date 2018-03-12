Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: linux-block@vger.kernel.org,
	nbd@other.debian.org,
	axboe@kernel.dk,
	alex@iss-integration.com
Cc: Josef Bacik <jbacik@fb.com>,
	stable@vger.kernel.org
Subject: [PATCH] nbd: update size when connected
Date: Mon, 12 Mar 2018 12:00:18 -0400
Message-Id: <20180312160018.30896-1-josef@toxicpanda.com>
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
index 86258b00a1d4..7106b98a35fb 100644
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
