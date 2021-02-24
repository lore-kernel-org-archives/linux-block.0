Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22F5C433DB
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 07:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 542D164ECF
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 07:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbhBXHaB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Feb 2021 02:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234371AbhBXHaA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Feb 2021 02:30:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97D4C061574
        for <linux-block@vger.kernel.org>; Tue, 23 Feb 2021 23:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=KApmaFE0CLCq8ntx3/Q1++hKQ3ATXV4KSXg5+UXa1mU=; b=S7SnOvqexn6dxuZRlN+VT7aGlB
        NSFaqsXvL+lFrkaNpAHwrWKLHFc+Q4bEZzcCQgjppSMitwHyKzf8+aYsKouLFl1PbGL9jOi6UVbb0
        ee7YLDjxeMxwbjMLBspELrVR8Z3DD/BLSDRS05l+ndWCV0eWwmP1M8CaN7cBwwwx84IgJv9JpGf0t
        bPeBtP2qcTSMZf7/NpdXtVnZWfjTK+dcvOUALGXt0NuVUrxEHxPbGyRrjK4Mn3+bWQArBTbOX0ZuG
        FTCkhbPl5D+15qTcxrtXgoBL2qTI5d7hVPT23IrCG+V9eGtYfPrc+45fmy8WK18KqNBC6Kqls4WMu
        tR/Fjohw==;
Received: from 213-225-9-156.nat.highway.a1.net ([213.225.9.156] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lEobO-0096fo-FD; Wed, 24 Feb 2021 07:29:00 +0000
From:   Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Satya Tangirala <satyat@google.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        John Stultz <john.stultz@linaro.org>,
        linux-block@vger.kernel.org
Subject: [PATCH 1/4] block-crypto-fallback: use a bio_set for splitting bios
Date:   Wed, 24 Feb 2021 08:24:04 +0100
Message-Id: <20210224072407.46363-2-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224072407.46363-1-hch@lst.de>
References: <20210224072407.46363-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bio_split with a NULL bs argumen used to fall back to kmalloc the
bio, which does not guarantee forward progress and could to deadlocks.
Now that the overloading of the NULL bs argument to bio_alloc_bioset
has been removed it crashes instead.  Fix all that by using a special
crafted bioset.

Fixes: 3175199ab0ac ("block: split bio_kmalloc from bio_alloc_bioset")
Reported-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: John Stultz <john.stultz@linaro.org>
---
 block/blk-crypto-fallback.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index e8327c50d7c9f4..c176b7af56a7a5 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -80,6 +80,7 @@ static struct blk_crypto_keyslot {
 static struct blk_keyslot_manager blk_crypto_ksm;
 static struct workqueue_struct *blk_crypto_wq;
 static mempool_t *blk_crypto_bounce_page_pool;
+static struct bio_set crypto_bio_split;
 
 /*
  * This is the key we set when evicting a keyslot. This *should* be the all 0's
@@ -224,7 +225,8 @@ static bool blk_crypto_split_bio_if_needed(struct bio **bio_ptr)
 	if (num_sectors < bio_sectors(bio)) {
 		struct bio *split_bio;
 
-		split_bio = bio_split(bio, num_sectors, GFP_NOIO, NULL);
+		split_bio = bio_split(bio, num_sectors, GFP_NOIO,
+				      &crypto_bio_split);
 		if (!split_bio) {
 			bio->bi_status = BLK_STS_RESOURCE;
 			return false;
@@ -538,9 +540,13 @@ static int blk_crypto_fallback_init(void)
 
 	prandom_bytes(blank_key, BLK_CRYPTO_MAX_KEY_SIZE);
 
-	err = blk_ksm_init(&blk_crypto_ksm, blk_crypto_num_keyslots);
+	err = bioset_init(&crypto_bio_split, 64, 0, 0);
 	if (err)
 		goto out;
+
+	err = blk_ksm_init(&blk_crypto_ksm, blk_crypto_num_keyslots);
+	if (err)
+		goto fail_free_bioset;
 	err = -ENOMEM;
 
 	blk_crypto_ksm.ksm_ll_ops = blk_crypto_ksm_ll_ops;
@@ -591,6 +597,8 @@ static int blk_crypto_fallback_init(void)
 	destroy_workqueue(blk_crypto_wq);
 fail_free_ksm:
 	blk_ksm_destroy(&blk_crypto_ksm);
+fail_free_bioset:
+	bioset_exit(&crypto_bio_split);
 out:
 	return err;
 }
-- 
2.29.2

