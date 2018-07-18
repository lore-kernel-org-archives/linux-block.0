Return-Path: <keith.busch@linux.intel.com>
Date: Wed, 18 Jul 2018 14:53:21 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: "hch@lst.de" <hch@lst.de>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
	"keith.busch@intel.com" <keith.busch@intel.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
Message-ID: <20180718205321.GA32160@localhost.localdomain>
References: <20180521231131.6685-4-keith.busch@intel.com>
 <c42d13289e38df93bb35e9876b803420e40b03d3.camel@wdc.com>
 <20180712192437.GA16839@localhost.localdomain>
 <7cad25b821c3a640e036f28ff1bbe51e7362d25d.camel@wdc.com>
 <20180713154346.GA18955@localhost.localdomain>
 <a32b251bd3c0a186e5c5ba82656a85fbdcc0c5e4.camel@wdc.com>
 <20180713184712.GA19419@localhost.localdomain>
 <291a13b35af1b65fbbe99a3a9cfc7d570a620cd9.camel@wdc.com>
 <20180713235807.GA19967@localhost.localdomain>
 <20180718195650.GA20336@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180718195650.GA20336@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 18, 2018 at 09:56:50PM +0200, hch@lst.de wrote:
> On Fri, Jul 13, 2018 at 05:58:08PM -0600, Keith Busch wrote:
> > Of the two you mentioned, yours is preferable IMO. While I appreciate
> > Jianchao's detailed analysis, it's hard to take a proposal seriously
> > that so colourfully calls everyone else "dangerous" while advocating
> > for silently losing requests on purpose.
> > 
> > But where's the option that fixes scsi to handle hardware completions
> > concurrently with arbitrary timeout software? Propping up that house of
> > cards can't be the only recourse.
> 
> The important bit is that we need to fix this issue quickly.  We are
> past -rc5 so I'm rather concerned about anything too complicated.
> 
> I'm not even sure SCSI has a problem with multiple completions happening
> at the same time, but it certainly has a problem with bypassing
> blk_mq_complete_request from the EH path.
> 
> I think we can solve this properly, but I also think we are way to late
> in the 4.18 cycle to fix it properly.  For now I fear we'll just have
> to revert the changes and try again for 4.19 or even 4.20 if we don't
> act quickly enough.

If scsi needs this behavior, why not just put that behavior in scsi? It
can set the state to complete and then everything can play out as
before.

---
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 22326612a5d3..f50559718b71 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -558,10 +558,8 @@ static void __blk_mq_complete_request(struct request *rq)
 	bool shared = false;
 	int cpu;
 
-	if (cmpxchg(&rq->state, MQ_RQ_IN_FLIGHT, MQ_RQ_COMPLETE) !=
-			MQ_RQ_IN_FLIGHT)
+	if (blk_mq_mark_complete(rq))
 		return;
-
 	if (rq->internal_tag != -1)
 		blk_mq_sched_completed_request(rq);
 
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 8932ae81a15a..a5d05fab24a7 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -286,6 +286,14 @@ enum blk_eh_timer_return scsi_times_out(struct request *req)
 	enum blk_eh_timer_return rtn = BLK_EH_DONE;
 	struct Scsi_Host *host = scmd->device->host;
 
+	/*
+	 * Mark complete now so lld can't post a completion during error
+	 * handling. Return immediately if it was already marked complete, as
+	 * that means the lld posted a completion already.
+	 */
+	if (req->q->mq_ops && blk_mq_mark_complete(req))
+		return rtn;
+
 	trace_scsi_dispatch_cmd_timeout(scmd);
 	scsi_log_completion(scmd, TIMEOUT_ERROR);
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 9b0fd11ce89a..0ce587c9c27b 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -289,6 +289,15 @@ void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
 
 void blk_mq_quiesce_queue_nowait(struct request_queue *q);
 
+/*
+ * Returns true if request is not in flight.
+ */
+static inline bool blk_mq_mark_complete(struct request *rq)
+{
+	return (cmpxchg(&rq->state, MQ_RQ_IN_FLIGHT, MQ_RQ_COMPLETE) !=
+			MQ_RQ_IN_FLIGHT);
+}
+
 /*
  * Driver command data is immediately after the request. So subtract request
  * size to get back to the original request, add request size to get the PDU.
--
