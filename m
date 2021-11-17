Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E40C433EF
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 03:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D259661BE1
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 03:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhKQDlK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Nov 2021 22:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbhKQDlJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Nov 2021 22:41:09 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EFDC061570
        for <linux-block@vger.kernel.org>; Tue, 16 Nov 2021 19:38:12 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id k22so1255878iol.13
        for <linux-block@vger.kernel.org>; Tue, 16 Nov 2021 19:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3CAui2JMitf1Xwb6TPXFbbW7kvaykln1ulpIaFQ2nLM=;
        b=Y5WGtLQxH2C0dni/BwVp7cYSTyYyohZ5DmlM12NpOdda0naLnwDTgU+H6vygFr1pri
         lc1kowFbPAzW0nDgJvvYV6s6QR2wYRlWdLfE5VJZmVoljnoy6jCSRgCkbiqCviAP23NZ
         gwvSldVPzfD3quCAFvyz4JkBzerN2MzMCayUjSguqo5f3bQOdExGfQpBzEANhfHibg2Q
         lLCpBSidzlBEcDtbLcd+ff2b6vCnjCtG9rovhxNXSR7dalqRxVd0/163YFYdnea4g714
         v7lRgP0mjSRJsKvA4uljvSd99C5CHohcfz3E+Yb38x70PIu0dqQRCjpmaIeUQPBm1vXa
         ukaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3CAui2JMitf1Xwb6TPXFbbW7kvaykln1ulpIaFQ2nLM=;
        b=5TOK8kDtcYK9OxMtYB5YOuLfsOeJDaOf4yjdkupHHZAbt9E9NUDtjx2M3gRFuPa2bA
         IYxHc/vhX9ChsBLjLAZehMXC0RejOuvSDwXtSzp67srSIHqtMVnxl50Yf1sTGpHHtrd3
         5OYU8OADf4+qy7xCzruBU2xRI1XMatKRvrlvuwzhiBP6A9OOkGFhgx6kGUWEHaie6Rx/
         uzfxYP4Vs6WWo9mglBxfvhupihyxYCcyqpCxdYW451P2xdEZSs0CYVnm4WSSIoE1K6xO
         4abT3MQLFjETawpRIg7DL3mm1nqPou0eHuKthTsP/IqWseQYqRGtK3x9GN18IqhBZ6O7
         VL5A==
X-Gm-Message-State: AOAM531KAUdpbovToi0DO/tRYSVskkLKjjM4sAf7tzbg0aZ6TkhyZ/HO
        9IxPFBvQUNZYdZJdyz4LFxYdUcFKQD4nB3zv
X-Google-Smtp-Source: ABdhPJwebyYKedlR+7B02BArNNq+dvUyBW9K/OXHNzZBKNMrJ9/h0poDWD81bXLbP+khNGWzi++u5g==
X-Received: by 2002:a05:6602:328a:: with SMTP id d10mr8670131ioz.175.1637120291220;
        Tue, 16 Nov 2021 19:38:11 -0800 (PST)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id l13sm12563693ios.49.2021.11.16.19.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 19:38:10 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     hch@infradead.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/4] block: add mq_ops->queue_rqs hook
Date:   Tue, 16 Nov 2021 20:38:04 -0700
Message-Id: <20211117033807.185715-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211117033807.185715-1-axboe@kernel.dk>
References: <20211117033807.185715-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we have a list of requests in our plug list, send it to the driver in
one go, if possible. The driver must set mq_ops->queue_rqs() to support
this, if not the usual one-by-one path is used.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c         | 17 +++++++++++++++++
 include/linux/blk-mq.h |  8 ++++++++
 2 files changed, 25 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9b4e79e2ac1e..005715206b16 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2208,6 +2208,19 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
 	int queued = 0;
 	int errors = 0;
 
+	/*
+	 * Peek first request and see if we have a ->queue_rqs() hook. If we
+	 * do, we can dispatch the whole plug list in one go. We already know
+	 * at this point that all requests belong to the same queue, caller
+	 * must ensure that's the case.
+	 */
+	rq = rq_list_peek(&plug->mq_list);
+	if (rq->q->mq_ops->queue_rqs) {
+		rq->q->mq_ops->queue_rqs(&plug->mq_list);
+		if (rq_list_empty(plug->mq_list))
+			return;
+	}
+
 	while ((rq = rq_list_pop(&plug->mq_list))) {
 		bool last = rq_list_empty(plug->mq_list);
 		blk_status_t ret;
@@ -2256,6 +2269,10 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 
 	if (!plug->multiple_queues && !plug->has_elevator && !from_schedule) {
 		blk_mq_plug_issue_direct(plug, false);
+		/*
+		 * Expected case, all requests got dispatched. If not, fall
+		 * through to individual dispatch of the remainder.
+		 */
 		if (rq_list_empty(plug->mq_list))
 			return;
 	}
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 3ba1e750067b..897cf475e7eb 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -503,6 +503,14 @@ struct blk_mq_ops {
 	 */
 	void (*commit_rqs)(struct blk_mq_hw_ctx *);
 
+	/**
+	 * @queue_rqs: Queue a list of new requests. Driver is guaranteed
+	 * that each request belongs to the same queue. If the driver doesn't
+	 * empty the @rqlist completely, then the rest will be queued
+	 * individually by the block layer upon return.
+	 */
+	void (*queue_rqs)(struct request **rqlist);
+
 	/**
 	 * @get_budget: Reserve budget before queue request, once .queue_rq is
 	 * run, it is driver's responsibility to release the
-- 
2.33.1

