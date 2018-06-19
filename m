Return-Path: <BATV+94b2d661b7de03f6cf2e+5413+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>,
	Boaz Harrosh <ooo@electrozaur.com>,
	linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	dm-devel@redhat.com
Subject: [PATCH 5/6] md: remove a bogus comment
Date: Tue, 19 Jun 2018 06:52:15 +0200
Message-Id: <20180619045216.21130-6-hch@lst.de>
In-Reply-To: <20180619045216.21130-1-hch@lst.de>
References: <20180619045216.21130-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

The function name mentioned doesn't exist, and the code next to it
doesn't match the description either.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/md.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 29b0cd9ec951..81f458514ac0 100644
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
2.17.1
