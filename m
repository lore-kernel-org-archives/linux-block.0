Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE606C43217
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 10:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbhKWKfI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 05:35:08 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:49824 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235337AbhKWKfH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 05:35:07 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 94D46218B5;
        Tue, 23 Nov 2021 10:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637663518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hJAAJMys5e2iX3w+jl91qrOqeHvDISapw3aG1kM/YnE=;
        b=gJFDCFFtyBpEypanCd8h9LF+MMOdaomSTqPAyrAfFnNXh85lHFZWq7ck/VLVPg6CqSiJcz
        lA9WzeraWTDP3266NVb/R7iVG3YY5uVktwe0COSSDENusXnuuDh1nOBNXMbsaIag0nO+PL
        uvDkODJ3/BLhYb2jXrbLtfORZmiNTTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637663518;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hJAAJMys5e2iX3w+jl91qrOqeHvDISapw3aG1kM/YnE=;
        b=lOGXebQM/seAKEQuH1jPu/RIGTKCP5uaM51CXB3LN8941pIRlFJr+SfMJg68P/p8KMufMj
        Ov3Bnbx6L4R/m5AQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 8C1F0A3B87;
        Tue, 23 Nov 2021 10:31:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6932F1E1649; Tue, 23 Nov 2021 11:31:58 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 3/8] bfq: Store full bitmap depth in bfq_data
Date:   Tue, 23 Nov 2021 11:29:15 +0100
Message-Id: <20211123103158.17284-3-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211123101109.20879-1-jack@suse.cz>
References: <20211123101109.20879-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2409; h=from:subject; bh=7/qYXPfTc6XjuEqvqs45tNdiXbwosf12+RSfio4p3QE=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhnMJ7moVbDgdbk1CPe/6FHUlvwoWHe8T345JGyssQ DfHokWCJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYZzCewAKCRCcnaoHP2RA2e/kB/ 9JoPJLHeYPYFPRGZ2i5t7oeI6B6F15bIXaL2sTfsgPszzJMLF0trouBOQ8/Qykns3WJHfciZi+6Ye2 Rdfg9unrxZvSOcBP9ViV06wKIWUZu/MvfYFzdQKTEfnt2jH6CWPo9vWz8E3GaKyU/Um3S0/LZ+bg+z SwoY0J31/7z/ePznjg0ooAgMUsWntkDdDqZlfNr62AfR2AzRbyeF4KTlKPDXipXjwmKVXaLFY9OJ0D 4bKQQv/ehWuRZ54Vy9aQug2fWlupYLG24GBo0dMqjxA1J1AGPpZZzBVHkcdg7KX1J+EVRZkuvOinBA 5axho+QWj7JyVZ5K4HPjAAADUGeFu5
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
index caa7a70d2d5f..1fef82bf4a55 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6855,7 +6855,9 @@ static unsigned int bfq_update_depths(struct bfq_data *bfqd,
 				      struct sbitmap_queue *bt)
 {
 	unsigned int i, j, min_shallow = UINT_MAX;
+	unsigned int depth = 1U << bt->sb.shift;
 
+	bfqd->full_depth_shift = bt->sb.shift;
 	/*
 	 * In-word depths if no bfq_queue is being weight-raised:
 	 * leaving 25% of tags only for sync reads.
@@ -6867,13 +6869,13 @@ static unsigned int bfq_update_depths(struct bfq_data *bfqd,
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
@@ -6883,9 +6885,9 @@ static unsigned int bfq_update_depths(struct bfq_data *bfqd,
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

