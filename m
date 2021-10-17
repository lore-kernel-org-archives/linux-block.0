Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E48FC433EF
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 01:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0B6360F70
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 01:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244792AbhJQBkE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Oct 2021 21:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244778AbhJQBkD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Oct 2021 21:40:03 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBB1C061765
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 18:37:55 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id 188so12157663iou.12
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 18:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Y03XGOLth6ew15W15TylF0EHYAmrv3Y3nwGIpoWtJU=;
        b=GY2jfy5JCSz/tI5lmX2KmMJ1Nnm4nNHqpEOccV8loPkha8cnNkfmpTIoR+c557yNY7
         5wvaZ353Dd/A6LSemW0P7PbIGT7pLhOZ7OXuMdPooOZrNctB4Se7C8ojDnxuCs+nDC6y
         USElD+rjUEj0Gnc4PG3ofOyh8jsqz3R0W537ZL/Gg3Z0t18pM0iFLZpEATNDoNK7aJim
         ErFk/y9iWU8SPj43lD0+1DtvpHmHLxUb1WsWfOHMmRNGMCK7caUYQ7BdFYD7xNPhDPj8
         R+su5PsNDGegg6ICRAyK2cU4XpZcu0wO3eBQOtp1akF+KUsxHNc4KbQpAHImG6bypWr/
         YYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Y03XGOLth6ew15W15TylF0EHYAmrv3Y3nwGIpoWtJU=;
        b=cp8zfZmjgirr1iMp6ySdsFemIrzwBaHvokT4gaXqgIy2ECfHKQa+v721TnRALFTUlb
         jfGMGYO2aBfJMEkhaIeTUGMBlbaMUcSoFNrLU5JiYvDtQ1wY9pwWxUIt1a9ajNx/pJhB
         Yl4m/5zFuSkfGDNceh9GvuPlxN9FZ2TlkIq/O29pOTLX7aGSZLdkBDPQupEgzdonNbgi
         lQ4+PSSG2uCC/EPLyNj4DcIBKWYQQ71T+7fSmuCBjgdQ1ZEy4xWvV/DTHXY29ieoz/tC
         RVtiX2oXxSKZJWAEs/ScAs3o02nogkN3Q0gcmV+/7GN8wVDVrkXIjqLsgbY/5NC6kaY3
         EiyQ==
X-Gm-Message-State: AOAM531fT4/vqq6IAoN/cOkRjKCzAGmVoCcXVj/wzSKoK7raIv3HJ2uj
        NCumTWIL2r1rZVYv5cI4tjYl24EhjD4=
X-Google-Smtp-Source: ABdhPJzfOz8+phn4bUIwqRK4WvHwgUfElCmdjdQ9hvw53ZdiIELLumMcQh61nCj2qbecg36Q7opQJA==
X-Received: by 2002:a05:6602:1651:: with SMTP id y17mr9509809iow.114.1634434674286;
        Sat, 16 Oct 2021 18:37:54 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id j17sm4934383ilq.1.2021.10.16.18.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 18:37:54 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 04/14] block: move update request helpers into blk-mq.c
Date:   Sat, 16 Oct 2021 19:37:38 -0600
Message-Id: <20211017013748.76461-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211017013748.76461-1-axboe@kernel.dk>
References: <20211017013748.76461-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For some reason we still have them in blk-core, with the rest of the
request completion being in blk-mq. That causes and out-of-line call
for each completion.

Move them into blk-mq.c instead, where they belong.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c | 146 +----------------------------------------------
 block/blk-mq.c   | 144 ++++++++++++++++++++++++++++++++++++++++++++++
 block/blk.h      |   1 +
 3 files changed, 146 insertions(+), 145 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 2596327f07d6..bdc03b80a8d0 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -217,7 +217,7 @@ int blk_status_to_errno(blk_status_t status)
 }
 EXPORT_SYMBOL_GPL(blk_status_to_errno);
 
-static void print_req_error(struct request *req, blk_status_t status)
+void blk_print_req_error(struct request *req, blk_status_t status)
 {
 	int idx = (__force int)status;
 
@@ -235,33 +235,6 @@ static void print_req_error(struct request *req, blk_status_t status)
 		IOPRIO_PRIO_CLASS(req->ioprio));
 }
 
-static void req_bio_endio(struct request *rq, struct bio *bio,
-			  unsigned int nbytes, blk_status_t error)
-{
-	if (error)
-		bio->bi_status = error;
-
-	if (unlikely(rq->rq_flags & RQF_QUIET))
-		bio_set_flag(bio, BIO_QUIET);
-
-	bio_advance(bio, nbytes);
-
-	if (req_op(rq) == REQ_OP_ZONE_APPEND && error == BLK_STS_OK) {
-		/*
-		 * Partial zone append completions cannot be supported as the
-		 * BIO fragments may end up not being written sequentially.
-		 */
-		if (bio->bi_iter.bi_size)
-			bio->bi_status = BLK_STS_IOERR;
-		else
-			bio->bi_iter.bi_sector = rq->__sector;
-	}
-
-	/* don't actually finish bio if it's part of flush sequence */
-	if (bio->bi_iter.bi_size == 0 && !(rq->rq_flags & RQF_FLUSH_SEQ))
-		bio_endio(bio);
-}
-
 void blk_dump_rq_flags(struct request *rq, char *msg)
 {
 	printk(KERN_INFO "%s: dev %s: flags=%llx\n", msg,
@@ -1304,17 +1277,6 @@ static void update_io_ticks(struct block_device *part, unsigned long now,
 	}
 }
 
-static void blk_account_io_completion(struct request *req, unsigned int bytes)
-{
-	if (req->part && blk_do_io_stat(req)) {
-		const int sgrp = op_stat_group(req_op(req));
-
-		part_stat_lock();
-		part_stat_add(req->part, sectors[sgrp], bytes >> 9);
-		part_stat_unlock();
-	}
-}
-
 void __blk_account_io_done(struct request *req, u64 now)
 {
 	const int sgrp = op_stat_group(req_op(req));
@@ -1423,112 +1385,6 @@ void blk_steal_bios(struct bio_list *list, struct request *rq)
 }
 EXPORT_SYMBOL_GPL(blk_steal_bios);
 
-/**
- * blk_update_request - Complete multiple bytes without completing the request
- * @req:      the request being processed
- * @error:    block status code
- * @nr_bytes: number of bytes to complete for @req
- *
- * Description:
- *     Ends I/O on a number of bytes attached to @req, but doesn't complete
- *     the request structure even if @req doesn't have leftover.
- *     If @req has leftover, sets it up for the next range of segments.
- *
- *     Passing the result of blk_rq_bytes() as @nr_bytes guarantees
- *     %false return from this function.
- *
- * Note:
- *	The RQF_SPECIAL_PAYLOAD flag is ignored on purpose in this function
- *      except in the consistency check at the end of this function.
- *
- * Return:
- *     %false - this request doesn't have any more data
- *     %true  - this request has more data
- **/
-bool blk_update_request(struct request *req, blk_status_t error,
-		unsigned int nr_bytes)
-{
-	int total_bytes;
-
-	trace_block_rq_complete(req, blk_status_to_errno(error), nr_bytes);
-
-	if (!req->bio)
-		return false;
-
-#ifdef CONFIG_BLK_DEV_INTEGRITY
-	if (blk_integrity_rq(req) && req_op(req) == REQ_OP_READ &&
-	    error == BLK_STS_OK)
-		req->q->integrity.profile->complete_fn(req, nr_bytes);
-#endif
-
-	if (unlikely(error && !blk_rq_is_passthrough(req) &&
-		     !(req->rq_flags & RQF_QUIET)))
-		print_req_error(req, error);
-
-	blk_account_io_completion(req, nr_bytes);
-
-	total_bytes = 0;
-	while (req->bio) {
-		struct bio *bio = req->bio;
-		unsigned bio_bytes = min(bio->bi_iter.bi_size, nr_bytes);
-
-		if (bio_bytes == bio->bi_iter.bi_size)
-			req->bio = bio->bi_next;
-
-		/* Completion has already been traced */
-		bio_clear_flag(bio, BIO_TRACE_COMPLETION);
-		req_bio_endio(req, bio, bio_bytes, error);
-
-		total_bytes += bio_bytes;
-		nr_bytes -= bio_bytes;
-
-		if (!nr_bytes)
-			break;
-	}
-
-	/*
-	 * completely done
-	 */
-	if (!req->bio) {
-		/*
-		 * Reset counters so that the request stacking driver
-		 * can find how many bytes remain in the request
-		 * later.
-		 */
-		req->__data_len = 0;
-		return false;
-	}
-
-	req->__data_len -= total_bytes;
-
-	/* update sector only for requests with clear definition of sector */
-	if (!blk_rq_is_passthrough(req))
-		req->__sector += total_bytes >> 9;
-
-	/* mixed attributes always follow the first bio */
-	if (req->rq_flags & RQF_MIXED_MERGE) {
-		req->cmd_flags &= ~REQ_FAILFAST_MASK;
-		req->cmd_flags |= req->bio->bi_opf & REQ_FAILFAST_MASK;
-	}
-
-	if (!(req->rq_flags & RQF_SPECIAL_PAYLOAD)) {
-		/*
-		 * If total number of sectors is less than the first segment
-		 * size, something has gone terribly wrong.
-		 */
-		if (blk_rq_bytes(req) < blk_rq_cur_bytes(req)) {
-			blk_dump_rq_flags(req, "request botched");
-			req->__data_len = blk_rq_cur_bytes(req);
-		}
-
-		/* recalculate the number of segments */
-		req->nr_phys_segments = blk_recalc_rq_segments(req);
-	}
-
-	return true;
-}
-EXPORT_SYMBOL_GPL(blk_update_request);
-
 #if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
 /**
  * rq_flush_dcache_pages - Helper function to flush all pages in a request
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 90bc93fe373e..ffccc5f0f66a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -613,6 +613,150 @@ void blk_mq_free_plug_rqs(struct blk_plug *plug)
 	}
 }
 
+static void req_bio_endio(struct request *rq, struct bio *bio,
+			  unsigned int nbytes, blk_status_t error)
+{
+	if (error)
+		bio->bi_status = error;
+
+	if (unlikely(rq->rq_flags & RQF_QUIET))
+		bio_set_flag(bio, BIO_QUIET);
+
+	bio_advance(bio, nbytes);
+
+	if (req_op(rq) == REQ_OP_ZONE_APPEND && error == BLK_STS_OK) {
+		/*
+		 * Partial zone append completions cannot be supported as the
+		 * BIO fragments may end up not being written sequentially.
+		 */
+		if (bio->bi_iter.bi_size)
+			bio->bi_status = BLK_STS_IOERR;
+		else
+			bio->bi_iter.bi_sector = rq->__sector;
+	}
+
+	/* don't actually finish bio if it's part of flush sequence */
+	if (bio->bi_iter.bi_size == 0 && !(rq->rq_flags & RQF_FLUSH_SEQ))
+		bio_endio(bio);
+}
+
+static void blk_account_io_completion(struct request *req, unsigned int bytes)
+{
+	if (req->part && blk_do_io_stat(req)) {
+		const int sgrp = op_stat_group(req_op(req));
+
+		part_stat_lock();
+		part_stat_add(req->part, sectors[sgrp], bytes >> 9);
+		part_stat_unlock();
+	}
+}
+
+/**
+ * blk_update_request - Complete multiple bytes without completing the request
+ * @req:      the request being processed
+ * @error:    block status code
+ * @nr_bytes: number of bytes to complete for @req
+ *
+ * Description:
+ *     Ends I/O on a number of bytes attached to @req, but doesn't complete
+ *     the request structure even if @req doesn't have leftover.
+ *     If @req has leftover, sets it up for the next range of segments.
+ *
+ *     Passing the result of blk_rq_bytes() as @nr_bytes guarantees
+ *     %false return from this function.
+ *
+ * Note:
+ *	The RQF_SPECIAL_PAYLOAD flag is ignored on purpose in this function
+ *      except in the consistency check at the end of this function.
+ *
+ * Return:
+ *     %false - this request doesn't have any more data
+ *     %true  - this request has more data
+ **/
+bool blk_update_request(struct request *req, blk_status_t error,
+		unsigned int nr_bytes)
+{
+	int total_bytes;
+
+	trace_block_rq_complete(req, blk_status_to_errno(error), nr_bytes);
+
+	if (!req->bio)
+		return false;
+
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+	if (blk_integrity_rq(req) && req_op(req) == REQ_OP_READ &&
+	    error == BLK_STS_OK)
+		req->q->integrity.profile->complete_fn(req, nr_bytes);
+#endif
+
+	if (unlikely(error && !blk_rq_is_passthrough(req) &&
+		     !(req->rq_flags & RQF_QUIET)))
+		blk_print_req_error(req, error);
+
+	blk_account_io_completion(req, nr_bytes);
+
+	total_bytes = 0;
+	while (req->bio) {
+		struct bio *bio = req->bio;
+		unsigned bio_bytes = min(bio->bi_iter.bi_size, nr_bytes);
+
+		if (bio_bytes == bio->bi_iter.bi_size)
+			req->bio = bio->bi_next;
+
+		/* Completion has already been traced */
+		bio_clear_flag(bio, BIO_TRACE_COMPLETION);
+		req_bio_endio(req, bio, bio_bytes, error);
+
+		total_bytes += bio_bytes;
+		nr_bytes -= bio_bytes;
+
+		if (!nr_bytes)
+			break;
+	}
+
+	/*
+	 * completely done
+	 */
+	if (!req->bio) {
+		/*
+		 * Reset counters so that the request stacking driver
+		 * can find how many bytes remain in the request
+		 * later.
+		 */
+		req->__data_len = 0;
+		return false;
+	}
+
+	req->__data_len -= total_bytes;
+
+	/* update sector only for requests with clear definition of sector */
+	if (!blk_rq_is_passthrough(req))
+		req->__sector += total_bytes >> 9;
+
+	/* mixed attributes always follow the first bio */
+	if (req->rq_flags & RQF_MIXED_MERGE) {
+		req->cmd_flags &= ~REQ_FAILFAST_MASK;
+		req->cmd_flags |= req->bio->bi_opf & REQ_FAILFAST_MASK;
+	}
+
+	if (!(req->rq_flags & RQF_SPECIAL_PAYLOAD)) {
+		/*
+		 * If total number of sectors is less than the first segment
+		 * size, something has gone terribly wrong.
+		 */
+		if (blk_rq_bytes(req) < blk_rq_cur_bytes(req)) {
+			blk_dump_rq_flags(req, "request botched");
+			req->__data_len = blk_rq_cur_bytes(req);
+		}
+
+		/* recalculate the number of segments */
+		req->nr_phys_segments = blk_recalc_rq_segments(req);
+	}
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(blk_update_request);
+
 inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
 {
 	if (blk_mq_need_time_stamp(rq)) {
diff --git a/block/blk.h b/block/blk.h
index f6e61cebd6ae..fdfaa6896fc4 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -213,6 +213,7 @@ static inline void blk_integrity_del(struct gendisk *disk)
 
 unsigned long blk_rq_timeout(unsigned long timeout);
 void blk_add_timer(struct request *req);
+void blk_print_req_error(struct request *req, blk_status_t status);
 
 bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs, struct request **same_queue_rq);
-- 
2.33.1

