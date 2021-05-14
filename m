Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619B2C433B4
	for <linux-block@archiver.kernel.org>; Fri, 14 May 2021 02:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DA2D6141E
	for <linux-block@archiver.kernel.org>; Fri, 14 May 2021 02:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbhENCWU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 May 2021 22:22:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31893 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230333AbhENCWU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 May 2021 22:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620958869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oln9fP+SDR62RC4VIKKcTfo3SsR0UfZ9c0gAs5YAlcg=;
        b=CaQCmXnRRQMdSB0algrCgZK9v0iccEmYt2VzcPGeKsYl1OeT0nh0TA5/NyDLkehgg+OOEd
        XssWXv1bvLMaqFUQfRcUuYq0kcoRh/ZY6ZzFh8tm48CJNDO2+5wOHndMAXW88xoVK9zIn/
        mnbKuTnn4CNS3aXIg7nRHFh26MZyTLQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-8y95JClyO_6y78IPGtXA3A-1; Thu, 13 May 2021 22:21:07 -0400
X-MC-Unique: 8y95JClyO_6y78IPGtXA3A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7008F1005D47;
        Fri, 14 May 2021 02:21:06 +0000 (UTC)
Received: from localhost (ovpn-12-87.pek2.redhat.com [10.72.12.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 71C855D6AC;
        Fri, 14 May 2021 02:20:59 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Yanhui Ma <yama@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        kashyap.desai@broadcom.com
Subject: [PATCH] blk-mq: plug request for shared sbitmap
Date:   Fri, 14 May 2021 10:20:52 +0800
Message-Id: <20210514022052.1047665-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In case of shared sbitmap, request won't be held in plug list any more
sine commit 32bc15afed04 ("blk-mq: Facilitate a shared sbitmap per
tagset"), this way makes request merge from flush plug list & batching
submission not possible, so cause performance regression.

Yanhui reports performance regression when running sequential IO
test(libaio, 16 jobs, 8 depth for each job) in VM, and the VM disk
is emulated with image stored on xfs/megaraid_sas.

Fix the issue by recovering original behavior to allow to hold request
in plug list.

Cc: Yanhui Ma <yama@redhat.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: kashyap.desai@broadcom.com
Fixes: 32bc15afed04 ("blk-mq: Facilitate a shared sbitmap per tagset")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ae7f5ee41cd3..baf7a9546068 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2236,8 +2236,9 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 		/* Bypass scheduler for flush requests */
 		blk_insert_flush(rq);
 		blk_mq_run_hw_queue(data.hctx, true);
-	} else if (plug && (q->nr_hw_queues == 1 || q->mq_ops->commit_rqs ||
-				!blk_queue_nonrot(q))) {
+	} else if (plug && (q->nr_hw_queues == 1 ||
+		   blk_mq_is_sbitmap_shared(rq->mq_hctx->flags) ||
+		   q->mq_ops->commit_rqs || !blk_queue_nonrot(q))) {
 		/*
 		 * Use plugging if we have a ->commit_rqs() hook as well, as
 		 * we know the driver uses bd->last in a smart fashion.
-- 
2.29.2

