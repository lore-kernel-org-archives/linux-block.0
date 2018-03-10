Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:44798 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751735AbeCJKKB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 10 Mar 2018 05:10:01 -0500
Date: Sat, 10 Mar 2018 11:09:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jens Axboe <axboe@fb.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, Meelis Roos <mroos@linux.ee>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Laurence Oberman <loberman@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Artem Bityutskiy <artem.bityutskiy@intel.com>
Subject: Re: [PATCH V4 1/4] scsi: hpsa: fix selection of reply queue
Message-ID: <20180310100959.GA32022@lst.de>
References: <20180309033218.23042-1-ming.lei@redhat.com> <20180309033218.23042-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180309033218.23042-2-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> +static void hpsa_setup_reply_map(struct ctlr_info *h)
> +{
> +	const struct cpumask *mask;
> +	unsigned int queue, cpu;
> +
> +	for (queue = 0; queue < h->msix_vectors; queue++) {
> +		mask = pci_irq_get_affinity(h->pdev, queue);
> +		if (!mask)
> +			goto fallback;
> +
> +		for_each_cpu(cpu, mask)
> +			h->reply_map[cpu] = queue;
> +	}
> +	return;
> +
> +fallback:
> +	for_each_possible_cpu(cpu)
> +		h->reply_map[cpu] = 0;
> +}

> +	h->reply_map = kzalloc(sizeof(*h->reply_map) * nr_cpu_ids, GFP_KERNEL);
> +	if (!h->reply_map) {
> +		kfree(h);
> +		return NULL;
> +	}
> +	return h;

I really dislike this being open coded in drivers.  It really should
be helper chared with the blk-mq map building that drivers just use.

For now just have a low-level blk_pci_map_queues that
blk_mq_pci_map_queues, hpsa and megaraid can share.  In the long run
it might make sense to change the blk-mq callout to that low-level
prototype as well.
