Return-Path: <BATV+eb4e61afd325b22435ea+5099+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: mpatocka@redhat.com,
	gmazyland@gmail.com,
	martin.petersen@oracle.com,
	linux-block@vger.kernel.org,
	dm-devel@redhat.com
Subject: [PATCH 1/2] bio-integrity: move the bio integrity profile check earlier in bio_integrity_prep
Date: Wed,  9 Aug 2017 17:48:08 +0200
Message-Id: <20170809154809.2168-2-hch@lst.de>
In-Reply-To: <20170809154809.2168-1-hch@lst.de>
References: <20170809154809.2168-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

This makes the code more obvious, and moves the most likely branch first
in the function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 9b1ea478577b..fafd19c540b0 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -246,6 +246,9 @@ bool bio_integrity_prep(struct bio *bio)
 	blk_status_t status;
 
 	bi = bdev_get_integrity(bio->bi_bdev);
+	if (!bi)
+		return true;
+
 	q = bdev_get_queue(bio->bi_bdev);
 	if (bio_op(bio) != REQ_OP_READ && bio_op(bio) != REQ_OP_WRITE)
 		return true;
@@ -257,9 +260,6 @@ bool bio_integrity_prep(struct bio *bio)
 	if (bio_integrity(bio))
 		return true;
 
-	if (bi == NULL)
-		return true;
-
 	if (bio_data_dir(bio) == READ) {
 		if (!bi->profile->verify_fn ||
 		    !(bi->flags & BLK_INTEGRITY_VERIFY))
-- 
2.11.0
