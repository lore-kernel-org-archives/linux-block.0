Return-Path: <SRS0=qX1g=65=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FFCC433E0
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 01:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3FBD2065F
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 01:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RZ9TAqHG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgEOBml (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 May 2020 21:42:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32583 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726170AbgEOBml (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 May 2020 21:42:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589506959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u+9DZ86cqTfYezr4bYqoP7gZM33mwhaLlYgbvYkOtlo=;
        b=RZ9TAqHG6AkV1wDEgMwkLlUCQJg7/ML8vwKWHVEMXi/bqCYu9+tbCNVhdY3j5+1AC/qp90
        WQajmGNKZZCl/ZXhhPKJG78LTIQJPckeCCII4kVeiIt98qFz78MvNJaIu1OwVXGOPLOhv4
        3PM8O2rpBuzdNS5l6KYTSfHuWsYUS1k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-Uc67Smi5Noi0yqRf0kdhBA-1; Thu, 14 May 2020 21:42:35 -0400
X-MC-Unique: Uc67Smi5Noi0yqRf0kdhBA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 704E918FE860;
        Fri, 15 May 2020 01:42:34 +0000 (UTC)
Received: from localhost (ovpn-12-94.pek2.redhat.com [10.72.12.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E6846E71B;
        Fri, 15 May 2020 01:42:30 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 5/6] blk-mq: disable preempt during allocating request tag
Date:   Fri, 15 May 2020 09:41:52 +0800
Message-Id: <20200515014153.2403464-6-ming.lei@redhat.com>
In-Reply-To: <20200515014153.2403464-1-ming.lei@redhat.com>
References: <20200515014153.2403464-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Disable preempt for a little while during allocating request tag, so
request's tag(internal tag) is always allocated on the cpu of data->ctx,
prepare for improving to handle cpu hotplug during allocating request.

In the following patch, hctx->state will be checked to see if it becomes
inactive which is always set on the last CPU of hctx->cpumask.

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Garry <john.garry@huawei.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-tag.c | 4 ++++
 block/blk-mq.c     | 4 ++++
 block/blk-mq.h     | 1 +
 3 files changed, 9 insertions(+)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index c27c6dfc7d36..0ae79ca6e2da 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -152,11 +152,15 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		if (tag != -1)
 			break;
 
+		if (data->preempt_disabled)
+			preempt_enable();
 		bt_prev = bt;
 		io_schedule();
 
 		sbitmap_finish_wait(bt, ws, &wait);
 
+		if (data->preempt_disabled)
+			preempt_disable();
 		data->ctx = blk_mq_get_ctx(data->q);
 		data->hctx = blk_mq_map_queue(data->q, data->cmd_flags,
 						data->ctx);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 151b63b1f88b..18999198a37f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -365,6 +365,9 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 	data->q = q;
 
 	WARN_ON_ONCE(data->ctx || data->hctx);
+
+	preempt_disable();
+	data->preempt_disabled = true;
 	data->ctx = blk_mq_get_ctx(q);
 	data->hctx = blk_mq_map_queue(q, data->cmd_flags, data->ctx);
 	if (data->cmd_flags & REQ_NOWAIT)
@@ -387,6 +390,7 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 	}
 
 	tag = blk_mq_get_tag(data);
+	preempt_enable();
 	if (tag == BLK_MQ_TAG_FAIL) {
 		data->ctx = NULL;
 		data->hctx = NULL;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 10bfdfb494fa..5ebc8d8d5a54 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -152,6 +152,7 @@ struct blk_mq_alloc_data {
 	blk_mq_req_flags_t flags;
 	unsigned int shallow_depth;
 	unsigned int cmd_flags;
+	bool preempt_disabled;
 
 	/* input & output parameter */
 	struct blk_mq_ctx *ctx;
-- 
2.25.2

