Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1F3C4742C
	for <linux-block@archiver.kernel.org>; Fri, 13 Nov 2020 13:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9403822248
	for <linux-block@archiver.kernel.org>; Fri, 13 Nov 2020 13:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bxXmkfaL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgKMNpD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Nov 2020 08:45:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36283 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726160AbgKMNpC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Nov 2020 08:45:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605275101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AP4wz3fH9xbIWbZxyf9DiD87AKLSleg+pwUD+FKYOag=;
        b=bxXmkfaLLazhkPNoy9ZPUlxsFGvd9HiRjDqrfIOYNEfYnz//u9uynpg1m2hFhlsMtLGiwR
        Gs2ap167rzTdkoJYIoBvqSbI8+fl/Q6uRbaZPcjO6RDl+nxsgcM/1DWuHauo1VSASd1N0C
        zTpS5CY8ej6bm0/ZVapzzN3hhoaSIgE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-91Nc7DuXNO-b3TNTV9Cf5Q-1; Fri, 13 Nov 2020 08:44:59 -0500
X-MC-Unique: 91Nc7DuXNO-b3TNTV9Cf5Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5D8310199A9;
        Fri, 13 Nov 2020 13:44:58 +0000 (UTC)
Received: from localhost (ovpn-12-41.pek2.redhat.com [10.72.12.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E99215D9F3;
        Fri, 13 Nov 2020 13:44:51 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH] block: mark flush request as IDLE when it is really finished
Date:   Fri, 13 Nov 2020 21:44:48 +0800
Message-Id: <20201113134448.1074373-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For avoiding use-after-free on flush request, we call its .end_io() from
both timeout code path and __blk_mq_end_request().

When flush request's ref doesn't drop to zero, it is still used, we
can't mark it as IDLE, so fix it by marking IDLE when its refcount drops
to zero really.

Fixes: 65ff5cd04551 ("blk-mq: mark flush request as IDLE in flush_end_io()")
Cc: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-flush.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index c64f049226f6..23124d60cffe 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -224,13 +224,18 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
 	/* release the tag's ownership to the req cloned from */
 	spin_lock_irqsave(&fq->mq_flush_lock, flags);
 
-	WRITE_ONCE(flush_rq->state, MQ_RQ_IDLE);
 	if (!refcount_dec_and_test(&flush_rq->ref)) {
 		fq->rq_status = error;
 		spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
 		return;
 	}
 
+	/*
+	 * Flush request has to be marked as IDLE when it is really ended
+	 * because its .end_io() is called from timeout code path too for
+	 * avoiding use-after-free.
+	 */
+	WRITE_ONCE(flush_rq->state, MQ_RQ_IDLE);
 	if (fq->rq_status != BLK_STS_OK)
 		error = fq->rq_status;
 
-- 
2.25.4

