Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04946C433E2
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 08:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E31AE2078A
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 08:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgGAIKS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:10:18 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:50572 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728188AbgGAIKR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 1 Jul 2020 04:10:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=hongnan.li@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0U1G8MLP_1593590997;
Received: from AliYun.localdomain(mailfrom:hongnan.li@linux.alibaba.com fp:SMTPD_---0U1G8MLP_1593590997)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 01 Jul 2020 16:10:15 +0800
From:   Hongnan Li <hongnan.li@linux.alibaba.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Hongnan Li <hongnan.li@linux.alibaba.com>
Subject: [PATCH v2] blk-iolatency: postpone ktime_get() execution until blk_iolatency_enabled() return true
Date:   Wed,  1 Jul 2020 16:09:38 +0800
Message-Id: <1593590978-23382-1-git-send-email-hongnan.li@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ktime_to_ns(ktime_get()) which is expensive do not need to be executed if
blk_iolatency_enabled() return false in blkcg_iolatency_done_bio().
Postponing ktime_to_ns(ktime_get()) execution can reduce CPU usage
when blk_iolatency was disabled.

---
V2:
  1.Fix compile warnings.

Signed-off-by: Hongnan Li <hongnan.li@linux.alibaba.com>
---
 block/blk-iolatency.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index c128d50..f90429c 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -591,7 +591,7 @@ static void blkcg_iolatency_done_bio(struct rq_qos *rqos, struct bio *bio)
 	struct rq_wait *rqw;
 	struct iolatency_grp *iolat;
 	u64 window_start;
-	u64 now = ktime_to_ns(ktime_get());
+	u64 now;
 	bool issue_as_root = bio_issue_as_root_blkg(bio);
 	bool enabled = false;
 	int inflight = 0;
@@ -608,6 +608,7 @@ static void blkcg_iolatency_done_bio(struct rq_qos *rqos, struct bio *bio)
 	if (!enabled)
 		return;
 
+	now = ktime_to_ns(ktime_get());
 	while (blkg && blkg->parent) {
 		iolat = blkg_to_lat(blkg);
 		if (!iolat) {
-- 
1.8.3.1

