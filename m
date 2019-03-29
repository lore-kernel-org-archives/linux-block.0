Return-Path: <SRS0=pPwc=SA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE50C43381
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 07:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4002173C
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 07:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbfC2HJG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 03:09:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33392 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728651AbfC2HJF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 03:09:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9CD71D7921;
        Fri, 29 Mar 2019 07:09:05 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94C1F6FEF3;
        Fri, 29 Mar 2019 07:09:02 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH V3 09/10] block: reuse __blk_bvec_map_sg() for mapping page sized bvec
Date:   Fri, 29 Mar 2019 15:08:02 +0800
Message-Id: <20190329070803.10958-10-ming.lei@redhat.com>
In-Reply-To: <20190329070803.10958-1-ming.lei@redhat.com>
References: <20190329070803.10958-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 29 Mar 2019 07:09:05 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Inside __blk_segment_map_sg(), page sized bvec mapping is optimized
a bit with one standalone branch.

So reuse __blk_bvec_map_sg() to do that.

Cc: Omar Sandoval <osandov@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-merge.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 9ec704bb58ec..3e934ee9a907 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -493,6 +493,14 @@ static unsigned blk_bvec_map_sg(struct request_queue *q,
 	return nsegs;
 }
 
+static inline int __blk_bvec_map_sg(struct bio_vec bv,
+		struct scatterlist *sglist, struct scatterlist **sg)
+{
+	*sg = blk_next_sg(sg, sglist);
+	sg_set_page(*sg, bv.bv_page, bv.bv_len, bv.bv_offset);
+	return 1;
+}
+
 static inline void
 __blk_segment_map_sg(struct request_queue *q, struct bio_vec *bvec,
 		     struct scatterlist *sglist, struct bio_vec *bvprv,
@@ -511,23 +519,13 @@ __blk_segment_map_sg(struct request_queue *q, struct bio_vec *bvec,
 	} else {
 new_segment:
 		if (bvec->bv_offset + bvec->bv_len <= PAGE_SIZE) {
-			*sg = blk_next_sg(sg, sglist);
-			sg_set_page(*sg, bvec->bv_page, nbytes, bvec->bv_offset);
-			(*nsegs) += 1;
+			(*nsegs) += __blk_bvec_map_sg(*bvec, sglist, sg);
 		} else
 			(*nsegs) += blk_bvec_map_sg(q, bvec, sglist, sg);
 	}
 	*bvprv = *bvec;
 }
 
-static inline int __blk_bvec_map_sg(struct bio_vec bv,
-		struct scatterlist *sglist, struct scatterlist **sg)
-{
-	*sg = sglist;
-	sg_set_page(*sg, bv.bv_page, bv.bv_len, bv.bv_offset);
-	return 1;
-}
-
 static int __blk_bios_map_sg(struct request_queue *q, struct bio *bio,
 			     struct scatterlist *sglist,
 			     struct scatterlist **sg)
-- 
2.9.5

