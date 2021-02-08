Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C557C433DB
	for <linux-block@archiver.kernel.org>; Mon,  8 Feb 2021 18:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 418B464DE1
	for <linux-block@archiver.kernel.org>; Mon,  8 Feb 2021 18:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235066AbhBHSJN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Feb 2021 13:09:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:47384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235189AbhBHSDf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 8 Feb 2021 13:03:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A91764EE2;
        Mon,  8 Feb 2021 17:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612807180;
        bh=axZ0Jl2Xd0A1Y4Llp/hS6PE0wj1Pn8dRYAEkgCvlvr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HBN6AQly2PquD8zcWSJqlkskLY9ilVMeiIAgSqGb7Tb5VAMbuuptO7s5O4u6HClmb
         jK+C7sJz8UCaIxWRbM0ySfCJk0fJHjztPi3ak3mLoK1rx2PL2QSIF7gZ8/rk7LIr6P
         nwf/DzK/iQRDh0d05krCtNTToT0/iu5fF9pUmPfINiWmxERnDm0DF71ks7XrcKUM5l
         Ne3o/9AO4UERAcPS7Z5cw7cnNPvT3RylQorHwcFhUwfi/05Ab0zg4W2CrLLWWd4Em1
         bSueuQM+2qDckzDIYsrsRi1/SF1o8T2v75NNWbYZBD/0D760ry23zU6SeFBueGncFz
         8dQK3NGphhYQg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lin Feng <linf@wangsu.com>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 10/14] bfq-iosched: Revert "bfq: Fix computation of shallow depth"
Date:   Mon,  8 Feb 2021 12:59:22 -0500
Message-Id: <20210208175926.2092211-10-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210208175926.2092211-1-sashal@kernel.org>
References: <20210208175926.2092211-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Lin Feng <linf@wangsu.com>

[ Upstream commit 388c705b95f23f317fa43e6abf9ff07b583b721a ]

This reverts commit 6d4d273588378c65915acaf7b2ee74e9dd9c130a.

bfq.limit_depth passes word_depths[] as shallow_depth down to sbitmap core
sbitmap_get_shallow, which uses just the number to limit the scan depth of
each bitmap word, formula:
scan_percentage_for_each_word = shallow_depth / (1 << sbimap->shift) * 100%

That means the comments's percentiles 50%, 75%, 18%, 37% of bfq are correct.
But after commit patch 'bfq: Fix computation of shallow depth', we use
sbitmap.depth instead, as a example in following case:

sbitmap.depth = 256, map_nr = 4, shift = 6; sbitmap_word.depth = 64.
The resulsts of computed bfqd->word_depths[] are {128, 192, 48, 96}, and
three of the numbers exceed core dirver's 'sbitmap_word.depth=64' limit
nothing.

Signed-off-by: Lin Feng <linf@wangsu.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bfq-iosched.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index b7ad8ac6bb41e..5198ed1b36690 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5280,13 +5280,13 @@ static unsigned int bfq_update_depths(struct bfq_data *bfqd,
 	 * limit 'something'.
 	 */
 	/* no more than 50% of tags for async I/O */
-	bfqd->word_depths[0][0] = max(bt->sb.depth >> 1, 1U);
+	bfqd->word_depths[0][0] = max((1U << bt->sb.shift) >> 1, 1U);
 	/*
 	 * no more than 75% of tags for sync writes (25% extra tags
 	 * w.r.t. async I/O, to prevent async I/O from starving sync
 	 * writes)
 	 */
-	bfqd->word_depths[0][1] = max((bt->sb.depth * 3) >> 2, 1U);
+	bfqd->word_depths[0][1] = max(((1U << bt->sb.shift) * 3) >> 2, 1U);
 
 	/*
 	 * In-word depths in case some bfq_queue is being weight-
@@ -5296,9 +5296,9 @@ static unsigned int bfq_update_depths(struct bfq_data *bfqd,
 	 * shortage.
 	 */
 	/* no more than ~18% of tags for async I/O */
-	bfqd->word_depths[1][0] = max((bt->sb.depth * 3) >> 4, 1U);
+	bfqd->word_depths[1][0] = max(((1U << bt->sb.shift) * 3) >> 4, 1U);
 	/* no more than ~37% of tags for sync writes (~20% extra tags) */
-	bfqd->word_depths[1][1] = max((bt->sb.depth * 6) >> 4, 1U);
+	bfqd->word_depths[1][1] = max(((1U << bt->sb.shift) * 6) >> 4, 1U);
 
 	for (i = 0; i < 2; i++)
 		for (j = 0; j < 2; j++)
-- 
2.27.0

