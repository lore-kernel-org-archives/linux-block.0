Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE93C2D0F9
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 09:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16B7423128
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 09:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E7T4ec0T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388267AbgEMJza (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 05:55:30 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50318 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387714AbgEMJz3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 05:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589363728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nArzI+Sotxf+dD55Mf1PULEEnzU8cszF1tvtiV+DEk8=;
        b=E7T4ec0TITNuNebExQyok4IitdhcK1n4lB7S51gzHU/58buKwC8A8C7KAL43+tg70QhuAq
        Z8/qYaRDpQ6iNYFc8B929CB8IAjYI/yLcTFsDM3IbKoy06PHY6CfOBpemXLNHvvxmaYBac
        Gki1H6dKHmNFm86gmVhJ8fqIsN9TMPg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-ovxtCjCGNwS9EJcszQIn5g-1; Wed, 13 May 2020 05:55:26 -0400
X-MC-Unique: ovxtCjCGNwS9EJcszQIn5g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9381818B6424;
        Wed, 13 May 2020 09:55:25 +0000 (UTC)
Received: from localhost (ovpn-12-166.pek2.redhat.com [10.72.12.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 38E9860BF1;
        Wed, 13 May 2020 09:55:21 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 5/9] blk-mq: move .queue_rq code into one helper
Date:   Wed, 13 May 2020 17:54:39 +0800
Message-Id: <20200513095443.2038859-6-ming.lei@redhat.com>
In-Reply-To: <20200513095443.2038859-1-ming.lei@redhat.com>
References: <20200513095443.2038859-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move code for queueing rq into one helper, so that blk_mq_dispatch_rq_list
gets a bit simpified, and easier to read.

No functional change.

Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Baolin Wang <baolin.wang7@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c06421faa555..34fd09adb7fc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1220,6 +1220,17 @@ static enum prep_dispatch blk_mq_prep_dispatch_rq(struct request *rq,
 	return PREP_DISPATCH_OK;
 }
 
+static blk_status_t blk_mq_dispatch_rq(struct request *rq, bool is_last)
+{
+	struct blk_mq_queue_data bd;
+
+	list_del_init(&rq->queuelist);
+	bd.rq = rq;
+	bd.last = is_last;
+
+	return rq->q->mq_ops->queue_rq(rq->mq_hctx, &bd);
+}
+
 /*
  * Returns true if we did some work AND can potentially do more.
  */
@@ -1243,8 +1254,6 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 	 */
 	errors = queued = 0;
 	do {
-		struct blk_mq_queue_data bd;
-
 		rq = list_first_entry(list, struct request, queuelist);
 
 		WARN_ON_ONCE(hctx != rq->mq_hctx);
@@ -1252,12 +1261,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 		if (prep != PREP_DISPATCH_OK)
 			break;
 
-		list_del_init(&rq->queuelist);
-
-		bd.rq = rq;
-		bd.last = !!list_empty(list);
-
-		ret = q->mq_ops->queue_rq(hctx, &bd);
+		ret = blk_mq_dispatch_rq(rq, list_is_singular(list));
 		if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE) {
 			blk_mq_handle_dev_resource(rq, list);
 			break;
-- 
2.25.2

