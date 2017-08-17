Return-Path: <keith.busch@intel.com>
Date: Thu, 17 Aug 2017 16:29:45 -0400
From: Keith Busch <keith.busch@intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH] nvme: always return IRQ_HANDLED
Message-ID: <20170817202945.GB21397@localhost.localdomain>
References: <06b85884-efb4-e419-4b31-3aa4751bb338@kernel.dk>
 <20170817201526.GA21397@localhost.localdomain>
 <60b6e2b7-86d1-d5c7-66af-e771d17384b8@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <60b6e2b7-86d1-d5c7-66af-e771d17384b8@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 17, 2017 at 02:17:08PM -0600, Jens Axboe wrote:
> On 08/17/2017 02:15 PM, Keith Busch wrote:
> > On Thu, Aug 17, 2017 at 01:32:20PM -0600, Jens Axboe wrote:
> >> We currently have an issue with nvme when polling is used. Just
> >> ran some testing on 4.13-rc5, and it's trivial to trigger an IRQ
> >> disable ala:
> >>
> >> [   52.412851] irq 77: nobody cared (try booting with the "irqpoll" option)
> >> [   52.415310] irq 70: nobody cared (try booting with the "irqpoll" option)
> >>
> >> when running a few processes polling. The reason is pretty obvious - if
> >> we're effective at polling, the triggered IRQ will never find any
> >> events. If this happens enough times in a row, the kernel disables our
> >> IRQ since we keep returning IRQ_NONE.
> > 
> > If you're seeing IRQ_NONE returned, the NVMe driver didn't poll any
> > completions since the last time nvme_irq was called. The cqe_seen on
> > polled compeletions is sticky until the IRQ handler is run, in which
> > case it returns IRQ_HANDLED even when no completions were handled during
> > that interrupt.
> > 
> > The only way it should be able to return IRQ_NONE is if no completions
> > were observed (polled or otherwise) since the last time the IRQ handler
> > was called.
> 
> The polling do not update the cqe_seen. So it's possible that every time
> the IRQ handler does trigger, there are no entries found. Maybe a better
> or simpler fix would be to have the polling set cqe_seen to true, and
> leave the clearing to the interrupt handler as is done now.

Oops, that looks like a mistake. I don't think we want to suppress
spurious interrupt detection, though. How about this patch to set cq_seen
on polling like we used to have?

Fixes: 920d13a884 ("nvme-pci: factor out the cqe reading mechanics from __nvme_process_cq")

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ea5eb4c..e9886e1 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -795,6 +795,7 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
 		return;
 	}
 
+	nvmeq->cqe_seen = 1;
 	req = blk_mq_tag_to_rq(*nvmeq->tags, cqe->command_id);
 	nvme_end_request(req, cqe->status, cqe->result);
 }
@@ -824,10 +825,8 @@ static void nvme_process_cq(struct nvme_queue *nvmeq)
 		consumed++;
 	}
 
-	if (consumed) {
+	if (consumed)
 		nvme_ring_cq_doorbell(nvmeq);
-		nvmeq->cqe_seen = 1;
-	}
 }
 
 static irqreturn_t nvme_irq(int irq, void *data)
--
