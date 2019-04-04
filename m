Return-Path: <SRS0=51nD=SG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AD4C4360F
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 08:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD82C20855
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 08:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfDDInu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:43:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60154 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfDDInu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Apr 2019 04:43:50 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BF54070D64;
        Thu,  4 Apr 2019 08:43:49 +0000 (UTC)
Received: from localhost (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0124C1001E65;
        Thu,  4 Apr 2019 08:43:45 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
Subject: [PATCH V4 3/7] blk-mq: quiesce queue before updating nr_hw_queues
Date:   Thu,  4 Apr 2019 16:43:16 +0800
Message-Id: <20190404084320.24681-4-ming.lei@redhat.com>
In-Reply-To: <20190404084320.24681-1-ming.lei@redhat.com>
References: <20190404084320.24681-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 04 Apr 2019 08:43:49 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Inside __blk_mq_update_nr_hw_queues(), only request queues are frozen
before updating nr_hw_queues.

However, even though blk_mq_freeze_queue() is returned, there might be
run queue activity not completed, then use-after-free may be triggered
on hctx and its fields.

Fix this issue by really quiescing queue via blk_mq_quiesce_queue() and
blk_sync_queue() for making sure no any run queue activity pending
before releasing hctx.

Cc: Dongli Zhang <dongli.zhang@oracle.com>
Cc: James Smart <james.smart@broadcom.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-scsi@vger.kernel.org,
Cc: Martin K . Petersen <martin.petersen@oracle.com>,
Cc: Christoph Hellwig <hch@lst.de>,
Cc: James E . J . Bottomley <jejb@linux.vnet.ibm.com>,
Cc: jianchao wang <jianchao.w.wang@oracle.com>
Reported-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b512ba0cb359..41c12d9008b7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3224,8 +3224,11 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	if (nr_hw_queues < 1 || nr_hw_queues == set->nr_hw_queues)
 		return;
 
-	list_for_each_entry(q, &set->tag_list, tag_set_list)
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		blk_mq_freeze_queue(q);
+		blk_mq_quiesce_queue(q);
+		blk_sync_queue(q);
+	}
 	/*
 	 * Sync with blk_mq_queue_tag_busy_iter.
 	 */
@@ -3269,8 +3272,10 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		blk_mq_elv_switch_back(&head, q);
 
-	list_for_each_entry(q, &set->tag_list, tag_set_list)
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		blk_mq_unquiesce_queue(q);
 		blk_mq_unfreeze_queue(q);
+	}
 }
 
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
-- 
2.9.5

