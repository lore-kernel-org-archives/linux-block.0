Return-Path: <SRS0=J6N0=QB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A084C282C5
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 00:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66CD7217D7
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 00:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbfAYANK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 19:13:10 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:59807 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726173AbfAYANK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 19:13:10 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=bo.liu@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0TIwmQ-K_1548375188;
Received: from localhost(mailfrom:bo.liu@linux.alibaba.com fp:SMTPD_---0TIwmQ-K_1548375188)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 25 Jan 2019 08:13:08 +0800
From:   Liu Bo <bo.liu@linux.alibaba.com>
To:     linux-block@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 2/3] Blk-iolatency: warn on negative inflight IO counter
Date:   Fri, 25 Jan 2019 08:12:48 +0800
Message-Id: <20190125001249.72688-3-bo.liu@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.2.gb21ebb6
In-Reply-To: <20190125001249.72688-1-bo.liu@linux.alibaba.com>
References: <20190125001249.72688-1-bo.liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is to catch any unexpected negative value of inflight IO counter.

Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
---
 block/blk-iolatency.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 1893686a9c1f..2620baa1f699 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -592,6 +592,7 @@ static void blkcg_iolatency_done_bio(struct rq_qos *rqos, struct bio *bio)
 	u64 now = ktime_to_ns(ktime_get());
 	bool issue_as_root = bio_issue_as_root_blkg(bio);
 	bool enabled = false;
+	int inflight = 0;
 
 	blkg = bio->bi_blkg;
 	if (!blkg || !bio_flagged(bio, BIO_TRACKED))
@@ -613,7 +614,8 @@ static void blkcg_iolatency_done_bio(struct rq_qos *rqos, struct bio *bio)
 		}
 		rqw = &iolat->rq_wait;
 
-		atomic_dec(&rqw->inflight);
+		inflight = atomic_dec_return(&rqw->inflight);
+		WARN_ON_ONCE(inflight < 0);
 		if (iolat->min_lat_nsec == 0)
 			goto next;
 		iolatency_record_time(iolat, &bio->bi_issue, now,
-- 
2.20.1.2.gb21ebb6

