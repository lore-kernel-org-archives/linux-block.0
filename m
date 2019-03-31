Return-Path: <SRS0=bw4W=SC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78424C10F00
	for <linux-block@archiver.kernel.org>; Sun, 31 Mar 2019 03:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46CC4218A3
	for <linux-block@archiver.kernel.org>; Sun, 31 Mar 2019 03:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731073AbfCaDKP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 30 Mar 2019 23:10:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35174 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730061AbfCaDKP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 Mar 2019 23:10:15 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 41F99C0641E2;
        Sun, 31 Mar 2019 03:10:15 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 66CD96013A;
        Sun, 31 Mar 2019 03:10:12 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
Subject: [PATCH 2/5] blk-mq: re-organize blk_mq_exit_hw_queues() into two parts
Date:   Sun, 31 Mar 2019 11:09:51 +0800
Message-Id: <20190331030954.22320-3-ming.lei@redhat.com>
In-Reply-To: <20190331030954.22320-1-ming.lei@redhat.com>
References: <20190331030954.22320-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Sun, 31 Mar 2019 03:10:15 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch re-organizes blk_mq_exit_hw_queues() into two parts, and
one part is for exit hw queues really, and another part is for free
hw queues.

No function change, just prepare for fixing hctx lifetime issue.

Cc: James Smart <james.smart@broadcom.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-scsi@vger.kernel.org,
Cc: Martin K . Petersen <martin.petersen@oracle.com>,
Cc: Christoph Hellwig <hch@lst.de>,
Cc: James E . J . Bottomley <jejb@linux.vnet.ibm.com>,
Cc: jianchao wang <jianchao.w.wang@oracle.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 53265ce45238..a264d1967396 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2265,8 +2265,17 @@ static void blk_mq_exit_hw_queues(struct request_queue *q,
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (i == nr_queue)
 			break;
-		blk_mq_debugfs_unregister_hctx(hctx);
 		blk_mq_exit_hctx(q, set, hctx, i);
+	}
+}
+
+static void blk_mq_free_hw_queues(struct request_queue *q)
+{
+	struct blk_mq_hw_ctx *hctx;
+	unsigned int i;
+
+	queue_for_each_hw_ctx(q, hctx, i) {
+		blk_mq_debugfs_unregister_hctx(hctx);
 		blk_mq_free_hctx(q, hctx);
 	}
 }
@@ -2893,6 +2902,7 @@ void blk_mq_free_queue(struct request_queue *q)
 
 	blk_mq_del_queue_tag_set(q);
 	blk_mq_exit_hw_queues(q, set, set->nr_hw_queues);
+	blk_mq_free_hw_queues(q);
 }
 
 static int __blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
-- 
2.9.5

