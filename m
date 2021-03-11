Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B97C433E6
	for <linux-block@archiver.kernel.org>; Thu, 11 Mar 2021 08:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B954A64FBB
	for <linux-block@archiver.kernel.org>; Thu, 11 Mar 2021 08:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhCKIRn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Mar 2021 03:17:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:35058 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231234AbhCKIRR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Mar 2021 03:17:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615450636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=sqrZmMAL/8McYRpqo33lzEKth3MRLtyIILBmFDL6iPE=;
        b=kjJj9b7+BpnHwjKoacGWzbm+/0STgk+KqCTJiV1rSPkQXerOi/8h8c4Imt9wapwddUKwg6
        6IMSQa3J8TnXvS1eQ3g8qpO6xvsZw4uwqdmLthqb32VQ8yn9RWsVmq/AywGn5W8asXVDES
        wetqwTWIEBTaHhIFJWSHlT4qB/awEZI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 00C83AC16;
        Thu, 11 Mar 2021 08:17:16 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] blk-mq: Always use blk_mq_is_sbitmap_shared
Date:   Thu, 11 Mar 2021 10:17:13 +0200
Message-Id: <20210311081713.2763171-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 block/blk-mq-tag.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 9c92053e704d..99bc5fe14e9b 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -517,7 +517,7 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
 	tags->nr_tags = total_tags;
 	tags->nr_reserved_tags = reserved_tags;
 
-	if (flags & BLK_MQ_F_TAG_HCTX_SHARED)
+	if (blk_mq_is_sbitmap_shared(flags))
 		return tags;
 
 	if (blk_mq_init_bitmap_tags(tags, node, alloc_policy) < 0) {
@@ -529,7 +529,7 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
 
 void blk_mq_free_tags(struct blk_mq_tags *tags, unsigned int flags)
 {
-	if (!(flags & BLK_MQ_F_TAG_HCTX_SHARED)) {
+	if (!blk_mq_is_sbitmap_shared(flags)) {
 		sbitmap_queue_free(tags->bitmap_tags);
 		sbitmap_queue_free(tags->breserved_tags);
 	}
-- 
2.25.1

