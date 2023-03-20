Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABC9C6FD1C
	for <linux-block@archiver.kernel.org>; Mon, 20 Mar 2023 23:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjCTXvK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Mar 2023 19:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjCTXvG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Mar 2023 19:51:06 -0400
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151A531E00
        for <linux-block@vger.kernel.org>; Mon, 20 Mar 2023 16:50:32 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id s8so7868327pfk.5
        for <linux-block@vger.kernel.org>; Mon, 20 Mar 2023 16:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679356173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YhxQB1ck5AzwQak0OgHEiUUpT5lV2AE4SHuGYT8zNGY=;
        b=TTg2oHE/NFdVFDE62LmqoGTOaFwoqc8xtD4QX7C/nFBZj+AMG15gX20K1qPDpIvb05
         y3Z+QvmSq+CjOpqijrtzAv6KIEWPEUnh7rkfDRILLlnN1FL9fjgu2UUpFObKg6vy5DnD
         L+qvi7h6+xkAL/CzD4tMtzXW0I76nzyK/Tg4XVYahApewSydbUD/i5+pKSKIri9p/Jld
         a/zjruzWuMuBuLy2OvnPQWDKqlQeBW+jz8hF6pUayC/FmwF/NyyYAIRNLtu7SjYVMH/u
         o40FvOGEkRpetKf2OuO6lXa0PJGGwpu8hNGrwn1EkSyCmo/yvKFLH++egA9bnS9Mk76d
         QAbA==
X-Gm-Message-State: AO0yUKV6K7w7GSdcXlquDzY1C5az2YXQ6Q8YqlCaM6lvpEyh5QlKzN8G
        QDrP7AWp4hq47S4N81+wUKo=
X-Google-Smtp-Source: AK7set/JsoMQoi00fzY3PKfPmi0clTN+HVGW3WsgqSJBpiIHS4yr/Z2P5CDuuR3J0eDOd657kWMdFg==
X-Received: by 2002:aa7:96f9:0:b0:626:a9b:94b8 with SMTP id i25-20020aa796f9000000b006260a9b94b8mr461526pfq.20.1679356173107;
        Mon, 20 Mar 2023 16:49:33 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ad26:bef0:6406:d659])
        by smtp.gmail.com with ESMTPSA id j23-20020aa78dd7000000b0058bf2ae9694sm6915907pfr.156.2023.03.20.16.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 16:49:32 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 1/3] block: Split blk_recalc_rq_segments()
Date:   Mon, 20 Mar 2023 16:49:03 -0700
Message-Id: <20230320234905.3832131-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230320234905.3832131-1-bvanassche@acm.org>
References: <20230320234905.3832131-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Prepare for adding an additional call to bio_chain_nr_segments().

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-merge.c | 26 ++++++++++++++++----------
 block/blk.h       |  2 ++
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 65e75efa9bd3..d6f8552ef209 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -409,22 +409,22 @@ struct bio *bio_split_to_limits(struct bio *bio)
 }
 EXPORT_SYMBOL(bio_split_to_limits);
 
-unsigned int blk_recalc_rq_segments(struct request *rq)
+/* Calculate the number of DMA segments in a bio chain. */
+unsigned int bio_chain_nr_segments(struct bio *bio,
+				   const struct queue_limits *lim)
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
@@ -436,12 +436,18 @@ unsigned int blk_recalc_rq_segments(struct request *rq)
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
+	return bio_chain_nr_segments(rq->bio, &rq->q->limits);
+}
+
 static inline struct scatterlist *blk_next_sg(struct scatterlist **sg,
 		struct scatterlist *sglist)
 {
diff --git a/block/blk.h b/block/blk.h
index d65d96994a94..ea15b1a4c2b7 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -330,6 +330,8 @@ int ll_back_merge_fn(struct request *req, struct bio *bio,
 		unsigned int nr_segs);
 bool blk_attempt_req_merge(struct request_queue *q, struct request *rq,
 				struct request *next);
+unsigned int bio_chain_nr_segments(struct bio *bio,
+				   const struct queue_limits *lim);
 unsigned int blk_recalc_rq_segments(struct request *rq);
 void blk_rq_set_mixed_merge(struct request *rq);
 bool blk_rq_merge_ok(struct request *rq, struct bio *bio);
