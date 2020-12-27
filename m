Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394F6C433E0
	for <linux-block@archiver.kernel.org>; Sun, 27 Dec 2020 11:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECC27217A0
	for <linux-block@archiver.kernel.org>; Sun, 27 Dec 2020 11:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgL0Lgn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Dec 2020 06:36:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43660 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726039AbgL0Lgm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Dec 2020 06:36:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609068917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pSTOjMzwybL8O2en7wmB6uCwB+vyZM21YghPJixNIOs=;
        b=ifwZbFKe0ntqOnKsirLrDiHep0fZoPo+ReHZ+Hzi7PyV5UOUXo5Pb86xVH0TONjJayq3vU
        TjCEWlvHzHiOXpZorKlOx8GJicYqDu+OeQk9C9hsttGXGaA/oPq5brtf1ZI1rQEU03h9gQ
        3xTOE3n8JPktgOaUd5T/DtenNmciRGA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-ANMGTS9bM4yH9BucwYHsnA-1; Sun, 27 Dec 2020 06:35:15 -0500
X-MC-Unique: ANMGTS9bM4yH9BucwYHsnA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7F3415721;
        Sun, 27 Dec 2020 11:35:13 +0000 (UTC)
Received: from localhost (ovpn-12-134.pek2.redhat.com [10.72.12.134])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E8284189B8;
        Sun, 27 Dec 2020 11:35:03 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>
Subject: [PATCH] blk-mq: test QUEUE_FLAG_HCTX_ACTIVE for sbitmap_shared in hctx_may_queue
Date:   Sun, 27 Dec 2020 19:34:58 +0800
Message-Id: <20201227113458.3289082-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In case of blk_mq_is_sbitmap_shared(), we should test QUEUE_FLAG_HCTX_ACTIVE against
q->queue_flags instead of BLK_MQ_S_TAG_ACTIVE.

So fix it.

Cc: John Garry <john.garry@huawei.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Fixes: f1b49fdc1c64 ("blk-mq: Record active_queues_shared_sbitmap per tag_set for when using shared sbitmap")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.h b/block/blk-mq.h
index c1458d9502f1..3616453ca28c 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -304,7 +304,7 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
 		struct request_queue *q = hctx->queue;
 		struct blk_mq_tag_set *set = q->tag_set;
 
-		if (!test_bit(BLK_MQ_S_TAG_ACTIVE, &q->queue_flags))
+		if (!test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
 			return true;
 		users = atomic_read(&set->active_queues_shared_sbitmap);
 	} else {
-- 
2.28.0

