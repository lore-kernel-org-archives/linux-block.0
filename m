Return-Path: <keith.busch@intel.com>
Date: Thu, 1 Feb 2018 12:52:12 -0700
From: Keith Busch <keith.busch@intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: "jianchao.wang" <jianchao.w.wang@oracle.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: Re: WARNING: CPU: 2 PID: 207 at drivers/nvme/host/core.c:527
 nvme_setup_cmd+0x3d3
Message-ID: <20180201195212.GD24417@localhost.localdomain>
References: <45f93661-da0d-94c5-1740-85242df8776e@kernel.dk>
 <0872b361-157b-a876-20af-3d7a4ee7ff31@kernel.dk>
 <8fd916ab-42d7-c654-5a01-8f1eb4be730e@oracle.com>
 <0b7686b3-f716-49ba-c7c4-929d84905569@kernel.dk>
 <7459ffed-c63c-38a9-84f5-456c2a5c4fe0@oracle.com>
 <0f6c248b-eb67-9b02-a4b9-0366d476e70d@kernel.dk>
 <20180201045645.GF27735@localhost.localdomain>
 <576ba7dc-78cf-b5d2-d1de-446d1f4b2732@kernel.dk>
 <7ec361a3-8900-d259-6842-e0b0b14a253a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7ec361a3-8900-d259-6842-e0b0b14a253a@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Feb 01, 2018 at 10:58:23AM -0700, Jens Axboe wrote:
> I was able to reproduce on a test box, pretty trivially in fact:
> 
> # echo mq-deadline > /sys/block/nvme2n1/queue/scheduler
> # mkfs.ext4 /dev/nvme2n1
> # mount /dev/nvme2n1 /data -o discard
> # dd if=/dev/zero of=/data/10g bs=1M count=10k
> # sync
> # rm /data/10g
> # sync <- triggered
> 
> Your patch still doesn't work, but mainly because we init the segments
> to 0 when setting up a discard. The below works for me, and cleans up
> the merge path a bit, since your patch was missing various adjustments
> on both the merged and freed request.

I'm still finding cases not accounted even your patch. I had to use the
following on top of that, and this pattern looks like it needs to be
repeated for all schedulers:

---
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 55c0a745b427..25c14c58385c 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -259,6 +259,8 @@ bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
 		if (!*merged_request)
 			elv_merged_request(q, rq, ELEVATOR_FRONT_MERGE);
 		return true;
+	case ELEVATOR_DISCARD_MERGE:
+		return bio_attempt_discard_merge(q, rq, bio);
 	default:
 		return false;
 	}
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index c56f211c8440..a0f5752b6858 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -451,7 +451,7 @@ static int dd_request_merge(struct request_queue *q, struct request **rq,
 
 		if (elv_bio_merge_ok(__rq, bio)) {
 			*rq = __rq;
-			return ELEVATOR_FRONT_MERGE;
+			return blk_try_merge(__rq, bio);
 		}
 	}
 
--
