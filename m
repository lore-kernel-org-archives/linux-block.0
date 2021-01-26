Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD30C433E0
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 10:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ED9E23109
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 10:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404468AbhAZKwe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 05:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404476AbhAZKwc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jan 2021 05:52:32 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4569C06178B
        for <linux-block@vger.kernel.org>; Tue, 26 Jan 2021 02:51:22 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h9so5687038wrr.9
        for <linux-block@vger.kernel.org>; Tue, 26 Jan 2021 02:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t86iMQKIqsS0m2aCrWu55vo8IS053fSBSrJitc0MorY=;
        b=o7mD/KjydYdHiZ0EaOi+To5IHQ2Tr3u1GFOjlqb57h46hhwlQI9CbkB+zdYmqK0C2A
         Ndn6MZHrdqMvjJA6yFwjCnRuyvQwx9uNrzKIlYIDbSayT6cahYF7zn/w3ixc9SmG7gMl
         O3kiZStPme9n68UyflaMzQ4Xtl4Qm4+h/cYBUnT1AjEHGaodBv1V18nFA8qmsTCuYICd
         us2Y1L2Mk9j9mCuN8LCYzBCBfL4jGL1Gp0hNs/7S9LFU08Pjz4MJhVT/D6FtmDgTPiMR
         c96mheNENcTGjtOYLmjONbjVreusfNQ/oeFotn42jd7TwDAWKkSVEqLGyJW/raAvT4Ab
         a1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t86iMQKIqsS0m2aCrWu55vo8IS053fSBSrJitc0MorY=;
        b=BPWmSA7lptIZkyYjviqNrZmH1LCjzlJVN2ZBB4LiKFtJYqHNXJ/bcH6Picn83rR3L9
         9AmGYKqtA3TNETj3R39moFr2YzJz0FC8vIK22HUN+5zjJ44F0BimpwnELt0NGQyWfmpn
         lqSwHKUvtrlMrf4R08977k9+expdH25wE6DeEeKAj09UP/UAGsvMPcDiSteOKbBmXSFz
         6yh7AwV2kkB1NhLmXt0Vo7MUCqKoRK5k4197m1z/O0yBAvXozcfWR1j0dH2EnlWjpFA6
         RN+hK+xw1jF/3f474yA48zKD71jTim6SUzRB2Im74/krkf8AGFreYbGz11inL4tyw0cK
         5CtQ==
X-Gm-Message-State: AOAM533lY3emY60L5APnyNE1pXzyYN4nf9eg3ZgE71vDzH7krrPY53w3
        UpgZPOQhwYeowtHDqIvEIe5sng==
X-Google-Smtp-Source: ABdhPJyTqVADEw9M3IHNU0FlSb0fH6q1RWNU4RKVai0zsh9bNEHZ4TfAJv6yPLjuOy5tjfaM/4Uofw==
X-Received: by 2002:adf:80c3:: with SMTP id 61mr4963946wrl.100.1611658281280;
        Tue, 26 Jan 2021 02:51:21 -0800 (PST)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id h18sm7177879wru.65.2021.01.26.02.51.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jan 2021 02:51:20 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH BUGFIX/IMPROVEMENT 3/6] block, bfq: make shared queues inherit wakers
Date:   Tue, 26 Jan 2021 11:50:59 +0100
Message-Id: <20210126105102.53102-4-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210126105102.53102-1-paolo.valente@linaro.org>
References: <20210126105102.53102-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Consider a bfq_queue bfqq that is about to be merged with another
bfq_queue new_bfqq. The processes associated with bfqq are cooperators
of the processes associated with new_bfqq. So, if bfqq has a waker,
then it is reasonable (and beneficial for throughput) to assume that
all these processes will be happy to let bfqq's waker freely inject
I/O when they have no I/O. So this commit makes new_bfqq inherit
bfqq's waker.

Tested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 42 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index e5b83910fbe0..c5bda33c0923 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2819,6 +2819,29 @@ bfq_merge_bfqqs(struct bfq_data *bfqd, struct bfq_io_cq *bic,
 		bfq_mark_bfqq_IO_bound(new_bfqq);
 	bfq_clear_bfqq_IO_bound(bfqq);
 
+	/*
+	 * The processes associated with bfqq are cooperators of the
+	 * processes associated with new_bfqq. So, if bfqq has a
+	 * waker, then assume that all these processes will be happy
+	 * to let bfqq's waker freely inject I/O when they have no
+	 * I/O.
+	 */
+	if (bfqq->waker_bfqq && !new_bfqq->waker_bfqq &&
+	    bfqq->waker_bfqq != new_bfqq) {
+		new_bfqq->waker_bfqq = bfqq->waker_bfqq;
+		new_bfqq->tentative_waker_bfqq = NULL;
+
+		/*
+		 * If the waker queue disappears, then
+		 * new_bfqq->waker_bfqq must be reset. So insert
+		 * new_bfqq into the woken_list of the waker. See
+		 * bfq_check_waker for details.
+		 */
+		hlist_add_head(&new_bfqq->woken_list_node,
+			       &new_bfqq->waker_bfqq->woken_list);
+
+	}
+
 	/*
 	 * If bfqq is weight-raised, then let new_bfqq inherit
 	 * weight-raising. To reduce false positives, neglect the case
@@ -6276,7 +6299,7 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 	if (likely(!new_queue)) {
 		/* If the queue was seeky for too long, break it apart. */
 		if (bfq_bfqq_coop(bfqq) && bfq_bfqq_split_coop(bfqq)) {
-			bfq_log_bfqq(bfqd, bfqq, "breaking apart bfqq");
+			struct bfq_queue *old_bfqq = bfqq;
 
 			/* Update bic before losing reference to bfqq */
 			if (bfq_bfqq_in_large_burst(bfqq))
@@ -6285,11 +6308,24 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 			bfqq = bfq_split_bfqq(bic, bfqq);
 			split = true;
 
-			if (!bfqq)
+			if (!bfqq) {
 				bfqq = bfq_get_bfqq_handle_split(bfqd, bic, bio,
 								 true, is_sync,
 								 NULL);
-			else
+				bfqq->waker_bfqq = old_bfqq->waker_bfqq;
+				bfqq->tentative_waker_bfqq = NULL;
+
+				/*
+				 * If the waker queue disappears, then
+				 * new_bfqq->waker_bfqq must be
+				 * reset. So insert new_bfqq into the
+				 * woken_list of the waker. See
+				 * bfq_check_waker for details.
+				 */
+				if (bfqq->waker_bfqq)
+					hlist_add_head(&bfqq->woken_list_node,
+						       &bfqq->waker_bfqq->woken_list);
+			} else
 				bfqq_already_existing = true;
 		}
 	}
-- 
2.20.1

