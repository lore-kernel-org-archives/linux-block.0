Return-Path: <SRS0=qX1g=65=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C670C433E1
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 01:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73AFA2065F
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 01:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OjVrk4ns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgEOBmW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 May 2020 21:42:22 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36106 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726170AbgEOBmV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 May 2020 21:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589506940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zLeamPVLRdoj/vFWEGMZ49e4ZeJDPS8g1FuBMBDhxY8=;
        b=OjVrk4nsSw/QE5MIp3yZYwmjBv2htPLBlfacgejlAntF2M9x+cGfxCHKpePilGdzOPPbp2
        RurHlWf65ZkrFyBgDWOtTUnHaZVI/Hmxkw6EBVKdsCJp3pVLYg0YxStLHVgMgwvKSg9HHF
        nijUbbs2y5gQXHg6fZc1GG+vluAV39o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-BQny4e4XM46fEcMP_xbgIQ-1; Thu, 14 May 2020 21:42:16 -0400
X-MC-Unique: BQny4e4XM46fEcMP_xbgIQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B821460;
        Fri, 15 May 2020 01:42:15 +0000 (UTC)
Received: from localhost (ovpn-12-94.pek2.redhat.com [10.72.12.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 72E121C8;
        Fri, 15 May 2020 01:42:14 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 2/6] blk-mq: set data->ctx and data->hctx explicitly in blk_mq_get_request
Date:   Fri, 15 May 2020 09:41:49 +0800
Message-Id: <20200515014153.2403464-3-ming.lei@redhat.com>
In-Reply-To: <20200515014153.2403464-1-ming.lei@redhat.com>
References: <20200515014153.2403464-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The only request allocation user which provides data->ctx and data->hctx
is blk_mq_alloc_request_hctx, now we have kill such use, so set
data->ctx and data->hctx explicitly in blk_mq_get_request()

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Garry <john.garry@huawei.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e2e1b6808b32..35966af878c6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -354,7 +354,6 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 	struct elevator_queue *e = q->elevator;
 	struct request *rq;
 	unsigned int tag;
-	bool clear_ctx_on_error = false;
 	u64 alloc_time_ns = 0;
 
 	blk_queue_enter_live(q);
@@ -364,13 +363,10 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 		alloc_time_ns = ktime_get_ns();
 
 	data->q = q;
-	if (likely(!data->ctx)) {
-		data->ctx = blk_mq_get_ctx(q);
-		clear_ctx_on_error = true;
-	}
-	if (likely(!data->hctx))
-		data->hctx = blk_mq_map_queue(q, data->cmd_flags,
-						data->ctx);
+
+	WARN_ON_ONCE(data->ctx || data->hctx);
+	data->ctx = blk_mq_get_ctx(q);
+	data->hctx = blk_mq_map_queue(q, data->cmd_flags, data->ctx);
 	if (data->cmd_flags & REQ_NOWAIT)
 		data->flags |= BLK_MQ_REQ_NOWAIT;
 
@@ -392,8 +388,8 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 
 	tag = blk_mq_get_tag(data);
 	if (tag == BLK_MQ_TAG_FAIL) {
-		if (clear_ctx_on_error)
-			data->ctx = NULL;
+		data->ctx = NULL;
+		data->hctx = NULL;
 		blk_queue_exit(q);
 		return NULL;
 	}
-- 
2.25.2

