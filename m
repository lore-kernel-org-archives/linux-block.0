Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A356C433B4
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 02:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0881D610E9
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 02:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbhDSCJJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Apr 2021 22:09:09 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:52191 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232288AbhDSCJJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Apr 2021 22:09:09 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0UVyLV0r_1618798118;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UVyLV0r_1618798118)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 19 Apr 2021 10:08:39 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v2] blk-mq: cleanup set->nr_hw_queues assignement
Date:   Mon, 19 Apr 2021 10:08:38 +0800
Message-Id: <20210419020838.118548-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move 'set->nr_hw_queues = new_nr_hw_queues' assignment into
blk_mq_realloc_tag_set_tags() when
'cur_nr_hw_queues >= new_nr_hw_queues', to make the assignement
encapsulated in one function. Besides, it can reduce the redundant
assignement when 'cur_nr_hw_queues < new_nr_hw_queues' called from
__blk_mq_update_nr_hw_queues().

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
Changes since v1:
Make 'set->nr_hw_queues = new_nr_hw_queues' assigenment when
'cur_nr_hw_queues >= new_nr_hw_queues' in blk_mq_realloc_tag_set_tags().
---
 block/blk-mq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 55ef6b975169..a32345bbadd6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3373,7 +3373,7 @@ static int blk_mq_realloc_tag_set_tags(struct blk_mq_tag_set *set,
 	struct blk_mq_tags **new_tags;
 
 	if (cur_nr_hw_queues >= new_nr_hw_queues)
-		return 0;
+		goto out;
 
 	new_tags = kcalloc_node(new_nr_hw_queues, sizeof(struct blk_mq_tags *),
 				GFP_KERNEL, set->numa_node);
@@ -3385,8 +3385,9 @@ static int blk_mq_realloc_tag_set_tags(struct blk_mq_tag_set *set,
 		       sizeof(*set->tags));
 	kfree(set->tags);
 	set->tags = new_tags;
-	set->nr_hw_queues = new_nr_hw_queues;
 
+out:
+	set->nr_hw_queues = new_nr_hw_queues;
 	return 0;
 }
 
@@ -3672,7 +3673,6 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	    0)
 		goto reregister;
 
-	set->nr_hw_queues = nr_hw_queues;
 fallback:
 	blk_mq_update_queue_map(set);
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
-- 
2.27.0

