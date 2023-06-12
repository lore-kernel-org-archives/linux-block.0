Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF689C7EE43
	for <linux-block@archiver.kernel.org>; Mon, 12 Jun 2023 20:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236160AbjFLUda (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Jun 2023 16:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236594AbjFLUd2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jun 2023 16:33:28 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA7C10CE
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 13:33:27 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1b3a9eae57cso15992885ad.1
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 13:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686602007; x=1689194007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D76EF1PRUG4k1Tw0AWeqUDGcfk53v67F7APUOd5gLok=;
        b=D1eDFKnJvuKEhCmvLysekJuRq4ReyBb52w6apBOtRbBEopofhO5/PKLZZnkCFEzM1m
         7E+YAFMTHMjLqdHLIvAY0mdTkllcCUT8X8n6JlDLVJ5LamZkow4jBymxguBXkaMv3oRu
         SSit/fN9Otxz2vxdrttcdOfHGC2l3KnwViaNIUqV/r3iU9WIBTC728l19QwW0leUePkS
         xzOcW8ssdIAm+8XXYJT3JtkEyed2TAZuf70QFb4y2naGNDXnfgE82EgpB8db1KRFkAFV
         uWj8bRk+0+QXKbChAjZVudkPfeViRBHi/4upxmBnC85zUwPXe/s/OMZimd0K5gpJ0n3B
         COPg==
X-Gm-Message-State: AC+VfDwDIcZyQlaEDCF3Wo4c9zenOQBJUGEUFSKuGAdF+ZPQTW3LOGy8
        KyD54O9T1ocBEGfj+GCu+bk=
X-Google-Smtp-Source: ACHHUZ6+ywaGcwwhW/1e0+gJeV6PNofySNqKstbEfzqwcpLZqBmm/9miafUPnKio/eEZhl7jtElv7w==
X-Received: by 2002:a17:902:d487:b0:1b2:22cd:9827 with SMTP id c7-20020a170902d48700b001b222cd9827mr9630245plg.1.1686602006638;
        Mon, 12 Jun 2023 13:33:26 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id ji1-20020a170903324100b001b016313b1dsm3324767plb.86.2023.06.12.13.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 13:33:25 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sandeep Dhavale <dhavale@google.com>,
        Juan Yescas <jyescas@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v6 6/8] block: Add support for filesystem requests and small segments
Date:   Mon, 12 Jun 2023 13:33:12 -0700
Message-Id: <20230612203314.17820-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612203314.17820-1-bvanassche@acm.org>
References: <20230612203314.17820-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add support in the bio splitting code and also in the bio submission code
for bios with segments smaller than the page size.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Tested-by: Sandeep Dhavale <dhavale@google.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-merge.c |  8 ++++++--
 block/blk-mq.c    |  2 ++
 block/blk.h       | 11 +++++------
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 65e75efa9bd3..0b28f6df07bc 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -294,7 +294,8 @@ struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim,
 		if (nsegs < lim->max_segments &&
 		    bytes + bv.bv_len <= max_bytes &&
 		    bv.bv_offset + bv.bv_len <= PAGE_SIZE) {
-			nsegs++;
+			/* single-page bvec optimization */
+			nsegs += blk_segments(lim, bv.bv_len);
 			bytes += bv.bv_len;
 		} else {
 			if (bvec_split_segs(lim, &bv, &nsegs, &bytes,
@@ -544,7 +545,10 @@ static int __blk_bios_map_sg(struct request_queue *q, struct bio *bio,
 			    __blk_segment_map_sg_merge(q, &bvec, &bvprv, sg))
 				goto next_bvec;
 
-			if (bvec.bv_offset + bvec.bv_len <= PAGE_SIZE)
+			if (bvec.bv_offset + bvec.bv_len <= PAGE_SIZE &&
+			    (!blk_queue_sub_page_limits(&q->limits) ||
+			     bvec.bv_len <= q->limits.max_segment_size))
+				/* single-segment bvec optimization */
 				nsegs += __blk_bvec_map_sg(bvec, sglist, sg);
 			else
 				nsegs += blk_bvec_map_sg(q, &bvec, sglist, sg);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1749f5890606..ad787c14ea09 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2936,6 +2936,8 @@ void blk_mq_submit_bio(struct bio *bio)
 		bio = __bio_split_to_limits(bio, &q->limits, &nr_segs);
 		if (!bio)
 			return;
+	} else if (bio->bi_vcnt == 1) {
+		nr_segs = blk_segments(&q->limits, bio->bi_io_vec[0].bv_len);
 	}
 
 	if (!bio_integrity_prep(bio))
diff --git a/block/blk.h b/block/blk.h
index 18b898a38c72..e905cc6364fa 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -332,13 +332,12 @@ static inline bool bio_may_exceed_limits(struct bio *bio,
 	}
 
 	/*
-	 * All drivers must accept single-segments bios that are <= PAGE_SIZE.
-	 * This is a quick and dirty check that relies on the fact that
-	 * bi_io_vec[0] is always valid if a bio has data.  The check might
-	 * lead to occasional false negatives when bios are cloned, but compared
-	 * to the performance impact of cloned bios themselves the loop below
-	 * doesn't matter anyway.
+	 * Check whether bio splitting should be performed. This check may
+	 * trigger the bio splitting code even if splitting is not necessary.
 	 */
+	if (blk_queue_sub_page_limits(lim) && bio->bi_io_vec &&
+	    bio->bi_io_vec->bv_len > lim->max_segment_size)
+		return true;
 	return lim->chunk_sectors || bio->bi_vcnt != 1 ||
 		bio->bi_io_vec->bv_len + bio->bi_io_vec->bv_offset > PAGE_SIZE;
 }
