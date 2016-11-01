Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:50182 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1169193AbcKANkW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2016 09:40:22 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/16] cfq-iosched: use op_is_sync instead of opencoding it
Date: Tue,  1 Nov 2016 07:40:02 -0600
Message-Id: <1478007617-18715-2-git-send-email-hch@lst.de>
In-Reply-To: <1478007617-18715-1-git-send-email-hch@lst.de>
References: <1478007617-18715-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/cfq-iosched.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index c96186a..f28db97 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -912,15 +912,6 @@ static inline struct cfq_data *cic_to_cfqd(struct cfq_io_cq *cic)
 }
 
 /*
- * We regard a request as SYNC, if it's either a read or has the SYNC bit
- * set (in which case it could also be direct WRITE).
- */
-static inline bool cfq_bio_sync(struct bio *bio)
-{
-	return bio_data_dir(bio) == READ || (bio->bi_opf & REQ_SYNC);
-}
-
-/*
  * scheduler run of queue, if there are requests pending and no one in the
  * driver that will restart queueing
  */
@@ -2490,7 +2481,7 @@ cfq_find_rq_fmerge(struct cfq_data *cfqd, struct bio *bio)
 	if (!cic)
 		return NULL;
 
-	cfqq = cic_to_cfqq(cic, cfq_bio_sync(bio));
+	cfqq = cic_to_cfqq(cic, op_is_sync(bio->bi_opf));
 	if (cfqq)
 		return elv_rb_find(&cfqq->sort_list, bio_end_sector(bio));
 
@@ -2604,13 +2595,14 @@ static int cfq_allow_bio_merge(struct request_queue *q, struct request *rq,
 			       struct bio *bio)
 {
 	struct cfq_data *cfqd = q->elevator->elevator_data;
+	bool is_sync = op_is_sync(bio->bi_opf);
 	struct cfq_io_cq *cic;
 	struct cfq_queue *cfqq;
 
 	/*
 	 * Disallow merge of a sync bio into an async request.
 	 */
-	if (cfq_bio_sync(bio) && !rq_is_sync(rq))
+	if (is_sync && !rq_is_sync(rq))
 		return false;
 
 	/*
@@ -2621,7 +2613,7 @@ static int cfq_allow_bio_merge(struct request_queue *q, struct request *rq,
 	if (!cic)
 		return false;
 
-	cfqq = cic_to_cfqq(cic, cfq_bio_sync(bio));
+	cfqq = cic_to_cfqq(cic, is_sync);
 	return cfqq == RQ_CFQQ(rq);
 }
 
-- 
2.1.4

