Return-Path: <SRS0=HYnl=B5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CBEC433DF
	for <linux-block@archiver.kernel.org>; Wed, 19 Aug 2020 08:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51BF0207FB
	for <linux-block@archiver.kernel.org>; Wed, 19 Aug 2020 08:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgHSIyz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Aug 2020 04:54:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9845 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726794AbgHSIwL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Aug 2020 04:52:11 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3262A7CE5FA0FD472EB2;
        Wed, 19 Aug 2020 16:51:57 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Wed, 19 Aug 2020
 16:51:49 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <axboe@kernel.dk>, <paolo.valente@linaro.org>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] block: Convert to use the preferred fallthrough macro
Date:   Wed, 19 Aug 2020 04:50:44 -0400
Message-ID: <20200819085044.41887-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Convert the uses of fallthrough comments to fallthrough macro.

Signed-off-by: Hongxiang Lou <louhongxiang@huawei.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 block/badblocks.c   | 2 +-
 block/bfq-iosched.c | 4 ++--
 block/blk-wbt.c     | 2 +-
 block/ioprio.c      | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index 2e5f5697db35..d39056630d9c 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -525,7 +525,7 @@ ssize_t badblocks_store(struct badblocks *bb, const char *page, size_t len,
 	case 3:
 		if (newline != '\n')
 			return -EINVAL;
-		/* fall through */
+		fallthrough;
 	case 2:
 		if (length <= 0)
 			return -EINVAL;
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index a4c0bec920cb..c34b090178a9 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4980,7 +4980,7 @@ bfq_set_next_ioprio_data(struct bfq_queue *bfqq, struct bfq_io_cq *bic)
 		pr_err("bdi %s: bfq: bad prio class %d\n",
 				bdi_dev_name(bfqq->bfqd->queue->backing_dev_info),
 				ioprio_class);
-		/* fall through */
+		fallthrough;
 	case IOPRIO_CLASS_NONE:
 		/*
 		 * No prio set, inherit CPU scheduling settings.
@@ -5112,7 +5112,7 @@ static struct bfq_queue **bfq_async_queue_prio(struct bfq_data *bfqd,
 		return &bfqg->async_bfqq[0][ioprio];
 	case IOPRIO_CLASS_NONE:
 		ioprio = IOPRIO_NORM;
-		/* fall through */
+		fallthrough;
 	case IOPRIO_CLASS_BE:
 		return &bfqg->async_bfqq[1][ioprio];
 	case IOPRIO_CLASS_IDLE:
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 0fa615eefd52..fd410086fe1d 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -528,7 +528,7 @@ static inline bool wbt_should_throttle(struct rq_wb *rwb, struct bio *bio)
 		if ((bio->bi_opf & (REQ_SYNC | REQ_IDLE)) ==
 		    (REQ_SYNC | REQ_IDLE))
 			return false;
-		/* fallthrough */
+		fallthrough;
 	case REQ_OP_DISCARD:
 		return true;
 	default:
diff --git a/block/ioprio.c b/block/ioprio.c
index 77bcab11dce5..04ebd37966f1 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -71,7 +71,7 @@ int ioprio_check_cap(int ioprio)
 		case IOPRIO_CLASS_RT:
 			if (!capable(CAP_SYS_ADMIN))
 				return -EPERM;
-			/* fall through */
+			fallthrough;
 			/* rt has prio field too */
 		case IOPRIO_CLASS_BE:
 			if (data >= IOPRIO_BE_NR || data < 0)
-- 
2.19.1

