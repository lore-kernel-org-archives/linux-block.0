Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B06C433FE
	for <linux-block@archiver.kernel.org>; Wed, 19 Oct 2022 22:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiJSWXs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Oct 2022 18:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiJSWXq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Oct 2022 18:23:46 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D4D176B9A
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 15:23:45 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so1499501pjq.3
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 15:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jSY95nno9cQBjlFCvz9y79nBwCAPjE+pkBLEhf1tCY=;
        b=iFHtBF87zx47wd7/nWyfNu5SoOjfIu4lBVWHKRuVrxAgFJfk9fbuA/v0slvRRq0O/p
         koEsZECi9c4oJZYrUN8LegWlhh6QmkQK1UWlC3ZR6YqKJdrrFW7yr6Dsouv8jzAtLLhi
         sqZFO5AAsf7end3w7vZkW3huahH89mRAhUFDsqvXfdiMWQzobnM4yF9PmScvnoMAtula
         BdWYm2A7BfU/q9GOJ81LOfL3cq0qnEylKKYIEnxALUrTnPMgHuwWrQdN+R+LuUL4OqqZ
         kubN4FuwZAyY8DyyhIjNu45I7unRrvMTiaAInAtONyrHmh6FBLXjyuNcFytrDfB0uVsd
         EEVg==
X-Gm-Message-State: ACrzQf0a7CaVYftWHGnGWsQBJ9Dc6KXuHF9N3Bt/C5qIuaDWzCd/Cxdh
        1hbZi5Lr+gvi7GCk0FDKUR8=
X-Google-Smtp-Source: AMsMyM4hdcg8+km2UciIySKPCiN5HqPp7nxVY+ZueOrvjxjpoAGLvfBOwK0y4dP65g1u1AN/6FNm3A==
X-Received: by 2002:a17:902:cf42:b0:184:5b9a:24f1 with SMTP id e2-20020a170902cf4200b001845b9a24f1mr10847607plg.73.1666218225431;
        Wed, 19 Oct 2022 15:23:45 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:8280:2606:af57:d34])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902d50300b00174d9bbeda4sm11486866plg.197.2022.10.19.15.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 15:23:44 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 06/10] block: Fix the number of segment calculations
Date:   Wed, 19 Oct 2022 15:23:20 -0700
Message-Id: <20221019222324.362705-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221019222324.362705-1-bvanassche@acm.org>
References: <20221019222324.362705-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since multi-page bvecs are supported there can be multiple segments per
bvec (see also bvec_split_segs()). Hence this patch that calculates the
number of segments per bvec instead of assuming that there is only one
segment per bvec.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-map.c | 14 +++++++++++++-
 block/blk-mq.c  |  2 ++
 block/blk.h     |  3 +++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 4505307d758e..2976a8d68992 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -529,6 +529,18 @@ static struct bio *bio_copy_kern(struct request_queue *q, void *data,
 	return ERR_PTR(-ENOMEM);
 }
 
+/* Number of DMA segments required to transfer @bytes data. */
+unsigned int blk_segments(const struct queue_limits *limits, unsigned int bytes)
+{
+	const unsigned int mss = limits->max_segment_size;
+
+	if (bytes <= mss)
+		return 1;
+	if (is_power_of_2(mss))
+		return round_up(bytes, mss) >> ilog2(mss);
+	return (bytes + mss - 1) / mss;
+}
+
 /*
  * Append a bio to a passthrough request.  Only works if the bio can be merged
  * into the request based on the driver constraints.
@@ -540,7 +552,7 @@ int blk_rq_append_bio(struct request *rq, struct bio *bio)
 	unsigned int nr_segs = 0;
 
 	bio_for_each_bvec(bv, bio, iter)
-		nr_segs++;
+		nr_segs += blk_segments(&rq->q->limits, bv.bv_len);
 
 	if (!rq->bio) {
 		blk_rq_bio_prep(rq, bio, nr_segs);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8070b6c10e8d..82ae8099afdd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2883,6 +2883,8 @@ void blk_mq_submit_bio(struct bio *bio)
 	bio = blk_queue_bounce(bio, q);
 	if (bio_may_exceed_limits(bio, &q->limits))
 		bio = __bio_split_to_limits(bio, &q->limits, &nr_segs);
+	else if (bio->bi_vcnt == 1)
+		nr_segs = blk_segments(&q->limits, bio->bi_io_vec[0].bv_len);
 
 	if (!bio_integrity_prep(bio))
 		return;
diff --git a/block/blk.h b/block/blk.h
index 7f9e089ab1f7..342ba7d86e87 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -81,6 +81,9 @@ struct bio_vec *bvec_alloc(mempool_t *pool, unsigned short *nr_vecs,
 		gfp_t gfp_mask);
 void bvec_free(mempool_t *pool, struct bio_vec *bv, unsigned short nr_vecs);
 
+unsigned int blk_segments(const struct queue_limits *limits,
+			  unsigned int bytes);
+
 static inline bool biovec_phys_mergeable(struct request_queue *q,
 		struct bio_vec *vec1, struct bio_vec *vec2)
 {
