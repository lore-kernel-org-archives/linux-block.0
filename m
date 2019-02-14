Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC5CC10F04
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 22:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 484FB2229F
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 22:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395512AbfBNWlx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 17:41:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47542 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388757AbfBNWlx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 17:41:53 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 599ECA1E43;
        Thu, 14 Feb 2019 22:41:52 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FDD85D704;
        Thu, 14 Feb 2019 22:41:42 +0000 (UTC)
Date:   Fri, 15 Feb 2019 06:41:37 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>
Subject: Re: [patch V5 4/8] nvme-pci: Simplify interrupt allocation
Message-ID: <20190214224136.GA18764@ming.t460p>
References: <20190214204755.819014197@linutronix.de>
 <20190214211759.699390983@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214211759.699390983@linutronix.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 14 Feb 2019 22:41:52 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 14, 2019 at 09:47:59PM +0100, Thomas Gleixner wrote:
> From: Ming Lei <ming.lei@redhat.com>
> 
> The NVME PCI driver contains a tedious mechanism for interrupt
> allocation, which is necessary to adjust the number and size of interrupt
> sets to the maximum available number of interrupts which depends on the
> underlying PCI capabilities and the available CPU resources.
> 
> It works around the former short comings of the PCI and core interrupt
> allocation mechanims in combination with interrupt sets.
> 
> The PCI interrupt allocation function allows to provide a maximum and a
> minimum number of interrupts to be allocated and tries to allocate as
> many as possible. This worked without driver interaction as long as there
> was only a single set of interrupts to handle.
> 
> With the addition of support for multiple interrupt sets in the generic
> affinity spreading logic, which is invoked from the PCI interrupt
> allocation, the adaptive loop in the PCI interrupt allocation did not
> work for multiple interrupt sets. The reason is that depending on the
> total number of interrupts which the PCI allocation adaptive loop tries
> to allocate in each step, the number and the size of the interrupt sets
> need to be adapted as well. Due to the way the interrupt sets support was
> implemented there was no way for the PCI interrupt allocation code or the
> core affinity spreading mechanism to invoke a driver specific function
> for adapting the interrupt sets configuration.
> 
> As a consequence the driver had to implement another adaptive loop around
> the PCI interrupt allocation function and calling that with maximum and
> minimum interrupts set to the same value. This ensured that the
> allocation either succeeded or immediately failed without any attempt to
> adjust the number of interrupts in the PCI code.
> 
> The core code now allows drivers to provide a callback to recalculate the
> number and the size of interrupt sets during PCI interrupt allocation,
> which in turn allows the PCI interrupt allocation function to be called
> in the same way as with a single set of interrupts. The PCI code handles
> the adaptive loop and the interrupt affinity spreading mechanism invokes
> the driver callback to adapt the interrupt set configuration to the
> current loop value. This replaces the adaptive loop in the driver
> completely.
> 
> Implement the NVME specific callback which adjusts the interrupt sets
> configuration and remove the adaptive allocation loop.
> 
> [ tglx: Simplify the callback further and restore the dropped adjustment of
>   	number of sets ]
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> ---
>  drivers/nvme/host/pci.c |  108 ++++++++++++------------------------------------
>  1 file changed, 28 insertions(+), 80 deletions(-)
> 
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2041,41 +2041,32 @@ static int nvme_setup_host_mem(struct nv
>  	return ret;
>  }
>  
> -/* irq_queues covers admin queue */
> -static void nvme_calc_io_queues(struct nvme_dev *dev, unsigned int irq_queues)
> +/*
> + * nirqs is the number of interrupts available for write and read
> + * queues. The core already reserved an interrupt for the admin queue.
> + */
> +static void nvme_calc_irq_sets(struct irq_affinity *affd, unsigned int nrirqs)
>  {
> -	unsigned int this_w_queues = write_queues;
> -
> -	WARN_ON(!irq_queues);
> -
> -	/*
> -	 * Setup read/write queue split, assign admin queue one independent
> -	 * irq vector if irq_queues is > 1.
> -	 */
> -	if (irq_queues <= 2) {
> -		dev->io_queues[HCTX_TYPE_DEFAULT] = 1;
> -		dev->io_queues[HCTX_TYPE_READ] = 0;
> -		return;
> -	}
> +	struct nvme_dev *dev = affd->priv;
> +	unsigned int nr_read_queues;
>  
>  	/*
> -	 * If 'write_queues' is set, ensure it leaves room for at least
> -	 * one read queue and one admin queue
> -	 */
> -	if (this_w_queues >= irq_queues)
> -		this_w_queues = irq_queues - 2;
> -
> -	/*
> -	 * If 'write_queues' is set to zero, reads and writes will share
> -	 * a queue set.
> -	 */
> -	if (!this_w_queues) {
> -		dev->io_queues[HCTX_TYPE_DEFAULT] = irq_queues - 1;
> -		dev->io_queues[HCTX_TYPE_READ] = 0;
> -	} else {
> -		dev->io_queues[HCTX_TYPE_DEFAULT] = this_w_queues;
> -		dev->io_queues[HCTX_TYPE_READ] = irq_queues - this_w_queues - 1;
> -	}
> +	 * If only one interrupt is available, combine write and read
> +	 * queues. If 'write_queues' is set, ensure it leaves room for at
> +	 * least one read queue.
> +	 */
> +	if (nrirqs == 1)
> +		nr_read_queues = 0;
> +	else if (write_queues >= nrirqs)
> +		nr_read_queues = nrirqs - 1;
> +	else
> +		nr_read_queues = nrirqs - write_queues;
> +
> +	dev->io_queues[HCTX_TYPE_DEFAULT] = nrirqs - nr_read_queues;
> +	affd->set_size[HCTX_TYPE_DEFAULT] = nrirqs - nr_read_queues;
> +	dev->io_queues[HCTX_TYPE_READ] = nr_read_queues;
> +	affd->set_size[HCTX_TYPE_READ] = nr_read_queues;
> +	affd->nr_sets = nr_read_queues ? 2 : 1;
>  }

.calc_sets is called only if more than .pre_vectors is available,
then dev->io_queues[HCTX_TYPE_DEFAULT] may not be set in case of
(nvecs == affd->pre_vectors + affd->post_vectors).

Thanks,
Ming
