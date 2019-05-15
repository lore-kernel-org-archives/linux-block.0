Return-Path: <SRS0=Ir13=TP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E922C04AB4
	for <linux-block@archiver.kernel.org>; Wed, 15 May 2019 03:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D352084A
	for <linux-block@archiver.kernel.org>; Wed, 15 May 2019 03:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfEODDg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 May 2019 23:03:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbfEODDg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 May 2019 23:03:36 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5A7C03082129;
        Wed, 15 May 2019 03:03:36 +0000 (UTC)
Received: from localhost (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 95F3360F91;
        Wed, 15 May 2019 03:03:35 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 3/3] block: rename BIO_QUEUE_ENTERED as BIO_SPLITTED
Date:   Wed, 15 May 2019 11:03:10 +0800
Message-Id: <20190515030310.20393-4-ming.lei@redhat.com>
In-Reply-To: <20190515030310.20393-1-ming.lei@redhat.com>
References: <20190515030310.20393-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 15 May 2019 03:03:36 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

cd4a4ae4683d ("block: don't use blocking queue entered for recursive
bio submits") introduces BIO_QUEUE_ENTERED to avoid blocking queue entered
for recursive bio submits. Now there isn't such use any more. The only
one use is for cgroup accounting on splitted bio, so rename it
as BIO_SPLITTED.

Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-merge.c          | 10 +---------
 include/linux/blk-cgroup.h |  4 ++--
 include/linux/blk_types.h  |  2 +-
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 21e87a714a73..5fd81cd86928 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -332,15 +332,7 @@ void blk_queue_split(struct request_queue *q, struct bio **bio)
 		/* there isn't chance to merge the splitted bio */
 		split->bi_opf |= REQ_NOMERGE;
 
-		/*
-		 * Since we're recursing into make_request here, ensure
-		 * that we mark this bio as already having entered the queue.
-		 * If not, and the queue is going away, we can get stuck
-		 * forever on waiting for the queue reference to drop. But
-		 * that will never happen, as we're already holding a
-		 * reference to it.
-		 */
-		bio_set_flag(*bio, BIO_QUEUE_ENTERED);
+		bio_set_flag(*bio, BIO_SPLITTED);
 
 		bio_chain(split, *bio);
 		trace_block_split(q, split, (*bio)->bi_iter.bi_sector);
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 76c61318fda5..a24c9a04f79f 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -792,11 +792,11 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
 
 	if (!throtl) {
 		/*
-		 * If the bio is flagged with BIO_QUEUE_ENTERED it means this
+		 * If the bio is flagged with BIO_SPLITTED it means this
 		 * is a split bio and we would have already accounted for the
 		 * size of the bio.
 		 */
-		if (!bio_flagged(bio, BIO_QUEUE_ENTERED))
+		if (!bio_flagged(bio, BIO_SPLITTED))
 			blkg_rwstat_add(&blkg->stat_bytes, bio->bi_opf,
 					bio->bi_iter.bi_size);
 		blkg_rwstat_add(&blkg->stat_ios, bio->bi_opf, 1);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index be418275763c..d7235009f3a7 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -229,7 +229,7 @@ enum {
 				 * throttling rules. Don't do it again. */
 	BIO_TRACE_COMPLETION,	/* bio_endio() should trace the final completion
 				 * of this bio. */
-	BIO_QUEUE_ENTERED,	/* can use blk_queue_enter_live() */
+	BIO_SPLITTED,		/* splitted bio */
 	BIO_TRACKED,		/* set if bio goes through the rq_qos path */
 	BIO_FLAG_LAST
 };
-- 
2.20.1

