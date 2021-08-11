Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED93C4338F
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 14:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 500556101D
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 14:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbhHKOjP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Aug 2021 10:39:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31440 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231872AbhHKOjO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Aug 2021 10:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628692730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1bGB1E64FQSDld0IcKJmfnDWP9e0wNX7xEDhDyVbrlU=;
        b=EKqmLClZiilJZ4L5XMy+bi/kWU1zGkrH8bjIQBgYoaVhY0T7pBEDPd+XHBVRn07PZf4OkU
        VKTZzwQf+5zObw2g5h+csUskyApmBKGCyrSiI/TsAyPFeCNQXcHccygqhMnXjMHE/AX6uw
        JwmZOOlk4OjgX/LvC+D6huDBHi+Q9sM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-8YmkmTFFO9Oiy2oMbSV4CA-1; Wed, 11 Aug 2021 10:38:49 -0400
X-MC-Unique: 8YmkmTFFO9Oiy2oMbSV4CA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11E648799E0;
        Wed, 11 Aug 2021 14:38:48 +0000 (UTC)
Received: from localhost (ovpn-12-52.pek2.redhat.com [10.72.12.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C50B5C232;
        Wed, 11 Aug 2021 14:38:43 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        John Garry <john.garry@huawei.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] blk-mq: don't grab rq's refcount in blk_mq_check_expired()
Date:   Wed, 11 Aug 2021 22:38:38 +0800
Message-Id: <20210811143838.622001-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Inside blk_mq_queue_tag_busy_iter() we already grabbed request's
refcount before calling ->fn(), so needn't to grab it one more time
in blk_mq_check_expired().

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d2725f94491d..4d3457d2957f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -917,6 +917,10 @@ void blk_mq_put_rq_ref(struct request *rq)
 		__blk_mq_free_request(rq);
 }
 
+/*
+ * This request won't be re-allocated because its refcount is held when
+ * calling this callback.
+ */
 static bool blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
 		struct request *rq, void *priv, bool reserved)
 {
@@ -930,27 +934,12 @@ static bool blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
 		return true;
 
 	/*
-	 * We have reason to believe the request may be expired. Take a
-	 * reference on the request to lock this request lifetime into its
-	 * currently allocated context to prevent it from being reallocated in
-	 * the event the completion by-passes this timeout handler.
-	 *
-	 * If the reference was already released, then the driver beat the
-	 * timeout handler to posting a natural completion.
-	 */
-	if (!refcount_inc_not_zero(&rq->ref))
-		return true;
-
-	/*
-	 * The request is now locked and cannot be reallocated underneath the
-	 * timeout handler's processing. Re-verify this exact request is truly
-	 * expired; if it is not expired, then the request was completed and
-	 * reallocated as a new request.
+	 * Re-verify this exact request is truly expired; if it is not expired,
+	 * then the request was completed and reallocated as a new request
+	 * after returning from blk_mq_check_expired().
 	 */
 	if (blk_mq_req_expired(rq, next))
 		blk_mq_rq_timed_out(rq, reserved);
-
-	blk_mq_put_rq_ref(rq);
 	return true;
 }
 
-- 
2.31.1

