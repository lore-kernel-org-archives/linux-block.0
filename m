Return-Path: <BATV+94b2d661b7de03f6cf2e+5413+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>,
	Boaz Harrosh <ooo@electrozaur.com>,
	linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	dm-devel@redhat.com
Subject: [PATCH 3/6] exofs: use bio_clone_fast in _write_mirror
Date: Tue, 19 Jun 2018 06:52:13 +0200
Message-Id: <20180619045216.21130-4-hch@lst.de>
In-Reply-To: <20180619045216.21130-1-hch@lst.de>
References: <20180619045216.21130-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

The mirroring code never changes the bio data or biovecs.  This means
we can reuse the biovec allocation easily instead of duplicating it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/exofs/ore.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/exofs/ore.c b/fs/exofs/ore.c
index 1b8b44637e70..5331a15a61f1 100644
--- a/fs/exofs/ore.c
+++ b/fs/exofs/ore.c
@@ -873,8 +873,8 @@ static int _write_mirror(struct ore_io_state *ios, int cur_comp)
 			struct bio *bio;
 
 			if (per_dev != master_dev) {
-				bio = bio_clone_kmalloc(master_dev->bio,
-							GFP_KERNEL);
+				bio = bio_clone_fast(master_dev->bio,
+						     GFP_KERNEL, NULL);
 				if (unlikely(!bio)) {
 					ORE_DBGMSG(
 					      "Failed to allocate BIO size=%u\n",
-- 
2.17.1
