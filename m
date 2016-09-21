Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50460 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756883AbcIUMX4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Sep 2016 08:23:56 -0400
Date: Wed, 21 Sep 2016 14:29:44 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@fb.com, tglx@linutronix.de, keith.busch@intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] genirq/affinity: Provide smarter irq spreading
 infrastructure
Message-ID: <20160921122943.GE26808@agordeev.lab.eng.brq.redhat.com>
References: <1473862739-15032-1-git-send-email-hch@lst.de>
 <1473862739-15032-3-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473862739-15032-3-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Sep 14, 2016 at 04:18:48PM +0200, Christoph Hellwig wrote:
> +/**
> + * irq_calc_affinity_vectors - Calculate to optimal number of vectors for a given affinity mask
> + * @affinity:		The affinity mask to spread. If NULL cpu_online_mask
> + *			is used
> + * @maxvec:		The maximum number of vectors available
> + */
> +int irq_calc_affinity_vectors(const struct cpumask *affinity, int maxvec)
> +{
> +	int cpus, ret;
> +
> +	/* Stabilize the cpumasks */
> +	get_online_cpus();
> +	/* If the supplied affinity mask is NULL, use cpu online mask */
> +	if (!affinity)
> +		affinity = cpu_online_mask;
> +
> +	cpus = cpumask_weight(affinity);

Should not we consider the result of AND of affinity and cpu_online_mask?

> +	ret = (cpus < maxvec) ? cpus : maxvec;
> +
> +	put_online_cpus();
> +	return ret;
> +}
> +
>  static int get_first_sibling(unsigned int cpu)
>  {
>  	unsigned int ret;
> -- 
> 2.1.4
> 
