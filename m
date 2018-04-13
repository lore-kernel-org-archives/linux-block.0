Return-Path: <maier@linux.ibm.com>
From: Steffen Maier <maier@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Li Zefan <lizf@cn.fujitsu.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steffen Maier <maier@linux.ibm.com>
Subject: [RFC] tracing/events: block: also try to get dev_t via driver core for some events
Date: Fri, 13 Apr 2018 15:07:19 +0200
In-Reply-To: <20180413130719.22921-1-maier@linux.ibm.com>
References: <20180413130719.22921-1-maier@linux.ibm.com>
Message-Id: <20180413130719.22921-4-maier@linux.ibm.com>
List-ID: <linux-block@vger.kernel.org>

Complements v2.6.31 commit 55782138e47d ("tracing/events: convert block
trace points to TRACE_EVENT()") for cases where rq->rq_disk == NULL:
  block_rq_requeue, block_rq_insert, block_rq_issue;
and for cases where bio == NULL:
  block_getrq, block_sleeprq.

NB: The NULL pointer check for q->kobj.parent is certainly racy and
I don't have enough experience if it's good enough for a trace event.

Since I don't know when above cases would occur,
I'm not sure this is worth it.

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
---
 include/trace/events/block.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index cffedc26e8a3..c476b7af404b 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -86,7 +86,9 @@ TRACE_EVENT(block_rq_requeue,
 	),
 
 	TP_fast_assign(
-		__entry->dev	   = rq->rq_disk ? disk_devt(rq->rq_disk) : 0;
+		__entry->dev	   = rq->rq_disk ? disk_devt(rq->rq_disk) :
+		(q->kobj.parent ?
+		 container_of(q->kobj.parent, struct device, kobj)->devt : 0);
 		__entry->sector    = blk_rq_trace_sector(rq);
 		__entry->nr_sector = blk_rq_trace_nr_sectors(rq);
 
@@ -162,7 +164,9 @@ DECLARE_EVENT_CLASS(block_rq,
 	),
 
 	TP_fast_assign(
-		__entry->dev	   = rq->rq_disk ? disk_devt(rq->rq_disk) : 0;
+		__entry->dev	   = rq->rq_disk ? disk_devt(rq->rq_disk) :
+		(q->kobj.parent ?
+		 container_of(q->kobj.parent, struct device, kobj)->devt : 0);
 		__entry->sector    = blk_rq_trace_sector(rq);
 		__entry->nr_sector = blk_rq_trace_nr_sectors(rq);
 		__entry->bytes     = blk_rq_bytes(rq);
@@ -397,7 +401,9 @@ DECLARE_EVENT_CLASS(block_get_rq,
         ),
 
 	TP_fast_assign(
-		__entry->dev		= bio ? bio_dev(bio) : 0;
+		__entry->dev		= bio ? bio_dev(bio) :
+		(q->kobj.parent ?
+		 container_of(q->kobj.parent, struct device, kobj)->devt : 0);
 		__entry->sector		= bio ? bio->bi_iter.bi_sector : 0;
 		__entry->nr_sector	= bio ? bio_sectors(bio) : 0;
 		blk_fill_rwbs(__entry->rwbs,
-- 
2.13.5
