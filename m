Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAD1C41518
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 00:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA4FD21872
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 00:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfAXARA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jan 2019 19:17:00 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:46952 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726168AbfAXARA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jan 2019 19:17:00 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=bo.liu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0TIsCJom_1548289017;
Received: from localhost(mailfrom:bo.liu@linux.alibaba.com fp:SMTPD_---0TIsCJom_1548289017)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 24 Jan 2019 08:16:58 +0800
From:   Liu Bo <bo.liu@linux.alibaba.com>
To:     linux-block@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 1/3] Blk-iolatency: warn on negative inflight IO counter
Date:   Thu, 24 Jan 2019 08:16:53 +0800
Message-Id: <20190124001655.92508-2-bo.liu@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.2.gb21ebb6
In-Reply-To: <20190124001655.92508-1-bo.liu@linux.alibaba.com>
References: <20190124001655.92508-1-bo.liu@linux.alibaba.com>
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
index fc714ef402a6..7200f3189a84 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -591,6 +591,7 @@ static void blkcg_iolatency_done_bio(struct rq_qos *rqos, struct bio *bio)
 	u64 now = ktime_to_ns(ktime_get());
 	bool issue_as_root = bio_issue_as_root_blkg(bio);
 	bool enabled = false;
+	int inflight = 0;
 
 	blkg = bio->bi_blkg;
 	if (!blkg || !bio_flagged(bio, BIO_TRACKED))
@@ -609,7 +610,8 @@ static void blkcg_iolatency_done_bio(struct rq_qos *rqos, struct bio *bio)
 		}
 		rqw = &iolat->rq_wait;
 
-		atomic_dec(&rqw->inflight);
+		inflight = atomic_dec_return(&rqw->inflight);
+		WARN_ON_ONCE(inflight < 0);
 		if (!enabled || iolat->min_lat_nsec == 0)
 			goto next;
 		iolatency_record_time(iolat, &bio->bi_issue, now,
-- 
2.20.1.2.gb21ebb6

