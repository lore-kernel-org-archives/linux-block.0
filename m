Return-Path: <SRS0=DCcP=XU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DA2C432C2
	for <linux-block@archiver.kernel.org>; Wed, 25 Sep 2019 22:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F876205F4
	for <linux-block@archiver.kernel.org>; Wed, 25 Sep 2019 22:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbfIYWYC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Sep 2019 18:24:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38418 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729360AbfIYWYC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Sep 2019 18:24:02 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2A78A10DCC9D;
        Wed, 25 Sep 2019 22:24:02 +0000 (UTC)
Received: from localhost (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F4D160C44;
        Wed, 25 Sep 2019 22:23:58 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        syzbot+da3b7677bb913dc1b737@syzkaller.appspotmail.com
Subject: [PATCH] blk-mq: move lockdep_assert_held() into elevator_exit
Date:   Thu, 26 Sep 2019 06:23:54 +0800
Message-Id: <20190925222354.26152-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Wed, 25 Sep 2019 22:24:02 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit c48dac137a62 ("block: don't hold q->sysfs_lock in elevator_init_mq")
removes q->sysfs_lock from elevator_init_mq(), but forgot to deal with
lockdep_assert_held() called in blk_mq_sched_free_requests() which is
run in failure path of elevator_init_mq().

blk_mq_sched_free_requests() is called in the following 3 functions:

	elevator_init_mq()
	elevator_exit()
	blk_cleanup_queue()

In blk_cleanup_queue(), blk_mq_sched_free_requests() is followed exactly
by 'mutex_lock(&q->sysfs_lock)'.

So moving the lockdep_assert_held() from blk_mq_sched_free_requests()
into elevator_exit() for fixing the report by syzbot.

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Damien Le Moal <Damien.LeMoal@wdc.com>
Reported-by: syzbot+da3b7677bb913dc1b737@syzkaller.appspotmail.com
Fixed: c48dac137a62 ("block: don't hold q->sysfs_lock in elevator_init_mq")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.c | 2 --
 block/blk.h          | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index c9d183d6c499..ca22afd47b3d 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -555,8 +555,6 @@ void blk_mq_sched_free_requests(struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
-	lockdep_assert_held(&q->sysfs_lock);
-
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (hctx->sched_tags)
 			blk_mq_free_rqs(q->tag_set, hctx->sched_tags, i);
diff --git a/block/blk.h b/block/blk.h
index ed347f7a97b1..25773d668ec0 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -194,6 +194,8 @@ void elv_unregister_queue(struct request_queue *q);
 static inline void elevator_exit(struct request_queue *q,
 		struct elevator_queue *e)
 {
+	lockdep_assert_held(&q->sysfs_lock);
+
 	blk_mq_sched_free_requests(q);
 	__elevator_exit(q, e);
 }
-- 
2.20.1

