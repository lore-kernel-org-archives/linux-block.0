Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCC7C4167D
	for <linux-block@archiver.kernel.org>; Wed,  9 Nov 2022 10:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiKIKIV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Nov 2022 05:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiKIKIT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Nov 2022 05:08:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06703F009
        for <linux-block@vger.kernel.org>; Wed,  9 Nov 2022 02:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=81Wnbf1Ju6qrwCdHIW8/dNbtwhidyV0cz9bq0CHTJG8=; b=cgg6a/cqs9tS27vn9POhnkzL4Y
        EfjkQs7jpdOY6TqswmXQDQYzeB5FA4pZXx2WgbfPBLuESxAT6t+VnHTDyCOXvEy5pvNBnlHfS10xc
        lQHaYOJq688eSfaz4p22Km26QbCjP5LXTdejWogwDTlJH0cA3ZfJRxVMHFOM6KQGn3IBFBgXGNqaI
        6KPB3W3TlV60VwRzYRkOvF2qQ+ts4Xk8uVensEihJdxRGWqTX0iTGQWGxd8wc17kUItWlvqq6TvZs
        7RJjkbZKsWn2yi6SCPk1UvL2k2HtYXdb3GW63v4ilCbB5AoOtmR/YXuu7H+anM3N9L1V8EAoUu+O6
        3qbcF2TQ==;
Received: from [46.183.103.17] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1osi0G-00CZoY-S8; Wed, 09 Nov 2022 10:08:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/2] blk-mq: remove blk_mq_alloc_tag_set_tags
Date:   Wed,  9 Nov 2022 11:08:10 +0100
Message-Id: <20221109100811.2413423-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is no point in trying to share any code with the realloc case when
all that is needed by the initial tagset allocation is a simple
kcalloc_node.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7ff3415c8eadc..8c630dbdf107e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4403,12 +4403,6 @@ static int blk_mq_realloc_tag_set_tags(struct blk_mq_tag_set *set,
 	return 0;
 }
 
-static int blk_mq_alloc_tag_set_tags(struct blk_mq_tag_set *set,
-				int new_nr_hw_queues)
-{
-	return blk_mq_realloc_tag_set_tags(set, 0, new_nr_hw_queues);
-}
-
 /*
  * Alloc a tag set to be associated with one or more request queues.
  * May fail with EINVAL for various error conditions. May adjust the
@@ -4471,11 +4465,13 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 			goto out_free_srcu;
 	}
 
-	ret = blk_mq_alloc_tag_set_tags(set, set->nr_hw_queues);
-	if (ret)
+	ret = -ENOMEM;
+	set->tags = kcalloc_node(set->nr_hw_queues,
+				 sizeof(struct blk_mq_tags *), GFP_KERNEL,
+				 set->numa_node);
+	if (!set->tags)
 		goto out_cleanup_srcu;
 
-	ret = -ENOMEM;
 	for (i = 0; i < set->nr_maps; i++) {
 		set->map[i].mq_map = kcalloc_node(nr_cpu_ids,
 						  sizeof(set->map[i].mq_map[0]),
-- 
2.30.2

