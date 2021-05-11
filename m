Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FEAC433ED
	for <linux-block@archiver.kernel.org>; Tue, 11 May 2021 15:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F6B96192B
	for <linux-block@archiver.kernel.org>; Tue, 11 May 2021 15:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhEKPYC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 May 2021 11:24:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26031 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231561AbhEKPYA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 May 2021 11:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620746573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1LpDi19SU3PFBkqaiQ+sTOnxlbtP/1KV4QwaoUVnAeY=;
        b=WhnzLBtAl5CG+YNx19DiYg9G7CalK2CwedXQXZtxM+ItpkE0YWwYmPV6RMiXgXXN+gdrem
        F9sSPeKlnERQC1MT9G8NtMih91+pQrwoAZ9lBwqc771bYAKQGRSdoV34WUgqWqii/nGWbm
        kSw/8bFVxvIjgNLB918jM0ssz5gvuCI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-ozS5bdbSPbyuepP16BquiA-1; Tue, 11 May 2021 11:22:51 -0400
X-MC-Unique: ozS5bdbSPbyuepP16BquiA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 845CF18766E7;
        Tue, 11 May 2021 15:22:50 +0000 (UTC)
Received: from localhost (ovpn-12-205.pek2.redhat.com [10.72.12.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 90A3D1B427;
        Tue, 11 May 2021 15:22:49 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        Christoph Hellwig <hch@lst.de>,
        David Jeffery <djeffery@redhat.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V7 1/4] block: avoid double io accounting for flush request
Date:   Tue, 11 May 2021 23:22:33 +0800
Message-Id: <20210511152236.763464-2-ming.lei@redhat.com>
In-Reply-To: <20210511152236.763464-1-ming.lei@redhat.com>
References: <20210511152236.763464-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For flush request, rq->end_io() may be called two times, one is from
timeout handling(blk_mq_check_expired()), another is from normal
completion(__blk_mq_end_request()).

Move blk_account_io_flush() after flush_rq->ref drops to zero, so
io accounting can be done just once for flush request.

Fixes: b68663186577 ("block: add iostat counters for flush requests")
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: John Garry <john.garry@huawei.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-flush.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 7942ca6ed321..1002f6c58181 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -219,8 +219,6 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
 	unsigned long flags = 0;
 	struct blk_flush_queue *fq = blk_get_flush_queue(q, flush_rq->mq_ctx);
 
-	blk_account_io_flush(flush_rq);
-
 	/* release the tag's ownership to the req cloned from */
 	spin_lock_irqsave(&fq->mq_flush_lock, flags);
 
@@ -230,6 +228,7 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
 		return;
 	}
 
+	blk_account_io_flush(flush_rq);
 	/*
 	 * Flush request has to be marked as IDLE when it is really ended
 	 * because its .end_io() is called from timeout code path too for
-- 
2.29.2

