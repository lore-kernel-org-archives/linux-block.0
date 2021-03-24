Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A29C433E1
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 12:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B97AF61A0F
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 12:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbhCXMUd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Mar 2021 08:20:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27288 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234152AbhCXMUG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Mar 2021 08:20:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616588405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hiQvZh7foPjrFz+jjL1c3fsVbvj1Kh2WiEPhGKCssXE=;
        b=hHNg8t77HXnCSamBXKKmZt5RcirM+HkU8vuat/MPkYbEYPTKPGawyTHDoDInHIEeGaZWD6
        51N+kcZdIsa0LIJW4+02P5yLGQY8D1Xmq3s4gGWpy4enjhjD8aTXsBgK3TZQxZVGON0oIT
        TXFYAvRVlhCwP/40dElVeX4h/zSyexk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-570-yZmUT5WIPCmLKaxBL5r_fg-1; Wed, 24 Mar 2021 08:20:04 -0400
X-MC-Unique: yZmUT5WIPCmLKaxBL5r_fg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31CA881622;
        Wed, 24 Mar 2021 12:20:03 +0000 (UTC)
Received: from localhost (ovpn-13-127.pek2.redhat.com [10.72.13.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B4A805C5AE;
        Wed, 24 Mar 2021 12:20:01 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 03/13] block: add helper of blk_create_io_context
Date:   Wed, 24 Mar 2021 20:19:17 +0800
Message-Id: <20210324121927.362525-4-ming.lei@redhat.com>
In-Reply-To: <20210324121927.362525-1-ming.lei@redhat.com>
References: <20210324121927.362525-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add one helper for creating io context and prepare for supporting
efficient bio based io poll.

Meantime move the code of creating io_context before checking bio's
REQ_HIPRI flag because the following patch may change to clear REQ_HIPRI
if io_context can't be created.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index a31371d55b9d..d58f8a0c80de 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -792,6 +792,18 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
 	return BLK_STS_OK;
 }
 
+static inline void blk_create_io_context(struct request_queue *q)
+{
+	/*
+	 * Various block parts want %current->io_context, so allocate it up
+	 * front rather than dealing with lots of pain to allocate it only
+	 * where needed. This may fail and the block layer knows how to live
+	 * with it.
+	 */
+	if (unlikely(!current->io_context))
+		create_task_io_context(current, GFP_ATOMIC, q->node);
+}
+
 static noinline_for_stack bool submit_bio_checks(struct bio *bio)
 {
 	struct block_device *bdev = bio->bi_bdev;
@@ -836,6 +848,8 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
 		}
 	}
 
+	blk_create_io_context(q);
+
 	if (!blk_queue_poll(q))
 		bio->bi_opf &= ~REQ_HIPRI;
 
@@ -876,15 +890,6 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
 		break;
 	}
 
-	/*
-	 * Various block parts want %current->io_context, so allocate it up
-	 * front rather than dealing with lots of pain to allocate it only
-	 * where needed. This may fail and the block layer knows how to live
-	 * with it.
-	 */
-	if (unlikely(!current->io_context))
-		create_task_io_context(current, GFP_ATOMIC, q->node);
-
 	if (blk_throtl_bio(bio)) {
 		blkcg_bio_issue_init(bio);
 		return false;
-- 
2.29.2

