Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F157C43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F8E420855
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="u92aavNB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F8E420855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbeK0Day (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:30:54 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:45362 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbeK0Day (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 22:30:54 -0500
Received: by mail-io1-f67.google.com with SMTP id w7so14430703iom.12
        for <linux-block@vger.kernel.org>; Mon, 26 Nov 2018 08:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rqs+kcz4289Ghf5rqO8+g1izjb6etgUeESUQoGcKqu8=;
        b=u92aavNBLoOy1UkOEPDZw/jyK2q+4Gc4EQPqfb7sg9dQPJSeBeG9K9hQe2bNRlxC1s
         huykcWFTsWkXAgnU0moFJVbIalMKX3seyjy0LFUgXJfpULtLzytt43YniRYzXUuo5CSK
         2zEDfF7OCm7cJaA8d8R/1huLpZRZgEkO3vdPlnxq1rmueo2Rec6Wp6FcEfWDsU+N6Ee6
         jFhug5WgRPVnEs5gA8fYjcM8HVTrKjLoWa2AIRjfPK0cOvxYO0rPPwysmEWWC2E2hPLm
         BPJOiq9OnOjWltLwlC4YDeHScHbCU6RHdrirBppKImIzM0pNAS3S0Z0WuocSo1XEJLmn
         y6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rqs+kcz4289Ghf5rqO8+g1izjb6etgUeESUQoGcKqu8=;
        b=dRpaC0aSGj9n9ieuEz74D2FhtHe3sXquZAP/i5OcY5hRTXbUg+Gkgund9dtumLfKm9
         sM9RzM2brpLwxHdH8oBwu2M6iVCECtLOGns8vUbcaPoS3G9NAICeedMouuWKkun9wkhN
         tgUjg9FtHQAucVD7iCyEHa6coHB53P0pu7RMLD/aN/P2atmSACz9pJiMf5VYAT5Ku+Gb
         YXia59DHHMo62zn59dC7LQfwQaYgfN35VipzmyBFsO2nxI8NUkxPEscAzOTHGy4Y1M3y
         VMbQznoehycXkgU77i6zWPgD1wWBpPkChn9YeLTM0dKRoryzkfOAZPGZNa9Ox+trSHb3
         qAyQ==
X-Gm-Message-State: AA+aEWZHjJOKGbvByZ4AM0onjP9PIxUAABjFu343g4WI5cT4rmWPWWhc
        NguJrDLRhsmaCAwnwlfycxcnhiLoL4I=
X-Google-Smtp-Source: AFSGD/VcAq91nLKc3FPyvp+zfjJXLTEABcFOQKtReaeZQTcN3xKO/6q0znoccfU04cyf1jD6Vvc7gg==
X-Received: by 2002:a5e:9804:: with SMTP id s4mr18902345ioj.4.1543250175739;
        Mon, 26 Nov 2018 08:36:15 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id r11sm263717iog.46.2018.11.26.08.36.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 08:36:13 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 7/8] blk-mq: use bd->last == true for list inserts
Date:   Mon, 26 Nov 2018 09:35:55 -0700
Message-Id: <20181126163556.5181-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181126163556.5181-1-axboe@kernel.dk>
References: <20181126163556.5181-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we are issuing a list of requests, we know if we're at the last one.
If we fail issuing, ensure that we call ->commits_rqs() to flush any
potential previous requests.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c |  2 +-
 block/blk-mq.c   | 32 ++++++++++++++++++++++++--------
 block/blk-mq.h   |  2 +-
 3 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index c9758d185357..808a65d23f1a 100644
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
index 6a249bf6ed00..0a12cec0b426 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1260,6 +1260,14 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 	if (!list_empty(list)) {
 		bool needs_restart;
 
+		/*
+		 * If we didn't flush the entire list, we could have told
+		 * the driver there was more coming, but that turned out to
+		 * be a lie.
+		 */
+		if (q->mq_ops->commit_rqs)
+			q->mq_ops->commit_rqs(hctx);
+
 		spin_lock(&hctx->lock);
 		list_splice_init(list, &hctx->dispatch);
 		spin_unlock(&hctx->lock);
@@ -1736,12 +1744,12 @@ static blk_qc_t request_to_qc_t(struct blk_mq_hw_ctx *hctx, struct request *rq)
 
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
@@ -1776,7 +1784,7 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 						struct request *rq,
 						blk_qc_t *cookie,
-						bool bypass_insert)
+						bool bypass_insert, bool last)
 {
 	struct request_queue *q = rq->q;
 	bool run_queue = true;
@@ -1805,7 +1813,7 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 		goto insert;
 	}
 
-	return __blk_mq_issue_directly(hctx, rq, cookie);
+	return __blk_mq_issue_directly(hctx, rq, cookie, last);
 insert:
 	if (bypass_insert)
 		return BLK_STS_RESOURCE;
@@ -1824,7 +1832,7 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 
 	hctx_lock(hctx, &srcu_idx);
 
-	ret = __blk_mq_try_issue_directly(hctx, rq, cookie, false);
+	ret = __blk_mq_try_issue_directly(hctx, rq, cookie, false, true);
 	if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE)
 		blk_mq_sched_insert_request(rq, false, true, false);
 	else if (ret != BLK_STS_OK)
@@ -1833,7 +1841,7 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	hctx_unlock(hctx, srcu_idx);
 }
 
-blk_status_t blk_mq_request_issue_directly(struct request *rq)
+blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
 {
 	blk_status_t ret;
 	int srcu_idx;
@@ -1841,7 +1849,7 @@ blk_status_t blk_mq_request_issue_directly(struct request *rq)
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
 	hctx_lock(hctx, &srcu_idx);
-	ret = __blk_mq_try_issue_directly(hctx, rq, &unused_cookie, true);
+	ret = __blk_mq_try_issue_directly(hctx, rq, &unused_cookie, true, last);
 	hctx_unlock(hctx, srcu_idx);
 
 	return ret;
@@ -1856,7 +1864,7 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 				queuelist);
 
 		list_del_init(&rq->queuelist);
-		ret = blk_mq_request_issue_directly(rq);
+		ret = blk_mq_request_issue_directly(rq, list_empty(list));
 		if (ret != BLK_STS_OK) {
 			if (ret == BLK_STS_RESOURCE ||
 					ret == BLK_STS_DEV_RESOURCE) {
@@ -1866,6 +1874,14 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 			blk_mq_end_request(rq, ret);
 		}
 	}
+
+	/*
+	 * If we didn't flush the entire list, we could have told
+	 * the driver there was more coming, but that turned out to
+	 * be a lie.
+	 */
+	if (!list_empty(list) && hctx->queue->mq_ops->commit_rqs)
+		hctx->queue->mq_ops->commit_rqs(hctx);
 }
 
 static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
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

