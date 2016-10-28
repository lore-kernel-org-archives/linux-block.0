Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40583 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756769AbcJ1Wwk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Oct 2016 18:52:40 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u9SMnVE4006337
        for <linux-block@vger.kernel.org>; Fri, 28 Oct 2016 15:52:39 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 26c9u5bn08-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 28 Oct 2016 15:52:39 -0700
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.222.219.45) with ESMTP id
 38f1ab7a9d6111e6a3a124be05904660-519eda50 for <linux-block@vger.kernel.org>;
        Fri, 28 Oct 2016 15:52:37 -0700
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <Kernel-team@fb.com>, <axboe@fb.com>
Subject: [PATCH 1/2] block: immediately dispatch big size request
Date: Fri, 28 Oct 2016 15:52:35 -0700
Message-ID: <a42409a1a37e819e0497c091ab49461370b34989.1477694963.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Currently block plug holds up to 16 non-mergeable requests. This makes
sense if the request size is small, eg, reduce lock contention. But if
request size is big enough, we don't need to worry about lock
contention. Holding such request makes no sense and it lows the disk
utilization.

In practice, this improves 10% throughput for my raid5 sequential write
workload.

The size (128k) is arbitrary right now, but it makes sure lock
contention is small. This probably could be more intelligent, eg, check
average request size holded. Since this is mainly for sequential IO,
probably not worthy.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-core.c       | 4 +++-
 include/linux/blkdev.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 14d7c07..0a396e9 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1763,7 +1763,9 @@ static blk_qc_t blk_queue_bio(struct request_queue *q, struct bio *bio)
 		if (!request_count)
 			trace_block_plug(q);
 		else {
-			if (request_count >= BLK_MAX_REQUEST_COUNT) {
+			struct request *first = list_entry_rq(plug->list.next);
+			if (request_count >= BLK_MAX_REQUEST_COUNT ||
+			    blk_rq_bytes(first) >= BLK_PLUG_FLUSH_SIZE) {
 				blk_flush_plug_list(plug, false);
 				trace_block_plug(q);
 			}
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c47c358..72fa505 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1078,6 +1078,7 @@ struct blk_plug {
 	struct list_head cb_list; /* md requires an unplug callback */
 };
 #define BLK_MAX_REQUEST_COUNT 16
+#define BLK_PLUG_FLUSH_SIZE (128 * 1024)
 
 struct blk_plug_cb;
 typedef void (*blk_plug_cb_fn)(struct blk_plug_cb *, bool);
-- 
2.9.3

