Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2079DC433EF
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 03:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiBODdV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Feb 2022 22:33:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiBODdU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Feb 2022 22:33:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95071E95
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 19:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644895990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CDjDnpSyTsGm2IEUB335RL8/oZAkR7u9aGAwC4/XFZE=;
        b=a2kG/RkVps1fjrw2pijK+r/2py/EHu4Og/veXLnPCYcYTobrO/yKkNJravOuJnzNLV8QwO
        RuLPx3+SPv3l39fNFDlAb8XhazXNUHE8+X/WftIR+YJYvlsMVI4hm4EUIlGURHKFRGwBBR
        AMy1A8lDMWHfG/2N24ndWDRyLArdws0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-48-zZzcS5p-Mge9URvWUoo36g-1; Mon, 14 Feb 2022 22:33:09 -0500
X-MC-Unique: zZzcS5p-Mge9URvWUoo36g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 523431006AA6;
        Tue, 15 Feb 2022 03:33:08 +0000 (UTC)
Received: from localhost (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 74FA710595A9;
        Tue, 15 Feb 2022 03:33:07 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Li Ning <lining2020x@163.com>,
        Tejun Heo <tj@kernel.org>, Chunguang Xu <brookxu@tencent.com>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH V3 5/8] block: merge submit_bio_checks() into submit_bio_noacct
Date:   Tue, 15 Feb 2022 11:30:47 +0800
Message-Id: <20220215033050.2730533-6-ming.lei@redhat.com>
In-Reply-To: <20220215033050.2730533-1-ming.lei@redhat.com>
References: <20220215033050.2730533-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now submit_bio_checks() is only called by submit_bio_noacct(), so merge
it into submit_bio_noacct().

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c | 213 +++++++++++++++++++++++------------------------
 1 file changed, 103 insertions(+), 110 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index f97cb8b23610..42466d60aea1 100644
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
@@ -901,9 +794,109 @@ static inline void __submit_bio_noacct_nocheck(struct bio *bio)
  */
 void submit_bio_noacct(struct bio *bio)
 {
-	if (unlikely(!submit_bio_checks(bio)))
-		return;
-	__submit_bio_noacct_nocheck(bio);
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
+	if (!blk_throtl_bio(bio)) {
+		blk_cgroup_bio_start(bio);
+		blkcg_bio_issue_init(bio);
+
+		if (!bio_flagged(bio, BIO_TRACE_COMPLETION)) {
+			trace_block_bio_queue(bio);
+			/* Now that enqueuing has been traced, we need to
+			 * trace completion as well.
+			 */
+			bio_set_flag(bio, BIO_TRACE_COMPLETION);
+		}
+
+		__submit_bio_noacct_nocheck(bio);
+	}
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

