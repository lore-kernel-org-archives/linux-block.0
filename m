Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA354C43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7967720659
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lZrf3BOa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7967720659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbeK0Dal (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:30:41 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:35056 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbeK0Dal (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 22:30:41 -0500
Received: by mail-it1-f196.google.com with SMTP id p197so3164058itp.0
        for <linux-block@vger.kernel.org>; Mon, 26 Nov 2018 08:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wY8wSFZwGvj9JmcMtDWhg1FyLukBykQhyIYxMSU20DI=;
        b=lZrf3BOaNHJV7dFivtB2fbcZnUugPOpuIyPxGXAskJSl2WC3mXExzl2+g5bui7k4q5
         tDZ1xjy3RsZdZkv0oi3Y1LHGGWQA3CZoyBtx9A+gYfjjrVQ/eNGsr9qPwyp6jIyKQsXT
         PO+T9l6CIBJCHXt9CSIWhsPQCWTDZCRPSkeN5kNqxikLvB/bS9P5Bb5bDZTTozR0YBaD
         ubNvMY4RysUEJM0cfE3O+PJpUkpn88NtdVrZuzT76LCY1I8Y/avUGmFEdSehguGVscTc
         f7xLRjDpZ9Sb0p9mTmmaaS9w6EYJVFPOoeYQq74kge2WjKH3R9LiCOECqsdcX1xv0lHf
         7n6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wY8wSFZwGvj9JmcMtDWhg1FyLukBykQhyIYxMSU20DI=;
        b=RASLHOZD8Tywt3ESIdnQrJLvQi5S8xozpeDNMJMz47iIptQXulTCnXeCQRu8z+j3lG
         1aOYyH9SF8BHNXRrdsRk/a0VXt2u3uXcUVoNYZ+gJp0GMj9EUqX1zBlNdYAcP93hvfqw
         RKHLsUCZi/2jwHyNSMZjtb9fIQUaL3IFjWuyDT0QC6lTlqkVKgceSUhdQ84fDAB0CZHy
         uWx1Mr/yULwGO0EM1M7REbx1jT44ZDYHRtnn2wC+ghvyE8v9AjW56ttDp7amxveb9c01
         S++r6DRdGQN3Ggz0fTp5VWw7x2CTS22bX7ATytIAKEvVMkEWlVR02LhacngQN/xSRsd7
         a+4g==
X-Gm-Message-State: AGRZ1gKxgkkxS5sfdaMtULBLj5kS+tdNsxEjA8fzNVyZ0epzB7Jb2BKb
        vhboF4B/umB3v/ZjYfYyYwgB+aZTaJE=
X-Google-Smtp-Source: AFSGD/XkjBYC70cM+UHR1//zgjPb2WTo+2N9Nzntcow/ICB12kXO6f/VUugJuXIbBuY36xgwUxRbng==
X-Received: by 2002:a24:fdc4:: with SMTP id m187mr22908628ith.75.1543250162894;
        Mon, 26 Nov 2018 08:36:02 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id r11sm263717iog.46.2018.11.26.08.36.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 08:36:01 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/8] block: sum requests in the plug structure
Date:   Mon, 26 Nov 2018 09:35:49 -0700
Message-Id: <20181126163556.5181-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181126163556.5181-1-axboe@kernel.dk>
References: <20181126163556.5181-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This isn't exactly the same as the previous count, as it includes
requests for all devices. But that really doesn't matter, if we have
more than the threshold (16) queued up, flush it. It's not worth it
to have an expensive list loop for this.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c       | 30 ++++--------------------------
 block/blk-mq.c         | 16 +++++-----------
 block/blk.h            |  2 --
 include/linux/blkdev.h |  1 +
 4 files changed, 10 insertions(+), 39 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 9af56dbb84f1..be9233400314 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -736,7 +736,6 @@ bool bio_attempt_discard_merge(struct request_queue *q, struct request *req,
  * Caller must ensure !blk_queue_nomerges(q) beforehand.
  */
 bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
-			    unsigned int *request_count,
 			    struct request **same_queue_rq)
 {
 	struct blk_plug *plug;
@@ -746,22 +745,19 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 	plug = current->plug;
 	if (!plug)
 		return false;
-	*request_count = 0;
 
 	plug_list = &plug->mq_list;
 
 	list_for_each_entry_reverse(rq, plug_list, queuelist) {
 		bool merged = false;
 
-		if (rq->q == q) {
-			(*request_count)++;
+		if (rq->q == q && same_queue_rq) {
 			/*
 			 * Only blk-mq multiple hardware queues case checks the
 			 * rq in the same queue, there should be only one such
 			 * rq in a queue
 			 **/
-			if (same_queue_rq)
-				*same_queue_rq = rq;
+			*same_queue_rq = rq;
 		}
 
 		if (rq->q != q || !blk_rq_merge_ok(rq, bio))
@@ -788,26 +784,6 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 	return false;
 }
 
-unsigned int blk_plug_queued_count(struct request_queue *q)
-{
-	struct blk_plug *plug;
-	struct request *rq;
-	struct list_head *plug_list;
-	unsigned int ret = 0;
-
-	plug = current->plug;
-	if (!plug)
-		goto out;
-
-	plug_list = &plug->mq_list;
-	list_for_each_entry(rq, plug_list, queuelist) {
-		if (rq->q == q)
-			ret++;
-	}
-out:
-	return ret;
-}
-
 void blk_init_request_from_bio(struct request *req, struct bio *bio)
 {
 	if (bio->bi_opf & REQ_RAHEAD)
@@ -1803,6 +1779,8 @@ void blk_start_plug(struct blk_plug *plug)
 
 	INIT_LIST_HEAD(&plug->mq_list);
 	INIT_LIST_HEAD(&plug->cb_list);
+	plug->rq_count = 0;
+
 	/*
 	 * Store ordering should not be needed here, since a potential
 	 * preempt will imply a full memory barrier
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 37674c1766a7..99c66823d52f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1676,6 +1676,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 	unsigned int depth;
 
 	list_splice_init(&plug->mq_list, &list);
+	plug->rq_count = 0;
 
 	list_sort(NULL, &list, plug_rq_cmp);
 
@@ -1872,7 +1873,6 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 	const int is_flush_fua = op_is_flush(bio->bi_opf);
 	struct blk_mq_alloc_data data = { .flags = 0, .cmd_flags = bio->bi_opf };
 	struct request *rq;
-	unsigned int request_count = 0;
 	struct blk_plug *plug;
 	struct request *same_queue_rq = NULL;
 	blk_qc_t cookie;
@@ -1885,7 +1885,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		return BLK_QC_T_NONE;
 
 	if (!is_flush_fua && !blk_queue_nomerges(q) &&
-	    blk_attempt_plug_merge(q, bio, &request_count, &same_queue_rq))
+	    blk_attempt_plug_merge(q, bio, &same_queue_rq))
 		return BLK_QC_T_NONE;
 
 	if (blk_mq_sched_bio_merge(q, bio))
@@ -1916,20 +1916,12 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		blk_insert_flush(rq);
 		blk_mq_run_hw_queue(data.hctx, true);
 	} else if (plug && q->nr_hw_queues == 1) {
+		unsigned int request_count = plug->rq_count;
 		struct request *last = NULL;
 
 		blk_mq_put_ctx(data.ctx);
 		blk_mq_bio_to_request(rq, bio);
 
-		/*
-		 * @request_count may become stale because of schedule
-		 * out, so check the list again.
-		 */
-		if (list_empty(&plug->mq_list))
-			request_count = 0;
-		else if (blk_queue_nomerges(q))
-			request_count = blk_plug_queued_count(q);
-
 		if (!request_count)
 			trace_block_plug(q);
 		else
@@ -1942,6 +1934,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		}
 
 		list_add_tail(&rq->queuelist, &plug->mq_list);
+		plug->rq_count++;
 	} else if (plug && !blk_queue_nomerges(q)) {
 		blk_mq_bio_to_request(rq, bio);
 
@@ -1957,6 +1950,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		if (same_queue_rq)
 			list_del_init(&same_queue_rq->queuelist);
 		list_add_tail(&rq->queuelist, &plug->mq_list);
+		plug->rq_count++;
 
 		blk_mq_put_ctx(data.ctx);
 
diff --git a/block/blk.h b/block/blk.h
index 610948157a5b..848278c52030 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -161,9 +161,7 @@ bool bio_attempt_back_merge(struct request_queue *q, struct request *req,
 bool bio_attempt_discard_merge(struct request_queue *q, struct request *req,
 		struct bio *bio);
 bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
-			    unsigned int *request_count,
 			    struct request **same_queue_rq);
-unsigned int blk_plug_queued_count(struct request_queue *q);
 
 void blk_account_io_start(struct request *req, bool new_io);
 void blk_account_io_completion(struct request *req, unsigned int bytes);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e3c0a8ec16a7..02732cae6080 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1130,6 +1130,7 @@ extern void blk_set_queue_dying(struct request_queue *);
 struct blk_plug {
 	struct list_head mq_list; /* blk-mq requests */
 	struct list_head cb_list; /* md requires an unplug callback */
+	unsigned short rq_count;
 };
 #define BLK_MAX_REQUEST_COUNT 16
 #define BLK_PLUG_FLUSH_SIZE (128 * 1024)
-- 
2.17.1

