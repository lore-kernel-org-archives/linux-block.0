Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA78EC433EF
	for <linux-block@archiver.kernel.org>; Wed, 16 Feb 2022 04:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344410AbiBPEqt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 23:46:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241616AbiBPEqt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 23:46:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A656DF463E
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 20:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644986796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2QtPqgSXtDJ6wm1AUxhKjljGakXVNFcKq4G7SdwoTzs=;
        b=EFISNS4VYsbGfBBXzhTpwrJWRlT8FuKIt5Gx6QX2PMBVDoQ4mU2OY44ofR2Cv8SpYw7k37
        M46yRSRPpVWGIRLaRsVMXlXqZ5oPeW5wK4NtJ4Ze25TM9oc6jVmS32XoJQd4RRliwhYVPs
        Q05jAGTLuAJReher3anouSFoJsdoeeY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-290-dE1DJGCVOZ-WBU0wA3bo8Q-1; Tue, 15 Feb 2022 23:46:35 -0500
X-MC-Unique: dE1DJGCVOZ-WBU0wA3bo8Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 631D11091DA1;
        Wed, 16 Feb 2022 04:46:34 +0000 (UTC)
Received: from localhost (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15C96452FA;
        Wed, 16 Feb 2022 04:46:27 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ning Li <lining2020x@163.com>,
        Tejun Heo <tj@kernel.org>, Chunguang Xu <brookxu@tencent.com>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH V4 5/8] block: merge submit_bio_checks() into submit_bio_noacct
Date:   Wed, 16 Feb 2022 12:45:11 +0800
Message-Id: <20220216044514.2903784-6-ming.lei@redhat.com>
In-Reply-To: <20220216044514.2903784-1-ming.lei@redhat.com>
References: <20220216044514.2903784-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now submit_bio_checks() is only called by submit_bio_noacct(), so merge
it into submit_bio_noacct().

Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c | 209 +++++++++++++++++++++++------------------------
 1 file changed, 101 insertions(+), 108 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 72b7b2214c70..94bf37f8e61d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -676,113 +676,6 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
 	return BLK_STS_OK;
 }
 
-static noinline_for_stack bool submit_bio_checks(struct bio *bio)
-{
-	struct block_device *bdev = bio->bi_bdev;
-	struct request_queue *q = bdev_get_queue(bdev);
-	blk_status_t status = BLK_STS_IOERR;
-	struct blk_plug *plug;
-
-	might_sleep();
-
-	plug = blk_mq_plug(q, bio);
-	if (plug && plug->nowait)
-		bio->bi_opf |= REQ_NOWAIT;
-
-	/*
-	 * For a REQ_NOWAIT based request, return -EOPNOTSUPP
-	 * if queue does not support NOWAIT.
-	 */
-	if ((bio->bi_opf & REQ_NOWAIT) && !blk_queue_nowait(q))
-		goto not_supported;
-
-	if (should_fail_bio(bio))
-		goto end_io;
-	if (unlikely(bio_check_ro(bio)))
-		goto end_io;
-	if (!bio_flagged(bio, BIO_REMAPPED)) {
-		if (unlikely(bio_check_eod(bio)))
-			goto end_io;
-		if (bdev->bd_partno && unlikely(blk_partition_remap(bio)))
-			goto end_io;
-	}
-
-	/*
-	 * Filter flush bio's early so that bio based drivers without flush
-	 * support don't have to worry about them.
-	 */
-	if (op_is_flush(bio->bi_opf) &&
-	    !test_bit(QUEUE_FLAG_WC, &q->queue_flags)) {
-		bio->bi_opf &= ~(REQ_PREFLUSH | REQ_FUA);
-		if (!bio_sectors(bio)) {
-			status = BLK_STS_OK;
-			goto end_io;
-		}
-	}
-
-	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
-		bio_clear_polled(bio);
-
-	switch (bio_op(bio)) {
-	case REQ_OP_DISCARD:
-		if (!blk_queue_discard(q))
-			goto not_supported;
-		break;
-	case REQ_OP_SECURE_ERASE:
-		if (!blk_queue_secure_erase(q))
-			goto not_supported;
-		break;
-	case REQ_OP_WRITE_SAME:
-		if (!q->limits.max_write_same_sectors)
-			goto not_supported;
-		break;
-	case REQ_OP_ZONE_APPEND:
-		status = blk_check_zone_append(q, bio);
-		if (status != BLK_STS_OK)
-			goto end_io;
-		break;
-	case REQ_OP_ZONE_RESET:
-	case REQ_OP_ZONE_OPEN:
-	case REQ_OP_ZONE_CLOSE:
-	case REQ_OP_ZONE_FINISH:
-		if (!blk_queue_is_zoned(q))
-			goto not_supported;
-		break;
-	case REQ_OP_ZONE_RESET_ALL:
-		if (!blk_queue_is_zoned(q) || !blk_queue_zone_resetall(q))
-			goto not_supported;
-		break;
-	case REQ_OP_WRITE_ZEROES:
-		if (!q->limits.max_write_zeroes_sectors)
-			goto not_supported;
-		break;
-	default:
-		break;
-	}
-
-	if (blk_throtl_bio(bio))
-		return false;
-
-	blk_cgroup_bio_start(bio);
-	blkcg_bio_issue_init(bio);
-
-	if (!bio_flagged(bio, BIO_TRACE_COMPLETION)) {
-		trace_block_bio_queue(bio);
-		/* Now that enqueuing has been traced, we need to trace
-		 * completion as well.
-		 */
-		bio_set_flag(bio, BIO_TRACE_COMPLETION);
-	}
-	return true;
-
-not_supported:
-	status = BLK_STS_NOTSUPP;
-end_io:
-	bio->bi_status = status;
-	bio_endio(bio);
-	return false;
-}
-
 static void __submit_bio(struct bio *bio)
 {
 	struct gendisk *disk = bio->bi_bdev->bd_disk;
@@ -901,9 +794,109 @@ void submit_bio_noacct_nocheck(struct bio *bio)
  */
 void submit_bio_noacct(struct bio *bio)
 {
-	if (unlikely(!submit_bio_checks(bio)))
+	struct block_device *bdev = bio->bi_bdev;
+	struct request_queue *q = bdev_get_queue(bdev);
+	blk_status_t status = BLK_STS_IOERR;
+	struct blk_plug *plug;
+
+	might_sleep();
+
+	plug = blk_mq_plug(q, bio);
+	if (plug && plug->nowait)
+		bio->bi_opf |= REQ_NOWAIT;
+
+	/*
+	 * For a REQ_NOWAIT based request, return -EOPNOTSUPP
+	 * if queue does not support NOWAIT.
+	 */
+	if ((bio->bi_opf & REQ_NOWAIT) && !blk_queue_nowait(q))
+		goto not_supported;
+
+	if (should_fail_bio(bio))
+		goto end_io;
+	if (unlikely(bio_check_ro(bio)))
+		goto end_io;
+	if (!bio_flagged(bio, BIO_REMAPPED)) {
+		if (unlikely(bio_check_eod(bio)))
+			goto end_io;
+		if (bdev->bd_partno && unlikely(blk_partition_remap(bio)))
+			goto end_io;
+	}
+
+	/*
+	 * Filter flush bio's early so that bio based drivers without flush
+	 * support don't have to worry about them.
+	 */
+	if (op_is_flush(bio->bi_opf) &&
+	    !test_bit(QUEUE_FLAG_WC, &q->queue_flags)) {
+		bio->bi_opf &= ~(REQ_PREFLUSH | REQ_FUA);
+		if (!bio_sectors(bio)) {
+			status = BLK_STS_OK;
+			goto end_io;
+		}
+	}
+
+	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
+		bio_clear_polled(bio);
+
+	switch (bio_op(bio)) {
+	case REQ_OP_DISCARD:
+		if (!blk_queue_discard(q))
+			goto not_supported;
+		break;
+	case REQ_OP_SECURE_ERASE:
+		if (!blk_queue_secure_erase(q))
+			goto not_supported;
+		break;
+	case REQ_OP_WRITE_SAME:
+		if (!q->limits.max_write_same_sectors)
+			goto not_supported;
+		break;
+	case REQ_OP_ZONE_APPEND:
+		status = blk_check_zone_append(q, bio);
+		if (status != BLK_STS_OK)
+			goto end_io;
+		break;
+	case REQ_OP_ZONE_RESET:
+	case REQ_OP_ZONE_OPEN:
+	case REQ_OP_ZONE_CLOSE:
+	case REQ_OP_ZONE_FINISH:
+		if (!blk_queue_is_zoned(q))
+			goto not_supported;
+		break;
+	case REQ_OP_ZONE_RESET_ALL:
+		if (!blk_queue_is_zoned(q) || !blk_queue_zone_resetall(q))
+			goto not_supported;
+		break;
+	case REQ_OP_WRITE_ZEROES:
+		if (!q->limits.max_write_zeroes_sectors)
+			goto not_supported;
+		break;
+	default:
+		break;
+	}
+
+	if (blk_throtl_bio(bio))
 		return;
+
+	blk_cgroup_bio_start(bio);
+	blkcg_bio_issue_init(bio);
+
+	if (!bio_flagged(bio, BIO_TRACE_COMPLETION)) {
+		trace_block_bio_queue(bio);
+		/* Now that enqueuing has been traced, we need to trace
+		 * completion as well.
+		 */
+		bio_set_flag(bio, BIO_TRACE_COMPLETION);
+	}
 	submit_bio_noacct_nocheck(bio);
+	return;
+
+not_supported:
+	status = BLK_STS_NOTSUPP;
+end_io:
+	bio->bi_status = status;
+	bio_endio(bio);
 }
 EXPORT_SYMBOL(submit_bio_noacct);
 
-- 
2.31.1

