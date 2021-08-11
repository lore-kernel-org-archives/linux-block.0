Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35173C4320A
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 15:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D0AA61019
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 15:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbhHKPxN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Aug 2021 11:53:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21573 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233276AbhHKPxL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Aug 2021 11:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628697147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DUxtRhCT6Yy2CRsBgNph4jPMuk409yTWI7Iuc9nD2EI=;
        b=cQKejN2MiwDbSIZFqS+No2UB89z7CdEAZfwI7k3rzrb/m2J4oNh1bsG91ZLEqkoPmG/Aj8
        CDEY07Ldi/BE3CAi+lot2z/TOQo+zty5ieRYETdZ8fEInLUBEE690W4W1kv53wIE7hOIh2
        c1BuLI11V0Np0XqAWc1yRM5cUE9UiFY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-YziSKtdzPuuTP3vZTmEs9A-1; Wed, 11 Aug 2021 11:52:24 -0400
X-MC-Unique: YziSKtdzPuuTP3vZTmEs9A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 024FD1853028;
        Wed, 11 Aug 2021 15:52:23 +0000 (UTC)
Received: from localhost (ovpn-12-52.pek2.redhat.com [10.72.12.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 574A65C1B4;
        Wed, 11 Aug 2021 15:52:16 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>,
        Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH V2] blk-mq: don't grab rq's refcount in blk_mq_check_expired()
Date:   Wed, 11 Aug 2021 23:52:02 +0800
Message-Id: <20210811155202.629575-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Inside blk_mq_queue_tag_busy_iter() we already grabbed request's
refcount before calling ->fn(), so needn't to grab it one more time
in blk_mq_check_expired().

Meantime remove extra request expire check in blk_mq_check_expired().

Cc: Keith Busch <kbusch@kernel.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- remove extra request expire check as suggested by Keith
	- modify comment a bit

 block/blk-mq.c | 30 +++++-------------------------
 1 file changed, 5 insertions(+), 25 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d2725f94491d..b5237211ccb7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -923,34 +923,14 @@ static bool blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
 	unsigned long *next = priv;
 
 	/*
-	 * Just do a quick check if it is expired before locking the request in
-	 * so we're not unnecessarilly synchronizing across CPUs.
-	 */
-	if (!blk_mq_req_expired(rq, next))
-		return true;
-
-	/*
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
+	 * blk_mq_queue_tag_busy_iter() has locked the request, so it cannot
+	 * be reallocated underneath the timeout handler's processing, then
+	 * the expire check is reliable. If the request is not expired, then
+	 * it was completed and reallocated as a new request after returning
+	 * from blk_mq_check_expired().
 	 */
 	if (blk_mq_req_expired(rq, next))
 		blk_mq_rq_timed_out(rq, reserved);
-
-	blk_mq_put_rq_ref(rq);
 	return true;
 }
 
-- 
2.31.1

