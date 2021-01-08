Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C584C433E6
	for <linux-block@archiver.kernel.org>; Fri,  8 Jan 2021 09:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD45222B2E
	for <linux-block@archiver.kernel.org>; Fri,  8 Jan 2021 09:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbhAHJAf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Jan 2021 04:00:35 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10042 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbhAHJAf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Jan 2021 04:00:35 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DBxq35wSqzj5NX;
        Fri,  8 Jan 2021 16:58:55 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Fri, 8 Jan 2021 16:59:45 +0800
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH] blk-mq-debugfs: Add decode for BLK_MQ_F_TAG_HCTX_SHARED
Date:   Fri, 8 Jan 2021 16:55:37 +0800
Message-ID: <1610096137-187414-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Showing the hctx flags for when BLK_MQ_F_TAG_HCTX_SHARED is set gives
something like:

root@debian:/home/john# more /sys/kernel/debug/block/sda/hctx0/flags
alloc_policy=FIFO SHOULD_MERGE|TAG_QUEUE_SHARED|3

Add the decoding for that flag.

Fixes: 32bc15afed04b ("blk-mq: Facilitate a shared sbitmap per tagset")
Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 3094542e12ae..ea4ab98e6b25 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -245,6 +245,7 @@ static const char *const hctx_flag_name[] = {
 	HCTX_FLAG_NAME(BLOCKING),
 	HCTX_FLAG_NAME(NO_SCHED),
 	HCTX_FLAG_NAME(STACKING),
+	HCTX_FLAG_NAME(TAG_HCTX_SHARED),
 };
 #undef HCTX_FLAG_NAME
 
-- 
2.26.2

