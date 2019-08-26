Return-Path: <SRS0=sRwj=WW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662BDC3A5A1
	for <linux-block@archiver.kernel.org>; Mon, 26 Aug 2019 02:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C720206BB
	for <linux-block@archiver.kernel.org>; Mon, 26 Aug 2019 02:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbfHZCwe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 25 Aug 2019 22:52:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53270 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729032AbfHZCwe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 25 Aug 2019 22:52:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F0F023086268;
        Mon, 26 Aug 2019 02:52:33 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C056D5C3FD;
        Mon, 26 Aug 2019 02:52:18 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH V3 4/5] block: add helper for checking if queue is registered
Date:   Mon, 26 Aug 2019 10:51:45 +0800
Message-Id: <20190826025146.31158-5-ming.lei@redhat.com>
In-Reply-To: <20190826025146.31158-1-ming.lei@redhat.com>
References: <20190826025146.31158-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 26 Aug 2019 02:52:34 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There are 4 users which check if queue is registered, so add one helper
to check it.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-sysfs.c      | 4 ++--
 block/blk-wbt.c        | 2 +-
 block/elevator.c       | 2 +-
 include/linux/blkdev.h | 1 +
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 977c659dcd18..5b0b5224cfd4 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -942,7 +942,7 @@ int blk_register_queue(struct gendisk *disk)
 	if (WARN_ON(!q))
 		return -ENXIO;
 
-	WARN_ONCE(test_bit(QUEUE_FLAG_REGISTERED, &q->queue_flags),
+	WARN_ONCE(blk_queue_registered(q),
 		  "%s is registering an already registered queue\n",
 		  kobject_name(&dev->kobj));
 	blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);
@@ -1026,7 +1026,7 @@ void blk_unregister_queue(struct gendisk *disk)
 		return;
 
 	/* Return early if disk->queue was never registered. */
-	if (!test_bit(QUEUE_FLAG_REGISTERED, &q->queue_flags))
+	if (!blk_queue_registered(q))
 		return;
 
 	/*
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 313f45a37e9d..c4d3089e47f7 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -656,7 +656,7 @@ void wbt_enable_default(struct request_queue *q)
 		return;
 
 	/* Queue not registered? Maybe shutting down... */
-	if (!test_bit(QUEUE_FLAG_REGISTERED, &q->queue_flags))
+	if (!blk_queue_registered(q))
 		return;
 
 	if (queue_is_mq(q) && IS_ENABLED(CONFIG_BLK_WBT_MQ))
diff --git a/block/elevator.c b/block/elevator.c
index 33c15fb54ed1..03d923196569 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -656,7 +656,7 @@ static int __elevator_change(struct request_queue *q, const char *name)
 	struct elevator_type *e;
 
 	/* Make sure queue is not in the middle of being removed */
-	if (!test_bit(QUEUE_FLAG_REGISTERED, &q->queue_flags))
+	if (!blk_queue_registered(q))
 		return -ENOENT;
 
 	/*
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 167bf879f072..6041755984f4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -647,6 +647,7 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #define blk_queue_quiesced(q)	test_bit(QUEUE_FLAG_QUIESCED, &(q)->queue_flags)
 #define blk_queue_pm_only(q)	atomic_read(&(q)->pm_only)
 #define blk_queue_fua(q)	test_bit(QUEUE_FLAG_FUA, &(q)->queue_flags)
+#define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->queue_flags)
 
 extern void blk_set_pm_only(struct request_queue *q);
 extern void blk_clear_pm_only(struct request_queue *q);
-- 
2.20.1

