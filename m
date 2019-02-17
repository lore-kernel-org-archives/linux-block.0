Return-Path: <SRS0=s4v/=QY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A88C43381
	for <linux-block@archiver.kernel.org>; Sun, 17 Feb 2019 13:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9013921B69
	for <linux-block@archiver.kernel.org>; Sun, 17 Feb 2019 13:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbfBQNgP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Feb 2019 08:36:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35684 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727442AbfBQNgP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Feb 2019 08:36:15 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 81ED48110D;
        Sun, 17 Feb 2019 13:36:14 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3812660BF7;
        Sun, 17 Feb 2019 13:36:04 +0000 (UTC)
Date:   Sun, 17 Feb 2019 21:36:00 +0800
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
Subject: Re: [patch v6 1/7] genirq/affinity: Code consolidation
Message-ID: <20190217133559.GE7296@ming.t460p>
References: <20190216171306.403545970@linutronix.de>
 <20190216172228.336424556@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190216172228.336424556@linutronix.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Sun, 17 Feb 2019 13:36:14 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Feb 16, 2019 at 06:13:07PM +0100, Thomas Gleixner wrote:
> All information and calculations in the interrupt affinity spreading code
> is strictly unsigned int. Though the code uses int all over the place.
> 
> Convert it over to unsigned int.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/interrupt.h |   20 +++++++++-------
>  kernel/irq/affinity.c     |   56 ++++++++++++++++++++++------------------------
>  2 files changed, 38 insertions(+), 38 deletions(-)
> 
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -251,10 +251,10 @@ struct irq_affinity_notify {
>   * @sets:		Number of affinitized sets
>   */
>  struct irq_affinity {
> -	int	pre_vectors;
> -	int	post_vectors;
> -	int	nr_sets;
> -	int	*sets;
> +	unsigned int	pre_vectors;
> +	unsigned int	post_vectors;
> +	unsigned int	nr_sets;
> +	unsigned int	*sets;
>  };
>  
>  /**
> @@ -314,9 +314,10 @@ extern int
>  irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify);
>  
>  struct irq_affinity_desc *
> -irq_create_affinity_masks(int nvec, const struct irq_affinity *affd);
> +irq_create_affinity_masks(unsigned int nvec, const struct irq_affinity *affd);
>  
> -int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity *affd);
> +unsigned int irq_calc_affinity_vectors(unsigned int minvec, unsigned int maxvec,
> +				       const struct irq_affinity *affd);
>  
>  #else /* CONFIG_SMP */
>  
> @@ -350,13 +351,14 @@ irq_set_affinity_notifier(unsigned int i
>  }
>  
>  static inline struct irq_affinity_desc *
> -irq_create_affinity_masks(int nvec, const struct irq_affinity *affd)
> +irq_create_affinity_masks(unsigned int nvec, const struct irq_affinity *affd)
>  {
>  	return NULL;
>  }
>  
> -static inline int
> -irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity *affd)
> +static inline unsigned int
> +irq_calc_affinity_vectors(unsigned int minvec, unsigned int maxvec,
> +			  const struct irq_affinity *affd)
>  {
>  	return maxvec;
>  }
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -9,7 +9,7 @@
>  #include <linux/cpu.h>
>  
>  static void irq_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
> -				int cpus_per_vec)
> +				unsigned int cpus_per_vec)
>  {
>  	const struct cpumask *siblmsk;
>  	int cpu, sibl;
> @@ -95,15 +95,17 @@ static int get_nodes_in_cpumask(cpumask_
>  }
>  
>  static int __irq_build_affinity_masks(const struct irq_affinity *affd,
> -				      int startvec, int numvecs, int firstvec,
> +				      unsigned int startvec,
> +				      unsigned int numvecs,
> +				      unsigned int firstvec,
>  				      cpumask_var_t *node_to_cpumask,
>  				      const struct cpumask *cpu_mask,
>  				      struct cpumask *nmsk,
>  				      struct irq_affinity_desc *masks)
>  {
> -	int n, nodes, cpus_per_vec, extra_vecs, done = 0;
> -	int last_affv = firstvec + numvecs;
> -	int curvec = startvec;
> +	unsigned int n, nodes, cpus_per_vec, extra_vecs, done = 0;
> +	unsigned int last_affv = firstvec + numvecs;
> +	unsigned int curvec = startvec;
>  	nodemask_t nodemsk = NODE_MASK_NONE;
>  
>  	if (!cpumask_weight(cpu_mask))
> @@ -117,18 +119,16 @@ static int __irq_build_affinity_masks(co
>  	 */
>  	if (numvecs <= nodes) {
>  		for_each_node_mask(n, nodemsk) {
> -			cpumask_or(&masks[curvec].mask,
> -					&masks[curvec].mask,
> -					node_to_cpumask[n]);
> +			cpumask_or(&masks[curvec].mask, &masks[curvec].mask,
> +				   node_to_cpumask[n]);
>  			if (++curvec == last_affv)
>  				curvec = firstvec;
>  		}
> -		done = numvecs;
> -		goto out;
> +		return numvecs;
>  	}
>  
>  	for_each_node_mask(n, nodemsk) {
> -		int ncpus, v, vecs_to_assign, vecs_per_node;
> +		unsigned int ncpus, v, vecs_to_assign, vecs_per_node;
>  
>  		/* Spread the vectors per node */
>  		vecs_per_node = (numvecs - (curvec - firstvec)) / nodes;
> @@ -163,8 +163,6 @@ static int __irq_build_affinity_masks(co
>  			curvec = firstvec;
>  		--nodes;
>  	}
> -
> -out:
>  	return done;
>  }
>  
> @@ -174,13 +172,14 @@ static int __irq_build_affinity_masks(co
>   *	2) spread other possible CPUs on these vectors
>   */
>  static int irq_build_affinity_masks(const struct irq_affinity *affd,
> -				    int startvec, int numvecs, int firstvec,
> +				    unsigned int startvec, unsigned int numvecs,
> +				    unsigned int firstvec,
>  				    struct irq_affinity_desc *masks)
>  {
> -	int curvec = startvec, nr_present, nr_others;
> -	int ret = -ENOMEM;
> -	cpumask_var_t nmsk, npresmsk;
> +	unsigned int curvec = startvec, nr_present, nr_others;
>  	cpumask_var_t *node_to_cpumask;
> +	cpumask_var_t nmsk, npresmsk;
> +	int ret = -ENOMEM;
>  
>  	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
>  		return ret;
> @@ -239,12 +238,10 @@ static int irq_build_affinity_masks(cons
>   * Returns the irq_affinity_desc pointer or NULL if allocation failed.
>   */
>  struct irq_affinity_desc *
> -irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
> +irq_create_affinity_masks(unsigned int nvecs, const struct irq_affinity *affd)
>  {
> -	int affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
> -	int curvec, usedvecs;
> +	unsigned int affvecs, curvec, usedvecs, nr_sets, i;
>  	struct irq_affinity_desc *masks = NULL;
> -	int i, nr_sets;
>  
>  	/*
>  	 * If there aren't any vectors left after applying the pre/post
> @@ -264,16 +261,17 @@ irq_create_affinity_masks(int nvecs, con
>  	 * Spread on present CPUs starting from affd->pre_vectors. If we
>  	 * have multiple sets, build each sets affinity mask separately.
>  	 */
> +	affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
>  	nr_sets = affd->nr_sets;
>  	if (!nr_sets)
>  		nr_sets = 1;
>  
>  	for (i = 0, usedvecs = 0; i < nr_sets; i++) {
> -		int this_vecs = affd->sets ? affd->sets[i] : affvecs;
> +		unsigned int this_vecs = affd->sets ? affd->sets[i] : affvecs;
>  		int ret;
>  
>  		ret = irq_build_affinity_masks(affd, curvec, this_vecs,
> -						curvec, masks);
> +					       curvec, masks);
>  		if (ret) {
>  			kfree(masks);
>  			return NULL;
> @@ -303,17 +301,17 @@ irq_create_affinity_masks(int nvecs, con
>   * @maxvec:	The maximum number of vectors available
>   * @affd:	Description of the affinity requirements
>   */
> -int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity *affd)
> +unsigned int irq_calc_affinity_vectors(unsigned int minvec, unsigned int maxvec,
> +				       const struct irq_affinity *affd)
>  {
> -	int resv = affd->pre_vectors + affd->post_vectors;
> -	int vecs = maxvec - resv;
> -	int set_vecs;
> +	unsigned int resv = affd->pre_vectors + affd->post_vectors;
> +	unsigned int set_vecs;
>  
>  	if (resv > minvec)
>  		return 0;
>  
>  	if (affd->nr_sets) {
> -		int i;
> +		unsigned int i;
>  
>  		for (i = 0, set_vecs = 0;  i < affd->nr_sets; i++)
>  			set_vecs += affd->sets[i];
> @@ -323,5 +321,5 @@ int irq_calc_affinity_vectors(int minvec
>  		put_online_cpus();
>  	}
>  
> -	return resv + min(set_vecs, vecs);
> +	return resv + min(set_vecs, maxvec - resv);
>  }

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming
