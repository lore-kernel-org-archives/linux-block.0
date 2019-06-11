Return-Path: <SRS0=2dDp=UK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD14C43218
	for <linux-block@archiver.kernel.org>; Tue, 11 Jun 2019 09:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81242212F5
	for <linux-block@archiver.kernel.org>; Tue, 11 Jun 2019 09:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbfFKJcN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jun 2019 05:32:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36012 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727642AbfFKJcN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jun 2019 05:32:13 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8AC58316290F;
        Tue, 11 Jun 2019 09:32:08 +0000 (UTC)
Received: from localhost (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 23A095C5DE;
        Tue, 11 Jun 2019 09:32:00 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Yi Zhang <yi.zhang@redhat.com>,
        syzbot+b9d0d56867048c7bcfde@syzkaller.appspotmail.com
Subject: [PATCH] blk-mq: remove WARN_ON(!q->elevator) from blk_mq_sched_free_requests
Date:   Tue, 11 Jun 2019 17:31:53 +0800
Message-Id: <20190611093153.7147-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 11 Jun 2019 09:32:13 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_sched_free_requests() may be called in failure path in which
q->elevator may not be setup yet, so remove WARN_ON(!q->elevator) from
blk_mq_sched_free_requests for avoiding the false positive.

This function is actually safe to call in case of !q->elevator because
hctx->sched_tags is checked.

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Yi Zhang <yi.zhang@redhat.com>
Fixes: c3e2219216c9 ("block: free sched's request pool in blk_cleanup_queue")
Reported-by: syzbot+b9d0d56867048c7bcfde@syzkaller.appspotmail.com
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 500cb04901cc..2766066a15db 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -555,7 +555,6 @@ void blk_mq_sched_free_requests(struct request_queue *q)
 	int i;
 
 	lockdep_assert_held(&q->sysfs_lock);
-	WARN_ON(!q->elevator);
 
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (hctx->sched_tags)
-- 
2.20.1

