Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40046 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751022AbdEaMhn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 May 2017 08:37:43 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v3 2/9] block: introduce flag of QUEUE_FLAG_QUIESCED
Date: Wed, 31 May 2017 20:36:59 +0800
Message-Id: <20170531123706.20885-3-ming.lei@redhat.com>
In-Reply-To: <20170531123706.20885-1-ming.lei@redhat.com>
References: <20170531123706.20885-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This flag is introduced for improving the quiescing code.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/blkdev.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 41291be82ac4..60967797f4f6 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -618,6 +618,7 @@ struct request_queue {
 #define QUEUE_FLAG_STATS       27	/* track rq completion times */
 #define QUEUE_FLAG_POLL_STATS  28	/* collecting stats for hybrid polling */
 #define QUEUE_FLAG_REGISTERED  29	/* queue has been registered to a disk */
+#define QUEUE_FLAG_QUIESCED    30	/* queue has been quiesced */
 
 #define QUEUE_FLAG_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_STACKABLE)	|	\
@@ -712,6 +713,7 @@ static inline void queue_flag_clear(unsigned int flag, struct request_queue *q)
 #define blk_noretry_request(rq) \
 	((rq)->cmd_flags & (REQ_FAILFAST_DEV|REQ_FAILFAST_TRANSPORT| \
 			     REQ_FAILFAST_DRIVER))
+#define blk_queue_quiesced(q)	test_bit(QUEUE_FLAG_QUIESCED, &(q)->queue_flags)
 
 static inline bool blk_account_rq(struct request *rq)
 {
-- 
2.9.4
