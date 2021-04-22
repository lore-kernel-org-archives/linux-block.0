Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D894C43461
	for <linux-block@archiver.kernel.org>; Thu, 22 Apr 2021 12:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E74DC61164
	for <linux-block@archiver.kernel.org>; Thu, 22 Apr 2021 12:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236286AbhDVMWx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Apr 2021 08:22:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47317 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236150AbhDVMWx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Apr 2021 08:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619094138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GvVJ45Y3GWmeUhVFMQCO+Y9ILBOe8NcQbQI/uHP2HDU=;
        b=V6MFktj/WSNNLk1xBxVjquPqJfEgZ7Ucabu7LHHU8RV8A6qP+6wm8AjNcjaB3U/ruPZy8t
        LcBCJiEqjrtIC9/PNDtgRJyma0YLv2E49QUzZ10bg3HCLDJyBVe9Vj01gkT13Afh7TqIl0
        PQoQW5drXnq9JBFvKG3lIqfecBZW68E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-604-9Vpr1qtgOU27s7N6radbDA-1; Thu, 22 Apr 2021 08:21:45 -0400
X-MC-Unique: 9Vpr1qtgOU27s7N6radbDA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 756B510C40C5;
        Thu, 22 Apr 2021 12:21:44 +0000 (UTC)
Received: from localhost (ovpn-13-243.pek2.redhat.com [10.72.13.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D6EF660C05;
        Thu, 22 Apr 2021 12:21:36 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V6 05/12] block: extract one helper function polling hw queue
Date:   Thu, 22 Apr 2021 20:20:31 +0800
Message-Id: <20210422122038.2192933-6-ming.lei@redhat.com>
In-Reply-To: <20210422122038.2192933-1-ming.lei@redhat.com>
References: <20210422122038.2192933-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jeffle Xu <jefflexu@linux.alibaba.com>

Extract the logic of polling a hw queue and related statistics
handling out as the helper function.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-poll.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/block/blk-poll.c b/block/blk-poll.c
index daa307f84792..0a38c25bcee5 100644
--- a/block/blk-poll.c
+++ b/block/blk-poll.c
@@ -129,6 +129,19 @@ static bool blk_mq_poll_hybrid(struct request_queue *q,
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
 /**
  * blk_poll - poll for IO completions
  * @q:  the queue
@@ -171,11 +184,8 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
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

