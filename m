Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BABEB64DA
	for <linux-block@archiver.kernel.org>; Sat, 24 Jun 2023 13:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjFXNCC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 24 Jun 2023 09:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjFXNCB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 24 Jun 2023 09:02:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87212F3
        for <linux-block@vger.kernel.org>; Sat, 24 Jun 2023 06:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687611673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yzQK4nAaXgWnFMPuDqivgdDdDiFxTwgrcvdQj+2zIHA=;
        b=dwxKA4iTQBZc2savCdtNDAt1YlnU5SgLAF4/j6MdTw+pjORayN3kLNx2u5n0TtyUBIiv2B
        O+3PYlKmbzYv+wsKmpnnqI9xOGO6P12jOq7nlhYt54TVAToatYTc51vkNL7fM1AB4vxP4v
        4ICSEkBaoP4IZbp5u+MlUkVCD234BOU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-226--Tnam5mpMc-JgL5P-eF17A-1; Sat, 24 Jun 2023 09:01:10 -0400
X-MC-Unique: -Tnam5mpMc-JgL5P-eF17A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C73EF8E44E2;
        Sat, 24 Jun 2023 13:01:09 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E9AD72166B25;
        Sat, 24 Jun 2023 13:01:08 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Guangwu Zhang <guazhang@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] blk-mq: fix two misuses on RQF_USE_SCHED
Date:   Sat, 24 Jun 2023 21:01:05 +0800
Message-Id: <20230624130105.1443879-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Request allocated from sched tags can't be issued via ->queue_rqs()
directly, since driver tag isn't allocated yet. This is the 1st misuse
of RQF_USE_SCHED for figuring out plug->has_elevator.

Request allocated from sched tags can't be ended by
blk_mq_end_request_batch() too, fix the 2nd RQF_USE_SCHED misuse
in blk_mq_add_to_batch().

Without this patch, NVMe uring cmd passthrough IO workload can run into
hang easily with real io scheduler.

Fixes: dd6216bb16e8 ("blk-mq: make sure elevator callbacks aren't called for passthrough request")
Reported-by: Guangwu Zhang <guazhang@redhat.com>
Closes: https://lore.kernel.org/linux-block/CAGS2=YrBjpLPOKa-gzcKuuOG60AGth5794PNCDwatdnnscB9ug@mail.gmail.com/
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         | 6 +++++-
 include/linux/blk-mq.h | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1628873d7587..0aba08a9ded6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1302,7 +1302,11 @@ static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
 
 	if (!plug->multiple_queues && last && last->q != rq->q)
 		plug->multiple_queues = true;
-	if (!plug->has_elevator && (rq->rq_flags & RQF_USE_SCHED))
+	/*
+	 * Any request allocated from sched tags can't be issued to
+	 * ->queue_rqs() directly
+	 */
+	if (!plug->has_elevator && (rq->rq_flags & RQF_SCHED_TAGS))
 		plug->has_elevator = true;
 	rq->rq_next = NULL;
 	rq_list_add(&plug->mq_list, rq);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index fa265e85d753..12103d5654f5 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -852,7 +852,11 @@ static inline bool blk_mq_add_to_batch(struct request *req,
 				       struct io_comp_batch *iob, int ioerror,
 				       void (*complete)(struct io_comp_batch *))
 {
-	if (!iob || (req->rq_flags & RQF_USE_SCHED) || ioerror ||
+	/*
+	 * blk_mq_end_request_batch() can't end request allocated from
+	 * sched tags
+	 */
+	if (!iob || (req->rq_flags & RQF_SCHED_TAGS) || ioerror ||
 			(req->end_io && !blk_rq_is_passthrough(req)))
 		return false;
 
-- 
2.40.1

