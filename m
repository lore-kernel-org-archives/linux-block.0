Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59140 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751020AbeCIMDc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 9 Mar 2018 07:03:32 -0500
Date: Fri, 9 Mar 2018 20:03:14 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jens Axboe <axboe@fb.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, Meelis Roos <mroos@linux.ee>,
        Don Brace <don.brace@microsemi.com>,
        Laurence Oberman <loberman@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Artem Bityutskiy <artem.bityutskiy@intel.com>
Subject: Re: [PATCH V4 2/4] scsi: megaraid_sas: fix selection of reply queue
Message-ID: <20180309120309.GA30257@ming.t460p>
References: <20180309033218.23042-1-ming.lei@redhat.com>
 <20180309033218.23042-3-ming.lei@redhat.com>
 <f4fa1b519ad05129dc4900cb47c7b0c2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f4fa1b519ad05129dc4900cb47c7b0c2@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Mar 09, 2018 at 04:37:56PM +0530, Kashyap Desai wrote:
> > -----Original Message-----
> > From: Ming Lei [mailto:ming.lei@redhat.com]
> > Sent: Friday, March 9, 2018 9:02 AM
> > To: James Bottomley; Jens Axboe; Martin K . Petersen
> > Cc: Christoph Hellwig; linux-scsi@vger.kernel.org; linux-
> > block@vger.kernel.org; Meelis Roos; Don Brace; Kashyap Desai; Laurence
> > Oberman; Mike Snitzer; Ming Lei; Hannes Reinecke; James Bottomley; Artem
> > Bityutskiy
> > Subject: [PATCH V4 2/4] scsi: megaraid_sas: fix selection of reply queue
> >
> > From 84676c1f21 (genirq/affinity: assign vectors to all possible CPUs),
> one
> > msix vector can be created without any online CPU mapped, then command
> > may be queued, and won't be notified after its completion.
> >
> > This patch setups mapping between cpu and reply queue according to irq
> > affinity info retrived by pci_irq_get_affinity(), and uses this info to
> choose
> > reply queue for queuing one command.
> >
> > Then the chosen reply queue has to be active, and fixes IO hang caused
> by
> > using inactive reply queue which doesn't have any online CPU mapped.
> 
> Also megaraid FW will use reply queue 0 for any async notification.  We
> want to set pre_vectors = 1 and make sure reply queue 0 is not part of
> affinity hint.
> To meet that requirement, I have to make some more changes like add extra
> queue.
> Example if reply queue supported by FW is 96 and online CPU is 16, current
> driver will allocate 16 msix vector. We may have to allocate 17 msix
> vector and reserve reply queue 0 for async reply from FW.
> 
> I will be sending follow up patch soon.

OK, but the above extra change shouldn't belong to this patch, which
focuses on fixing IO hang because of reply queue selection.

> 
> >
> > Cc: Hannes Reinecke <hare@suse.de>
> > Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
> > Cc: James Bottomley <james.bottomley@hansenpartnership.com>,
> > Cc: Christoph Hellwig <hch@lst.de>,
> > Cc: Don Brace <don.brace@microsemi.com>
> > Cc: Kashyap Desai <kashyap.desai@broadcom.com>
> > Cc: Laurence Oberman <loberman@redhat.com>
> > Cc: Mike Snitzer <snitzer@redhat.com>
> > Cc: Meelis Roos <mroos@linux.ee>
> > Cc: Artem Bityutskiy <artem.bityutskiy@intel.com>
> > Fixes: 84676c1f21e8 ("genirq/affinity: assign vectors to all possible
> CPUs")
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/scsi/megaraid/megaraid_sas.h        |  2 +-
> >  drivers/scsi/megaraid/megaraid_sas_base.c   | 34
> > ++++++++++++++++++++++++++++-
> >  drivers/scsi/megaraid/megaraid_sas_fusion.c | 12 ++++------
> >  3 files changed, 38 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/scsi/megaraid/megaraid_sas.h
> > b/drivers/scsi/megaraid/megaraid_sas.h
> > index ba6503f37756..a644d2be55b6 100644
> > --- a/drivers/scsi/megaraid/megaraid_sas.h
> > +++ b/drivers/scsi/megaraid/megaraid_sas.h
> > @@ -2127,7 +2127,7 @@ enum MR_PD_TYPE {
> >  #define MR_NVME_PAGE_SIZE_MASK		0x000000FF
> >
> >  struct megasas_instance {
> > -
> > +	unsigned int *reply_map;
> >  	__le32 *producer;
> >  	dma_addr_t producer_h;
> >  	__le32 *consumer;
> > diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c
> > b/drivers/scsi/megaraid/megaraid_sas_base.c
> > index a71ee67df084..065956cb2aeb 100644
> > --- a/drivers/scsi/megaraid/megaraid_sas_base.c
> > +++ b/drivers/scsi/megaraid/megaraid_sas_base.c
> > @@ -5165,6 +5165,26 @@ megasas_setup_jbod_map(struct
> > megasas_instance *instance)
> >  		instance->use_seqnum_jbod_fp = false;  }
> >
> > +static void megasas_setup_reply_map(struct megasas_instance *instance)
> > +{
> > +	const struct cpumask *mask;
> > +	unsigned int queue, cpu;
> > +
> > +	for (queue = 0; queue < instance->msix_vectors; queue++) {
> > +		mask = pci_irq_get_affinity(instance->pdev, queue);
> > +		if (!mask)
> > +			goto fallback;
> > +
> > +		for_each_cpu(cpu, mask)
> > +			instance->reply_map[cpu] = queue;
> > +	}
> > +	return;
> > +
> > +fallback:
> > +	for_each_possible_cpu(cpu)
> > +		instance->reply_map[cpu] = 0;
> 
> Fallback should be better instead of just assigning to single reply queue.
> May be something like below.
> 
>    for_each_possible_cpu(cpu)
>        instance->reply_map[cpu] = cpu % instance->msix_vectors;;
> 
> If smp_affinity_enable module parameter is set to 0, I see performance
> drop because IO is going to single reply queue.

OK, that looks one issue. If smp_affinity_enable is set as 0, we should
follow the original way.

> 
> > +}
> > +
> >  /**
> >   * megasas_init_fw -	Initializes the FW
> >   * @instance:		Adapter soft state
> > @@ -5343,6 +5363,8 @@ static int megasas_init_fw(struct megasas_instance
> > *instance)
> >  			goto fail_setup_irqs;
> >  	}
> >
> > +	megasas_setup_reply_map(instance);
> > +
> >  	dev_info(&instance->pdev->dev,
> >  		"firmware supports msix\t: (%d)", fw_msix_count);
> >  	dev_info(&instance->pdev->dev,
> > @@ -6448,6 +6470,11 @@ static int megasas_probe_one(struct pci_dev
> > *pdev,
> >  	memset(instance, 0, sizeof(*instance));
> >  	atomic_set(&instance->fw_reset_no_pci_access, 0);
> >
> > +	instance->reply_map = kzalloc(sizeof(unsigned int) * nr_cpu_ids,
> > +			GFP_KERNEL);
> > +	if (!instance->reply_map)
> > +		goto fail_alloc_reply_map;
> > +
> We have common function  megasas_alloc_ctrl_mem() to manage allocation.
> Good candidate to move this allocation to megasas_alloc_ctrl_mem.

Good point, will do that in V5.


-- 
Ming
