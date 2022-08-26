Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9B2ECAAA3
	for <linux-block@archiver.kernel.org>; Fri, 26 Aug 2022 03:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiHZDOt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Aug 2022 23:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244922AbiHZDOi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Aug 2022 23:14:38 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F63CE339;
        Thu, 25 Aug 2022 20:14:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VNH5TJ6_1661483653;
Received: from localhost(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VNH5TJ6_1661483653)
          by smtp.aliyun-inc.com;
          Fri, 26 Aug 2022 11:14:32 +0800
From:   Liu Song <liusong@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] sbitmap: remove unnecessary code in __sbitmap_queue_get_batch
Date:   Fri, 26 Aug 2022 11:14:13 +0800
Message-Id: <1661483653-27326-1-git-send-email-liusong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Liu Song <liusong@linux.alibaba.com>

If "nr + nr_tags <= map_depth", then the value of nr_tags will not be
greater than map_depth, so no additional comparison is required.

Signed-off-by: Liu Song <liusong@linux.alibaba.com>
---
 lib/sbitmap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 29eb048..34c904b 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -533,10 +533,9 @@ unsigned long __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, int nr_tags,
 		nr = find_first_zero_bit(&map->word, map_depth);
 		if (nr + nr_tags <= map_depth) {
 			atomic_long_t *ptr = (atomic_long_t *) &map->word;
-			int map_tags = min_t(int, nr_tags, map_depth);
 			unsigned long val, ret;
 
-			get_mask = ((1UL << map_tags) - 1) << nr;
+			get_mask = ((1UL << nr_tags) - 1) << nr;
 			do {
 				val = READ_ONCE(map->word);
 				if ((val & ~get_mask) != val)
@@ -547,7 +546,7 @@ unsigned long __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, int nr_tags,
 			if (get_mask) {
 				*offset = nr + (index << sb->shift);
 				update_alloc_hint_after_get(sb, depth, hint,
-							*offset + map_tags - 1);
+							*offset + nr_tags - 1);
 				return get_mask;
 			}
 		}
-- 
1.8.3.1

