Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF422C47096
	for <linux-block@archiver.kernel.org>; Fri,  4 Jun 2021 00:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B63356140B
	for <linux-block@archiver.kernel.org>; Fri,  4 Jun 2021 00:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhFDALN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Jun 2021 20:11:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29391 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229576AbhFDALN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 3 Jun 2021 20:11:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622765367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7jNl3LQFL9mHkTr7R8kJUO4wmJ8XVHENbDMxcxTKdME=;
        b=S7yTZ0dYuNccQ9aIfjAdpSb5WAyu7Yzd5q4vlxIQFQym383TTWnsaZt7EN5H3VVXO5w0Mq
        QlpVx7F7cr2UTi4/3Ajn2RW64M+GrmO+OByZAwhiIbjZNv9P95tJbK8DOp/vdNJNsYwZRC
        6eeLJQGXKLjqHHSl/gN5zbSR/N6j760=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-Nqlip1PvPlihNyeJs57V-Q-1; Thu, 03 Jun 2021 20:09:26 -0400
X-MC-Unique: Nqlip1PvPlihNyeJs57V-Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DD116D5C1;
        Fri,  4 Jun 2021 00:09:25 +0000 (UTC)
Received: from localhost (ovpn-12-139.pek2.redhat.com [10.72.12.139])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D1F02C169;
        Fri,  4 Jun 2021 00:09:21 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH V2] blk-mq: update hctx->dispatch_busy in case of real scheduler
Date:   Fri,  4 Jun 2021 08:09:15 +0800
Message-Id: <20210604000915.192286-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 6e6fcbc27e77 ("blk-mq: support batching dispatch in case of io")
starts to support io batching submission by using hctx->dispatch_busy.

However, blk_mq_update_dispatch_busy() isn't changed to update hctx->dispatch_busy
in that commit, so fix the issue by updating hctx->dispatch_busy in case
of real scheduler.

Reported-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jan Kara <jack@suse.cz>
Fixes: 6e6fcbc27e77 ("blk-mq: support batching dispatch in case of io")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4261adee9964..5af4f099cdb0 100644
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
2.31.1

