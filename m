Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC776C4338F
	for <linux-block@archiver.kernel.org>; Sun,  8 Aug 2021 06:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98DFC60FF2
	for <linux-block@archiver.kernel.org>; Sun,  8 Aug 2021 06:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhHHGxH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 8 Aug 2021 02:53:07 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:16994 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbhHHGxG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 8 Aug 2021 02:53:06 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Gj8vT0z80zZydk;
        Sun,  8 Aug 2021 14:49:09 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sun, 8 Aug 2021 14:52:45 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sun, 8 Aug
 2021 14:52:45 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH] block: don't decrement flush request refcount if it's state is idle in flush_end_io()
Date:   Sun, 8 Aug 2021 15:03:30 +0800
Message-ID: <20210808070330.763177-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

flush_end_io() currently decrement request refcount unconditionally.
However, it's possible that the request is already idle and it's
refcount is zero since that flush_end_io() can be called concurrently.

For example, nbd_clear_que() can be called concurrently with normal
io completion or io timeout.

Thus check idle before decrement to avoid refcount_t underflow
warning.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-flush.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 1002f6c58181..9b65dc43702c 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -222,7 +222,8 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
 	/* release the tag's ownership to the req cloned from */
 	spin_lock_irqsave(&fq->mq_flush_lock, flags);
 
-	if (!refcount_dec_and_test(&flush_rq->ref)) {
+	if (blk_mq_rq_state(flush_rq) == MQ_RQ_IDLE ||
+	    !refcount_dec_and_test(&flush_rq->ref)) {
 		fq->rq_status = error;
 		spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
 		return;
-- 
2.31.1

