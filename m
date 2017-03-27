Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35771 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752607AbdC0MHg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2017 08:07:36 -0400
Received: by mail-pg0-f67.google.com with SMTP id g2so12358541pge.2
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2017 05:07:30 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Hannes Reinecke <hare@suse.de>,
        Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH v3 2/4] block: add a read barrier in blk_queue_enter()
Date: Mon, 27 Mar 2017 20:06:56 +0800
Message-Id: <20170327120658.29864-3-tom.leiming@gmail.com>
In-Reply-To: <20170327120658.29864-1-tom.leiming@gmail.com>
References: <20170327120658.29864-1-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Without the barrier, reading DEAD flag of .q_usage_counter
and reading .mq_freeze_depth may be reordered, then the
following wait_event_interruptible() may never return.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 block/blk-core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index ad388d5e309a..5e8963bc98d9 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -669,6 +669,15 @@ int blk_queue_enter(struct request_queue *q, bool nowait)
 		if (nowait)
 			return -EBUSY;
 
+		/*
+		 * read pair of barrier in blk_mq_freeze_queue_start(),
+		 * we need to order reading __PERCPU_REF_DEAD flag of
+		 * .q_usage_counter and reading .mq_freeze_depth,
+		 * otherwise the following wait may never return if the
+		 * two reads are reordered.
+		 */
+		smp_rmb();
+
 		ret = wait_event_interruptible(q->mq_freeze_wq,
 				!atomic_read(&q->mq_freeze_depth) ||
 				blk_queue_dying(q));
-- 
2.9.3
