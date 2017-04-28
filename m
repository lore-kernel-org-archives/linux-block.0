Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59242 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936271AbdD1PRC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2017 11:17:02 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 4/4] blk-mq: dump new introduced flag of BLK_MQ_F_SCHED_USE_HW_TAG
Date: Fri, 28 Apr 2017 23:15:39 +0800
Message-Id: <20170428151539.25514-5-ming.lei@redhat.com>
In-Reply-To: <20170428151539.25514-1-ming.lei@redhat.com>
References: <20170428151539.25514-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index bcd2a7d4a3a5..bc390847a60d 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -220,6 +220,7 @@ static const char *const hctx_flag_name[] = {
 	[ilog2(BLK_MQ_F_SG_MERGE)]	= "SG_MERGE",
 	[ilog2(BLK_MQ_F_BLOCKING)]	= "BLOCKING",
 	[ilog2(BLK_MQ_F_NO_SCHED)]	= "NO_SCHED",
+	[ilog2(BLK_MQ_F_SCHED_USE_HW_TAG)]	= "SCHED_USE_HW_TAG",
 };
 
 static int hctx_flags_show(struct seq_file *m, void *v)
-- 
2.9.3
