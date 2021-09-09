Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4ACC433F5
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 08:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A039A61167
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 08:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhIIIsA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Sep 2021 04:48:00 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9020 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbhIIIsA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Sep 2021 04:48:00 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H4szS6WJtzVqc0;
        Thu,  9 Sep 2021 16:45:56 +0800 (CST)
Received: from dggpeml500025.china.huawei.com (7.185.36.35) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 9 Sep 2021 16:46:49 +0800
Received: from huawei.com (10.175.124.27) by dggpeml500025.china.huawei.com
 (7.185.36.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 9 Sep 2021
 16:46:49 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>
Subject: [PATCH] block: check the existence of tags[hctx_idx] in blk_mq_clear_rq_mapping()
Date:   Thu, 9 Sep 2021 17:00:54 +0800
Message-ID: <20210909090054.492923-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

According to commit 4412efecf7fd ("Revert "blk-mq: remove code for
dealing with remapping queue""), for some devices queue hctx may not
being mapped, and tagset->tags[hctx_idx] will be released and be NULL.

If an IO scheduler is used on these devices, blk_mq_clear_rq_mapping()
will be called for all hctxs in blk_mq_sched_free_requests() during
scheduler switch, and these will be oops. So checking the existence of
tags[hctx_idx] before going on in blk_mq_clear_rq_mapping().

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 block/blk-mq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 65d3a63aecc6..c3d701f44e49 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2297,6 +2297,10 @@ static void blk_mq_clear_rq_mapping(struct blk_mq_tag_set *set,
 	struct page *page;
 	unsigned long flags;
 
+	/* If the hctx is unmapped, drv_tags may be NULL */
+	if (!drv_tags)
+		return;
+
 	list_for_each_entry(page, &tags->page_list, lru) {
 		unsigned long start = (unsigned long)page_address(page);
 		unsigned long end = start + order_to_size(page->private);
-- 
2.29.2

