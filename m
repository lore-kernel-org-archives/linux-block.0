Return-Path: <Adam.Manzanares@hgst.com>
From: Adam Manzanares <adam.manzanares@hgst.com>
To: <axboe@kernel.dk>, <tj@kernel.org>
CC: <linux-block@vger.kernel.org>, <linux-ide@vger.kernel.org>, Adam
 Manzanares <adam.manzanares@hgst.com>
Subject: [PATCH 1/3] block: Add iocontext priority to request
Date: Tue, 27 Sep 2016 11:14:54 -0700
Message-ID: <1475000096-6148-2-git-send-email-adam.manzanares@hgst.com>
In-Reply-To: <1475000096-6148-1-git-send-email-adam.manzanares@hgst.com>
References: <1475000096-6148-1-git-send-email-adam.manzanares@hgst.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: adam.manzanares@hgst.com
List-ID: <linux-block@vger.kernel.org>

Patch adds association between iocontext and a request.

Signed-off-by: Adam Manzanares <adam.manzanares@hgst.com>
---
 block/blk-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 36c7ac3..9c6d733 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -33,6 +33,7 @@
 #include <linux/ratelimit.h>
 #include <linux/pm_runtime.h>
 #include <linux/blk-cgroup.h>
+#include <linux/ioprio.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/block.h>
@@ -1648,6 +1649,7 @@ out:
 
 void init_request_from_bio(struct request *req, struct bio *bio)
 {
+	struct io_context *ioc = rq_ioc(bio);
 	req->cmd_type = REQ_TYPE_FS;
 
 	req->cmd_flags |= bio->bi_opf & REQ_COMMON_MASK;
@@ -1657,6 +1659,9 @@ void init_request_from_bio(struct request *req, struct bio *bio)
 	req->errors = 0;
 	req->__sector = bio->bi_iter.bi_sector;
 	req->ioprio = bio_prio(bio);
+	if (ioc)
+		req->ioprio = ioprio_best(req->ioprio, ioc->ioprio);
+
 	blk_rq_bio_prep(req->q, req, bio);
 }
 
-- 
2.1.4

Western Digital Corporation (and its subsidiaries) E-mail Confidentiality Notice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or legally privileged information of WDC and/or its affiliates, and are intended solely for the use of the individual or entity to which they are addressed. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited. If you have received this e-mail in error, please notify the sender immediately and delete the e-mail in its entirety from your system.
