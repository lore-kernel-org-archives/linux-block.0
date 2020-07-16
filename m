Return-Path: <SRS0=Ci6H=A3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F3CC433DF
	for <linux-block@archiver.kernel.org>; Thu, 16 Jul 2020 06:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18CE2206F4
	for <linux-block@archiver.kernel.org>; Thu, 16 Jul 2020 06:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgGPGvA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jul 2020 02:51:00 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60380 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728139AbgGPGvA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jul 2020 02:51:00 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E3FB81A860EF525CAD5B;
        Thu, 16 Jul 2020 14:50:54 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Thu, 16 Jul 2020
 14:50:53 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <tj@kernel.org>, <hch@lst.de>
Subject: [RFC PATCH] block: defer flush request no matter whether we have elevator
Date:   Thu, 16 Jul 2020 02:52:01 -0400
Message-ID: <20200716065201.3213045-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 7520872c0cf4 ("block: don't defer flushes on blk-mq + scheduling")
tried to fix deadlock for cycled wait between flush requests and data
request into flush_data_in_flight. The former holded all driver tags
and wait for data request completion, but the latter can not complete
for waiting free driver tags.

After commit 923218f6166a ("blk-mq: don't allocate driver tag upfront
for flush rq"), flush requests will not get driver tag before queuing
into flush queue.

* With elevator, flush request just get sched_tags before inserting
  flush queue. It will not get driver tag until issue them to driver.
  data request on list fq->flush_data_in_flight will complete in
  the end.

* Without elevator, each flush request will get a driver tag when
  allocate request. Then data request on fq->flush_data_in_flight
  don't worry about lacking driver tag.

In both of these cases, cycled wait cannot be true. So we may allow
to defer flush request.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/blk-flush.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 15ae0155ec07..24c208d21793 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -286,13 +286,8 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
 	if (fq->flush_pending_idx != fq->flush_running_idx || list_empty(pending))
 		return;
 
-	/* C2 and C3
-	 *
-	 * For blk-mq + scheduling, we can risk having all driver tags
-	 * assigned to empty flushes, and we deadlock if we are expecting
-	 * other requests to make progress. Don't defer for that case.
-	 */
-	if (!list_empty(&fq->flush_data_in_flight) && q->elevator &&
+	/* C2 and C3 */
+	if (!list_empty(&fq->flush_data_in_flight) &&
 	    time_before(jiffies,
 			fq->flush_pending_since + FLUSH_PENDING_TIMEOUT))
 		return;
-- 
2.25.4

