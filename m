Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB824C433E0
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 13:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B419A20663
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 13:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fWzRLKx9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbgGAN7N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:59:13 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33931 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728021AbgGAN7N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 1 Jul 2020 09:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593611951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tvg6bb+r20Vp7qxbnSu3jxpHrXmD8FOCaXMRkieQw8E=;
        b=fWzRLKx9vkFN24P+aFrnxWZoJkL7d3cuGZweavxgmNo07Ky618pY3lE7fi8HPkXMR3Qltd
        UxX9lKOfPI+xVsp3RdIwzCHPLD+5PDcSw/M7vYbt7Afoi+JH+uyxvAn5OLsgxGU5WPOtTo
        MKm9BJbfqro54nILADLtIcKTpOIyGsA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-Y8PpWS-dM7mMQz6hScG_YA-1; Wed, 01 Jul 2020 09:59:08 -0400
X-MC-Unique: Y8PpWS-dM7mMQz6hScG_YA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F4CFA0BD8;
        Wed,  1 Jul 2020 13:59:07 +0000 (UTC)
Received: from localhost (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B61FB100164D;
        Wed,  1 Jul 2020 13:59:02 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH V2] blk-mq: streamline handling of q->mq_ops->queue_rq result
Date:   Wed,  1 Jul 2020 21:58:57 +0800
Message-Id: <20200701135857.2445459-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Current handling of q->mq_ops->queue_rq result is a bit ugly:

- two branches which needs to 'continue' have to check if the
dispatch local list is empty, otherwise one bad request may
be retrieved via 'rq = list_first_entry(list, struct request, queuelist);'

- the branch of 'if (unlikely(ret != BLK_STS_OK))' isn't easy
to follow, since it is actually one error branch.

Streamline this handling, so the code becomes more readable, meantime
potential kernel oops can be avoided in case that the last request in
local dispatch list is failed.

Fixes: fc17b6534eb8 ("blk-mq: switch ->queue_rq return value to blk_status_t")
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- change 'if else' to switch as suggested by Christoph

 block/blk-mq.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 65e0846fd065..cc85775fc372 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1407,30 +1407,28 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 		if (nr_budgets)
 			nr_budgets--;
 		ret = q->mq_ops->queue_rq(hctx, &bd);
-		if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE) {
-			blk_mq_handle_dev_resource(rq, list);
+		switch (ret) {
+		case BLK_STS_OK:
+			queued++;
 			break;
-		} else if (ret == BLK_STS_ZONE_RESOURCE) {
+		case BLK_STS_RESOURCE:
+		case BLK_STS_DEV_RESOURCE:
+			blk_mq_handle_dev_resource(rq, list);
+			goto out;
+		case BLK_STS_ZONE_RESOURCE:
 			/*
 			 * Move the request to zone_list and keep going through
 			 * the dispatch list to find more requests the drive can
 			 * accept.
 			 */
 			blk_mq_handle_zone_resource(rq, &zone_list);
-			if (list_empty(list))
-				break;
-			continue;
-		}
-
-		if (unlikely(ret != BLK_STS_OK)) {
+			break;
+		default:
 			errors++;
 			blk_mq_end_request(rq, BLK_STS_IOERR);
-			continue;
 		}
-
-		queued++;
 	} while (!list_empty(list));
-
+out:
 	if (!list_empty(&zone_list))
 		list_splice_tail_init(&zone_list, list);
 
-- 
2.25.2

