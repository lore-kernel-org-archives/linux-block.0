Return-Path: <ming.lei@redhat.com>
Date: Thu, 8 Mar 2018 17:19:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Mike Snitzer <snitzer@redhat.com>, linux-scsi@vger.kernel.org,
	Arun Easi <arun.easi@cavium.com>, Omar Sandoval <osandov@fb.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	James Bottomley <james.bottomley@hansenpartnership.com>,
	Don Brace <don.brace@microsemi.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Peter Rivera <peter.rivera@broadcom.com>,
	Laurence Oberman <loberman@redhat.com>,
	Meelis Roos <mroos@linux.ee>
Subject: Re: [PATCH V3 1/8] scsi: hpsa: fix selection of reply queue
Message-ID: <20180308091926.GB24816@ming.t460p>
References: <20180227100750.32299-1-ming.lei@redhat.com>
 <20180227100750.32299-2-ming.lei@redhat.com>
 <20180308075035.GE15748@lst.de>
 <20180308081527.GA24816@ming.t460p>
 <ad59f1bc-5db6-1f27-9924-b043b76d5257@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ad59f1bc-5db6-1f27-9924-b043b76d5257@suse.de>
List-ID: <linux-block@vger.kernel.org>

On Thu, Mar 08, 2018 at 09:41:16AM +0100, Hannes Reinecke wrote:
> On 03/08/2018 09:15 AM, Ming Lei wrote:
> > On Thu, Mar 08, 2018 at 08:50:35AM +0100, Christoph Hellwig wrote:
> >>> +static void hpsa_setup_reply_map(struct ctlr_info *h)
> >>> +{
> >>> +	const struct cpumask *mask;
> >>> +	unsigned int queue, cpu;
> >>> +
> >>> +	for (queue = 0; queue < h->msix_vectors; queue++) {
> >>> +		mask = pci_irq_get_affinity(h->pdev, queue);
> >>> +		if (!mask)
> >>> +			goto fallback;
> >>> +
> >>> +		for_each_cpu(cpu, mask)
> >>> +			h->reply_map[cpu] = queue;
> >>> +	}
> >>> +	return;
> >>> +
> >>> +fallback:
> >>> +	for_each_possible_cpu(cpu)
> >>> +		h->reply_map[cpu] = 0;
> >>> +}
> >>
> >> It seems a little annoying that we have to duplicate this in the driver.
> >> Wouldn't this be solved by your force_blk_mq flag and relying on the
> >> hw_ctx id?
> > 
> > This issue can be solved by force_blk_mq, but may cause performance
> > regression for host-wide tagset drivers:
> > 
> > - If the whole tagset is partitioned into each hw queue, each hw queue's
> > depth may not be high enough, especially SCSI's IO path may be not
> > efficient enough. Even though we keep each queue's depth as 256, which
> > should be high enough to exploit parallelism from device internal view,
> > but still can't get good performance.
> > 
> > - If the whole tagset is still shared among all hw queues, the shared
> > tags can be accessed from all CPUs, and IOPS is degraded.
> > 
> > Kashyap has tested the above two approaches, both hurts IOPS on megaraid_sas.
> > 
> This is precisely the issue I have been worried about, too.
> 
> The problem is not so much the tagspace (which actually is quite small
> memory footprint-wise), but rather the _requests_ indexed by the tags.

But V1 is done in this way, one shared tags is used and requests are
allocated for each hw queue in NUMA locality, finally Kashyap confirmed
that IOPS can be recovered to normal if iostats is set as 0 after V1 is
applied:

	https://marc.info/?l=linux-scsi&m=151815231026789&w=2

That means the shared tags does have a big effect on performance.

> 
> We have this:
> 
> struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_mq_tag_set *set,
>                                         unsigned int hctx_idx,
>                                         unsigned int nr_tags,
>                                         unsigned int reserved_tags)
> {
>         struct blk_mq_tags *tags;
>         int node;
> 
>         node = blk_mq_hw_queue_to_node(set->mq_map, hctx_idx);
>         if (node == NUMA_NO_NODE)
>                 node = set->numa_node;
> 
>         tags = blk_mq_init_tags(nr_tags, reserved_tags, node,
>                      BLK_MQ_FLAG_TO_ALLOC_POLICY(set->flags));
>         if (!tags)
>                 return NULL;
> 
>         tags->rqs = kzalloc_node(nr_tags * sizeof(struct request *),
>                       GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY, node);
> 
> 
> IE the _entire_ request set is allocated as _one_ array, making it quite
> hard to handle from the lower-level CPU caches.
> Also the 'node' indicator doesn't really help us here, as the requests
> have to be access by all CPUs in the shared tag case.
> 
> Would it be possible move tags->rqs to become a _double_ pointer?
> Then we would have only a shared lookup table, but the requests
> themselves can be allocated per node, depending on the CPU map.
> _And_ it should be easier on the CPU cache ...

That is basically same with the way in V1, even similar with V3, in
which per-node hw queue is introduced, from Kashyap's test, the
performance isn't bad. I believe finally IOPS can be improved if
scsi_host->host_busy operation is removed from IO path and
megaraid_sas driver is improved, as I mentioned earlier.

Thanks,
Ming
