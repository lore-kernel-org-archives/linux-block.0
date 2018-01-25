Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:52904 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752173AbeA3Bpm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jan 2018 20:45:42 -0500
Message-Id: <87o9lcp1aq.fsf@debian.i-did-not-set--mail-host-address--so-tickle-me>
Subject: [PATCH] Use bio_endio instead of bio_put in error path of
 blk_rq_append_bio
To: linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@infradead.org>
In-Reply-To: <20171218074044.1369-3-ming.lei@redhat.com>
References: <20171218074044.1369-3-ming.lei@redhat.com>
From: =?iso8859-2?q?Ji=F8=ED=20Pale=E8ek?= <jpalecek@web.de>
Date: Thu, 25 Jan 2018 14:58:36 +0100
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

 Avoids page leak from bounced requests
---
 block/blk-map.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index d3a94719f03f..702d68166689 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -26,7 +26,8 @@ int blk_rq_append_bio(struct request *rq, struct bio **bio)
 	} else {
 		if (!ll_back_merge_fn(rq->q, rq, *bio)) {
 			if (orig_bio != *bio) {
-				bio_put(*bio);
+				bio_inc_remaining(orig_bio);
+				bio_endio(*bio);
 				*bio = orig_bio;
 			}
 			return -EINVAL;
-- 
2.15.1
