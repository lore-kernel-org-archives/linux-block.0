Return-Path: <colin.king@canonical.com>
From: Colin King <colin.king@canonical.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: avoid null pointer dereference on null disk
Date: Mon,  6 Nov 2017 17:53:53 +0000
Message-Id: <20171106175353.20199-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-block@vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

It is possible that the pointer disk can be null and hence
we can get a null pointer deference when accessing disk->flags.
Add a null pointer check to avoid the dereference.

Detected by CoverityScan, CID#1461133 ("Explicit null dereferenced")

Fixes: 8ddcd653257c ("block: introduce GENHD_FL_HIDDEN")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 block/genhd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index d85dcc701d76..42908a7186cd 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -798,7 +798,7 @@ struct gendisk *get_gendisk(dev_t devt, int *partno)
 		spin_unlock_bh(&ext_devt_lock);
 	}
 
-	if (unlikely(disk->flags & GENHD_FL_HIDDEN)) {
+	if (disk && unlikely(disk->flags & GENHD_FL_HIDDEN)) {
 		put_disk(disk);
 		disk = NULL;
 	}
-- 
2.14.1
