Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	nbd@other.debian.org,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Cc: Josef Bacik <jbacik@fb.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/7] nbd: update size when connected
Date: Wed, 16 May 2018 14:51:18 -0400
Message-Id: <20180516185122.18590-3-josef@toxicpanda.com>
In-Reply-To: <20180516185122.18590-1-josef@toxicpanda.com>
References: <20180516185122.18590-1-josef@toxicpanda.com>
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
index 9710a0c338b0..b709abf3cb79 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -246,6 +246,8 @@ static void nbd_size_set(struct nbd_device *nbd, loff_t blocksize,
 	struct nbd_config *config = nbd->config;
 	config->blksize = blocksize;
 	config->bytesize = blocksize * nr_blocks;
+	if (nbd->task_recv != NULL)
+		nbd_size_update(nbd);
 }
 
 static void nbd_complete_rq(struct request *req)
-- 
2.14.3
