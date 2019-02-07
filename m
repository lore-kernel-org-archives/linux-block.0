Return-Path: <SRS0=wMCK=QO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F24EC282C4
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 22:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E22E721919
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 22:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549578175;
	bh=+S0HWjzFF0bkCAurrzo7b8npCJKlJiHsUY5c5VVDZDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pWlNDE9+fodMK3UUZy3TsBvL8dte9aFds/Xwprr3Pc3NkYTLO/YEzOAQ7r/OmNObm
	 EKT12WhvrAcA5+3Q8qDJS2wxsnpmPRFGOqXmJ0wIrMGi7C2dRQF2TUd56BqewYNrGq
	 VKdGt2I5IeITuYm/5TFv92l/rhM6mzv3XyiuHwQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfBGWWt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 17:22:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:34340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbfBGWWt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 Feb 2019 17:22:49 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 383AC2147C;
        Thu,  7 Feb 2019 22:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549578167;
        bh=+S0HWjzFF0bkCAurrzo7b8npCJKlJiHsUY5c5VVDZDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JDOjQa/cArkkc7VQhjY5RWYjgsni7kBaXiozB7ISiGTshZGO4hk4CnSzg5LkHPoU+
         5ByVGq3aUxVOjDRajNa7CInblnqHRKJZXH+QMH1bGqpbeOM6x9CcgPQrpLc1eVH41Y
         7vo/nhV2/zmQ4wuaGgYONGymC+E/Zn+X3oUBrXBY=
Date:   Thu, 7 Feb 2019 16:22:46 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 5/5] genirq/affinity: remove support for allocating
 interrupt sets
Message-ID: <20190207222245.GR7268@google.com>
References: <20190125095347.17950-1-ming.lei@redhat.com>
 <20190125095347.17950-6-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125095347.17950-6-ming.lei@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 25, 2019 at 05:53:47PM +0800, Ming Lei wrote:
> Now allocating interrupt sets can be done via .setup_affinity()
> easily, so remove the support for allocating interrupt sets.
> 
> With this change, we don't need the limit of 'minvec == maxvec'
> any more in pci_alloc_irq_vectors_affinity().
> 
> Meantime irq_create_affinity_masks() gets simplified a lot.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# pci/msi.c parts

> ---
>  drivers/pci/msi.c         | 14 -------------
>  include/linux/interrupt.h |  4 ----
>  kernel/irq/affinity.c     | 52 +++++++++++------------------------------------
>  3 files changed, 12 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 4c0b47867258..331483de1294 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1035,13 +1035,6 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
>  	if (maxvec < minvec)
>  		return -ERANGE;
>  
> -	/*
> -	 * If the caller is passing in sets, we can't support a range of
> -	 * vectors. The caller needs to handle that.
> -	 */
> -	if (affd && affd->nr_sets && minvec != maxvec)
> -		return -EINVAL;
> -
>  	if (WARN_ON_ONCE(dev->msi_enabled))
>  		return -EINVAL;
>  
> @@ -1093,13 +1086,6 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
>  	if (maxvec < minvec)
>  		return -ERANGE;
>  
> -	/*
> -	 * If the caller is passing in sets, we can't support a range of
> -	 * supported vectors. The caller needs to handle that.
> -	 */
> -	if (affd && affd->nr_sets && minvec != maxvec)
> -		return -EINVAL;
> -
>  	if (WARN_ON_ONCE(dev->msix_enabled))
>  		return -EINVAL;
>  
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index b820b07f3b55..a035e165f405 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -260,8 +260,6 @@ struct irq_affinity_desc {
>   * 			and driver has to handle pre_vectors & post_vectors
>   * 			correctly, set 'is_managed' flag correct too
>   * @priv:		Private data of @setup_affinity
> - * @nr_sets:		Length of passed in *sets array
> - * @sets:		Number of affinitized sets
>   */
>  struct irq_affinity {
>  	int	pre_vectors;
> @@ -270,8 +268,6 @@ struct irq_affinity {
>  				  struct irq_affinity_desc *,
>  				  unsigned int);
>  	void    *priv;
> -	int	nr_sets;
> -	int	*sets;
>  };
>  
>  #if defined(CONFIG_SMP)
> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> index 524fdcda9f85..e8fea65325d9 100644
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -269,9 +269,9 @@ struct irq_affinity_desc *
>  irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
>  {
>  	int affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
> -	int curvec, usedvecs;
> +	int curvec;
>  	struct irq_affinity_desc *masks = NULL;
> -	int i, nr_sets;
> +	int i;
>  
>  	/*
>  	 * If there aren't any vectors left after applying the pre/post
> @@ -293,34 +293,14 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
>  	/* Fill out vectors at the beginning that don't need affinity */
>  	for (curvec = 0; curvec < affd->pre_vectors; curvec++)
>  		cpumask_copy(&masks[curvec].mask, irq_default_affinity);
> -	/*
> -	 * Spread on present CPUs starting from affd->pre_vectors. If we
> -	 * have multiple sets, build each sets affinity mask separately.
> -	 */
> -	nr_sets = affd->nr_sets;
> -	if (!nr_sets)
> -		nr_sets = 1;
> -
> -	for (i = 0, usedvecs = 0; i < nr_sets; i++) {
> -		int this_vecs = affd->sets ? affd->sets[i] : affvecs;
> -		int ret;
> -
> -		ret = irq_build_affinity_masks(affd, curvec, this_vecs,
> -						curvec, masks);
> -		if (ret) {
> -			kfree(masks);
> -			return NULL;
> -		}
> -		curvec += this_vecs;
> -		usedvecs += this_vecs;
> +
> +	if (irq_build_affinity_masks(affd, curvec, affvecs, curvec, masks)) {
> +		kfree(masks);
> +		return NULL;
>  	}
>  
>  	/* Fill out vectors at the end that don't need affinity */
> -	if (usedvecs >= affvecs)
> -		curvec = affd->pre_vectors + affvecs;
> -	else
> -		curvec = affd->pre_vectors + usedvecs;
> -	for (; curvec < nvecs; curvec++)
> +	for (curvec = affd->pre_vectors + affvecs; curvec < nvecs; curvec++)
>  		cpumask_copy(&masks[curvec].mask, irq_default_affinity);
>  
>  	/* Mark the managed interrupts */
> @@ -340,21 +320,13 @@ int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity
>  {
>  	int resv = affd->pre_vectors + affd->post_vectors;
>  	int vecs = maxvec - resv;
> -	int set_vecs;
> +	int ret;
>  
>  	if (resv > minvec)
>  		return 0;
>  
> -	if (affd->nr_sets) {
> -		int i;
> -
> -		for (i = 0, set_vecs = 0;  i < affd->nr_sets; i++)
> -			set_vecs += affd->sets[i];
> -	} else {
> -		get_online_cpus();
> -		set_vecs = cpumask_weight(cpu_possible_mask);
> -		put_online_cpus();
> -	}
> -
> -	return resv + min(set_vecs, vecs);
> +	get_online_cpus();
> +	ret = min_t(int, cpumask_weight(cpu_possible_mask), vecs) + resv;
> +	put_online_cpus();
> +	return ret;
>  }
> -- 
> 2.9.5
> 
