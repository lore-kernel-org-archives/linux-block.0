Return-Path: <SRS0=9ToN=AL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4772AC433E0
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 10:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19DD520771
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 10:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DjCXIhPl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732434AbgF3KZk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jun 2020 06:25:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49285 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732452AbgF3KZi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jun 2020 06:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593512737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IByy82y7HuBW6Y3JaXB/0a1+G6TgF2ex3DZ0VWkVc3A=;
        b=DjCXIhPl5J8YYoQ+BrLyELLK7f3fmRYSF45pxKjEh3IgE6bKs7tbNb1j0JV4K4DWmoAvBL
        K3Uhg1ZdekOrnON2RUVzyNffFlMZ5URak2XY4tjY5Yl9dG3izutqh5yZvm9KGc2l8bgtHs
        BFv2hoiGZcOVYSJ+4cqK7Vl74HSjlUQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-IwVrQfAkNxuom6qrfa5qoA-1; Tue, 30 Jun 2020 06:25:35 -0400
X-MC-Unique: IwVrQfAkNxuom6qrfa5qoA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 055C6107ACCD;
        Tue, 30 Jun 2020 10:25:34 +0000 (UTC)
Received: from localhost (ovpn-13-98.pek2.redhat.com [10.72.13.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5365C7BEA0;
        Tue, 30 Jun 2020 10:25:32 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH V7 4/6] blk-mq: remove dead check from blk_mq_dispatch_rq_list
Date:   Tue, 30 Jun 2020 18:24:59 +0800
Message-Id: <20200630102501.2238972-5-ming.lei@redhat.com>
In-Reply-To: <20200630102501.2238972-1-ming.lei@redhat.com>
References: <20200630102501.2238972-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@infradead.org>
Tested-by: Baolin Wang <baolin.wang7@gmail.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 39a2332e32ac..0a6fb6d647f6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1482,13 +1482,6 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
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

