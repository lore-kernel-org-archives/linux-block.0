Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDA9C47095
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 06:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95ED061040
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 06:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbhFIGcx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 02:32:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39809 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231847AbhFIGcx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 9 Jun 2021 02:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623220259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NA2hhxeIjW6frsqSwuiHUgf8TX8b1wswVenUR3poUA8=;
        b=dScO66nxXPnENg1DnYyNuh66AzNgrxtOMqTLXKq4R6ZONi0gldIyNjXSOiqvgNeUCTR00S
        +stwxRcty8ABBBhPxpQThsm906BpDusT95/fF3f5jAebI4P4y1asLJtn5KC8ynCGKFErJ7
        Bb3QCTG7AqDZ8j99x67/K1Dmd9spnsk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-L9as9uWaO0GM_6Ck1aAchQ-1; Wed, 09 Jun 2021 02:30:57 -0400
X-MC-Unique: L9as9uWaO0GM_6Ck1aAchQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52BC418D6A2E;
        Wed,  9 Jun 2021 06:30:56 +0000 (UTC)
Received: from localhost (ovpn-12-143.pek2.redhat.com [10.72.12.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 90A4E5D9DE;
        Wed,  9 Jun 2021 06:30:50 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        syzbot+77ba3d171a25c56756ea@syzkaller.appspotmail.com,
        John Garry <john.garry@huawei.com>
Subject: [PATCH] blk-mq: fix use-after-free in blk_mq_exit_sched
Date:   Wed,  9 Jun 2021 14:30:46 +0800
Message-Id: <20210609063046.122843-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

tagset can't be used after blk_cleanup_queue() is returned because
freeing tagset usually follows blk_clenup_queue(). Commit d97e594c5166
("blk-mq: Use request queue-wide tags for tagset-wide sbitmap") adds
check on q->tag_set->flags in blk_mq_exit_sched(), and causes
use-after-free.

Fixes it by using hctx->flags.

Reported-by: syzbot+77ba3d171a25c56756ea@syzkaller.appspotmail.com
Fixes: d97e594c5166 ("blk-mq: Use request queue-wide tags for tagset-wide sbitmap")
Cc: John Garry <john.garry@huawei.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index a9182d2f8ad3..80273245d11a 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -680,6 +680,7 @@ void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e)
 {
 	struct blk_mq_hw_ctx *hctx;
 	unsigned int i;
+	unsigned int flags = 0;
 
 	queue_for_each_hw_ctx(q, hctx, i) {
 		blk_mq_debugfs_unregister_sched_hctx(hctx);
@@ -687,12 +688,13 @@ void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e)
 			e->type->ops.exit_hctx(hctx, i);
 			hctx->sched_data = NULL;
 		}
+		flags = hctx->flags;
 	}
 	blk_mq_debugfs_unregister_sched(q);
 	if (e->type->ops.exit_sched)
 		e->type->ops.exit_sched(e);
 	blk_mq_sched_tags_teardown(q);
-	if (blk_mq_is_sbitmap_shared(q->tag_set->flags))
+	if (blk_mq_is_sbitmap_shared(flags))
 		blk_mq_exit_sched_shared_sbitmap(q);
 	q->elevator = NULL;
 }
-- 
2.31.1

