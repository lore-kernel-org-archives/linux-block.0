Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42064 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753194AbeBFWGE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Feb 2018 17:06:04 -0500
From: Howard McLauchlan <hmclauchlan@fb.com>
To: <linux-block@vger.kernel.org>
CC: Jens Axboe <axboe@fb.com>, <kernel-team@fb.com>,
        Omar Sandoval <osandov@osandov.com>,
        Josef Bacik <jbacik@fb.com>,
        Howard McLauchlan <hmclauchlan@fb.com>
Subject: [PATCH v3] block: Add should_fail_bio() for bpf error injection
Date: Tue, 6 Feb 2018 14:05:39 -0800
Message-ID: <20180206220539.30413-1-hmclauchlan@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The classic error injection mechanism, should_fail_request() does not
support use cases where more information is required (from the entire
struct bio, for example).

To that end, this patch introduces should_fail_bio(), which calls
should_fail_request() under the hood but provides a convenient
place for kprobes to hook into if they require the entire struct bio.
This patch also replaces some existing calls to should_fail_request()
with should_fail_bio() with no degradation in performance.

Signed-off-by: Howard McLauchlan <hmclauchlan@fb.com>
---
 block/blk-core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d0d104268f1a..2d1a7bbe0634 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -34,6 +34,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/blk-cgroup.h>
 #include <linux/debugfs.h>
+#include <linux/bpf.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/block.h>
@@ -2083,6 +2084,14 @@ static inline bool bio_check_ro(struct bio *bio, struct hd_struct *part)
 	return false;
 }
 
+static noinline int should_fail_bio(struct bio *bio)
+{
+	if (should_fail_request(&bio->bi_disk->part0, bio->bi_iter.bi_size))
+		return -EIO;
+	return 0;
+}
+ALLOW_ERROR_INJECTION(should_fail_bio, ERRNO);
+
 /*
  * Remap block n of partition p to block n+start(p) of the disk.
  */
@@ -2174,7 +2183,7 @@ generic_make_request_checks(struct bio *bio)
 	if ((bio->bi_opf & REQ_NOWAIT) && !queue_is_rq_based(q))
 		goto not_supported;
 
-	if (should_fail_request(&bio->bi_disk->part0, bio->bi_iter.bi_size))
+	if (should_fail_bio(bio))
 		goto end_io;
 
 	if (!bio->bi_partno) {
-- 
2.14.1
