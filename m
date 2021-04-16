Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A8DC433B4
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 07:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 017296113D
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 07:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237759AbhDPHxq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Apr 2021 03:53:46 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:39993 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233959AbhDPHxp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Apr 2021 03:53:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0UVj6Uke_1618559598;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UVj6Uke_1618559598)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 16 Apr 2021 15:53:19 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] blk-mq: cleanup redundant nr_hw_queues assignement
Date:   Fri, 16 Apr 2021 15:53:18 +0800
Message-Id: <20210416075318.19976-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

'set->nr_hw_queues' has already been assigneid to nr_hw_queues in
blk_mq_realloc_tag_set_tags().

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 block/blk-mq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 55ef6b975169..c7d1613e7514 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3672,7 +3672,6 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	    0)
 		goto reregister;
 
-	set->nr_hw_queues = nr_hw_queues;
 fallback:
 	blk_mq_update_queue_map(set);
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
-- 
2.27.0

