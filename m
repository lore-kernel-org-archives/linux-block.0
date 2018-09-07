Return-Path: <hangdianqj@163.com>
From: jun qian <hangdianqj@163.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jun qian <hangdianqj@163.com>
Subject: [PATCH] block: umem: replace spin_lock_bh with spin_lock in tasklet callback
Date: Fri,  7 Sep 2018 10:27:20 -0700
Message-Id: <20180907172720.48621-1-hangdianqj@163.com>
List-ID: <linux-block@vger.kernel.org>

As you are already in a tasklet, it is unnecessary to call spin_lock_bh.

Signed-off-by: jun qian <hangdianqj@163.com>
---
 drivers/block/umem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/umem.c b/drivers/block/umem.c
index 5c7fb8cc4149..9094ca60949c 100644
--- a/drivers/block/umem.c
+++ b/drivers/block/umem.c
@@ -421,7 +421,7 @@ static void process_page(unsigned long data)
 	struct cardinfo *card = (struct cardinfo *)data;
 	unsigned int dma_status = card->dma_status;
 
-	spin_lock_bh(&card->lock);
+	spin_lock(&card->lock);
 	if (card->Active < 0)
 		goto out_unlock;
 	page = &card->mm_pages[card->Active];
@@ -496,7 +496,7 @@ static void process_page(unsigned long data)
 		mm_start_io(card);
 	}
  out_unlock:
-	spin_unlock_bh(&card->lock);
+	spin_unlock(&card->lock);
 
 	while (return_bio) {
 		struct bio *bio = return_bio;
-- 
2.17.1
