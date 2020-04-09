Return-Path: <SRS0=YBka=5Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC3CC2BB85
	for <linux-block@archiver.kernel.org>; Thu,  9 Apr 2020 17:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FFDC20678
	for <linux-block@archiver.kernel.org>; Thu,  9 Apr 2020 17:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgDIRJa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Apr 2020 13:09:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:44228 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728159AbgDIRJa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Apr 2020 13:09:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1472DAC58;
        Thu,  9 Apr 2020 17:09:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 964821E1253; Thu,  9 Apr 2020 19:09:28 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     <linux-block@vger.kernel.org>,
        Andreas Herrmann <aherrmann@suse.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 2/2] bfq: Allow short_ttime queues to have waker
Date:   Thu,  9 Apr 2020 19:09:15 +0200
Message-Id: <20200409170915.30570-3-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200409170915.30570-1-jack@suse.cz>
References: <20200409170915.30570-1-jack@suse.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently queues that have average think time shorter than slice_idle
cannot have waker. However this requirement is too strict. E.g. dbench
process always submits a one or two IOs (which is enough to pull its
average think time below slice_idle) and then blocks waiting for jbd2
thread to commit a transaction. Due to idling logic jbd2 thread is
often forced to wait for dbench's idle timer to trigger to be able to
submit its IO and this severely delays the overall benchmark progress.

E.g. on my test machine current dbench single-thread throughput is ~80
MB/s, with this patch it is ~200 MB/s.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 18f85d474c9c..416473ba80c8 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1928,7 +1928,6 @@ static void bfq_add_request(struct request *rq)
 		 * I/O-plugging interval for bfqq.
 		 */
 		if (bfqd->last_completed_rq_bfqq &&
-		    !bfq_bfqq_has_short_ttime(bfqq) &&
 		    ktime_get_ns() - bfqd->last_completion <
 		    200 * NSEC_PER_USEC) {
 			if (bfqd->last_completed_rq_bfqq != bfqq &&
-- 
2.16.4

