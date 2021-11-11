Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D6FC4167D
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 08:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E2F761212
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 08:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhKKIzm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Nov 2021 03:55:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57216 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232649AbhKKIz3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Nov 2021 03:55:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636620759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L+qJPrmNNJb3PrDW6Oz46w7+NniLi81A014fyYsCCw4=;
        b=ClTa8NadfP0T5I6WZWrAaju94ZjefqqghlvYcY2Szcf6qcZK4nVcx7b7wEyOTJzMST7Jn+
        IWmP0rbG0wjowj5amgXeToXSxxuUVhDsbQ2mwUX0l19bqwrgifGut3+O0P55fiqgAVRx4u
        sH+m9Rlyrz4o3H27qJ34UOsfJIOUpvc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-YQTCUvaHMZ-6fLhkekXOLQ-1; Thu, 11 Nov 2021 03:52:36 -0500
X-MC-Unique: YQTCUvaHMZ-6fLhkekXOLQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 406AD802B7A;
        Thu, 11 Nov 2021 08:52:30 +0000 (UTC)
Received: from localhost (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2439667843;
        Thu, 11 Nov 2021 08:52:19 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/2] blk-mq: don't grab ->q_usage_counter in blk_mq_sched_bio_merge
Date:   Thu, 11 Nov 2021 16:51:33 +0800
Message-Id: <20211111085134.345235-2-ming.lei@redhat.com>
In-Reply-To: <20211111085134.345235-1-ming.lei@redhat.com>
References: <20211111085134.345235-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_sched_bio_merge is only called from blk-mq.c:blk_attempt_bio_merge(),
which is called when queue usage counter is grabbed already:

1) blk_mq_get_new_requests()

2) blk_mq_get_request()
- cached request in current plug owns one queue usage counter

So don't grab ->q_usage_counter in blk_mq_sched_bio_merge(), and more
importantly this nest way causes hang in blk_mq_freeze_queue_wait().

Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 4be652fa38e7..ba21449439cc 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -370,9 +370,6 @@ bool blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
 	bool ret = false;
 	enum hctx_type type;
 
-	if (bio_queue_enter(bio))
-		return false;
-
 	if (e && e->type->ops.bio_merge) {
 		ret = e->type->ops.bio_merge(q, bio, nr_segs);
 		goto out_put;
@@ -397,7 +394,6 @@ bool blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
 
 	spin_unlock(&ctx->lock);
 out_put:
-	blk_queue_exit(q);
 	return ret;
 }
 
-- 
2.31.1

