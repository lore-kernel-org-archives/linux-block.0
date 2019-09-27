Return-Path: <SRS0=f8eR=XW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2A8C4360C
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 07:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD801206B7
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 07:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfI0HZN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Sep 2019 03:25:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54308 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfI0HZN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Sep 2019 03:25:13 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 10413307D962;
        Fri, 27 Sep 2019 07:25:13 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 337A21000337;
        Fri, 27 Sep 2019 07:25:09 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: [PATCH 2/2] blk-mq: apply normal plugging for HDD
Date:   Fri, 27 Sep 2019 15:24:31 +0800
Message-Id: <20190927072431.23901-3-ming.lei@redhat.com>
In-Reply-To: <20190927072431.23901-1-ming.lei@redhat.com>
References: <20190927072431.23901-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 27 Sep 2019 07:25:13 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some HDD drive may expose multiple hw queue, such as MegraRaid, so
still apply the normal plugging for such devices because sequential IO
may benefit a lot from plug merging.

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d7aed6518e62..969dfe02fa7c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1983,10 +1983,14 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		/* bypass scheduler for flush rq */
 		blk_insert_flush(rq);
 		blk_mq_run_hw_queue(data.hctx, true);
-	} else if (plug && (q->nr_hw_queues == 1 || q->mq_ops->commit_rqs)) {
+	} else if (plug && (q->nr_hw_queues == 1 || q->mq_ops->commit_rqs ||
+				!blk_queue_nonrot(q))) {
 		/*
 		 * Use plugging if we have a ->commit_rqs() hook as well, as
 		 * we know the driver uses bd->last in a smart fashion.
+		 *
+		 * Use normal plugging if this disk is slow HDD, as sequential
+		 * IO may benefit a lot from plug merging.
 		 */
 		unsigned int request_count = plug->rq_count;
 		struct request *last = NULL;
-- 
2.20.1

