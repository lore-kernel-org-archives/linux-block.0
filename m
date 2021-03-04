Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC21AC4332D
	for <linux-block@archiver.kernel.org>; Thu,  4 Mar 2021 17:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDFBE64F57
	for <linux-block@archiver.kernel.org>; Thu,  4 Mar 2021 17:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239477AbhCDRq5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Mar 2021 12:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239475AbhCDRqL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Mar 2021 12:46:11 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8DEC0613E1
        for <linux-block@vger.kernel.org>; Thu,  4 Mar 2021 09:45:30 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id i9so8853445wml.0
        for <linux-block@vger.kernel.org>; Thu, 04 Mar 2021 09:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CpdNy3aVzBPLz4zskOuLUeTUqeMtI64LdXSnJTLPY1g=;
        b=GPkvXnFiKfBcww25//CHtxNQHCRJwuNcosNdpu4fIPtjSdJsiRTpdfPS7OdamfBEO5
         JbNRTznkyntl0F3NmCUPktJDKDXVvjv9892sOs8/9WUntPeef64/XAe82HKosaoJeWQR
         fPUZq94AX1RrLkujTJYL39lQGKoSYJGymoYluRIrOASVQNI22kv9UKU2TBCIEXSrYvfM
         nWq5UcU+IuoxseNVq908TpzcsaAOf/4+QhhnVWjbOOGzIvLE2VJcYknpJEZ81CTWr0Ja
         3PGkLPHvHccJgxaPZ2sAMUlIIf4t29n/B8oKSZxuZ3bYirE2NafJd+EJ4rFyTOSTqGmP
         yPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CpdNy3aVzBPLz4zskOuLUeTUqeMtI64LdXSnJTLPY1g=;
        b=dUNDs37MNqZS3fo25H4mZDrhrRX2+8IviosGUX38wzN3uYbYKMFO4WAn7GfFKCr/aF
         E5cnCMcDDL+fRlgBS79FZbP2s/XvFB+3CHsAJr83dvBvj1Bs3lM8w3SAbbmePe2ES83E
         Dhu2rY2JKdBnZNrH4lE7iYdDpLCn5S+2cGGO8PvWb/HOc4Y9i8YOCI2o7cC7ZxghPEA1
         kzXNPXM+5MJ7+WRdY/m4nzkDDALH3KlJxLxsgJKLTrZ6vRB18R8jBNRpPfHjKzZLNJoG
         9/IgT8WKuR6UZZDal9onlrLvZdaPhQusn6QwFcgcQq1/nH8ejONvr32ZQp8OPKQRC5lz
         rW+Q==
X-Gm-Message-State: AOAM532Ql143ntASWqBgkSsXvBoPSNqHqGiCyEvC9jea+4gw221XrbLE
        iYP1PRaGB37y9/EElRhQkhUguQ==
X-Google-Smtp-Source: ABdhPJyJD+YF0j69T7Vwu87133tqy5JdmSjbivAHfFXRLXHtYkNix+8sy7MhVcPQIAlga48QsZSKDw==
X-Received: by 2002:a7b:c4c9:: with SMTP id g9mr5180733wmk.82.1614879929196;
        Thu, 04 Mar 2021 09:45:29 -0800 (PST)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id a21sm271023wmb.5.2021.03.04.09.45.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Mar 2021 09:45:28 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH BUGFIX/IMPROVEMENT V2 3/6] block, bfq: make shared queues inherit wakers
Date:   Thu,  4 Mar 2021 18:46:24 +0100
Message-Id: <20210304174627.161-4-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210304174627.161-1-paolo.valente@linaro.org>
References: <20210304174627.161-1-paolo.valente@linaro.org>
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
index a9c1a14b64f4..4b3d4849f3f5 100644
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
@@ -6303,7 +6326,7 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 	if (likely(!new_queue)) {
 		/* If the queue was seeky for too long, break it apart. */
 		if (bfq_bfqq_coop(bfqq) && bfq_bfqq_split_coop(bfqq)) {
-			bfq_log_bfqq(bfqd, bfqq, "breaking apart bfqq");
+			struct bfq_queue *old_bfqq = bfqq;
 
 			/* Update bic before losing reference to bfqq */
 			if (bfq_bfqq_in_large_burst(bfqq))
@@ -6312,11 +6335,24 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
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

