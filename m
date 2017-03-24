Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34744 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932434AbdCXMgn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Mar 2017 08:36:43 -0400
Received: by mail-pg0-f66.google.com with SMTP id w20so226597pgc.1
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2017 05:36:42 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Hannes Reinecke <hare@suse.de>,
        Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH v2 2/4] block: add a read barrier in blk_queue_enter()
Date: Fri, 24 Mar 2017 20:36:19 +0800
Message-Id: <20170324123621.5227-3-tom.leiming@gmail.com>
In-Reply-To: <20170324123621.5227-1-tom.leiming@gmail.com>
References: <20170324123621.5227-1-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Without the barrier, reading DEAD flag of .q_usage_counter
and reading .mq_freeze_depth may be reordered, then the
following wait_event_interruptible() may never return.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 block/blk-core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index ad388d5e309a..44eed17319c0 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -669,6 +669,14 @@ int blk_queue_enter(struct request_queue *q, bool nowait)
 		if (nowait)
 			return -EBUSY;
 
+		/*
+		 * read pair of barrier in blk_mq_freeze_queue_start(),
+		 * we need to order reading DEAD flag of .q_usage_counter
+		 * and reading .mq_freeze_depth, otherwise the following
+		 * wait may never return if the two read are reordered.
+		 */
+		smp_rmb();
+
 		ret = wait_event_interruptible(q->mq_freeze_wq,
 				!atomic_read(&q->mq_freeze_depth) ||
 				blk_queue_dying(q));
-- 
2.9.3
