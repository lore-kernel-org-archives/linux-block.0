Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2584BC432C3
	for <linux-block@archiver.kernel.org>; Thu, 18 Mar 2021 16:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0397B64ED2
	for <linux-block@archiver.kernel.org>; Thu, 18 Mar 2021 16:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbhCRQuD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Mar 2021 12:50:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44858 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232257AbhCRQtt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Mar 2021 12:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616086189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OGFzBt2lBQvR+kYNIXjbrj2LIjdMT9WGJclN37ZNiu4=;
        b=FGWcLFLWJvj/JglHfEF+6PzD3di4LdxwR58x7Z0hTsEGmqP9Ah9l5h5d3LZNYzk9QSOELy
        Gu8Myfkx17GgY3DV7X8BiXinZwc+XxiwQoeWmFZ05e87q6kz3WuVZyrj35+K7ykYPOUbun
        80bF/PgMIpZ3Z7ZaEubrZCc8YTksAL0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-jvjTZ1-mPEWPBJd5xe_OFA-1; Thu, 18 Mar 2021 12:49:43 -0400
X-MC-Unique: jvjTZ1-mPEWPBJd5xe_OFA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E871107B79B;
        Thu, 18 Mar 2021 16:49:35 +0000 (UTC)
Received: from localhost (ovpn-12-24.pek2.redhat.com [10.72.12.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 371DE5D9C6;
        Thu, 18 Mar 2021 16:49:33 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Ming Lei <ming.lei@redhat.com>
Subject: [RFC PATCH V2 07/13] block/mq: extract one helper function polling hw queue
Date:   Fri, 19 Mar 2021 00:48:21 +0800
Message-Id: <20210318164827.1481133-8-ming.lei@redhat.com>
In-Reply-To: <20210318164827.1481133-1-ming.lei@redhat.com>
References: <20210318164827.1481133-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jeffle Xu <jefflexu@linux.alibaba.com>

Extract the logic of polling one hw queue and related statistics
handling out as the helper function.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c832faa52ca0..03f59915fe2c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3852,6 +3852,19 @@ static bool blk_mq_poll_hybrid(struct request_queue *q,
 	return blk_mq_poll_hybrid_sleep(q, rq);
 }
 
+static inline int blk_mq_poll_hctx(struct request_queue *q,
+				   struct blk_mq_hw_ctx *hctx)
+{
+	int ret;
+
+	hctx->poll_invoked++;
+	ret = q->mq_ops->poll(hctx);
+	if (ret > 0)
+		hctx->poll_success++;
+
+	return ret;
+}
+
 static int blk_bio_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 {
 	/*
@@ -3908,11 +3921,8 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 	do {
 		int ret;
 
-		hctx->poll_invoked++;
-
-		ret = q->mq_ops->poll(hctx);
+		ret = blk_mq_poll_hctx(q, hctx);
 		if (ret > 0) {
-			hctx->poll_success++;
 			__set_current_state(TASK_RUNNING);
 			return ret;
 		}
-- 
2.29.2

