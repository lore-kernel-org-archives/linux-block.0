Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57948 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752388AbcIOVQ4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 17:16:56 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.17/8.16.0.17) with SMTP id u8FL8sY9010989
        for <linux-block@vger.kernel.org>; Thu, 15 Sep 2016 14:16:55 -0700
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0089730.ppops.net with ESMTP id 25g2cgrfqw-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 15 Sep 2016 14:16:55 -0700
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@fb.com>
Subject: [PATCH] blk-mq: account higher order dispatch
Message-ID: <80fca3d5-7c21-bce1-11db-2010a459a774@fb.com>
Date: Thu, 15 Sep 2016 15:16:49 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

We currently account a '0' dispatch, and anything above that still falls
below the range set by BLK_MQ_MAX_DISPATCH_ORDER. If we dispatch more,
we don't account it.

Change the last bucket to be inclusive of anything above the range we
track, and have the sysfs file reflect that by including a '+' in the
output:

$ cat /sys/block/nvme0n1/mq/0/dispatched
        0	1006
        1	20229
        2	1
        4	0
        8	0
       16	0
       32+	0

Signed-off-by: Jens Axboe <axboe@fb.com>

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 885a4a59acd9..39840c37b7ce 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -208,12 +208,14 @@ static ssize_t 
blk_mq_hw_sysfs_dispatched_show(struct blk_mq_hw_ctx *hctx,

  	page += sprintf(page, "%8u\t%lu\n", 0U, hctx->dispatched[0]);

-	for (i = 1; i < BLK_MQ_MAX_DISPATCH_ORDER; i++) {
-		unsigned long d = 1U << (i - 1);
+	for (i = 1; i < BLK_MQ_MAX_DISPATCH_ORDER - 1; i++) {
+		unsigned int d = 1U << (i - 1);

-		page += sprintf(page, "%8lu\t%lu\n", d, hctx->dispatched[i]);
+		page += sprintf(page, "%8u\t%lu\n", d, hctx->dispatched[i]);
  	}

+	page += sprintf(page, "%8u+\t%lu\n", 1U << (i - 1),
+						hctx->dispatched[i]);
  	return page - start_page;
  }

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4b8034e54478..fb4b6795ec57 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -802,6 +802,14 @@ static void flush_busy_ctxs(struct blk_mq_hw_ctx 
*hctx, struct list_head *list)
  	}
  }

+static inline unsigned int queued_to_index(unsigned int queued)
+{
+	if (!queued)
+		return 0;
+
+	return min(BLK_MQ_MAX_DISPATCH_ORDER - 1, ilog2(queued) + 1);
+}
+
  /*
   * Run this hardware queue, pulling any software queues mapped to it in.
   * Note that this function currently has various problems around ordering
@@ -890,10 +898,7 @@ static void __blk_mq_run_hw_queue(struct 
blk_mq_hw_ctx *hctx)
  			dptr = &driver_list;
  	}

-	if (!queued)
-		hctx->dispatched[0]++;
-	else if (queued < (1 << (BLK_MQ_MAX_DISPATCH_ORDER - 1)))
-		hctx->dispatched[ilog2(queued) + 1]++;
+	hctx->dispatched[queued_to_index(queued)]++;

  	/*
  	 * Any items that need requeuing? Stuff them into hctx->dispatch,

-- 
Jens Axboe

