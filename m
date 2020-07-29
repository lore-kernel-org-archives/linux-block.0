Return-Path: <SRS0=8JfY=BI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64C9C433E0
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 03:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99A692074B
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 03:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgG2D26 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jul 2020 23:28:58 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:52307 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726319AbgG2D24 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 23:28:56 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U46X3YU_1595993331;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U46X3YU_1595993331)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 29 Jul 2020 11:28:52 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@lst.de, baolin.wang@linux.alibaba.com,
        baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] block: Add a new helper to attempt to merge a bio
Date:   Wed, 29 Jul 2020 11:28:35 +0800
Message-Id: <fd369d040fad6c47823bc6218d7f81aa99d02374.1595987955.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1595987955.git.baolin.wang@linux.alibaba.com>
References: <cover.1595987955.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1595987955.git.baolin.wang@linux.alibaba.com>
References: <cover.1595987955.git.baolin.wang@linux.alibaba.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There are lots of duplicated code when trying to merge a bio from
plug list and sw queue, we can introduce a new helper to attempt
to merge a bio, which can simplify the blk_mq_bio_list_merge()
and blk_attempt_plug_merge().

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 block/blk-merge.c    | 47 +++++++++++++++++++++++++++++------------------
 block/blk-mq-sched.c | 22 ++++------------------
 block/blk.h          |  9 +++++++++
 3 files changed, 42 insertions(+), 36 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 1993e6a..feaee53 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -975,6 +975,33 @@ bool bio_attempt_discard_merge(struct request_queue *q, struct request *req,
 	return false;
 }
 
+enum bio_merge_status blk_attempt_bio_merge(struct request_queue *q,
+					    struct request *rq,
+					    struct bio *bio,
+					    unsigned int nr_segs)
+{
+	bool merged = false;
+
+	if (!blk_rq_merge_ok(rq, bio))
+		return BIO_MERGE_NONE;
+
+	switch (blk_try_merge(rq, bio)) {
+	case ELEVATOR_BACK_MERGE:
+		merged = bio_attempt_back_merge(rq, bio, nr_segs);
+		break;
+	case ELEVATOR_FRONT_MERGE:
+		merged = bio_attempt_front_merge(rq, bio, nr_segs);
+		break;
+	case ELEVATOR_DISCARD_MERGE:
+		merged = bio_attempt_discard_merge(q, rq, bio);
+		break;
+	default:
+		return BIO_MERGE_NONE;
+	}
+
+	return merged ? BIO_MERGE_OK : BIO_MERGE_FAILED;
+}
+
 /**
  * blk_attempt_plug_merge - try to merge with %current's plugged list
  * @q: request_queue new bio is being queued at
@@ -1011,8 +1038,6 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 	plug_list = &plug->mq_list;
 
 	list_for_each_entry_reverse(rq, plug_list, queuelist) {
-		bool merged = false;
-
 		if (rq->q == q && same_queue_rq) {
 			/*
 			 * Only blk-mq multiple hardware queues case checks the
@@ -1022,24 +1047,10 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 			*same_queue_rq = rq;
 		}
 
-		if (rq->q != q || !blk_rq_merge_ok(rq, bio))
+		if (rq->q != q)
 			continue;
 
-		switch (blk_try_merge(rq, bio)) {
-		case ELEVATOR_BACK_MERGE:
-			merged = bio_attempt_back_merge(rq, bio, nr_segs);
-			break;
-		case ELEVATOR_FRONT_MERGE:
-			merged = bio_attempt_front_merge(rq, bio, nr_segs);
-			break;
-		case ELEVATOR_DISCARD_MERGE:
-			merged = bio_attempt_discard_merge(q, rq, bio);
-			break;
-		default:
-			break;
-		}
-
-		if (merged)
+		if (blk_attempt_bio_merge(q, rq, bio, nr_segs) == BIO_MERGE_OK)
 			return true;
 	}
 
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index cc34f69..24d5078 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -391,31 +391,17 @@ bool blk_mq_bio_list_merge(struct request_queue *q, struct list_head *list,
 {
 	struct request *rq;
 	int checked = 8;
+	enum bio_merge_status merge;
 
 	list_for_each_entry_reverse(rq, list, queuelist) {
-		bool merged = false;
-
 		if (!checked--)
 			break;
 
-		if (!blk_rq_merge_ok(rq, bio))
+		merge = blk_attempt_bio_merge(q, rq, bio, nr_segs);
+		if (merge == BIO_MERGE_NONE)
 			continue;
 
-		switch (blk_try_merge(rq, bio)) {
-		case ELEVATOR_BACK_MERGE:
-			merged = bio_attempt_back_merge(rq, bio, nr_segs);
-			break;
-		case ELEVATOR_FRONT_MERGE:
-			merged = bio_attempt_front_merge(rq, bio, nr_segs);
-			break;
-		case ELEVATOR_DISCARD_MERGE:
-			merged = bio_attempt_discard_merge(q, rq, bio);
-			break;
-		default:
-			continue;
-		}
-
-		return merged;
+		return merge == BIO_MERGE_OK ? true: false;
 	}
 
 	return false;
diff --git a/block/blk.h b/block/blk.h
index 49e2928..a6c54e1 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -234,6 +234,15 @@ int blk_attempt_req_merge(struct request_queue *q, struct request *rq,
 bool blk_rq_merge_ok(struct request *rq, struct bio *bio);
 enum elv_merge blk_try_merge(struct request *rq, struct bio *bio);
 
+enum bio_merge_status {
+	BIO_MERGE_OK,
+	BIO_MERGE_NONE,
+	BIO_MERGE_FAILED,
+};
+
+enum bio_merge_status blk_attempt_bio_merge(struct request_queue *q,
+		struct request *rq, struct bio *bio, unsigned int nr_segs);
+
 int blk_dev_init(void);
 
 /*
-- 
1.8.3.1

