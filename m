Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:44180 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752632AbdHQUJh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Aug 2017 16:09:37 -0400
Date: Thu, 17 Aug 2017 16:15:27 -0400
From: Keith Busch <keith.busch@intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH] nvme: always return IRQ_HANDLED
Message-ID: <20170817201526.GA21397@localhost.localdomain>
References: <06b85884-efb4-e419-4b31-3aa4751bb338@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <06b85884-efb4-e419-4b31-3aa4751bb338@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Aug 17, 2017 at 01:32:20PM -0600, Jens Axboe wrote:
> We currently have an issue with nvme when polling is used. Just
> ran some testing on 4.13-rc5, and it's trivial to trigger an IRQ
> disable ala:
> 
> [   52.412851] irq 77: nobody cared (try booting with the "irqpoll" option)
> [   52.415310] irq 70: nobody cared (try booting with the "irqpoll" option)
> 
> when running a few processes polling. The reason is pretty obvious - if
> we're effective at polling, the triggered IRQ will never find any
> events. If this happens enough times in a row, the kernel disables our
> IRQ since we keep returning IRQ_NONE.

If you're seeing IRQ_NONE returned, the NVMe driver didn't poll any
completions since the last time nvme_irq was called. The cqe_seen on
polled compeletions is sticky until the IRQ handler is run, in which
case it returns IRQ_HANDLED even when no completions were handled during
that interrupt.

The only way it should be able to return IRQ_NONE is if no completions
were observed (polled or otherwise) since the last time the IRQ handler
was called.

> Question is, what's the best way to solve this. Ideally we should not be
> triggering an IRQ at all, but that's still not in mainline. Can we
> safely just return IRQ_HANDLED always? That should work except for the
> case where we happen to run into an IRQ flood where DO want to turn off
> the nvme irq. For now, I think that's small price to pay, since the
> current issue is much worse and leaves the device in a weird non-working
> state where some queue interrupts are turned off.

My recommended way to get this handled is to enable interrupt coalescing
and have controllers behave as the specification describes to suppress
interrupts when polling is active. From section 5.21.1.8:

  Specifically, if the Completion Queue Head Doorbell register is being
  updated that is associated with a particular interrupt vector, then
  the controller has a positive indication that completion queue entries
  are already being processed. In this case, the aggregation time and/or
  the aggregation threshold may be reset/restarted upon the associated
  register write. This may result in interrupts being delayed indefinitely
  in certain workloads where the aggregation time or aggregation threshold
  is non-zero.

> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 74a124a06264..21a35faff86f 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -160,7 +160,6 @@ struct nvme_queue {
>  	u16 cq_head;
>  	u16 qid;
>  	u8 cq_phase;
> -	u8 cqe_seen;
>  	u32 *dbbuf_sq_db;
>  	u32 *dbbuf_cq_db;
>  	u32 *dbbuf_sq_ei;
> @@ -830,22 +829,19 @@ static void nvme_process_cq(struct nvme_queue *nvmeq)
>  		consumed++;
>  	}
>  
> -	if (consumed) {
> +	if (consumed)
>  		nvme_ring_cq_doorbell(nvmeq);
> -		nvmeq->cqe_seen = 1;
> -	}
>  }
>  
>  static irqreturn_t nvme_irq(int irq, void *data)
>  {
> -	irqreturn_t result;
>  	struct nvme_queue *nvmeq = data;
> +
>  	spin_lock(&nvmeq->q_lock);
>  	nvme_process_cq(nvmeq);
> -	result = nvmeq->cqe_seen ? IRQ_HANDLED : IRQ_NONE;
> -	nvmeq->cqe_seen = 0;
>  	spin_unlock(&nvmeq->q_lock);
> -	return result;
> +
> +	return IRQ_HANDLED;
>  }
>  
>  static irqreturn_t nvme_irq_check(int irq, void *data)
> 
> -- 
> Jens Axboe
