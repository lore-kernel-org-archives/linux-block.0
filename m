Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB11ECA90AF
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 10:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9139F2064A
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 10:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W2eMQho/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbgEMKfB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 06:35:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56001 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728258AbgEMKfA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 06:35:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589366099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WjAGY+vKS5FKu5XUsMlPEwLGZwBbU8EiD+qbeGnL3L4=;
        b=W2eMQho/WIBt8ePQnLQoA7zy3shvkSnKoGMLdIdUCyEiKRtBx33CzFBbM1mDjJ9/817dUl
        TJZwHXvRM853JHhJMKlO/NoHwfoPmmpGVjSQ8xGj91vjBEjVkR2pTwWwoYHjv0jCPaa0XE
        HFrSCOaXM+xfyz1uCfqQ5kDVzpuJAIA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-ucgh7CpTOReteWnmcdQDSA-1; Wed, 13 May 2020 06:34:57 -0400
X-MC-Unique: ucgh7CpTOReteWnmcdQDSA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E52AC8014C0;
        Wed, 13 May 2020 10:34:55 +0000 (UTC)
Received: from T590 (ovpn-12-166.pek2.redhat.com [10.72.12.166])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F62960C05;
        Wed, 13 May 2020 10:34:49 +0000 (UTC)
Date:   Wed, 13 May 2020 18:34:45 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH V12 10/12] block: add request allocation flag of
 BLK_MQ_REQ_FORCE
Message-ID: <20200513103445.GB2038938@T590>
References: <20200513034803.1844579-1-ming.lei@redhat.com>
 <20200513034803.1844579-11-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513034803.1844579-11-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From 1151afd4c11997c2769c385586097bf4f1cf60ce Mon Sep 17 00:00:00 2001
From: Ming Lei <ming.lei@redhat.com>
Date: Mon, 11 May 2020 15:43:28 +0800
Subject: [PATCH V12 10/12] block: add request allocation flag of
 BLK_MQ_REQ_FORCE

When one hctx becomes inactive, there may be requests allocated from
this hctx, we can't queue them to the inactive hctx, one approach is
to re-submit them via one active hctx.

However, the request queue may have been started to freeze, and allocating
request becomes not possible. Add flag of BLK_MQ_REQ_FORCE to allow block
layer to allocate request in this case becasue the queue won't be frozen
completely before all requests allocated from inactive hctx are completed.

The similar approach has been applied in commit 8dc765d438f1 ("SCSI: fix queue
cleanup race before queue initialization is done").

This way can help on other request dependency case too, such as, storage
device side has some problem, and IO request can't be queued to device
successfully, and passthrough request is required to fix the device problem.
If queue freeze just comes before allocating passthrough request, hang will be
triggered in queue freeze process, IO process and context for allocating
passthrough request forever. See commit 01e99aeca397 ("blk-mq: insert passthrough
request into hctx->dispatch directly") for background of this kind of issue.

Cc: John Garry <john.garry@huawei.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V12:
	- one line change for not warning on BLK_MQ_REQ_FORCE

 block/blk-core.c       | 8 +++++++-
 include/linux/blk-mq.h | 7 +++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index ffb1579fd4da..c4e306f0e6fd 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -430,6 +430,11 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 		if (success)
 			return 0;
 
+		if (flags & BLK_MQ_REQ_FORCE) {
+			percpu_ref_get(&q->q_usage_counter);
+			return 0;
+		}
+
 		if (flags & BLK_MQ_REQ_NOWAIT)
 			return -EBUSY;
 
@@ -617,7 +622,8 @@ struct request *blk_get_request(struct request_queue *q, unsigned int op,
 	struct request *req;
 
 	WARN_ON_ONCE(op & REQ_NOWAIT);
-	WARN_ON_ONCE(flags & ~(BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_PREEMPT));
+	WARN_ON_ONCE(flags & ~(BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_PREEMPT |
+				BLK_MQ_REQ_FORCE));
 
 	req = blk_mq_alloc_request(q, op, flags);
 	if (!IS_ERR(req) && q->mq_ops->initialize_rq_fn)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index c2ea0a6e5b56..7d7aa5305a67 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -448,6 +448,13 @@ enum {
 	BLK_MQ_REQ_INTERNAL	= (__force blk_mq_req_flags_t)(1 << 2),
 	/* set RQF_PREEMPT */
 	BLK_MQ_REQ_PREEMPT	= (__force blk_mq_req_flags_t)(1 << 3),
+
+	/*
+	 * force to allocate request and caller has to make sure queue
+	 * won't be frozen completely during allocation, and this flag
+	 * is only applied after queue freeze is started
+	 */
+	BLK_MQ_REQ_FORCE	= (__force blk_mq_req_flags_t)(1 << 4),
 };
 
 struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
-- 
2.25.2

