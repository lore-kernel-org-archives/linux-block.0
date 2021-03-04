Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75B3C43381
	for <linux-block@archiver.kernel.org>; Thu,  4 Mar 2021 17:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D72D64F4C
	for <linux-block@archiver.kernel.org>; Thu,  4 Mar 2021 17:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239875AbhCDRqz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Mar 2021 12:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239480AbhCDRqL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Mar 2021 12:46:11 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4B8C0613DD
        for <linux-block@vger.kernel.org>; Thu,  4 Mar 2021 09:45:27 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m7so2177135wmq.0
        for <linux-block@vger.kernel.org>; Thu, 04 Mar 2021 09:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kPe9/bC+fapDM9TyJPKrxL534jOiWcGHIwwJRVky7EU=;
        b=VJr7P5uBLKuYY1rMRD3JFi+li8ZpAK972sPQIW7fAMqv4MBC5pLyZV4PEPH7KNTFd/
         P8h2sFnz8YRjppTiHtUhoUDKq8mdCwkfJnoXoxmEGGzE9jZOYywEWkHrQAMnTxE9IMNo
         LL5/2jJxWH0u/sdzVdndhW9UeCKSXDen7KuiTWGLZ7nn8dLOjm002rgO3AZLVevCBsud
         gc76V9VWspuARIl3tfAM/NoQ8/xz73xvoeHyA8hURhHU51i2Jnzp23Iw0xSlHODilsyi
         rwgU5INYVb7xAXsRm4cbFByt/57YLxHq5V7BGEUFYfVAPHB+MTU9dojAYnbqy9TZKeGQ
         /WSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kPe9/bC+fapDM9TyJPKrxL534jOiWcGHIwwJRVky7EU=;
        b=Lof6L9wemEH7oNhk6sd6+Qk+4tfnKotvc27LqRtP8RVo/bYl/LPcdtT2QuwdujGTcm
         HTE6vJ5FewC5hV8q4oMxf0VnuSH6HfUU1HvBj2xCIoO13SA0qTLpRk7KnOOSYMkJw6Pq
         UMr0QCBItSvtq7bFSn6DyCP/cjdHi6zl8pQAyhUEHB9Q9wcwdzItZTnJYvYyA8mJSaFM
         Xa5vU4azx90z8mYt3ji00lnaVLaSExBdz6sJ7Vw48mVj8Q5PSq7g+ldbUy8WTWHsou1g
         hDlci40HuITdB8SSCihXwzSYWe1rhjG93TY2yV38ojENxJYSWWJQtrayneSzKWzfc1zM
         CErw==
X-Gm-Message-State: AOAM531YrFJqBkGNmOzmEa4cwC8soLVb+jfW+kSQBMchyC85askcb8Fb
        QBqcvWmFLNqGUSUJGOaU2TmCVw==
X-Google-Smtp-Source: ABdhPJzwvhB5Zw+ULJWGpHtkDNXZUeVZWjNivjUYgxFJC35EZUg0yBfGSvjjkNlV7bsYqEJNzd13cg==
X-Received: by 2002:a1c:f312:: with SMTP id q18mr5012386wmq.79.1614879926349;
        Thu, 04 Mar 2021 09:45:26 -0800 (PST)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id a21sm271023wmb.5.2021.03.04.09.45.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Mar 2021 09:45:25 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH BUGFIX/IMPROVEMENT V2 1/6] block, bfq: always inject I/O of queues blocked by wakers
Date:   Thu,  4 Mar 2021 18:46:22 +0100
Message-Id: <20210304174627.161-2-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210304174627.161-1-paolo.valente@linaro.org>
References: <20210304174627.161-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Suppose that I/O dispatch is plugged, to wait for new I/O for the
in-service bfq-queue, say bfqq.  Suppose then that there is a further
bfq_queue woken by bfqq, and that this woken queue has pending I/O. A
woken queue does not steal bandwidth from bfqq, because it remains
soon without I/O if bfqq is not served. So there is virtually no risk
of loss of bandwidth for bfqq if this woken queue has I/O dispatched
while bfqq is waiting for new I/O. In contrast, this extra I/O
injection boosts throughput. This commit performs this extra
injection.

Tested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 32 +++++++++++++++++++++++++++-----
 block/bfq-wf2q.c    |  8 ++++++++
 2 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 445cef9c0bb9..a83149407336 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4487,9 +4487,15 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
 			bfq_bfqq_busy(bfqq->bic->bfqq[0]) &&
 			bfqq->bic->bfqq[0]->next_rq ?
 			bfqq->bic->bfqq[0] : NULL;
+		struct bfq_queue *blocked_bfqq =
+			!hlist_empty(&bfqq->woken_list) ?
+			container_of(bfqq->woken_list.first,
+				     struct bfq_queue,
+				     woken_list_node)
+			: NULL;
 
 		/*
-		 * The next three mutually-exclusive ifs decide
+		 * The next four mutually-exclusive ifs decide
 		 * whether to try injection, and choose the queue to
 		 * pick an I/O request from.
 		 *
@@ -4522,7 +4528,15 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
 		 * next bfqq's I/O is brought forward dramatically,
 		 * for it is not blocked for milliseconds.
 		 *
-		 * The third if checks whether bfqq is a queue for
+		 * The third if checks whether there is a queue woken
+		 * by bfqq, and currently with pending I/O. Such a
+		 * woken queue does not steal bandwidth from bfqq,
+		 * because it remains soon without I/O if bfqq is not
+		 * served. So there is virtually no risk of loss of
+		 * bandwidth for bfqq if this woken queue has I/O
+		 * dispatched while bfqq is waiting for new I/O.
+		 *
+		 * The fourth if checks whether bfqq is a queue for
 		 * which it is better to avoid injection. It is so if
 		 * bfqq delivers more throughput when served without
 		 * any further I/O from other queues in the middle, or
@@ -4542,11 +4556,11 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
 		 * bfq_update_has_short_ttime(), it is rather likely
 		 * that, if I/O is being plugged for bfqq and the
 		 * waker queue has pending I/O requests that are
-		 * blocking bfqq's I/O, then the third alternative
+		 * blocking bfqq's I/O, then the fourth alternative
 		 * above lets the waker queue get served before the
 		 * I/O-plugging timeout fires. So one may deem the
 		 * second alternative superfluous. It is not, because
-		 * the third alternative may be way less effective in
+		 * the fourth alternative may be way less effective in
 		 * case of a synchronization. For two main
 		 * reasons. First, throughput may be low because the
 		 * inject limit may be too low to guarantee the same
@@ -4555,7 +4569,7 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
 		 * guarantees (the second alternative unconditionally
 		 * injects a pending I/O request of the waker queue
 		 * for each bfq_dispatch_request()). Second, with the
-		 * third alternative, the duration of the plugging,
+		 * fourth alternative, the duration of the plugging,
 		 * i.e., the time before bfqq finally receives new I/O,
 		 * may not be minimized, because the waker queue may
 		 * happen to be served only after other queues.
@@ -4573,6 +4587,14 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
 			   bfq_bfqq_budget_left(bfqq->waker_bfqq)
 			)
 			bfqq = bfqq->waker_bfqq;
+		else if (blocked_bfqq &&
+			   bfq_bfqq_busy(blocked_bfqq) &&
+			   blocked_bfqq->next_rq &&
+			   bfq_serv_to_charge(blocked_bfqq->next_rq,
+					      blocked_bfqq) <=
+			   bfq_bfqq_budget_left(blocked_bfqq)
+			)
+			bfqq = blocked_bfqq;
 		else if (!idling_boosts_thr_without_issues(bfqd, bfqq) &&
 			 (bfqq->wr_coeff == 1 || bfqd->wr_busy_queues > 1 ||
 			  !bfq_bfqq_has_short_ttime(bfqq)))
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 26776bdbdf36..02e59931d897 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -1709,4 +1709,12 @@ void bfq_add_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 
 	if (bfqq->wr_coeff > 1)
 		bfqd->wr_busy_queues++;
+
+	/* Move bfqq to the head of the woken list of its waker */
+	if (!hlist_unhashed(&bfqq->woken_list_node) &&
+	    &bfqq->woken_list_node != bfqq->waker_bfqq->woken_list.first) {
+		hlist_del_init(&bfqq->woken_list_node);
+		hlist_add_head(&bfqq->woken_list_node,
+			       &bfqq->waker_bfqq->woken_list);
+	}
 }
-- 
2.20.1

