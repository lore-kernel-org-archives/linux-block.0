Return-Path: <linux-block-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:39427 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933968AbcIVVRB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Sep 2016 17:17:01 -0400
Date: Thu, 22 Sep 2016 23:14:30 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Alexander Gordeev <agordeev@redhat.com>
cc: Christoph Hellwig <hch@lst.de>, axboe@fb.com,
        keith.busch@intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] genirq/affinity: Provide smarter irq spreading
 infrastructure
In-Reply-To: <20160921122943.GE26808@agordeev.lab.eng.brq.redhat.com>
Message-ID: <alpine.DEB.2.20.1609222309300.5640@nanos>
References: <1473862739-15032-1-git-send-email-hch@lst.de> <1473862739-15032-3-git-send-email-hch@lst.de> <20160921122943.GE26808@agordeev.lab.eng.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Alexander,

On Wed, 21 Sep 2016, Alexander Gordeev wrote:
> On Wed, Sep 14, 2016 at 04:18:48PM +0200, Christoph Hellwig wrote:
> > +/**
> > + * irq_calc_affinity_vectors - Calculate to optimal number of vectors for a given affinity mask
> > + * @affinity:		The affinity mask to spread. If NULL cpu_online_mask
> > + *			is used
> > + * @maxvec:		The maximum number of vectors available
> > + */
> > +int irq_calc_affinity_vectors(const struct cpumask *affinity, int maxvec)
> > +{
> > +	int cpus, ret;
> > +
> > +	/* Stabilize the cpumasks */
> > +	get_online_cpus();
> > +	/* If the supplied affinity mask is NULL, use cpu online mask */
> > +	if (!affinity)
> > +		affinity = cpu_online_mask;
> > +
> > +	cpus = cpumask_weight(affinity);
> 
> Should not we consider the result of AND of affinity and cpu_online_mask?

That's a good question.

The argument against it is the increased usage of cpu (soft)hotplug for
power-management. The driver might well want to set the mapping even for an
offline cpu and as long as the interrupt is not requested for that
particular queue, it will stay (in software) associated to that cpu. So
once the CPU is brought up again the driver can request the interrupt and
work with the associated queue.

I'm aware that there are arguments against it, but lets see how it works
out.

Thanks,

	tglx
