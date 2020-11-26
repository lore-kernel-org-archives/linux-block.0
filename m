Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7166C56202
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 09:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B62E2145D
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 09:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732141AbgKZJsg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Nov 2020 04:48:36 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:57658 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726099AbgKZJsg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 04:48:36 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UGarA.G_1606384113;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UGarA.G_1606384113)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 26 Nov 2020 17:48:34 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, joseph.qi@linux.alibaba.com
Subject: [PATCH] block: fix inflight statistics of part0
Date:   Thu, 26 Nov 2020 17:48:33 +0800
Message-Id: <20201126094833.61309-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The inflight of partition 0 doesn't include inflight IOs to all
sub-partitions, since currently mq calculates inflight of specific
partition by simply camparing the value of the partition pointer.

Thus the following case is possible:

$ cat /sys/block/vda/inflight
       0        0
$ cat /sys/block/vda/vda1/inflight
       0      128

Partition 0 should be specially handled since it represents the whole
disk.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 block/blk-mq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 55bcee5dc032..04b6b4d21ce6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -105,7 +105,8 @@ static bool blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
 {
 	struct mq_inflight *mi = priv;
 
-	if (rq->part == mi->part && blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT)
+	if ((!mi->part->partno || rq->part == mi->part) &&
+	    blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT)
 		mi->inflight[rq_data_dir(rq)]++;
 
 	return true;
-- 
2.27.0

