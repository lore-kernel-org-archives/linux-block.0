Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7061EC7618B
	for <linux-block@archiver.kernel.org>; Fri, 17 Mar 2023 20:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjCQUAI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Mar 2023 16:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjCQT7v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2023 15:59:51 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F95BB5FF7
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 12:59:50 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id i5so6472242pla.2
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 12:59:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679083190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i47uOO6/+y8p+DtYwfV6zCJst449LdtNzp1tXqbitP4=;
        b=L6EnEqIcSsOuGiiynpuYUCFNZGJjdgeQHb5qH6i+UgkCo13z0AJWVvKzXde16eijJ+
         +r05JkhbU3MWPlMNAePzB4tCw0562uUfd29BUpYsFIyr4BNtJwZk9VfFsIIlVuVvBwIS
         oOz/Zarr5eD5fY7A1xNdVbcxPLL1FS3s5i1+XCDCnLwtahVjj0taRuxyIcDcGvIF1Xbn
         +m8cOeX94XrSJxKcXHS1YIvDO6Wdl+9VyHJTiSZ3NwjLiN68+mF8XZ51aSGUh5AI7hm9
         R6K5xe8piN23zc8oGJVQaLsUim5SL+q068LG2Ey/Q8TcHMA7IBzDO2+7SOF+oobMLZ6R
         weyQ==
X-Gm-Message-State: AO0yUKVUT868MnqI9kv5uAooXms353a3vpco6CN0TJosbQXKt6KQM1Uz
        /Q0Rku0LlFy9bLOr6aBSD30=
X-Google-Smtp-Source: AK7set/Mg1H9cs7YRzZs8/D8zV4d27gDZByMbjLQ/395mG8X8H5G4r+2fz/pflxWpmK2f/Kh/OK9kw==
X-Received: by 2002:a17:902:db0f:b0:1a1:8edc:c5f8 with SMTP id m15-20020a170902db0f00b001a18edcc5f8mr9714449plx.56.1679083189852;
        Fri, 17 Mar 2023 12:59:49 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ad26:bef0:6406:d659])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902eec600b0019cb131b89csm1051917plb.254.2023.03.17.12.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 12:59:49 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 1/2] block: Split blk_recalc_rq_segments()
Date:   Fri, 17 Mar 2023 12:59:37 -0700
Message-Id: <20230317195938.1745318-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230317195938.1745318-1-bvanassche@acm.org>
References: <20230317195938.1745318-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Prepare for adding a direct call to bio_nr_segments().

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-merge.c | 24 ++++++++++++++----------
 block/blk.h       |  1 +
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index b80c3e650588..2e07f6bd96be 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -408,22 +408,20 @@ struct bio *bio_split_to_limits(struct bio *bio)
 }
 EXPORT_SYMBOL(bio_split_to_limits);
 
-unsigned int blk_recalc_rq_segments(struct request *rq)
+unsigned int bio_nr_segments(const struct queue_limits *lim, struct bio *bio)
 {
 	unsigned int nr_phys_segs = 0;
 	unsigned int bytes = 0;
-	struct req_iterator iter;
+	struct bvec_iter iter;
 	struct bio_vec bv;
 
-	if (!rq->bio)
+	if (!bio)
 		return 0;
 
-	switch (bio_op(rq->bio)) {
+	switch (bio_op(bio)) {
 	case REQ_OP_DISCARD:
 	case REQ_OP_SECURE_ERASE:
-		if (queue_max_discard_segments(rq->q) > 1) {
-			struct bio *bio = rq->bio;
-
+		if (lim->max_discard_segments > 1) {
 			for_each_bio(bio)
 				nr_phys_segs++;
 			return nr_phys_segs;
@@ -435,12 +433,18 @@ unsigned int blk_recalc_rq_segments(struct request *rq)
 		break;
 	}
 
-	rq_for_each_bvec(bv, rq, iter)
-		bvec_split_segs(&rq->q->limits, &bv, &nr_phys_segs, &bytes,
-				UINT_MAX, UINT_MAX);
+	for_each_bio(bio)
+		bio_for_each_bvec(bv, bio, iter)
+			bvec_split_segs(lim, &bv, &nr_phys_segs, &bytes,
+					UINT_MAX, UINT_MAX);
 	return nr_phys_segs;
 }
 
+unsigned int blk_recalc_rq_segments(struct request *rq)
+{
+	return bio_nr_segments(&rq->q->limits, rq->bio);
+}
+
 static inline struct scatterlist *blk_next_sg(struct scatterlist **sg,
 		struct scatterlist *sglist)
 {
diff --git a/block/blk.h b/block/blk.h
index d65d96994a94..9686ee808bab 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -330,6 +330,7 @@ int ll_back_merge_fn(struct request *req, struct bio *bio,
 		unsigned int nr_segs);
 bool blk_attempt_req_merge(struct request_queue *q, struct request *rq,
 				struct request *next);
+unsigned int bio_nr_segments(const struct queue_limits *lim, struct bio *bio);
 unsigned int blk_recalc_rq_segments(struct request *rq);
 void blk_rq_set_mixed_merge(struct request *rq);
 bool blk_rq_merge_ok(struct request *rq, struct bio *bio);
