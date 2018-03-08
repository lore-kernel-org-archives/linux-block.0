Return-Path: <ming.lei@redhat.com>
Date: Thu, 8 Mar 2018 16:15:32 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Mike Snitzer <snitzer@redhat.com>, linux-scsi@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>, Arun Easi <arun.easi@cavium.com>,
	Omar Sandoval <osandov@fb.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	James Bottomley <james.bottomley@hansenpartnership.com>,
	Don Brace <don.brace@microsemi.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Peter Rivera <peter.rivera@broadcom.com>,
	Laurence Oberman <loberman@redhat.com>,
	Meelis Roos <mroos@linux.ee>
Subject: Re: [PATCH V3 1/8] scsi: hpsa: fix selection of reply queue
Message-ID: <20180308081527.GA24816@ming.t460p>
References: <20180227100750.32299-1-ming.lei@redhat.com>
 <20180227100750.32299-2-ming.lei@redhat.com>
 <20180308075035.GE15748@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180308075035.GE15748@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Thu, Mar 08, 2018 at 08:50:35AM +0100, Christoph Hellwig wrote:
> > +static void hpsa_setup_reply_map(struct ctlr_info *h)
> > +{
> > +	const struct cpumask *mask;
> > +	unsigned int queue, cpu;
> > +
> > +	for (queue = 0; queue < h->msix_vectors; queue++) {
> > +		mask = pci_irq_get_affinity(h->pdev, queue);
> > +		if (!mask)
> > +			goto fallback;
> > +
> > +		for_each_cpu(cpu, mask)
> > +			h->reply_map[cpu] = queue;
> > +	}
> > +	return;
> > +
> > +fallback:
> > +	for_each_possible_cpu(cpu)
> > +		h->reply_map[cpu] = 0;
> > +}
> 
> It seems a little annoying that we have to duplicate this in the driver.
> Wouldn't this be solved by your force_blk_mq flag and relying on the
> hw_ctx id?

This issue can be solved by force_blk_mq, but may cause performance
regression for host-wide tagset drivers:

- If the whole tagset is partitioned into each hw queue, each hw queue's
depth may not be high enough, especially SCSI's IO path may be not
efficient enough. Even though we keep each queue's depth as 256, which
should be high enough to exploit parallelism from device internal view,
but still can't get good performance.

- If the whole tagset is still shared among all hw queues, the shared
tags can be accessed from all CPUs, and IOPS is degraded.

Kashyap has tested the above two approaches, both hurts IOPS on megaraid_sas.


thanks,
Ming
