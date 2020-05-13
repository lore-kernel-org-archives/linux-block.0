Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C93C2D0FA
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 09:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFB9B23127
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 09:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CPATM2G6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388280AbgEMJzh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 05:55:37 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40367 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732931AbgEMJzg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 05:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589363735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3+MUoZzwMp13HCBwCfJu9RTOqS7FEeQK4jsKE3Q2QLs=;
        b=CPATM2G6ZGI0iOIjr52ZcmTRddGB1DK4as7BYYFmBCwbeH66QBIp0eFVAYI32VVqxz+hnC
        142HZuqeWQl9djkeC97ekvyprcN0GB75HAD7gZe8gRnGE6UMgKSe+ABEG1SUlwhuLj8K/X
        wN85Rfv/3Y+e/ymnlUmla9EpDQXPq4A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-QLcLi5pFO0ioiMQU_MjnxQ-1; Wed, 13 May 2020 05:55:33 -0400
X-MC-Unique: QLcLi5pFO0ioiMQU_MjnxQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F5EF8015CE;
        Wed, 13 May 2020 09:55:32 +0000 (UTC)
Received: from localhost (ovpn-12-166.pek2.redhat.com [10.72.12.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8222E60C84;
        Wed, 13 May 2020 09:55:31 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 7/9] blk-mq: remove dead check from blk_mq_dispatch_rq_list
Date:   Wed, 13 May 2020 17:54:41 +0800
Message-Id: <20200513095443.2038859-8-ming.lei@redhat.com>
In-Reply-To: <20200513095443.2038859-1-ming.lei@redhat.com>
References: <20200513095443.2038859-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When BLK_STS_RESOURCE or BLK_STS_DEV_RESOURCE is returned from
.queue_rq, the 'list' variable always holds this rq which isn't
queued to LLD successfully.

So blk_mq_dispatch_rq_list() always returns false from the branch
of '!list_empty(list)'.

No functional change.

Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Baolin Wang <baolin.wang7@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 86beb8c66868..3e3fbb13f3b9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1366,13 +1366,6 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 	} else
 		blk_mq_update_dispatch_busy(hctx, false);
 
-	/*
-	 * If the host/device is unable to accept more work, inform the
-	 * caller of that.
-	 */
-	if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE)
-		return false;
-
 	return (queued + errors) != 0;
 }
 
-- 
2.25.2

