Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713C9C4338F
	for <linux-block@archiver.kernel.org>; Mon,  2 Aug 2021 14:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5969060F36
	for <linux-block@archiver.kernel.org>; Mon,  2 Aug 2021 14:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235783AbhHBOXc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Aug 2021 10:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235537AbhHBOX3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Aug 2021 10:23:29 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27010C077214
        for <linux-block@vger.kernel.org>; Mon,  2 Aug 2021 07:14:14 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id o5so31162862ejy.2
        for <linux-block@vger.kernel.org>; Mon, 02 Aug 2021 07:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/DfJGvKPYs2b4GFALQdTSuGeCIFT4Xl1aMZnLTgiRN4=;
        b=qlX4S5b+mRMzYVQec489RdIHfebNI0B/eaB18FCdvGZtAYdvGFmRuCAhY/JOCnA79p
         P6IV6L0Sks49L1XjLwokhjwgtg394puloBpe4HHpsaMa7pIsi1HWbx9RuPU5WyyqIAmM
         2nY9yOja6nvYZp1QnxF+du574QlTJU3GqSvXM2jIrRdI+4w46fKfxbkkpxdQf/E5DyuB
         SP6YO9D66AXd5VJWIBGE/kY9Yf2OiXzyYO+wKf+r/FpGAjr0vkaFHsGxg7PeWNBg6Nnk
         kuaHx7TRzx4BKj5I5cqfob6FYfQzmYRe9PDVYbd56ZHo37X4MBOe5ohlTNWkBWhoPAJm
         0Qrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/DfJGvKPYs2b4GFALQdTSuGeCIFT4Xl1aMZnLTgiRN4=;
        b=Zle5KnxiOo8WmeMnuccmJrd/DnDpbeIzgAPWGqIZoRjGgX6JBlgFrjQpC+XOv17EB/
         7cFYhfXf440XBpfayFC/9S3FPxla1ldOeMSrEZo1pEQ4mgMjzil7Q90VfHpOxGRm5L7m
         KMGqPibTf9rhBfY+sVJTYWPAzzbB/1W5qDe456pxjXkUmUgsYGAO78QX8cFFi5iaM6gN
         bIra8QV2QgizyFvhjA2aos78ACTTA3quNoT8Okk0lOV1e0l57yyW91i841q/L/zI3ft6
         TjMixg+56R4ZHlnkd+6zdmQ2tizBNdOMQXqk4KT8Ii2j4J1CP7l7SBKuQ0uS0DH2PBot
         GLmg==
X-Gm-Message-State: AOAM532/se8CgjTIo78FaQEWfvoDWx8B+xDwfPKN5BgSLoC2S33mP2at
        pmLcqQ5ND4CF3St6wT0lURVyX8GV2A7gUSvd
X-Google-Smtp-Source: ABdhPJxhG992fKUAdukWXFACHaZ29/sa9RaqRE26tbJ6qTIHGc+2iQOaLfhKSAbY8359zAx+6Pa67g==
X-Received: by 2002:a17:906:c20d:: with SMTP id d13mr15236738ejz.259.1627913652690;
        Mon, 02 Aug 2021 07:14:12 -0700 (PDT)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id o3sm6084403edt.61.2021.08.02.07.14.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Aug 2021 07:14:12 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        davidezini2@gmail.com, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX 1/1] block, bfq: honor already-setup queue merges
Date:   Mon,  2 Aug 2021 16:13:52 +0200
Message-Id: <20210802141352.74353-2-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210802141352.74353-1-paolo.valente@linaro.org>
References: <20210802141352.74353-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The function bfq_setup_merge prepares the merging between two
bfq_queues, say bfqq and new_bfqq. To this goal, it assigns
bfqq->new_bfqq = new_bfqq. Then, each time some I/O for bfqq arrives,
the process that generated that I/O is disassociated from bfqq and
associated with new_bfqq (merging is actually a redirection). In this
respect, bfq_setup_merge increases new_bfqq->ref in advance, adding
the number of processes that are expected to be associated with
new_bfqq.

Unfortunately, the stable-merging mechanism interferes with this
setup. After bfqq->new_bfqq has been set by bfq_setup_merge, and
before all the expected processes have been associated with
bfqq->new_bfqq, bfqq may happen to be stably merged with a different
queue than the current bfqq->new_bfqq. In this case, bfqq->new_bfqq
gets changed. So, some of the processes that have been already
accounted for in the ref counter of the previous new_bfqq will not be
associated with that queue.  This creates an unbalance, because those
references will never be decremented.

This commit fixes this issue by reestablishing the previous, natural
behaviour: once bfqq->new_bfqq has been set, it will not be changed
until all expected redirections have occurred.

Signed-off-by: Davide Zini <davidezini2@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 727955918563..08d9122dd4c0 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2659,6 +2659,15 @@ bfq_setup_merge(struct bfq_queue *bfqq, struct bfq_queue *new_bfqq)
 	 * are likely to increase the throughput.
 	 */
 	bfqq->new_bfqq = new_bfqq;
+	/*
+	 * The above assignment schedules the following redirections:
+	 * each time some I/O for bfqq arrives, the process that
+	 * generated that I/O is disassociated from bfqq and
+	 * associated with new_bfqq. Here we increases new_bfqq->ref
+	 * in advance, adding the number of processes that are
+	 * expected to be associated with new_bfqq as they happen to
+	 * issue I/O.
+	 */
 	new_bfqq->ref += process_refs;
 	return new_bfqq;
 }
@@ -2721,6 +2730,10 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 {
 	struct bfq_queue *in_service_bfqq, *new_bfqq;
 
+	/* if a merge has already been setup, then proceed with that first */
+	if (bfqq->new_bfqq)
+		return bfqq->new_bfqq;
+
 	/*
 	 * Check delayed stable merge for rotational or non-queueing
 	 * devs. For this branch to be executed, bfqq must not be
@@ -2822,9 +2835,6 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	if (bfq_too_late_for_merging(bfqq))
 		return NULL;
 
-	if (bfqq->new_bfqq)
-		return bfqq->new_bfqq;
-
 	if (!io_struct || unlikely(bfqq == &bfqd->oom_bfqq))
 		return NULL;
 
-- 
2.20.1

