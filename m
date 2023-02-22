Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D950DC636D6
	for <linux-block@archiver.kernel.org>; Wed, 22 Feb 2023 18:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjBVSxT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Feb 2023 13:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjBVSxT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Feb 2023 13:53:19 -0500
Received: from mail-il1-x163.google.com (mail-il1-x163.google.com [IPv6:2607:f8b0:4864:20::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3787F12F3D
        for <linux-block@vger.kernel.org>; Wed, 22 Feb 2023 10:53:17 -0800 (PST)
Received: by mail-il1-x163.google.com with SMTP id x6so3966712ilm.11
        for <linux-block@vger.kernel.org>; Wed, 22 Feb 2023 10:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3XQJnDEONaQxroBOwHQuKkK6NHLqVHt0xLQJjGikbCg=;
        b=G5B+cSfkit3EJQuCpLQXki+NknWed1zMk4ErSnqD24VppgiNn2VEibMuHrJCVXAZia
         HPcfJlX1vre5I01w6kqlANU4GkxoELBa+YwYQDVgmWkIYRrIjxDDgxC289dfqRBjx7cF
         cHzT5Nqw0Gj4q0ebnTXqLAIk9bwHrlvcxJ7faktMrY2Luz+8vt3MHDV0chMYp3MhTLCd
         ppe7HwgpH/T4ZYzo39pHkqpFbPpIhqKaCiOt+gVQJBl/myGYIXoWyAI9qTtYRy2Slbsj
         lpVrH+wdDMUKtdqSlLAk41mRn2NCeb5+zSvJn1aU1qsU6Iq6ZHySLPr1dV8gv3OGSiyI
         PGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3XQJnDEONaQxroBOwHQuKkK6NHLqVHt0xLQJjGikbCg=;
        b=PAkbuNhUt+m6M9mkUx5V6hJ0wIYmwJXo1NeR+kfXOMnm2iyagQa2An36B62jR4PIHN
         JI08TovprkrmEe/umeV008+pTAuNza9C5GlbuLcoKZEIZoaOmFhc5iEy0erw0j3RRyhg
         BKtUekENgxNm5Wmp4FMlJjI73DoTxllsBiCMiKNZJ+6PqciNvV4tQAY2hBBzxoPGt0P4
         Z9ornslfh/oTtWfzK9aHsoNzldwHzVC3slH/7qAb1z3fxjA0bUUTqVUxp6Rh2uxIeAOj
         nxLvZJ8ZtB6ZPaq923uyfYibMPwt66+ttHtMkD9jQODRhXIJiblboIuF7k6G/n5mY3wy
         7wtQ==
X-Gm-Message-State: AO0yUKVIfMViwFDLTZzmNhx16t4fafOeZs2v1AesnwskvGVfWzqDDRhz
        mIJmC6LE6758q6j+pyNKENP6z2y++LwwfFHEbdkYXGhYFmWqAA==
X-Google-Smtp-Source: AK7set+y8N+kEI1uXvjpEcsNFNqman9u8t5ylXlm7hQchLag6GPppv3lVzivdlSoUDopDWc7gcrL8+XVN3g4
X-Received: by 2002:a05:6e02:221d:b0:315:69ef:345d with SMTP id j29-20020a056e02221d00b0031569ef345dmr5366501ilf.16.1677091996562;
        Wed, 22 Feb 2023 10:53:16 -0800 (PST)
Received: from c7-smtp.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id bw10-20020a056638460a00b003de5c87c093sm567444jab.45.2023.02.22.10.53.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Feb 2023 10:53:16 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
        by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id BC04721141;
        Wed, 22 Feb 2023 11:53:15 -0700 (MST)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
        id B7C4DE4332F; Wed, 22 Feb 2023 11:53:15 -0700 (MST)
From:   Uday Shankar <ushankar@purestorage.com>
To:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Uday Shankar <ushankar@purestorage.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] blk-mq: enforce op-specific segment limits in blk_insert_cloned_request
Date:   Wed, 22 Feb 2023 11:52:25 -0700
Message-Id: <20230222185224.2484590-1-ushankar@purestorage.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The block layer might merge together discard requests up until the
max_discard_segments limit is hit, but blk_insert_cloned_request checks
the segment count against max_segments regardless of the req op. This
can result in errors like the following when discards are issued through
a DM device and max_discard_segments exceeds max_segments for the queue
of the chosen underlying device.

blk_insert_cloned_request: over max segments limit. (256 > 129)

Fix this by looking at the req_op and enforcing the appropriate segment
limit - max_discard_segments for REQ_OP_DISCARDs and max_segments for
everything else.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
Changes since v1:
- Fixed format specifier type mismatch
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202302162040.FaI25ul2-lkp@intel.com/

 block/blk-merge.c | 4 +---
 block/blk-mq.c    | 7 ++++---
 block/blk.h       | 8 ++++++++
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index b7c193d67..7f663c2d3 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -588,9 +588,7 @@ EXPORT_SYMBOL(__blk_rq_map_sg);
 
 static inline unsigned int blk_rq_get_max_segments(struct request *rq)
 {
-	if (req_op(rq) == REQ_OP_DISCARD)
-		return queue_max_discard_segments(rq->q);
-	return queue_max_segments(rq->q);
+	return blk_queue_get_max_segments(rq->q, req_op(rq));
 }
 
 static inline unsigned int blk_rq_get_max_sectors(struct request *rq,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d3494a796..b053a9255 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3000,6 +3000,7 @@ blk_status_t blk_insert_cloned_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
 	unsigned int max_sectors = blk_queue_get_max_sectors(q, req_op(rq));
+	unsigned int max_segments = blk_queue_get_max_segments(q, req_op(rq));
 	blk_status_t ret;
 
 	if (blk_rq_sectors(rq) > max_sectors) {
@@ -3026,9 +3027,9 @@ blk_status_t blk_insert_cloned_request(struct request *rq)
 	 * original queue.
 	 */
 	rq->nr_phys_segments = blk_recalc_rq_segments(rq);
-	if (rq->nr_phys_segments > queue_max_segments(q)) {
-		printk(KERN_ERR "%s: over max segments limit. (%hu > %hu)\n",
-			__func__, rq->nr_phys_segments, queue_max_segments(q));
+	if (rq->nr_phys_segments > max_segments) {
+		printk(KERN_ERR "%s: over max segments limit. (%u > %u)\n",
+			__func__, rq->nr_phys_segments, max_segments);
 		return BLK_STS_IOERR;
 	}
 
diff --git a/block/blk.h b/block/blk.h
index f02381405..8d705c13a 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -169,6 +169,14 @@ static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
 	return q->limits.max_sectors;
 }
 
+static inline unsigned int blk_queue_get_max_segments(struct request_queue *q,
+						      enum req_op op)
+{
+	if (op == REQ_OP_DISCARD)
+		return queue_max_discard_segments(q);
+	return queue_max_segments(q);
+}
+
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 void blk_flush_integrity(void);
 bool __bio_integrity_endio(struct bio *);

base-commit: 6bea9ac7c6481c09eb2b61d7cd844fc64a526e3e
-- 
2.25.1

