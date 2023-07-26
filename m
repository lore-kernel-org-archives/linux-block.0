Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCD0EB64DD
	for <linux-block@archiver.kernel.org>; Wed, 26 Jul 2023 00:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjGZA5v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jul 2023 20:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjGZA5u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jul 2023 20:57:50 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AF9BC
        for <linux-block@vger.kernel.org>; Tue, 25 Jul 2023 17:57:49 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6bc481fe23eso998683a34.0
        for <linux-block@vger.kernel.org>; Tue, 25 Jul 2023 17:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690333069; x=1690937869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGeYdvHkIe+/g6ccJ3EraC4iHJ4sXYdBakvs/IB1EFw=;
        b=HLk0UH0//8wK5ITtfjGCxmRKT5UJM1KAtLSbgeBGgJDBOT3gMQUBhxCMxfBUbmfjoJ
         VrpuSX5yCf+iX4XG021NTN0qRZSvF2/AiopGIumbrI66vBiWgI6YznCEpWC2hP+83zKe
         1qPavThyW6T0h1kLYO+0eyrMtnN7OOKP4O2dQjU1a27WpsAI48vgfTxvczYYHXZXEJ9k
         gB5/Wro+VIN+pmd2zolfpJyHmrHhR78pUjQvdz0U/f1nZpejcEyt55tfrjwx1fPehjOH
         Rx+qs7cmvpFgh3FpKbMdwGbQA4P/55q96frHCizyvT2zfMoE3kRRm0evyeFgd3y7I7WX
         xp9Q==
X-Gm-Message-State: ABy/qLYOy6iGQA9Ro+stPqtwxCPR1eHc/DFCvPj/uJmW7FPh6BeoNwJq
        qh7QNWRa4Bku9WB/nTbR4/I=
X-Google-Smtp-Source: APBJJlGR3CAcA8VpElr35t1iMcTkPeQOnRSHlP0QtX8e9pyEypaUrJK5JHOiBj5whMhet5KN4MMRZA==
X-Received: by 2002:a05:6358:e48f:b0:139:4de9:2a68 with SMTP id by15-20020a056358e48f00b001394de92a68mr441992rwb.27.1690333068842;
        Tue, 25 Jul 2023 17:57:48 -0700 (PDT)
Received: from bvanassche-glaptop2.roam.corp.google.com ([2601:642:4c05:4a8d:dbda:6b13:2798:9795])
        by smtp.gmail.com with ESMTPSA id t10-20020a63954a000000b005634bd81331sm11090138pgn.72.2023.07.25.17.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 17:57:48 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v3 1/6] block: Introduce the flag REQ_NO_WRITE_LOCK
Date:   Tue, 25 Jul 2023 17:57:25 -0700
Message-ID: <20230726005742.303865-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230726005742.303865-1-bvanassche@acm.org>
References: <20230726005742.303865-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Not all software that supports zoned storage allocates and submits zoned
writes in LBA order per zone. Introduce the REQ_NO_WRITE_LOCK flag such
that submitters of zoned writes can indicate that zoned writes are
allocated and submitted in LBA order per zone.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-flush.c         | 3 ++-
 include/linux/blk_types.h | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index e73dc22d05c1..038350ed7cce 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -336,7 +336,8 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
 		flush_rq->internal_tag = first_rq->internal_tag;
 
 	flush_rq->cmd_flags = REQ_OP_FLUSH | REQ_PREFLUSH;
-	flush_rq->cmd_flags |= (flags & REQ_DRV) | (flags & REQ_FAILFAST_MASK);
+	flush_rq->cmd_flags |= flags &
+		(REQ_FAILFAST_MASK | REQ_NO_ZONE_WRITE_LOCK | REQ_DRV);
 	flush_rq->rq_flags |= RQF_FLUSH_SEQ;
 	flush_rq->end_io = flush_end_io;
 	/*
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 0bad62cca3d0..68f7934d8fa6 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -416,6 +416,12 @@ enum req_flag_bits {
 	__REQ_PREFLUSH,		/* request for cache flush */
 	__REQ_RAHEAD,		/* read ahead, can fail anytime */
 	__REQ_BACKGROUND,	/* background IO */
+	/*
+	 * Do not use zone write locking. Setting this flag is only safe if
+	 * the request submitter allocates and submit requests in LBA order per
+	 * zone.
+	 */
+	__REQ_NO_ZONE_WRITE_LOCK,
 	__REQ_NOWAIT,           /* Don't wait if request will block */
 	__REQ_POLLED,		/* caller polls for completion using bio_poll */
 	__REQ_ALLOC_CACHE,	/* allocate IO from cache if available */
@@ -448,6 +454,8 @@ enum req_flag_bits {
 #define REQ_PREFLUSH	(__force blk_opf_t)(1ULL << __REQ_PREFLUSH)
 #define REQ_RAHEAD	(__force blk_opf_t)(1ULL << __REQ_RAHEAD)
 #define REQ_BACKGROUND	(__force blk_opf_t)(1ULL << __REQ_BACKGROUND)
+#define REQ_NO_ZONE_WRITE_LOCK	\
+			(__force blk_opf_t)(1ULL << __REQ_NO_ZONE_WRITE_LOCK)
 #define REQ_NOWAIT	(__force blk_opf_t)(1ULL << __REQ_NOWAIT)
 #define REQ_POLLED	(__force blk_opf_t)(1ULL << __REQ_POLLED)
 #define REQ_ALLOC_CACHE	(__force blk_opf_t)(1ULL << __REQ_ALLOC_CACHE)
