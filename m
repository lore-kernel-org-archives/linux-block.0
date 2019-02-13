Return-Path: <SRS0=Y8Hj=QU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D1FC282C2
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 15:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C20AF222C9
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 15:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550070447;
	bh=uOCdBJs/k/DikWGzoXILqmP1QrmQOgHrs7BMqLTb/es=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1NywkDo2muJPYqSyWNvG/Cbq0Lha6trs42cd7JdDjWLd/m4h1Dmq5wcHC2MhsaNEk
	 u0rEM3nvpNfwHRyicfvkyQV2BCHY6UHzb7auX8Wbv1CFrMcxdRql3UmoI4KoJlyvO+
	 fJpeqxNaBxLaDBPJNN+wR9ZxfrqMr7/piNFn6Fow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbfBMPH0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:07:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:51960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfBMPH0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 10:07:26 -0500
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C649222C2;
        Wed, 13 Feb 2019 15:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550070445;
        bh=uOCdBJs/k/DikWGzoXILqmP1QrmQOgHrs7BMqLTb/es=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=biQ+NnN+tg1ZIjk2cwb0j/ehhjs7eTiaV+NLd+uAPocDFQyYKS4SoRAhmhPv61gsF
         Tu8jOUu4O9wPIHPozU4ElCNkbQeZvKrqkPEI+Ad7mBmr5lWj9kQUmIqerZazLral61
         g7iolxP6fmse3JvkBLaLU/tRtyLaW/5h/YSOfM1o=
Date:   Wed, 13 Feb 2019 09:07:24 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH V3 2/5] genirq/affinity: store irq set vectors in 'struct
 irq_affinity'
Message-ID: <20190213150723.GC96272@google.com>
References: <20190213105041.13537-1-ming.lei@redhat.com>
 <20190213105041.13537-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213105041.13537-3-ming.lei@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 13, 2019 at 06:50:38PM +0800, Ming Lei wrote:
> Currently the array of irq set vectors is provided by driver.
> 
> irq_create_affinity_masks() can be simplied a bit by treating the
> non-irq-set case as single irq set.

s/simplied a bit/simplified/

> So move this array into 'struct irq_affinity', and pre-define the max
> set number as 4, which should be enough for normal cases.

s/irq/IRQ/
You have a real mixture of capitalization across the changelogs.

> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/nvme/host/pci.c   |  5 ++---
>  include/linux/interrupt.h |  6 ++++--
>  kernel/irq/affinity.c     | 18 +++++++++++-------
>  3 files changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 022ea1ee63f8..0086bdf80ea1 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2081,12 +2081,11 @@ static void nvme_calc_io_queues(struct nvme_dev *dev, unsigned int irq_queues)
>  static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev->dev);
> -	int irq_sets[2];
>  	struct irq_affinity affd = {
>  		.pre_vectors = 1,
> -		.nr_sets = ARRAY_SIZE(irq_sets),
> -		.sets = irq_sets,
> +		.nr_sets = 2,
>  	};
> +	int *irq_sets = affd.set_vectors;
>  	int result = 0;
>  	unsigned int irq_queues, this_p_queues;
>  
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index 1ed1014c9684..a20150627a32 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -259,6 +259,8 @@ struct irq_affinity_notify {
>  	void (*release)(struct kref *ref);
>  };
>  
> +#define	IRQ_MAX_SETS  4

This is a pretty generic name.  Maybe it should include a hint that it's
related to affinity?

>  /**
>   * struct irq_affinity - Description for automatic irq affinity assignements
>   * @pre_vectors:	Don't apply affinity to @pre_vectors at beginning of
> @@ -266,13 +268,13 @@ struct irq_affinity_notify {
>   * @post_vectors:	Don't apply affinity to @post_vectors at end of
>   *			the MSI(-X) vector space
>   * @nr_sets:		Length of passed in *sets array
> - * @sets:		Number of affinitized sets
> + * @set_vectors:	Number of affinitized sets
>   */
>  struct irq_affinity {
>  	int	pre_vectors;
>  	int	post_vectors;
>  	int	nr_sets;
> -	int	*sets;
> +	int	set_vectors[IRQ_MAX_SETS];
>  };
>  
>  /**
> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> index 9200d3b26f7d..b868b9d3df7f 100644
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -244,7 +244,7 @@ irq_create_affinity_masks(int nvecs, struct irq_affinity *affd)
>  	int affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
>  	int curvec, usedvecs;
>  	struct irq_affinity_desc *masks = NULL;
> -	int i, nr_sets;
> +	int i;
>  
>  	/*
>  	 * If there aren't any vectors left after applying the pre/post
> @@ -253,6 +253,9 @@ irq_create_affinity_masks(int nvecs, struct irq_affinity *affd)
>  	if (nvecs == affd->pre_vectors + affd->post_vectors)
>  		return NULL;
>  
> +	if (affd->nr_sets > IRQ_MAX_SETS)
> +		return NULL;
> +
>  	masks = kcalloc(nvecs, sizeof(*masks), GFP_KERNEL);
>  	if (!masks)
>  		return NULL;
> @@ -264,12 +267,13 @@ irq_create_affinity_masks(int nvecs, struct irq_affinity *affd)
>  	 * Spread on present CPUs starting from affd->pre_vectors. If we
>  	 * have multiple sets, build each sets affinity mask separately.
>  	 */
> -	nr_sets = affd->nr_sets;
> -	if (!nr_sets)
> -		nr_sets = 1;
> +	if (!affd->nr_sets) {
> +		affd->nr_sets = 1;
> +		affd->set_vectors[0] = affvecs;
> +	}
>  
> -	for (i = 0, usedvecs = 0; i < nr_sets; i++) {
> -		int this_vecs = affd->sets ? affd->sets[i] : affvecs;
> +	for (i = 0, usedvecs = 0; i < affd->nr_sets; i++) {
> +		int this_vecs = affd->set_vectors[i];
>  		int ret;
>  
>  		ret = irq_build_affinity_masks(affd, curvec, this_vecs,
> @@ -316,7 +320,7 @@ int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity
>  		int i;
>  
>  		for (i = 0, set_vecs = 0;  i < affd->nr_sets; i++)
> -			set_vecs += affd->sets[i];
> +			set_vecs += affd->set_vectors[i];
>  	} else {
>  		get_online_cpus();
>  		set_vecs = cpumask_weight(cpu_possible_mask);
> -- 
> 2.9.5
> 
