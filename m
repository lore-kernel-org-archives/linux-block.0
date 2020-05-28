Return-Path: <SRS0=lWBJ=7K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48F5C433DF
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 08:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 972E820B80
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 08:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dNAOepua"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgE1IBi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 May 2020 04:01:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25045 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726063AbgE1IBh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 May 2020 04:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590652897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W6Xjw5gPXIvbU87+iZzl5PEABi/070RhWYChETIhYtU=;
        b=dNAOepuayJqmH3M6E7mAoyYdRPSxSyLjFo8Gz3wCPmnRTG7KIN3eDGTXOkIZxjVMa0w6xD
        fvdmcdctFgLes0tXsIN5hxyjqWcIlfX3R8Alf0WcSv4mE/EpHfP5tbv0sd2lx3+wbbMmoy
        0QymYxdRp3S9xFwJ7IpuH2P0OHYhxI8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-2f6zWwjSOWaEofZnfcDgEQ-1; Thu, 28 May 2020 04:01:33 -0400
X-MC-Unique: 2f6zWwjSOWaEofZnfcDgEQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D281F10524FF;
        Thu, 28 May 2020 08:01:31 +0000 (UTC)
Received: from localhost (ovpn-12-189.pek2.redhat.com [10.72.12.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 75C822B473;
        Thu, 28 May 2020 08:01:28 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH V3 4/6] blk-mq: remove dead check from blk_mq_dispatch_rq_list
Date:   Thu, 28 May 2020 16:00:51 +0800
Message-Id: <20200528080053.1062653-5-ming.lei@redhat.com>
In-Reply-To: <20200528080053.1062653-1-ming.lei@redhat.com>
References: <20200528080053.1062653-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d97403cb6229..d41a0bffde88 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1376,13 +1376,6 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
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

