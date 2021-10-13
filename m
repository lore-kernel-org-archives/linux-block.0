Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C660BC433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 16:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0B296052B
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 16:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbhJMQvu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 12:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbhJMQvt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 12:51:49 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DC0C061570
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 09:49:45 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id w11so392318ilv.6
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 09:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vk9BWAfusAs9hjR+WsXJQirfaoLZFWwpwknRZKmkpJ4=;
        b=zTaDvbvGp60ozDJUuF4NmUC9vQJELqwGwuBP9g9qyxxwe71AEoZJC6POsdksHYuZzB
         IGDljTTv2nk4rk9RONIkuH53qweT/Sfe3XObaF5LxyOJlB5cBmhUAJQxV+GWAZD2dj0d
         MR6RBOe07dpLo5PokRpBKV2GziAg7I91duq++G0oI/2W98G6NKWEBvov5RtHP85OMZR6
         77kohxNmxL1n8fHlh1G8Uknq032B6PIS8jFey8g9rTUVP63LbRW1pFOgfb+itev7E9rc
         pgBSnsnPpaOOEACqcdONLH2LGW7uNIl3EQbsrtrbZt3XVN4ayF31FzogBiZI0mWPg1M4
         OObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vk9BWAfusAs9hjR+WsXJQirfaoLZFWwpwknRZKmkpJ4=;
        b=KnTW/I8Zg6oeo3cyP3DS908rdz0s6NSHnuRsSpZ0iUOoA950qD2MLv+6rkVFPYodEA
         vUrFK7RUH2NNckcFLk3duGdHqAfxLKsZ1XxwZ/7f8oNsSDcbDm9Pja/C2zqSLTuxpI3u
         1Rm1nJcYW6WHcLaawtjZnxhcQW6bu4HEK6Y/XDS+ql6HHGlhFexfaQ35fkURldkpXUMO
         KYUxJZboDyuDr3/NxtfV9ZnvS8unyF+5+E4JzgGgynmCtb7ZjN+hdjdPyJ5GKACoalRV
         ztd98rj+KSvzTYKmbP/BZNO2l8tqS3HGcpGWlvn4g+oenIO7rOHTiqVzLdEmiIsKF6Vv
         hUTA==
X-Gm-Message-State: AOAM533+xAcYF2DMkVGJoIqTwv+STEd605NG5l0/T8WaYOuUSFXJl0uY
        SerTEdtHNwHUb0nQ71W23XvTcpUTvodGHg==
X-Google-Smtp-Source: ABdhPJxyv3wrouSm/gVOocKkqzmuu+SFRsItXYXfERspv9rrOzfckeq+OfEof0jHy7NOD6n8QzHYOg==
X-Received: by 2002:a05:6e02:1be8:: with SMTP id y8mr137276ilv.24.1634143784574;
        Wed, 13 Oct 2021 09:49:44 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v15sm17217ilg.87.2021.10.13.09.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 09:49:43 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/4] block: move update request helpers into blk-mq.c
Date:   Wed, 13 Oct 2021 10:49:37 -0600
Message-Id: <20211013164937.985367-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211013164937.985367-1-axboe@kernel.dk>
References: <20211013164937.985367-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For some reason we still have them in blk-core, with the rest of the
request completion being in blk-mq. That causes and out-of-line call
for each completion.

Move them into blk-mq.c instead.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c | 214 -----------------------------------------------
 block/blk-mq.c   | 214 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 214 insertions(+), 214 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d5b0258dd218..b199579c5f1f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -166,103 +166,6 @@ inline const char *blk_op_str(unsigned int op)
 }
 EXPORT_SYMBOL_GPL(blk_op_str);
 
-static const struct {
-	int		errno;
-	const char	*name;
-} blk_errors[] = {
-	[BLK_STS_OK]		= { 0,		"" },
-	[BLK_STS_NOTSUPP]	= { -EOPNOTSUPP, "operation not supported" },
-	[BLK_STS_TIMEOUT]	= { -ETIMEDOUT,	"timeout" },
-	[BLK_STS_NOSPC]		= { -ENOSPC,	"critical space allocation" },
-	[BLK_STS_TRANSPORT]	= { -ENOLINK,	"recoverable transport" },
-	[BLK_STS_TARGET]	= { -EREMOTEIO,	"critical target" },
-	[BLK_STS_NEXUS]		= { -EBADE,	"critical nexus" },
-	[BLK_STS_MEDIUM]	= { -ENODATA,	"critical medium" },
-	[BLK_STS_PROTECTION]	= { -EILSEQ,	"protection" },
-	[BLK_STS_RESOURCE]	= { -ENOMEM,	"kernel resource" },
-	[BLK_STS_DEV_RESOURCE]	= { -EBUSY,	"device resource" },
-	[BLK_STS_AGAIN]		= { -EAGAIN,	"nonblocking retry" },
-
-	/* device mapper special case, should not leak out: */
-	[BLK_STS_DM_REQUEUE]	= { -EREMCHG, "dm internal retry" },
-
-	/* zone device specific errors */
-	[BLK_STS_ZONE_OPEN_RESOURCE]	= { -ETOOMANYREFS, "open zones exceeded" },
-	[BLK_STS_ZONE_ACTIVE_RESOURCE]	= { -EOVERFLOW, "active zones exceeded" },
-
-	/* everything else not covered above: */
-	[BLK_STS_IOERR]		= { -EIO,	"I/O" },
-};
-
-blk_status_t errno_to_blk_status(int errno)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(blk_errors); i++) {
-		if (blk_errors[i].errno == errno)
-			return (__force blk_status_t)i;
-	}
-
-	return BLK_STS_IOERR;
-}
-EXPORT_SYMBOL_GPL(errno_to_blk_status);
-
-int blk_status_to_errno(blk_status_t status)
-{
-	int idx = (__force int)status;
-
-	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(blk_errors)))
-		return -EIO;
-	return blk_errors[idx].errno;
-}
-EXPORT_SYMBOL_GPL(blk_status_to_errno);
-
-static void print_req_error(struct request *req, blk_status_t status,
-		const char *caller)
-{
-	int idx = (__force int)status;
-
-	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(blk_errors)))
-		return;
-
-	printk_ratelimited(KERN_ERR
-		"%s: %s error, dev %s, sector %llu op 0x%x:(%s) flags 0x%x "
-		"phys_seg %u prio class %u\n",
-		caller, blk_errors[idx].name,
-		req->rq_disk ? req->rq_disk->disk_name : "?",
-		blk_rq_pos(req), req_op(req), blk_op_str(req_op(req)),
-		req->cmd_flags & ~REQ_OP_MASK,
-		req->nr_phys_segments,
-		IOPRIO_PRIO_CLASS(req->ioprio));
-}
-
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
@@ -1305,17 +1208,6 @@ static void update_io_ticks(struct block_device *part, unsigned long now,
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
@@ -1424,112 +1316,6 @@ void blk_steal_bios(struct bio_list *list, struct request *rq)
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
-		print_req_error(req, error, __func__);
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
index fe3e926c20a9..069837a020fe 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -626,6 +626,220 @@ inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
 }
 EXPORT_SYMBOL(__blk_mq_end_request);
 
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
+static const struct {
+	int		errno;
+	const char	*name;
+} blk_errors[] = {
+	[BLK_STS_OK]		= { 0,		"" },
+	[BLK_STS_NOTSUPP]	= { -EOPNOTSUPP, "operation not supported" },
+	[BLK_STS_TIMEOUT]	= { -ETIMEDOUT,	"timeout" },
+	[BLK_STS_NOSPC]		= { -ENOSPC,	"critical space allocation" },
+	[BLK_STS_TRANSPORT]	= { -ENOLINK,	"recoverable transport" },
+	[BLK_STS_TARGET]	= { -EREMOTEIO,	"critical target" },
+	[BLK_STS_NEXUS]		= { -EBADE,	"critical nexus" },
+	[BLK_STS_MEDIUM]	= { -ENODATA,	"critical medium" },
+	[BLK_STS_PROTECTION]	= { -EILSEQ,	"protection" },
+	[BLK_STS_RESOURCE]	= { -ENOMEM,	"kernel resource" },
+	[BLK_STS_DEV_RESOURCE]	= { -EBUSY,	"device resource" },
+	[BLK_STS_AGAIN]		= { -EAGAIN,	"nonblocking retry" },
+
+	/* device mapper special case, should not leak out: */
+	[BLK_STS_DM_REQUEUE]	= { -EREMCHG, "dm internal retry" },
+
+	/* zone device specific errors */
+	[BLK_STS_ZONE_OPEN_RESOURCE]	= { -ETOOMANYREFS, "open zones exceeded" },
+	[BLK_STS_ZONE_ACTIVE_RESOURCE]	= { -EOVERFLOW, "active zones exceeded" },
+
+	/* everything else not covered above: */
+	[BLK_STS_IOERR]		= { -EIO,	"I/O" },
+};
+
+blk_status_t errno_to_blk_status(int errno)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(blk_errors); i++) {
+		if (blk_errors[i].errno == errno)
+			return (__force blk_status_t)i;
+	}
+
+	return BLK_STS_IOERR;
+}
+EXPORT_SYMBOL_GPL(errno_to_blk_status);
+
+int blk_status_to_errno(blk_status_t status)
+{
+	int idx = (__force int)status;
+
+	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(blk_errors)))
+		return -EIO;
+	return blk_errors[idx].errno;
+}
+EXPORT_SYMBOL_GPL(blk_status_to_errno);
+
+static void print_req_error(struct request *req, blk_status_t status,
+		const char *caller)
+{
+	int idx = (__force int)status;
+
+	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(blk_errors)))
+		return;
+
+	printk_ratelimited(KERN_ERR
+		"%s: %s error, dev %s, sector %llu op 0x%x:(%s) flags 0x%x "
+		"phys_seg %u prio class %u\n",
+		caller, blk_errors[idx].name,
+		req->rq_disk ? req->rq_disk->disk_name : "?",
+		blk_rq_pos(req), req_op(req), blk_op_str(req_op(req)),
+		req->cmd_flags & ~REQ_OP_MASK,
+		req->nr_phys_segments,
+		IOPRIO_PRIO_CLASS(req->ioprio));
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
+		print_req_error(req, error, __func__);
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
 void blk_mq_end_request(struct request *rq, blk_status_t error)
 {
 	if (blk_update_request(rq, error, blk_rq_bytes(rq)))
-- 
2.33.0

