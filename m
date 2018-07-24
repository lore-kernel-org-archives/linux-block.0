Return-Path: <BATV+c9ebeb9e9cafa2a765ab+5448+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Boaz Harrosh <ooo@electrozaur.com>,
	linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	dm-devel@redhat.com
Subject: [PATCH 4/5] md: remove a bogus comment
Date: Tue, 24 Jul 2018 09:52:33 +0200
Message-Id: <20180724075234.26861-5-hch@lst.de>
In-Reply-To: <20180724075234.26861-1-hch@lst.de>
References: <20180724075234.26861-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

The function name mentioned doesn't exist, and the code next to it
doesn't match the description either.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/md/md.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index f6e58dbca0d4..cb4eb5faa519 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -204,10 +204,6 @@ static int start_readonly;
  */
 static bool create_on_open = true;
 
-/* bio_clone_mddev
- * like bio_clone_bioset, but with a local bio set
- */
-
 struct bio *bio_alloc_mddev(gfp_t gfp_mask, int nr_iovecs,
 			    struct mddev *mddev)
 {
-- 
2.18.0
