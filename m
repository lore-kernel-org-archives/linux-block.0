Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C615CC43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 13:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9DF2081B
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 13:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="IJQX8Mys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D9DF2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbeK2Ahg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 19:37:36 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39664 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbeK2Ahg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 19:37:36 -0500
Received: by mail-pg1-f194.google.com with SMTP id w6so9522824pgl.6
        for <linux-block@vger.kernel.org>; Wed, 28 Nov 2018 05:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RDuEkV9cJG9s5HziL1by9uzNwPApvJvo3ZMsm87/Itc=;
        b=IJQX8Mys4T7IMuka+dCfw0MCSLtBiW5vrOAlKHCAntto5uKLY766vJ1yVLCphtnprG
         WvvkEnztI9UMY7vSkXer9CidrZ3oagsSJoSOaajHa5ZRo/jEzzHhz7Vt0sDSvUMZdWhe
         ys/RY0LblMiyY5kZIVxvhI3bwoQPcR9iEiQkabGO332JJtVeo7Iibcg7VSf3E8qYKhtV
         TB3nqO9xza/T6HGM32uSmqKzvEAVD9ehjtkupDYXF47ezGKuirAaHBBDxPmRbRkawNQM
         lyeaEjvl26IrBNNPo0Wk4rMacFl0aD5+gfUw5ffg+kLDsrNyaYqZ0GxEGphLAZyCSpim
         zGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RDuEkV9cJG9s5HziL1by9uzNwPApvJvo3ZMsm87/Itc=;
        b=DdVpb9W3wJI49N4DxUeIBSQK4n4K0Dc6U1COytKiM34DNBSr9mEUEYxgICq3CkTC5l
         8RhQ9HH/pcIHeGbe5Vg2q5MbGyzWNTm2KlU0SlKzLjtoiJCcuRkUiO7a4E8Kh8jYiE/3
         dicIX0CFqY4MZA3NX6Qw5WgA3tSo/q0L7X+zdEFCKRDYAJedP8wM2gI8jBrSPFGb94aX
         uMCpdRAoTDk4l8P6NWaEoXXP7A34u4sRWFMP1+O1EahuU+R/xrWwbqHtj/xvHTdyOz6E
         1AkxchMUd1TuYlImpdK2jxP86riyek9OzcFlqb6HZq/dKlWdhXnCXl5hzwCKkBvzzhkq
         kGrA==
X-Gm-Message-State: AA+aEWbFKeB/hdfoQJV/8fFSF4GCUAs3YO7xu2mBw1esmDjoiKD9TAnU
        qgmuIwa0kERoJo4bdqE9kCly/K4MozQ=
X-Google-Smtp-Source: AFSGD/X5WVSoGN3vMHHrPXuJ+ByB3PLcXddVOv3BuArSHxk9nLZHH01DD8xvrllXpqAgOhqVHSv+bw==
X-Received: by 2002:a62:1f53:: with SMTP id f80mr1323093pff.92.1543412154580;
        Wed, 28 Nov 2018 05:35:54 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id q75sm4744925pfa.38.2018.11.28.05.35.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 05:35:53 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6/7] blk-mq: use bd->last == true for list inserts
Date:   Wed, 28 Nov 2018 06:35:37 -0700
Message-Id: <20181128133538.20329-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181128133538.20329-1-axboe@kernel.dk>
References: <20181128133538.20329-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we are issuing a list of requests, we know if we're at the last one.
If we fail issuing, ensure that we call ->commits_rqs() to flush any
potential previous requests.

Reviewed-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c |  2 +-
 block/blk-mq.c   | 16 ++++++++--------
 block/blk-mq.h   |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d107d016b92b..3f6f5e6c2fe4 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1334,7 +1334,7 @@ blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *
 	 * bypass a potential scheduler on the bottom device for
 	 * insert.
 	 */
-	return blk_mq_request_issue_directly(rq);
+	return blk_mq_request_issue_directly(rq, true);
 }
 EXPORT_SYMBOL_GPL(blk_insert_cloned_request);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 18ff47a85ad3..9e1045152e45 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1743,12 +1743,12 @@ static blk_qc_t request_to_qc_t(struct blk_mq_hw_ctx *hctx, struct request *rq)
 
 static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 					    struct request *rq,
-					    blk_qc_t *cookie)
+					    blk_qc_t *cookie, bool last)
 {
 	struct request_queue *q = rq->q;
 	struct blk_mq_queue_data bd = {
 		.rq = rq,
-		.last = true,
+		.last = last,
 	};
 	blk_qc_t new_cookie;
 	blk_status_t ret;
@@ -1783,7 +1783,7 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 						struct request *rq,
 						blk_qc_t *cookie,
-						bool bypass_insert)
+						bool bypass_insert, bool last)
 {
 	struct request_queue *q = rq->q;
 	bool run_queue = true;
@@ -1812,7 +1812,7 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 		goto insert;
 	}
 
-	return __blk_mq_issue_directly(hctx, rq, cookie);
+	return __blk_mq_issue_directly(hctx, rq, cookie, last);
 insert:
 	if (bypass_insert)
 		return BLK_STS_RESOURCE;
@@ -1831,7 +1831,7 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 
 	hctx_lock(hctx, &srcu_idx);
 
-	ret = __blk_mq_try_issue_directly(hctx, rq, cookie, false);
+	ret = __blk_mq_try_issue_directly(hctx, rq, cookie, false, true);
 	if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE)
 		blk_mq_sched_insert_request(rq, false, true, false);
 	else if (ret != BLK_STS_OK)
@@ -1840,7 +1840,7 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	hctx_unlock(hctx, srcu_idx);
 }
 
-blk_status_t blk_mq_request_issue_directly(struct request *rq)
+blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
 {
 	blk_status_t ret;
 	int srcu_idx;
@@ -1848,7 +1848,7 @@ blk_status_t blk_mq_request_issue_directly(struct request *rq)
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
 	hctx_lock(hctx, &srcu_idx);
-	ret = __blk_mq_try_issue_directly(hctx, rq, &unused_cookie, true);
+	ret = __blk_mq_try_issue_directly(hctx, rq, &unused_cookie, true, last);
 	hctx_unlock(hctx, srcu_idx);
 
 	return ret;
@@ -1863,7 +1863,7 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 				queuelist);
 
 		list_del_init(&rq->queuelist);
-		ret = blk_mq_request_issue_directly(rq);
+		ret = blk_mq_request_issue_directly(rq, list_empty(list));
 		if (ret != BLK_STS_OK) {
 			if (ret == BLK_STS_RESOURCE ||
 					ret == BLK_STS_DEV_RESOURCE) {
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 9ae8e9f8f8b1..7291e5379358 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -69,7 +69,7 @@ void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 				struct list_head *list);
 
 /* Used by blk_insert_cloned_request() to issue request directly */
-blk_status_t blk_mq_request_issue_directly(struct request *rq);
+blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last);
 void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 				    struct list_head *list);
 
-- 
2.17.1

