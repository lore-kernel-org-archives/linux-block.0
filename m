Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25D4C433B4
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 03:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B13E361154
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 03:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhDOD5E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Apr 2021 23:57:04 -0400
Received: from mail.wangsu.com ([123.103.51.227]:43112 "EHLO wangsu.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S229457AbhDOD5D (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Apr 2021 23:57:03 -0400
Received: from fedora33.wangsu.com (unknown [183.253.10.81])
        by app2 (Coremail) with SMTP id 4zNnewCX+HFgtndgywwCAA--.3584S2;
        Thu, 15 Apr 2021 11:43:32 +0800 (CST)
From:   Lin Feng <linf@wangsu.com>
To:     axboe@kernel.dk, paolo.valente@linaro.org
Cc:     linux-block@vger.kernel.org, ming.lei@redhat.com, linf@wangsu.com,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] bfq/mq-deadline: remove redundant check for passthrough request
Date:   Thu, 15 Apr 2021 11:43:26 +0800
Message-Id: <20210415034326.214227-1-linf@wangsu.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 4zNnewCX+HFgtndgywwCAA--.3584S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4UtFWrCFWDGF4kGrW7urg_yoW8Aw1Dpw
        s3Wan0yFW5WrWFqF1xua15XayxXws3Ar9rtrWYqrZavFnxursrX3Z5K3W2vFyfZrs3ur42
        9rs8t3yxXF1jva7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyY1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
        z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
        xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26r48McIj6xkF7I0En7xvr7AKxVW8
        Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
        AqYI8I648v4I1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8GwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
        JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6F
        yj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4U
        JbIYCTnIWIevJa73UjIFyTuYvjfUcLZ2DUUUU
X-CM-SenderInfo: holqwq5zdqw23xof0z/
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since commit 01e99aeca39796003 'blk-mq: insert passthrough request into
hctx->dispatch directly', passthrough request should not appear in
IO-scheduler any more, so blk_rq_is_passthrough checking in addon IO
schedulers is redundant.

(Notes: this patch passes generic IO load test with hdds under SAS
controller and hdds under AHCI controller but obviously not covers all.
Not sure if passthrough request can still escape into IO scheduler from
blk_mq_sched_insert_requests, which is used by blk_mq_flush_plug_list and
has lots of indirect callers.)

Signed-off-by: Lin Feng <linf@wangsu.com>
---
 block/bfq-iosched.c | 2 +-
 block/mq-deadline.c | 7 ++-----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 95586137194e..b827c9212b02 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5627,7 +5627,7 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 
 	spin_lock_irq(&bfqd->lock);
 	bfqq = bfq_init_rq(rq);
-	if (!bfqq || at_head || blk_rq_is_passthrough(rq)) {
+	if (!bfqq || at_head) {
 		if (at_head)
 			list_add(&rq->queuelist, &bfqd->dispatch);
 		else
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index f3631a287466..04aded71ead2 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -500,11 +500,8 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 
 	trace_block_rq_insert(rq);
 
-	if (at_head || blk_rq_is_passthrough(rq)) {
-		if (at_head)
-			list_add(&rq->queuelist, &dd->dispatch);
-		else
-			list_add_tail(&rq->queuelist, &dd->dispatch);
+	if (at_head) {
+		list_add(&rq->queuelist, &dd->dispatch);
 	} else {
 		deadline_add_rq_rb(dd, rq);
 
-- 
2.30.2

