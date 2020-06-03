Return-Path: <SRS0=EWxa=7Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0E2C433DF
	for <linux-block@archiver.kernel.org>; Wed,  3 Jun 2020 10:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B20D2067B
	for <linux-block@archiver.kernel.org>; Wed,  3 Jun 2020 10:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e+psHK4M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgFCKvq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Jun 2020 06:51:46 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37990 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725828AbgFCKvq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Jun 2020 06:51:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591181505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ldgonZ2DlV7LRQByUlde8lyBCswR/fyiQiwPLedQAWc=;
        b=e+psHK4MhFCHq0KFzwGjGueFbdYztCO0LHxLxlCYbZsvzdhj9SUOTLHiCuA4JnI6iy4Xk0
        UcySb3/GpVz30hVXeCUrYsMkaggEsS60hC1w4IBR3hArHV6oqUoCAw7NLbtZ+V+IYLHqo3
        eZWf6gs02x+3F1HNNuaVxd3l+1NoPXQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-9lD8V9pzOKyMTLiHQqEjRA-1; Wed, 03 Jun 2020 06:51:43 -0400
X-MC-Unique: 9lD8V9pzOKyMTLiHQqEjRA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3CC2872FE4;
        Wed,  3 Jun 2020 10:51:41 +0000 (UTC)
Received: from localhost (ovpn-12-230.pek2.redhat.com [10.72.12.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 456FD5D9CD;
        Wed,  3 Jun 2020 10:51:36 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        John Garry <john.garry@huawei.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH] blk-mq: don't fail driver tag allocation because of inactive hctx
Date:   Wed,  3 Jun 2020 18:51:27 +0800
Message-Id: <20200603105128.2147139-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit bf0beec0607d ("blk-mq: drain I/O when all CPUs in a hctx are offline")
prevents new request from being allocated on hctx which is going to be inactive,
meantime drains all in-queue requests.

We needn't to prevent driver tag from being allocated during cpu hotplug, more
importantly we have to provide driver tag for requests, so that the cpu hotplug
handling can move on. blk_mq_get_tag() is shared for allocating both internal
tag and drive tag, so driver tag allocation may fail because the hctx is
marked as inactive.

Fix the issue by moving BLK_MQ_S_INACTIVE check to __blk_mq_alloc_request().

Cc: Dongli Zhang <dongli.zhang@oracle.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <dwagner@suse.de>
Fixes: bf0beec0607d ("blk-mq: drain I/O when all CPUs in a hctx are offline")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-tag.c |  8 --------
 block/blk-mq.c     | 27 ++++++++++++++++++++-------
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 96a39d0724a2..762198b62088 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -180,14 +180,6 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	sbitmap_finish_wait(bt, ws, &wait);
 
 found_tag:
-	/*
-	 * Give up this allocation if the hctx is inactive.  The caller will
-	 * retry on an active hctx.
-	 */
-	if (unlikely(test_bit(BLK_MQ_S_INACTIVE, &data->hctx->state))) {
-		blk_mq_put_tag(tags, data->ctx, tag + tag_offset);
-		return BLK_MQ_NO_TAG;
-	}
 	return tag + tag_offset;
 }
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a98a19353461..c5acf4858abf 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -347,6 +347,24 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	return rq;
 }
 
+static inline unsigned int blk_mq_get_request_tag(
+		struct blk_mq_alloc_data *data)
+{
+	/*
+	 * Waiting allocations only fail because of an inactive hctx.  In that
+	 * case just retry the hctx assignment and tag allocation as CPU hotplug
+	 * should have migrated us to an online CPU by now.
+	 */
+	int tag = blk_mq_get_tag(data);
+	if (unlikely(test_bit(BLK_MQ_S_INACTIVE, &data->hctx->state) &&
+				tag != BLK_MQ_NO_TAG)) {
+		blk_mq_put_tag(blk_mq_tags_from_data(data), data->ctx, tag);
+		tag = BLK_MQ_NO_TAG;
+	}
+
+	return tag;
+}
+
 static struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data)
 {
 	struct request_queue *q = data->q;
@@ -381,12 +399,7 @@ static struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data)
 	if (!(data->flags & BLK_MQ_REQ_INTERNAL))
 		blk_mq_tag_busy(data->hctx);
 
-	/*
-	 * Waiting allocations only fail because of an inactive hctx.  In that
-	 * case just retry the hctx assignment and tag allocation as CPU hotplug
-	 * should have migrated us to an online CPU by now.
-	 */
-	tag = blk_mq_get_tag(data);
+	tag = blk_mq_get_request_tag(data);
 	if (tag == BLK_MQ_NO_TAG) {
 		if (data->flags & BLK_MQ_REQ_NOWAIT)
 			return NULL;
@@ -480,7 +493,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 		blk_mq_tag_busy(data.hctx);
 
 	ret = -EWOULDBLOCK;
-	tag = blk_mq_get_tag(&data);
+	tag = blk_mq_get_request_tag(&data);
 	if (tag == BLK_MQ_NO_TAG)
 		goto out_queue_exit;
 	return blk_mq_rq_ctx_init(&data, tag, alloc_time_ns);
-- 
2.25.2

