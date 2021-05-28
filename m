Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93FDC4707F
	for <linux-block@archiver.kernel.org>; Fri, 28 May 2021 03:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A63CF613D4
	for <linux-block@archiver.kernel.org>; Fri, 28 May 2021 03:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234715AbhE1DWz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 May 2021 23:22:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45114 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234628AbhE1DWy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 May 2021 23:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622172080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Yjm7HIfV2/m61/Y4v0cLS+VL8hIlMQp+vkJ8feD7wPg=;
        b=he3Adj3YAtmG1OUHE7cEVgTWxpXsKuBggHO1ZIUAEMIUo+TDJa84imQ1LpcKEMXOfonRIU
        AD7Au6g5Gt8ltr2KZ/8JRKk9IBdsRIYumd4yXB1zqqvlmBNI7HZ/KccmEHr28l7ROsJd9Q
        E341YmiRLmcivhk1Rj2/DKcKJlK7X3k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-D6keXZ3sPPSb6L1k6ChwKA-1; Thu, 27 May 2021 23:21:18 -0400
X-MC-Unique: D6keXZ3sPPSb6L1k6ChwKA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44F07FC98;
        Fri, 28 May 2021 03:21:17 +0000 (UTC)
Received: from localhost (ovpn-12-72.pek2.redhat.com [10.72.12.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A00310023AF;
        Fri, 28 May 2021 03:21:13 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH] blk-mq: update hctx->dispatch_busy in case of real scheduler
Date:   Fri, 28 May 2021 11:20:55 +0800
Message-Id: <20210528032055.2242080-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 6e6fcbc27e77 ("blk-mq: support batching dispatch in case of io")
starts to support io batching submission by using hctx->dispatch_busy.

However, blk_mq_update_dispatch_busy() isn't changed to update hctx->dispatch_busy
in that commit, so fix the issue by updating hctx->dispatch_busy in case
of real scheduler.

Reported-by: Jan Kara <jack@suse.cz>
Fixes: 6e6fcbc27e77 ("blk-mq: support batching dispatch in case of io")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f11d4018ce2e..4930f7119f22 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1224,9 +1224,6 @@ static void blk_mq_update_dispatch_busy(struct blk_mq_hw_ctx *hctx, bool busy)
 {
 	unsigned int ewma;
 
-	if (hctx->queue->elevator)
-		return;
-
 	ewma = hctx->dispatch_busy;
 
 	if (!ewma && !busy)
-- 
2.29.2

