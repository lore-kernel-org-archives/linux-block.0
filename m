Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94D6C2D0F8
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 03:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94E16205ED
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 03:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PGWxl/Pr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgEMDss (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 May 2020 23:48:48 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60002 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727107AbgEMDsr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 May 2020 23:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589341726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cRN4fvBlbA692u6w3wONDOYbS3q4737Kd7pKANbh94s=;
        b=PGWxl/Pr3ZftcB2cpSqBgzmop3mXP6HvWR+nS+QbdyjID66khScIRkrdDFYsfEZSkT4Knm
        /MkBajOoyNKt8GQdJUUAfFgGGeVDquynq0g7TKtPcrZiUecnituGoEme17IJajiXKnPlg0
        22fLBNIiOkEjJL5suP/RBAGsfa1INi4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-PuIq99YOOdSHPQoXOzc_5w-1; Tue, 12 May 2020 23:48:44 -0400
X-MC-Unique: PuIq99YOOdSHPQoXOzc_5w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6049C83DE6C;
        Wed, 13 May 2020 03:48:42 +0000 (UTC)
Received: from localhost (ovpn-12-166.pek2.redhat.com [10.72.12.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC04175286;
        Wed, 13 May 2020 03:48:38 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH V11 03/12] blk-mq: mark blk_mq_get_driver_tag as static
Date:   Wed, 13 May 2020 11:47:54 +0800
Message-Id: <20200513034803.1844579-4-ming.lei@redhat.com>
In-Reply-To: <20200513034803.1844579-1-ming.lei@redhat.com>
References: <20200513034803.1844579-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now all callers of blk_mq_get_driver_tag are in blk-mq.c, so mark
it as static.

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Garry <john.garry@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 2 +-
 block/blk-mq.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9ee695bdf873..53c6e7678c14 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1015,7 +1015,7 @@ static inline unsigned int queued_to_index(unsigned int queued)
 	return min(BLK_MQ_MAX_DISPATCH_ORDER - 1, ilog2(queued) + 1);
 }
 
-bool blk_mq_get_driver_tag(struct request *rq)
+static bool blk_mq_get_driver_tag(struct request *rq)
 {
 	struct blk_mq_alloc_data data = {
 		.q = rq->q,
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 10bfdfb494fa..e7d1da4b1f73 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -44,7 +44,6 @@ bool blk_mq_dispatch_rq_list(struct request_queue *, struct list_head *, bool);
 void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
 				bool kick_requeue_list);
 void blk_mq_flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head *list);
-bool blk_mq_get_driver_tag(struct request *rq);
 struct request *blk_mq_dequeue_from_ctx(struct blk_mq_hw_ctx *hctx,
 					struct blk_mq_ctx *start);
 
-- 
2.25.2

