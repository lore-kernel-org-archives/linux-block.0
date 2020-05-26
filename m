Return-Path: <SRS0=PnPs=7I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CD3C433E0
	for <linux-block@archiver.kernel.org>; Tue, 26 May 2020 10:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EEA1207CB
	for <linux-block@archiver.kernel.org>; Tue, 26 May 2020 10:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgEZKtE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 May 2020 06:49:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5284 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726977AbgEZKtE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 May 2020 06:49:04 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1B41DDB73B7C7464554A;
        Tue, 26 May 2020 18:49:02 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Tue, 26 May 2020 18:48:55 +0800
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH] blk-mq: Explicitly zero-init blk_mq_tags.active_queues
Date:   Tue, 26 May 2020 18:45:00 +0800
Message-ID: <1590489900-121753-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As is good practice, explicitly zero-init atomic_t type
blk_mq_tags.active_queues.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 586c9d6e904a..cbbd0af9f3b0 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -469,6 +469,7 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
 
 	tags->nr_tags = total_tags;
 	tags->nr_reserved_tags = reserved_tags;
+	atomic_set(&tags->active_queues, 0);
 
 	return blk_mq_init_bitmap_tags(tags, node, alloc_policy);
 }
-- 
2.16.4

