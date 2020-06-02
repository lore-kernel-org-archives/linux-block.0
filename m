Return-Path: <SRS0=F1yh=7P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91A5C433E1
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 09:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7D02206C3
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 09:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ahnYMkvL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgFBJPq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Jun 2020 05:15:46 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43600 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726174AbgFBJPp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Jun 2020 05:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591089344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WoyPxFuoNqpxCUGKApFEixGOx7Ttl2wzxIBmgLr8xpk=;
        b=ahnYMkvL+cx48On4f8IPn67gpRVPdtoBrGhQYMOQ4rVyHK32xzjVbcrW8/Hd054YsLWjd5
        1kkJBVR8H0cr2aIbzdWM1a4+4Ty54EPve1T/eEUiwlVJ/hAY4pfyzb88OIsU+Bvy9fVsMM
        Nm8WQErN0+bVqrSZtatWhixDKGvW6vo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-4imAGeexOt6hUOmSYK7FIw-1; Tue, 02 Jun 2020 05:15:40 -0400
X-MC-Unique: 4imAGeexOt6hUOmSYK7FIw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22897464;
        Tue,  2 Jun 2020 09:15:39 +0000 (UTC)
Received: from localhost (ovpn-12-167.pek2.redhat.com [10.72.12.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B4B4710013D5;
        Tue,  2 Jun 2020 09:15:35 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH V4 4/6] blk-mq: remove dead check from blk_mq_dispatch_rq_list
Date:   Tue,  2 Jun 2020 17:15:00 +0800
Message-Id: <20200602091502.1822499-5-ming.lei@redhat.com>
In-Reply-To: <20200602091502.1822499-1-ming.lei@redhat.com>
References: <20200602091502.1822499-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Tested-by: Baolin Wang <baolin.wang7@gmail.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ee9342aac7be..0e3aab91e6c0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1413,13 +1413,6 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
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

