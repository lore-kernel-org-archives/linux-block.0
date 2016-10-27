Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:46103 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933375AbcJ0HEt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Oct 2016 03:04:49 -0400
From: Christoph Hellwig <hch@lst.de>
To: petero2@telia.com, axboe@fb.com
Cc: linux-block@vger.kernel.org
Subject: [RFC, PATCH] pktcdvd: don't scribble over the bvec array
Date: Thu, 27 Oct 2016 09:04:44 +0200
Message-Id: <1477551884-25062-1-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Peter, hi Jens,

I've been looking over the multi page bio vec work again recently, and
one of the stumbling blocks is raw biovec access in the pktcdvd.

The first issue is that it directly sets up the page and offset pointers
in the biovec just before calling bio_add_page.  As bio_add_page already
does the setup it's trivial to just switch it to stack variables for the
arguments.

The second issue is the copy code in pkt_make_local_copy, which
effectively is an opencoded version of bio_copy_data except that it
skips pages that already are the same in the ѕource and destination.
But we look at the only calleer we just set up the bio using bio_add_page
to point exactly to the page array that pkt_make_local_copy compares,
so the pages will always be the same and we can just remove this function.

Note that all this is done based on code inspection, I don't have any
packet writing hardware myself.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/pktcdvd.c | 47 ++++++-----------------------------------------
 1 file changed, 6 insertions(+), 41 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 7cf795e..95c98de 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -944,39 +944,6 @@ static int pkt_set_segment_merging(struct pktcdvd_device *pd, struct request_que
 	}
 }
 
-/*
- * Copy all data for this packet to pkt->pages[], so that
- * a) The number of required segments for the write bio is minimized, which
- *    is necessary for some scsi controllers.
- * b) The data can be used as cache to avoid read requests if we receive a
- *    new write request for the same zone.
- */
-static void pkt_make_local_copy(struct packet_data *pkt, struct bio_vec *bvec)
-{
-	int f, p, offs;
-
-	/* Copy all data to pkt->pages[] */
-	p = 0;
-	offs = 0;
-	for (f = 0; f < pkt->frames; f++) {
-		if (bvec[f].bv_page != pkt->pages[p]) {
-			void *vfrom = kmap_atomic(bvec[f].bv_page) + bvec[f].bv_offset;
-			void *vto = page_address(pkt->pages[p]) + offs;
-			memcpy(vto, vfrom, CD_FRAMESIZE);
-			kunmap_atomic(vfrom);
-			bvec[f].bv_page = pkt->pages[p];
-			bvec[f].bv_offset = offs;
-		} else {
-			BUG_ON(bvec[f].bv_offset != offs);
-		}
-		offs += CD_FRAMESIZE;
-		if (offs >= PAGE_SIZE) {
-			offs = 0;
-			p++;
-		}
-	}
-}
-
 static void pkt_end_io_read(struct bio *bio)
 {
 	struct packet_data *pkt = bio->bi_private;
@@ -1298,7 +1265,6 @@ static int pkt_handle_queue(struct pktcdvd_device *pd)
 static void pkt_start_write(struct pktcdvd_device *pd, struct packet_data *pkt)
 {
 	int f;
-	struct bio_vec *bvec = pkt->w_bio->bi_io_vec;
 
 	bio_reset(pkt->w_bio);
 	pkt->w_bio->bi_iter.bi_sector = pkt->sector;
@@ -1308,9 +1274,10 @@ static void pkt_start_write(struct pktcdvd_device *pd, struct packet_data *pkt)
 
 	/* XXX: locking? */
 	for (f = 0; f < pkt->frames; f++) {
-		bvec[f].bv_page = pkt->pages[(f * CD_FRAMESIZE) / PAGE_SIZE];
-		bvec[f].bv_offset = (f * CD_FRAMESIZE) % PAGE_SIZE;
-		if (!bio_add_page(pkt->w_bio, bvec[f].bv_page, CD_FRAMESIZE, bvec[f].bv_offset))
+		struct page *page = pkt->pages[(f * CD_FRAMESIZE) / PAGE_SIZE];
+		unsigned offset = (f * CD_FRAMESIZE) % PAGE_SIZE;
+
+		if (!bio_add_page(pkt->w_bio, page, CD_FRAMESIZE, offset))
 			BUG();
 	}
 	pkt_dbg(2, pd, "vcnt=%d\n", pkt->w_bio->bi_vcnt);
@@ -1327,12 +1294,10 @@ static void pkt_start_write(struct pktcdvd_device *pd, struct packet_data *pkt)
 	pkt_dbg(2, pd, "Writing %d frames for zone %llx\n",
 		pkt->write_size, (unsigned long long)pkt->sector);
 
-	if (test_bit(PACKET_MERGE_SEGS, &pd->flags) || (pkt->write_size < pkt->frames)) {
-		pkt_make_local_copy(pkt, bvec);
+	if (test_bit(PACKET_MERGE_SEGS, &pd->flags) || (pkt->write_size < pkt->frames))
 		pkt->cache_valid = 1;
-	} else {
+	else
 		pkt->cache_valid = 0;
-	}
 
 	/* Start the write request */
 	atomic_set(&pkt->io_wait, 1);
-- 
2.1.4

