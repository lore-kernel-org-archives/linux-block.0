Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FBDC43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 04:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F24217D7
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 04:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbeLREPp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 23:15:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59726 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbeLREPp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 23:15:45 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0404F42BBB;
        Tue, 18 Dec 2018 04:15:45 +0000 (UTC)
Received: from localhost (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA99360C65;
        Tue, 18 Dec 2018 04:15:40 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Jeff Moyer <jmoyer@redhat.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH] blk-mq: enable IO poll if .nr_queues of type poll > 0
Date:   Tue, 18 Dec 2018 12:15:29 +0800
Message-Id: <20181218041529.27787-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 18 Dec 2018 04:15:45 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The queue mapping of type poll only exists when set->map[HCTX_TYPE_POLL].nr_queues
is bigger than zero, so enhance the constraint by checking .nr_queues of type poll
before enabling IO poll.

Otherwise IO race & timeout can be observed when running block/007.

Cc: Jeff Moyer <jmoyer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c    | 3 ++-
 block/blk-sysfs.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6847f014606b..e45400da4180 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2833,7 +2833,8 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	q->tag_set = set;
 
 	q->queue_flags |= QUEUE_FLAG_MQ_DEFAULT;
-	if (set->nr_maps > HCTX_TYPE_POLL)
+	if (set->nr_maps > HCTX_TYPE_POLL &&
+	    set->map[HCTX_TYPE_POLL].nr_queues)
 		blk_queue_flag_set(QUEUE_FLAG_POLL, q);
 
 	if (!(set->flags & BLK_MQ_F_SG_MERGE))
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index bb7c642ffefa..0619c8922893 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -402,7 +402,8 @@ static ssize_t queue_poll_store(struct request_queue *q, const char *page,
 	unsigned long poll_on;
 	ssize_t ret;
 
-	if (!q->tag_set || q->tag_set->nr_maps <= HCTX_TYPE_POLL)
+	if (!q->tag_set || q->tag_set->nr_maps <= HCTX_TYPE_POLL ||
+	    !q->tag_set->map[HCTX_TYPE_POLL].nr_queues)
 		return -EINVAL;
 
 	ret = queue_var_store(&poll_on, page, count);
-- 
2.9.5

