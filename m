Return-Path: <SRS0=2A/1=3K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C75C2D0DB
	for <linux-block@archiver.kernel.org>; Tue, 21 Jan 2020 08:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42BE824125
	for <linux-block@archiver.kernel.org>; Tue, 21 Jan 2020 08:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgAUIs7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jan 2020 03:48:59 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:55675 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725789AbgAUIs7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jan 2020 03:48:59 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0ToHY-kd_1579596536;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToHY-kd_1579596536)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 16:48:57 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] block/bfq: remove unused bfq_class_rt which never used
Date:   Tue, 21 Jan 2020 16:48:54 +0800
Message-Id: <1579596534-257642-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This macro is never used after introduced from commit aee69d78dec0
("block, bfq: introduce the BFQ-v0 I/O scheduler as an extra scheduler")

Better to remove it.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Paolo Valente <paolo.valente@linaro.org> 
Cc: Jens Axboe <axboe@kernel.dk> 
Cc: linux-block@vger.kernel.org 
Cc: linux-kernel@vger.kernel.org 
---
 block/bfq-iosched.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index ad4af4aaf2ce..4686b68b48b4 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -427,7 +427,6 @@ void bfq_schedule_dispatch(struct bfq_data *bfqd)
 }
 
 #define bfq_class_idle(bfqq)	((bfqq)->ioprio_class == IOPRIO_CLASS_IDLE)
-#define bfq_class_rt(bfqq)	((bfqq)->ioprio_class == IOPRIO_CLASS_RT)
 
 #define bfq_sample_valid(samples)	((samples) > 80)
 
-- 
1.8.3.1

