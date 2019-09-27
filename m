Return-Path: <SRS0=f8eR=XW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CF0C4360C
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 07:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 275C1206B7
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 07:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfI0HZH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Sep 2019 03:25:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58718 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbfI0HZH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Sep 2019 03:25:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 789E93090FD6;
        Fri, 27 Sep 2019 07:25:07 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 44BA35D9C3;
        Fri, 27 Sep 2019 07:25:03 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: [PATCH 1/2] blk-mq: respect io scheduler
Date:   Fri, 27 Sep 2019 15:24:30 +0800
Message-Id: <20190927072431.23901-2-ming.lei@redhat.com>
In-Reply-To: <20190927072431.23901-1-ming.lei@redhat.com>
References: <20190927072431.23901-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 27 Sep 2019 07:25:07 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now in case of real MQ, io scheduler may be bypassed, and not only this
way may hurt performance for some slow MQ device, but also break zoned
device which depends on mq-deadline for respecting the write order in
one zone.

So don't bypass io scheduler if we have one setup.

This patch can double sequential write performance basically on MQ
scsi_debug when mq-deadline is applied.

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 20a49be536b5..d7aed6518e62 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2003,6 +2003,8 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		}
 
 		blk_add_rq_to_plug(plug, rq);
+	} else if (q->elevator) {
+		blk_mq_sched_insert_request(rq, false, true, true);
 	} else if (plug && !blk_queue_nomerges(q)) {
 		/*
 		 * We do limited plugging. If the bio can be merged, do that.
@@ -2026,8 +2028,8 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 			blk_mq_try_issue_directly(data.hctx, same_queue_rq,
 					&cookie);
 		}
-	} else if ((q->nr_hw_queues > 1 && is_sync) || (!q->elevator &&
-			!data.hctx->dispatch_busy)) {
+	} else if ((q->nr_hw_queues > 1 && is_sync) ||
+			!data.hctx->dispatch_busy) {
 		blk_mq_try_issue_directly(data.hctx, rq, &cookie);
 	} else {
 		blk_mq_sched_insert_request(rq, false, true, true);
-- 
2.20.1

