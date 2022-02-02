Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE98AC433F5
	for <linux-block@archiver.kernel.org>; Wed,  2 Feb 2022 16:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345630AbiBBQBk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Feb 2022 11:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345632AbiBBQBj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Feb 2022 11:01:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEFBC061714
        for <linux-block@vger.kernel.org>; Wed,  2 Feb 2022 08:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=8t+56lp6dVMHM+jQkBmWG3FrLeB98BaTd5m46YJ8gF8=; b=piYM9GXRwThQPvdPrSoM/5lPmj
        MbrOC6Qa0iRJqSEHYoaRBxuwR7CMUJ7Q32SFkOivdbb23mWIxVHga9EAOfooYA1L3obWyn/l8MGH0
        xqiHh1SIcdVXPtKPatoepoY4a6pdWMGdRP3J6G/sqVd9EPS+npnPd4x4ODCyfm7ISqvJca0ZfymNn
        d7sa2QIRr0GgCpBexpNDw1qzzwPF2Hm7Eq2Vjrau7nAum5KIQ+/NRS3jIsZ914z3fxdrg61G7oRwL
        AVqPcYwq3eE1Uu6oWlKOhrYxP9N5qAQ8kMKnCGSkr3GDlJ5F2RWdrHDkjJfaJpnSQskJ7FLl0Wj7+
        fvVWlP/Q==;
Received: from [2001:4bb8:191:327d:b3e5:1ccd:eaac:6609] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFI4d-00G86M-IZ; Wed, 02 Feb 2022 16:01:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        drbd-dev@lists.linbit.com
Subject: [PATCH 09/13] dm-cache: remove __remap_to_origin_clear_discard
Date:   Wed,  2 Feb 2022 17:01:05 +0100
Message-Id: <20220202160109.108149-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220202160109.108149-1-hch@lst.de>
References: <20220202160109.108149-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fold __remap_to_origin_clear_discard into the two callers to prepare
for bio cloning refactoring.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm-cache-target.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index 447d030036d18..1c37fe028e531 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -744,21 +744,14 @@ static void check_if_tick_bio_needed(struct cache *cache, struct bio *bio)
 	spin_unlock_irq(&cache->lock);
 }
 
-static void __remap_to_origin_clear_discard(struct cache *cache, struct bio *bio,
-					    dm_oblock_t oblock, bool bio_has_pbd)
-{
-	if (bio_has_pbd)
-		check_if_tick_bio_needed(cache, bio);
-	remap_to_origin(cache, bio);
-	if (bio_data_dir(bio) == WRITE)
-		clear_discard(cache, oblock_to_dblock(cache, oblock));
-}
-
 static void remap_to_origin_clear_discard(struct cache *cache, struct bio *bio,
 					  dm_oblock_t oblock)
 {
 	// FIXME: check_if_tick_bio_needed() is called way too much through this interface
-	__remap_to_origin_clear_discard(cache, bio, oblock, true);
+	check_if_tick_bio_needed(cache, bio);
+	remap_to_origin(cache, bio);
+	if (bio_data_dir(bio) == WRITE)
+		clear_discard(cache, oblock_to_dblock(cache, oblock));
 }
 
 static void remap_to_cache_dirty(struct cache *cache, struct bio *bio,
@@ -831,11 +824,10 @@ static void remap_to_origin_and_cache(struct cache *cache, struct bio *bio,
 	BUG_ON(!origin_bio);
 
 	bio_chain(origin_bio, bio);
-	/*
-	 * Passing false to __remap_to_origin_clear_discard() skips
-	 * all code that might use per_bio_data (since clone doesn't have it)
-	 */
-	__remap_to_origin_clear_discard(cache, origin_bio, oblock, false);
+
+	remap_to_origin(cache, origin_bio);
+	if (bio_data_dir(origin_bio) == WRITE)
+		clear_discard(cache, oblock_to_dblock(cache, oblock));
 	submit_bio(origin_bio);
 
 	remap_to_cache(cache, bio, cblock);
-- 
2.30.2

