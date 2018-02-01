Return-Path: <keith.busch@intel.com>
Date: Wed, 31 Jan 2018 21:56:45 -0700
From: Keith Busch <keith.busch@intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: "jianchao.wang" <jianchao.w.wang@oracle.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: Re: WARNING: CPU: 2 PID: 207 at drivers/nvme/host/core.c:527
 nvme_setup_cmd+0x3d3
Message-ID: <20180201045645.GF27735@localhost.localdomain>
References: <45f93661-da0d-94c5-1740-85242df8776e@kernel.dk>
 <0872b361-157b-a876-20af-3d7a4ee7ff31@kernel.dk>
 <8fd916ab-42d7-c654-5a01-8f1eb4be730e@oracle.com>
 <0b7686b3-f716-49ba-c7c4-929d84905569@kernel.dk>
 <7459ffed-c63c-38a9-84f5-456c2a5c4fe0@oracle.com>
 <0f6c248b-eb67-9b02-a4b9-0366d476e70d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0f6c248b-eb67-9b02-a4b9-0366d476e70d@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jan 31, 2018 at 08:07:41PM -0700, Jens Axboe wrote:
>  	if (total_phys_segments > queue_max_segments(q))
> -		return 0;
> +			return 0;

This perhaps unintended change happens to point out another problem:
queue_max_segments is the wrong limit for discards, which require
queue_max_discard_segments.

It might be easier to merge discard requests special, like how merging
a discard bio is handled (untested).

---
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 8452fc7164cc..01671e1373ff 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -550,6 +550,28 @@ static bool req_no_special_merge(struct request *req)
 	return !q->mq_ops && req->special;
 }
 
+static bool req_attempt_discard_merge(struct request_queue *q, struct request *req,
+		struct request *next)
+{
+	unsigned short segments = blk_rq_nr_discard_segments(req);
+
+	if (segments >= queue_max_discard_segments(q))
+		goto no_merge;
+	if (blk_rq_sectors(req) + bio_sectors(next->bio) >
+	    blk_rq_get_max_sectors(req, blk_rq_pos(req)))
+		goto no_merge;
+
+	req->biotail->bi_next = next->bio;
+	req->biotail = next->biotail;
+	req->nr_phys_segments = segments + blk_rq_nr_discard_segments(next);
+	next->bio = NULL;
+	return true;
+
+no_merge:
+	req_set_nomerge(q, req);
+	return false;
+}
+
 static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
 				struct request *next)
 {
@@ -679,6 +701,15 @@ static struct request *attempt_merge(struct request_queue *q,
 	if (req->write_hint != next->write_hint)
 		return NULL;
 
+	/*
+	 * Discards are ... special.
+	 */
+	if (req_op(req) == REQ_OP_DISCARD) {
+		if (req_attempt_discard_merge(q, req, next))
+			return next;
+		return NULL;
+	}
+
 	/*
 	 * If we are allowed to merge, then append bio list
 	 * from next to rq and release next. merge_requests_fn
--
