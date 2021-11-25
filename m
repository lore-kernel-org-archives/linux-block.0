Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B295C433FE
	for <linux-block@archiver.kernel.org>; Thu, 25 Nov 2021 13:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350118AbhKYNmE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Nov 2021 08:42:04 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:58084 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355125AbhKYNkB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Nov 2021 08:40:01 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 26DE021B37;
        Thu, 25 Nov 2021 13:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637847409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W9fz+a5CrOjVhQv/LJfGt3GtW70ilV8sGNzDLI9pBqc=;
        b=yyq9Qp7P/yUuhAvOrbCUf5eTlVa831H7oOariEpW49JlRAIifzDiccp3F1D+TmPLfj0Hvi
        8/NeYw1T3QJZvc6eqDPW9PuMFGlJAOifOOnl7nlTZP7V7rIoidhYCSP30SShWP2TUDKBYL
        4mSIzCnHuE/KigsEnD/Izne1IdYZb9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637847409;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W9fz+a5CrOjVhQv/LJfGt3GtW70ilV8sGNzDLI9pBqc=;
        b=jD4vMc9GTJ7yD52Nnlrmo+g79U0x56YsbGtUjNmwXoojegYwpqtzTEb2+DUqEmhBUlEmas
        5GS1R4OpM8oXS8Aw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 19E80A3B8A;
        Thu, 25 Nov 2021 13:36:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EAF021F2CE3; Thu, 25 Nov 2021 14:36:45 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 3/8] bfq: Store full bitmap depth in bfq_data
Date:   Thu, 25 Nov 2021 14:36:36 +0100
Message-Id: <20211125133645.27483-3-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211125133131.14018-1-jack@suse.cz>
References: <20211125133131.14018-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2409; h=from:subject; bh=GenNats77LuvabWB/q5WUDZT8hAvprUKQfX+PrwPakg=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhn5Fk7PeIgOv04kxB6NOcPVIRIbfRxLErYt3BzNk3 n8G6PzOJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYZ+RZAAKCRCcnaoHP2RA2cjgB/ wLXmyv4xxxOSJMJY4qFtdTHUCIMWMIaW6uNBsF3XTw8q125/lrDUoAvogUvzpQfmJHJm7FdHudSgUU 1gLwdRnkwpWxwQJy80XexX8IBLlE+Ee5UrMBYWx2HNME1Tgh/t+7LFwgf6J6PgoSxWLxM3Re6/rst5 yLnZPs6Kv/0qucwUer68h9d6QM3EpZUPyJ8HiToMZdtvU+QB7Me+L/vroUTcxg8DCMjqQ1TWYO4OIN VYHmTbFRd8/krvgtp8PQfTdLqCEXrPUIiKVvTO0VJj8ndWkyBINH+KwBI+Nxs578EUxOpo3pUhiSjM ETMRNiHwweZlAIs5mNQEQsI4Q4V1w3
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Store bitmap depth shift inside bfq_data so that we can use it in
bfq_limit_depth() for proportioning when limiting number of available
request tags for a cgroup.

Acked-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.c | 10 ++++++----
 block/bfq-iosched.h |  1 +
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 1d564499614e..cf9247301e3c 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6857,7 +6857,9 @@ static unsigned int bfq_update_depths(struct bfq_data *bfqd,
 				      struct sbitmap_queue *bt)
 {
 	unsigned int i, j, min_shallow = UINT_MAX;
+	unsigned int depth = 1U << bt->sb.shift;
 
+	bfqd->full_depth_shift = bt->sb.shift;
 	/*
 	 * In-word depths if no bfq_queue is being weight-raised:
 	 * leaving 25% of tags only for sync reads.
@@ -6869,13 +6871,13 @@ static unsigned int bfq_update_depths(struct bfq_data *bfqd,
 	 * limit 'something'.
 	 */
 	/* no more than 50% of tags for async I/O */
-	bfqd->word_depths[0][0] = max((1U << bt->sb.shift) >> 1, 1U);
+	bfqd->word_depths[0][0] = max(depth >> 1, 1U);
 	/*
 	 * no more than 75% of tags for sync writes (25% extra tags
 	 * w.r.t. async I/O, to prevent async I/O from starving sync
 	 * writes)
 	 */
-	bfqd->word_depths[0][1] = max(((1U << bt->sb.shift) * 3) >> 2, 1U);
+	bfqd->word_depths[0][1] = max((depth * 3) >> 2, 1U);
 
 	/*
 	 * In-word depths in case some bfq_queue is being weight-
@@ -6885,9 +6887,9 @@ static unsigned int bfq_update_depths(struct bfq_data *bfqd,
 	 * shortage.
 	 */
 	/* no more than ~18% of tags for async I/O */
-	bfqd->word_depths[1][0] = max(((1U << bt->sb.shift) * 3) >> 4, 1U);
+	bfqd->word_depths[1][0] = max((depth * 3) >> 4, 1U);
 	/* no more than ~37% of tags for sync writes (~20% extra tags) */
-	bfqd->word_depths[1][1] = max(((1U << bt->sb.shift) * 6) >> 4, 1U);
+	bfqd->word_depths[1][1] = max((depth * 6) >> 4, 1U);
 
 	for (i = 0; i < 2; i++)
 		for (j = 0; j < 2; j++)
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 3787cfb0febb..820cb8c2d1fe 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -769,6 +769,7 @@ struct bfq_data {
 	 * function)
 	 */
 	unsigned int word_depths[2][2];
+	unsigned int full_depth_shift;
 };
 
 enum bfqq_state_flags {
-- 
2.26.2

