Return-Path: <linux-block-owner@vger.kernel.org>
Received: from 22.17.110.36.static.bjtelecom.net ([36.110.17.22]:25712 "EHLO
        BJEXCAS004.didichuxing.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751696AbeAOQcp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jan 2018 11:32:45 -0500
Date: Tue, 16 Jan 2018 00:32:36 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: [RFC PATCH] blktrace: fail earlier if blk_trace in use
Message-ID: <20180115163231.GA23803@bogon.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

add a check before allocate resource for blk_trace, if it's in use.

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 kernel/trace/blktrace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 987d9a9a..16c0000 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -491,6 +491,9 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	struct dentry *dir = NULL;
 	int ret;
 
+	if (unlikely(q->blk_trace))
+		return -EBUSY;
+
 	if (!buts->buf_size || !buts->buf_nr)
 		return -EINVAL;
 
-- 
2.9.4
