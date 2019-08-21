Return-Path: <SRS0=wMiD=WR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7EFC3A59E
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 09:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5622339F
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 09:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfHUJPh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Aug 2019 05:15:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51533 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbfHUJPh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 05:15:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6669A1801580;
        Wed, 21 Aug 2019 09:15:37 +0000 (UTC)
Received: from localhost (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 111FC2B9D7;
        Wed, 21 Aug 2019 09:15:31 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH V2 3/6] blk-mq: don't hold q->sysfs_lock in blk_mq_map_swqueue
Date:   Wed, 21 Aug 2019 17:15:03 +0800
Message-Id: <20190821091506.21196-4-ming.lei@redhat.com>
In-Reply-To: <20190821091506.21196-1-ming.lei@redhat.com>
References: <20190821091506.21196-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.63]); Wed, 21 Aug 2019 09:15:37 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_map_swqueue() is called from blk_mq_init_allocated_queue()
and blk_mq_update_nr_hw_queues(). For the former caller, the kobject
isn't exposed to userspace yet. For the latter caller, sysfs/debugfs
is un-registered before updating nr_hw_queues.

On the other hand, commit 2f8f1336a48b ("blk-mq: always free hctx after
request queue is freed") moves freeing hctx into queue's release
handler, so there won't be race with queue release path too.

So don't hold q->sysfs_lock in blk_mq_map_swqueue().

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6968de9d7402..b0ee0cac737f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2456,11 +2456,6 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 	struct blk_mq_ctx *ctx;
 	struct blk_mq_tag_set *set = q->tag_set;
 
-	/*
-	 * Avoid others reading imcomplete hctx->cpumask through sysfs
-	 */
-	mutex_lock(&q->sysfs_lock);
-
 	queue_for_each_hw_ctx(q, hctx, i) {
 		cpumask_clear(hctx->cpumask);
 		hctx->nr_ctx = 0;
@@ -2521,8 +2516,6 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 					HCTX_TYPE_DEFAULT, i);
 	}
 
-	mutex_unlock(&q->sysfs_lock);
-
 	queue_for_each_hw_ctx(q, hctx, i) {
 		/*
 		 * If no software queues are mapped to this hardware queue,
-- 
2.20.1

