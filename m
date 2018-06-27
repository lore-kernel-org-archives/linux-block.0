Return-Path: <prvs=70988ebf6=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH] include/trace/events/wbt.h: Suppress a compiler warning
Date: Wed, 27 Jun 2018 13:22:34 -0700
Message-Id: <20180627202234.17670-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

This patch avoids that the following warning appears when building
with gcc 8 and W=1:

./include/trace/events/wbt.h:36:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 include/trace/events/wbt.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/trace/events/wbt.h b/include/trace/events/wbt.h
index b048694070e2..29ec58adfddd 100644
--- a/include/trace/events/wbt.h
+++ b/include/trace/events/wbt.h
@@ -8,6 +8,9 @@
 #include <linux/tracepoint.h>
 #include "../../../block/blk-wbt.h"
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wstringop-truncation"
+
 /**
  * wbt_stat - trace stats for blk_wb
  * @stat: array of read/write stats
@@ -148,6 +151,8 @@ TRACE_EVENT(wbt_timer,
 		  __entry->status, __entry->step, __entry->inflight)
 );
 
+#pragma GCC diagnostic pop
+
 #endif /* _TRACE_WBT_H */
 
 /* This part must be outside protection */
-- 
2.17.1
