Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8EFC433EF
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 17:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A962C610C8
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 17:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbhJFRdz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Oct 2021 13:33:55 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50242 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbhJFRdv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Oct 2021 13:33:51 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C89F0223CD;
        Wed,  6 Oct 2021 17:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633541517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lvHw3PwW6TDsFi8W0PgH0zwihCZPnGWlWI/UD/BIXxI=;
        b=nqQ3Ykg+hYj70bYxleDCkje22wEYgzUe5kbYEj0KgxaerUN7/mYmaD9yDbRamZX8gD8b29
        hcwee4fSjXXHsPm+Azv9aG3t3uLu5PLBGepj2PSwaF6l9iWuSF7fOHxug6CYf9NkUsUBeq
        jzkPh6JKw2YhldGYasU3virP+dlorn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633541517;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lvHw3PwW6TDsFi8W0PgH0zwihCZPnGWlWI/UD/BIXxI=;
        b=pci4I5KY7Qahajl6GfgIuRdVgdutUDQppeEDRIa0CRJrgIBljtcZxxIk4svbru4uhbS9qe
        qSG2x4YckUUjBvCg==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id B13A6A3B83;
        Wed,  6 Oct 2021 17:31:57 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6551A1F2C99; Wed,  6 Oct 2021 19:31:57 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 3/8] bfq: Store full bitmap depth in bfq_data
Date:   Wed,  6 Oct 2021 19:31:42 +0200
Message-Id: <20211006173157.6906-3-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211006164110.10817-1-jack@suse.cz>
References: <20211006164110.10817-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2357; h=from:subject; bh=sNqsOH8z2zBVNQi55Ud9g7Q1mtyHGxzPOFAv9uD3Lg0=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhXd1+yJSM7NGZ5fl1qc4ciNJExWF/Rma0bIO8Nfk/ LJ93naWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYV3dfgAKCRCcnaoHP2RA2Q3bB/ 4rPNyR9++F1zwct/cWKAUmMIAwtGl4DjCoLAyoENLoo9c1X7YPkTIKTnRdVktbk22bmcunXN5y9Kr4 inuXMYA0PXtdUZ1+T+YEUpiNksE4esoQDpA8VQx4k3yZIqUxNlXv90hfw1N7NgEfJnerOcOQdX6YU1 NsnZVLK9owHzJHlt53cNXIBl2n622EVvzjkNn436JROjcqI3+wrkx8O6HblEtgTQoUd49U5PPJAFIV Ue6VmEtAYDFUKQI+LMUDLfaMoTJG7eDmGkZJCUbhY7PxmJbJqC3ykePZytdMzao8+vHs/Hqa2q1LJw G2Re6aBecfr1k6/61r4zfsUAfvx4fZ
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Store bitmap depth shift inside bfq_data so that we can use it in
bfq_limit_depth() for proportioning when limiting number of available
request tags for a cgroup.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.c | 10 ++++++----
 block/bfq-iosched.h |  1 +
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 4d9e04edb614..c93a74b8e9c8 100644
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

