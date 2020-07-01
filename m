Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D42C433E0
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 10:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CDCA20722
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 10:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OQAPfGio"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbgGAKQe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:16:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25359 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729226AbgGAKQd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 1 Jul 2020 06:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593598592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LAop02g6KSXyvsnBY8aZ2bcMLBTNcGuy/P4SZXkSxmw=;
        b=OQAPfGioRVvqMYe7NczAmuIQpEl1mkGIV0Uobq1g7dBwttTo1zMEnThp0BBTP61vvgfCff
        ISNrqevagK/UlBOxpX/KoPa+PpT2bHsjUDza8Em+dl5AQXZ0luaNW2vywYbDT7kgF0XVji
        oUhN8tAzbyiDjiPVGXxTs+PAogTcCDk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-Q3hZ6QaoN62rve8dt_Titg-1; Wed, 01 Jul 2020 06:16:30 -0400
X-MC-Unique: Q3hZ6QaoN62rve8dt_Titg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2AD86EC1A3;
        Wed,  1 Jul 2020 10:16:29 +0000 (UTC)
Received: from localhost (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4712660CD0;
        Wed,  1 Jul 2020 10:16:20 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH] blk-mq: streamline handling of q->mq_ops->queue_rq result
Date:   Wed,  1 Jul 2020 18:16:17 +0800
Message-Id: <20200701101617.2434985-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
 block/blk-mq.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 65e0846fd065..c3862144a2a7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1407,7 +1407,10 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 		if (nr_budgets)
 			nr_budgets--;
 		ret = q->mq_ops->queue_rq(hctx, &bd);
-		if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE) {
+		if (likely(ret == BLK_STS_OK)) {
+			queued++;
+		} else if (ret == BLK_STS_RESOURCE ||
+				ret == BLK_STS_DEV_RESOURCE) {
 			blk_mq_handle_dev_resource(rq, list);
 			break;
 		} else if (ret == BLK_STS_ZONE_RESOURCE) {
@@ -1417,18 +1420,10 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 			 * accept.
 			 */
 			blk_mq_handle_zone_resource(rq, &zone_list);
-			if (list_empty(list))
-				break;
-			continue;
-		}
-
-		if (unlikely(ret != BLK_STS_OK)) {
+		} else {
 			errors++;
 			blk_mq_end_request(rq, BLK_STS_IOERR);
-			continue;
 		}
-
-		queued++;
 	} while (!list_empty(list));
 
 	if (!list_empty(&zone_list))
-- 
2.25.2

