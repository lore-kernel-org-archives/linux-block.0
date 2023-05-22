Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F6FC7EE2E
	for <linux-block@archiver.kernel.org>; Mon, 22 May 2023 22:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbjEVW0P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 May 2023 18:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbjEVW0J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 May 2023 18:26:09 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6CA100
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 15:26:08 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ae6dce19f7so36343025ad.3
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 15:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684794368; x=1687386368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzt6cEybsd85d3muZOk+H+NKaJMGnQPvDUQ8Hxa2MpQ=;
        b=B/DezATaZkQTmiP0jJo9lVA7tJaZjP/E6+ADDXpCOd6XYIwq3/Q3V9hZAz2kHW2PEI
         I4A5voceMlb9qZLBGmPUpSSpD91jiadsDRbIKy/70yoCErcEVbQStYrrwoP0UWvOvjs4
         UzwHJ6isYx3ALDzt8MGibsQPPJfd42HtKoIFTNe7aYClzpR+M1RMQTev6V3d0KUgXpYP
         1frvrhirrvaCkCZQ1QChxU7mPq8qyWINOxZjZd4SyAa/NvixgOxpj17YQlYsBhm+ZuP6
         MW5cTgcL2qeVTBqIWNjNWOPgEg8vykGFoLZfq+gGIL+5g581qWi78hGICtL5Fvm172FS
         0jpQ==
X-Gm-Message-State: AC+VfDyfMQU1+dhe7zYrNWEp4BCiakoG3KpUuY9/4JOEBLMV4+P+9Csp
        bWzMFs0mT6GTVAstk/lK/JAw+SpCnD0=
X-Google-Smtp-Source: ACHHUZ5OWwMvmjehMPasFW6ZG6i3lr475Y3Yiolg2B0iquI6qlHlaI/SpCEDnp90mjzyE41a65eAzw==
X-Received: by 2002:a17:903:1c5:b0:1ae:8a22:d0dd with SMTP id e5-20020a17090301c500b001ae8a22d0ddmr10470081plh.58.1684794367843;
        Mon, 22 May 2023 15:26:07 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:642f:e57f:85fb:3794])
        by smtp.gmail.com with ESMTPSA id y8-20020a634b08000000b00520f4ecd71esm4725364pga.93.2023.05.22.15.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 15:26:07 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        jyescas@google.com, mcgrof@kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v5 6/9] block: Add support for filesystem requests and small segments
Date:   Mon, 22 May 2023 15:25:38 -0700
Message-ID: <20230522222554.525229-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230522222554.525229-1-bvanassche@acm.org>
References: <20230522222554.525229-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add support in the bio splitting code and also in the bio submission code
for bios with segments smaller than the page size.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
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
index 551e7760f45e..3a2dd49b8186 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2932,6 +2932,8 @@ void blk_mq_submit_bio(struct bio *bio)
 		bio = __bio_split_to_limits(bio, &q->limits, &nr_segs);
 		if (!bio)
 			return;
+	} else if (bio->bi_vcnt == 1) {
+		nr_segs = blk_segments(&q->limits, bio->bi_io_vec[0].bv_len);
 	}
 
 	if (!bio_integrity_prep(bio))
diff --git a/block/blk.h b/block/blk.h
index dfeebbb55a42..6e5f86ed3cbc 100644
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
