Return-Path: <SRS0=Y8Hj=QU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93272C282C2
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 15:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624F520835
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 15:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550070828;
	bh=6jRo9xVu8JdFnU+zOlf9IBsSFSRq1sbM9Zq4v0wDlds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qtKOXiLNTmKrLGMjzRCouj/W7VII38i4m3kLLOWy0vjd0ckHce0HyXvCFx1cqF7rB
	 izlbfxnZGKc+gIwRkMtiQ6QQBlzk0Z6Yhhd5ROBKL24jDusJazgYeRnyK4eOOasPTs
	 F6d+fU6nt3ZyNWf+NITJxpw9YDCkKAMOORgwFAxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbfBMPNn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:13:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:59490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729139AbfBMPNm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 10:13:42 -0500
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B8C220835;
        Wed, 13 Feb 2019 15:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550070820;
        bh=6jRo9xVu8JdFnU+zOlf9IBsSFSRq1sbM9Zq4v0wDlds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WIUfn27q9rHwln/4hnA4c0Hy1RJPbTQoSD7YmwUF2uY4pVmEHO1SLzNfgIBxOQMUo
         5qP/PyrN90QvJg3U/mWrho2Bk22v49dKl6RrbnSv/FlXh7skkCrteX5JQ2SO/CSxhW
         nUMM6RFNLD8qWwVqwoc1iLJqNx1VddmoVxcVkegk=
Date:   Wed, 13 Feb 2019 09:13:39 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH V3 4/5] nvme-pci: avoid irq allocation retrying via
 .calc_sets
Message-ID: <20190213151339.GE96272@google.com>
References: <20190213105041.13537-1-ming.lei@redhat.com>
 <20190213105041.13537-5-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213105041.13537-5-ming.lei@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 13, 2019 at 06:50:40PM +0800, Ming Lei wrote:
> Currently pre-caculate each set vectors, and this way requires same
> 'max_vecs' and 'min_vecs' passed to pci_alloc_irq_vectors_affinity(),
> then nvme_setup_irqs() has to retry in case of allocation failure.

s/pre-caculate/precalculate/
My usual "set vectors" question as on other patches.

> This usage & interface is a bit awkward because the retry should have
> been avoided by providing one reasonable 'min_vecs'.
> 
> Implement the callback of .calc_sets, so that pci_alloc_irq_vectors_affinity()
> can calculate each set's vector after IRQ vectors is allocated and
> before spread IRQ, then NVMe's retry in case of irq allocation failure
> can be removed.

s/irq/IRQ/

> Reviewed-by: Keith Busch <keith.busch@intel.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/nvme/host/pci.c | 62 +++++++++++++------------------------------------
>  1 file changed, 16 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 0086bdf80ea1..8c51252a897e 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2078,14 +2078,25 @@ static void nvme_calc_io_queues(struct nvme_dev *dev, unsigned int irq_queues)
>  	}
>  }
>  
> +static void nvme_calc_irq_sets(struct irq_affinity *affd, int nvecs)
> +{
> +	struct nvme_dev *dev = affd->priv;
> +
> +	nvme_calc_io_queues(dev, nvecs);
> +
> +	affd->set_vectors[HCTX_TYPE_DEFAULT] = dev->io_queues[HCTX_TYPE_DEFAULT];
> +	affd->set_vectors[HCTX_TYPE_READ] = dev->io_queues[HCTX_TYPE_READ];
> +	affd->nr_sets = 2;
> +}
> +
>  static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev->dev);
>  	struct irq_affinity affd = {
>  		.pre_vectors = 1,
> -		.nr_sets = 2,
> +		.calc_sets = nvme_calc_irq_sets,
> +		.priv = dev,
>  	};
> -	int *irq_sets = affd.set_vectors;
>  	int result = 0;
>  	unsigned int irq_queues, this_p_queues;
>  
> @@ -2102,50 +2113,8 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
>  	}
>  	dev->io_queues[HCTX_TYPE_POLL] = this_p_queues;
>  
> -	/*
> -	 * For irq sets, we have to ask for minvec == maxvec. This passes
> -	 * any reduction back to us, so we can adjust our queue counts and
> -	 * IRQ vector needs.
> -	 */
> -	do {
> -		nvme_calc_io_queues(dev, irq_queues);
> -		irq_sets[0] = dev->io_queues[HCTX_TYPE_DEFAULT];
> -		irq_sets[1] = dev->io_queues[HCTX_TYPE_READ];
> -		if (!irq_sets[1])
> -			affd.nr_sets = 1;
> -
> -		/*
> -		 * If we got a failure and we're down to asking for just
> -		 * 1 + 1 queues, just ask for a single vector. We'll share
> -		 * that between the single IO queue and the admin queue.
> -		 * Otherwise, we assign one independent vector to admin queue.
> -		 */
> -		if (irq_queues > 1)
> -			irq_queues = irq_sets[0] + irq_sets[1] + 1;
> -
> -		result = pci_alloc_irq_vectors_affinity(pdev, irq_queues,
> -				irq_queues,
> -				PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
> -
> -		/*
> -		 * Need to reduce our vec counts. If we get ENOSPC, the
> -		 * platform should support mulitple vecs, we just need
> -		 * to decrease our ask. If we get EINVAL, the platform
> -		 * likely does not. Back down to ask for just one vector.
> -		 */
> -		if (result == -ENOSPC) {
> -			irq_queues--;
> -			if (!irq_queues)
> -				return result;
> -			continue;
> -		} else if (result == -EINVAL) {
> -			irq_queues = 1;
> -			continue;
> -		} else if (result <= 0)
> -			return -EIO;
> -		break;
> -	} while (1);
> -
> +	result = pci_alloc_irq_vectors_affinity(pdev, 1, irq_queues,
> +			PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
>  	return result;
>  }
>  
> @@ -3021,6 +2990,7 @@ static struct pci_driver nvme_driver = {
>  
>  static int __init nvme_init(void)
>  {
> +	BUILD_BUG_ON(2 > IRQ_MAX_SETS);

"IRQ_MAX_SETS < 2" would read more naturally; is there a reason to have it
reversed?

>  	return pci_register_driver(&nvme_driver);
>  }
>  
> -- 
> 2.9.5
> 
