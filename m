Return-Path: <SRS0=tuS3=7S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85722C433DF
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 14:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EFFA2063A
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 14:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgFEOZm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:25:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:42442 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728242AbgFEOQa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Jun 2020 10:16:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 14703AE96;
        Fri,  5 Jun 2020 14:16:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 565161E1286; Fri,  5 Jun 2020 16:16:29 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-block@vger.kernel.org>
Cc:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 3/3] bfq: Use only idle IO periods for think time calculations
Date:   Fri,  5 Jun 2020 16:16:18 +0200
Message-Id: <20200605141629.15347-3-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200605140837.5394-1-jack@suse.cz>
References: <20200605140837.5394-1-jack@suse.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently whenever bfq queue has a request queued we add now -
last_completion_time to the think time statistics. This is however
misleading in case the process is able to submit several requests in
parallel because e.g. if the queue has request completed at time T0 and
then queues new requests at times T1, T2, then we will add T1-T0 and
T2-T0 to think time statistics which just doesn't make any sence (the
queue's think time is penalized by the queue being able to submit more
IO). So add to think time statistics only time intervals when the queue
had no IO pending.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index c66c3eaa9e26..4b1c9c5f57b6 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5192,8 +5192,16 @@ static void bfq_update_io_thinktime(struct bfq_data *bfqd,
 				    struct bfq_queue *bfqq)
 {
 	struct bfq_ttime *ttime = &bfqq->ttime;
-	u64 elapsed = ktime_get_ns() - bfqq->ttime.last_end_request;
-
+	u64 elapsed;
+	
+	/*
+	 * We are really interested in how long it takes for the queue to
+	 * become busy when there is no outstanding IO for this queue. So
+	 * ignore cases when the bfq queue has already IO queued.
+	 */
+	if (bfqq->dispatched || bfq_bfqq_busy(bfqq))
+		return;
+	elapsed = ktime_get_ns() - bfqq->ttime.last_end_request;
 	elapsed = min_t(u64, elapsed, 2ULL * bfqd->bfq_slice_idle);
 
 	ttime->ttime_samples = (7*ttime->ttime_samples + 256) / 8;
-- 
2.16.4

