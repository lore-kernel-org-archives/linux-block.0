Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C85ECAAD1
	for <linux-block@archiver.kernel.org>; Wed, 31 Aug 2022 14:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbiHaOkx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Aug 2022 10:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbiHaOkv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Aug 2022 10:40:51 -0400
Received: from out199-17.us.a.mail.aliyun.com (out199-17.us.a.mail.aliyun.com [47.90.199.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9D7AC252;
        Wed, 31 Aug 2022 07:40:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VNrX9FG_1661956807;
Received: from localhost(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VNrX9FG_1661956807)
          by smtp.aliyun-inc.com;
          Wed, 31 Aug 2022 22:40:43 +0800
From:   Liu Song <liusong@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] blk-mq: move set RQF_RESV flag codes outside retry scope
Date:   Wed, 31 Aug 2022 22:40:07 +0800
Message-Id: <1661956807-24481-1-git-send-email-liusong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Liu Song <liusong@linux.alibaba.com>

There is no need to set the RQF_RESV flag again on retry, so move that
code to a more appropriate place.

Signed-off-by: Liu Song <liusong@linux.alibaba.com>
---
 block/blk-mq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a17bc83..ccedb93 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -451,6 +451,9 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 	if (data->cmd_flags & REQ_NOWAIT)
 		data->flags |= BLK_MQ_REQ_NOWAIT;
 
+	if (data->flags & BLK_MQ_REQ_RESERVED)
+		data->rq_flags |= RQF_RESV;
+
 	if (q->elevator) {
 		struct elevator_queue *e = q->elevator;
 
@@ -474,9 +477,6 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 	if (!(data->rq_flags & RQF_ELV))
 		blk_mq_tag_busy(data->hctx);
 
-	if (data->flags & BLK_MQ_REQ_RESERVED)
-		data->rq_flags |= RQF_RESV;
-
 	/*
 	 * Try batched alloc if we want more than 1 tag.
 	 */
-- 
1.8.3.1

